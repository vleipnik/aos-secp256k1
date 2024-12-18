Handlers.add(
  "VerifySig",
  Handlers.utils.hasMatchingTag("Action", "VerifySig"),
  function (msg)
    local data = msg.Data
    local message, signature_der, public_key = data.message, data.signature_der, data.public_key

    local is_valid = verify_signature(message, signature_der, public_key)

    print("Message: " .. message)
    print("Signature Verification Result: " .. (is_valid and "VALID" or "INVALID"))

    ao.send({ Target = msg.From, Action = "Create-Result", Data = { is_valid = is_valid }})
  end
)