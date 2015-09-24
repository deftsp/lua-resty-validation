local validation   = require "resty.validation"
local escapeuri    = ngx.escape_uri
local unescapeuri  = ngx.unescape_uri
local base64enc    = ngx.encode_base64
local base64dec    = ngx.decode_base64
local crc32short   = ngx.crc32_short
local crc32long    = ngx.crc32_long
local validators   = validation.validators
local factory      = getmetatable(validators)
function factory.escapeuri()
    return function(value)
        return true, escapeuri(value)
    end
end
function factory.unescapeuri()
    return function(value)
        return true, unescapeuri(value)
    end
end
function factory.base64enc()
    return function(value)
        return true, base64enc(value)
    end
end
function factory.base64dec()
    return function(value)
        local decoded = base64dec(value)
        if decoded == nil then
            return false
        end
        return true, decoded
    end
end
function factory.crc32short()
    return function(value)
        return true, crc32short(value)
    end
end
function factory.crc32long()
    return function(value)
        return true, crc32long(value)
    end
end
function factory.crc32()
    return function(value)
        if #value < 61 then
            return true, crc32short(value)
        end
        return true, crc32long(value)
    end
end
validators.escapeuri   = factory.escapeuri()
validators.unescapeuri = factory.unescapeuri()
validators.base64enc   = factory.base64enc()
validators.base64dec   = factory.base64dec()
validators.crc32short  = factory.crc32short()
validators.crc32long   = factory.crc32long()
validators.crc32       = factory.crc32()
return {
    escape_uri   = factory.escape_uri,
    unescape_uri = factory.unescape_uri,
    base64enc    = factory.base64enc,
    base64dec    = factory.base64dec,
    crc32short   = factory.crc32short,
    crc32long    = factory.crc32long,
    crc32        = factory.crc32
}