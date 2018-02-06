From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 6 Feb 2018 15:27:39 +0000
Subject: [PATCH 1/3] net/utils: Introduce inet_addr_is_any
In-Reply-To: <20180206094432.12761-2-sagi@grimberg.me>
References: <20180206094432.12761-1-sagi@grimberg.me>
 <20180206094432.12761-2-sagi@grimberg.me>
Message-ID: <1517930858.3934.15.camel@wdc.com>

On Tue, 2018-02-06@11:44 +0200, Sagi Grimberg wrote:
> +bool inet_addr_is_any(struct sockaddr *addr)
> +{
> +	bool ret = false;
> +
> +	if (addr->sa_family == AF_INET6) {
> +		struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)addr;
> +		const struct sockaddr_in6 in6_any =
> +			{ .sin6_addr = IN6ADDR_ANY_INIT };
> +
> +		if (!memcmp(in6->sin6_addr.s6_addr,
> +			in6_any.sin6_addr.s6_addr, 16))
> +			ret = true;
> +	} else if (addr->sa_family == AF_INET) {
> +		struct sockaddr_in *in = (struct sockaddr_in *)addr;
> +
> +		if (in->sin_addr.s_addr == htonl(INADDR_ANY))
> +			ret = true;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(inet_addr_is_any);

Have you considered to eliminate the local variable 'ret' and to use multiple
return statements? Additionally, should this function trigger a warning if a
socket address is passed with an address family that is not supported by this
function? Should the in6_any local variable be declared static?

Thanks,

Bart.
