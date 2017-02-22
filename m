From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 21 Feb 2017 23:43:54 -0800
Subject: [PATCH rfc 1/4] net/utils: generic inet_pton_with_scope helper
In-Reply-To: <6c2a4f67-ede6-0ee1-5a90-14023994d029@grimberg.me>
References: <1487267017-29904-1-git-send-email-sagi@grimberg.me>
 <1487267017-29904-2-git-send-email-sagi@grimberg.me>
 <20170219171523.GC10310@infradead.org>
 <6c2a4f67-ede6-0ee1-5a90-14023994d029@grimberg.me>
Message-ID: <20170222074354.GA19012@infradead.org>

On Tue, Feb 21, 2017@11:18:04PM +0200, Sagi Grimberg wrote:
> I can maybe do something like:
> 
> if (af == AF_INET || af == AF_UNSPEC) {
> 	ret = inet4_pton();
> 	if (!ret)
> 		return 0;
> 	else if (af != AF_UNSPEC)
> 		return ret;
> }
> 
> if (af == AF_INET6 || af == AF_UNSPEC) {
> 	ret = inet6_pton();
> 	if (!ret)
> 		return 0;
> 	else if (af != AF_UNSPEC)
> 		return ret;
> }
> 
> return -EINVAL;
> 
> better?

My idead was the following:

	switch (af) {
	case AF_INET:
		ret = inet_pton();
		break;
	case AF_INET6:
		ret = inet6_pton();
		break;
	case AF_UNSPEC:
		ret = inet6_pton();
		if (ret)
			ret = inet_pton();
		break;
	}
