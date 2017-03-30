From: davem@davemloft.net (David Miller)
Date: Thu, 30 Mar 2017 12:40:07 -0700 (PDT)
Subject: [PATCH v3] net/utils: generic inet_pton_with_scope helper
In-Reply-To: <1490809724-25234-1-git-send-email-sagi@grimberg.me>
References: <1490809724-25234-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170330.124007.1065811391753224581.davem@davemloft.net>

From: Sagi Grimberg <sagi@grimberg.me>
Date: Wed, 29 Mar 2017 20:48:44 +0300

> Several locations in the stack need to handle ipv4/ipv6
> (with scope) and port strings conversion to sockaddr.
> Add a helper that takes either AF_INET, AF_INET6 or
> AF_UNSPEC (for wildcard) to centralize this handling.
> 
> Suggested-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks fine to me:

Acked-by: David S. Miller <davem at davemloft.net>
