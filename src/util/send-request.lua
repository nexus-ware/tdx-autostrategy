---@description Sends a request to a URL with given paramters.
return function (URL, METHOD, BODY, HEADERS, COOKIES) 
    return request({
        Url = URL,
        Method = METHOD,
        Body = BODY,
        Headers = HEADERS,
        Cookies = COOKIES
    })
end