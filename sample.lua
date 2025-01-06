local json = require("json")
-- local base64 = require(".base64")
local Array = require(".crypto.util.array")

-- Helper functions for base64url decoding
local alphabet='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function base64_url_decode(data)
  -- the contents in JWTs are base64 encoded, but also makde URL safe. This means substituting
  -- chars like + and / with - and _ respectively. We need to undo this before decoding the data.
  data = data:gsub("-", "+")
  data = data:gsub("_", "/")
  -- TODO: for some reason, there's an issue with using AO's base64 lib at runtime... opting to use a simpler implementation instead
  -- local res = base64.decode(data)
  -- return res
  data = string.gsub(data, '[^'..alphabet..'=]', '')
  local res = (data:gsub('.', function(x)
    if (x == '=') then return '' end
    local r,f='',(alphabet:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then return '' end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))

  return res
end

-- Parse JWT into header, payload, and signature
local function parse_jwt(jwt)
  local header_b64, payload_b64, signature_b64 = jwt:match("([^%.]+)%.([^%.]+)%.([^%.]+)")
  if not header_b64 or not payload_b64 or not signature_b64 then
      return nil, "Invalid JWT format"
  end
  local header = base64_url_decode(header_b64)
  local payload = base64_url_decode(payload_b64)
  local signature = base64_url_decode(signature_b64)
  return header, payload, signature, header_b64 .. "." .. payload_b64
end

local function decode_signature(signature)
  local bytes = Array.fromString(signature)
-- Ensure the signature is 64 bytes long (32 bytes for r, 32 bytes for s)
  if #bytes ~= 64 then
      error("Invalid signature length: expected 64 bytes")
  end

 local sig_hex = Array.toHex(bytes)
 return sig_hex
end

local function string_split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

local function get_authority(payload)
  -- TODO: handle other authority formats? Eg. public keys
  local issuer = payload.iss;
  local pub_key_hex = nil
  if (issuer) then
    -- TODO: parse out the pub key
    local parts = string_split(issuer, ':')
    if (parts[1] == 'did' and parts[2] == 'ethr') then
      if #parts == 3 then
        -- mainnet ethr did
        pub_key_hex = parts[3]
      elseif #parts == 4 then
        -- a non-mainnet chain is specified
        pub_key_hex = parts[4]
      end
    end
  end
  if pub_key_hex  then
    if string.sub(pub_key_hex, 1, 2) == '0x' then
      pub_key_hex = string.sub(pub_key_hex, 3, -1)
    end
  end
  return pub_key_hex
end

local function jwt_validate(jwt)
  local header, payload, signature, signing_input = parse_jwt(jwt)

  if not header or not payload or not signature then
      return false, "Failed to parse JWT"
  end

  local json_header = json.decode(header)
  if (json_header.alg ~= "ES256K") then
    error('Only support ES256K signatures')
  end
  local json_payload = json.decode(payload)
  -- TODO: don't assume the authority is always a compressed pub key?
  local pub_key_hex = get_authority(json_payload)
  if (not pub_key_hex) then
    error('Failed to get the public key from JWT payload')
  end
  local signature_hex = decode_signature(signature)
  local success = verify_signature(signing_input, signature_hex, pub_key_hex)
  return success
end

Handlers.add(
  "VerifyJwt",
  Handlers.utils.hasMatchingTag("Action", "VerifyJwt"),
  function (msg)
    local is_valid = jwt_validate(msg.Data)

    -- print("Message: " .. message)
    print("JWT Verification Result: " .. (is_valid and "VALID" or "INVALID"))

    ao.send({ Target = msg.From, Action = "Create-Result", Data = { is_valid = is_valid }})
  end
)

Handlers.add(
  "VerifySig",
  Handlers.utils.hasMatchingTag("Action", "VerifySig"),
  function (msg)
    local data = msg.Data
    local message, signature, public_key = data.message, data.signature, data.public_key

    local is_valid = verify_signature(message, signature, public_key)

    print("Message: " .. message)
    print("Signature Verification Result: " .. (is_valid and "VALID" or "INVALID"))

    ao.send({ Target = msg.From, Action = "Create-Result", Data = { is_valid = is_valid }})
  end
)