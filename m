From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 11 Jul 2017 10:52:04 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <4df0a8a8-168f-06c4-6112-dfd2893d6e06@grimberg.me>
References: <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
 <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
 <20170710115003.GH5105@linux-x5ow.site>
 <4df0a8a8-168f-06c4-6112-dfd2893d6e06@grimberg.me>
Message-ID: <20170711085204.GA7846@linux-x5ow.site>

On Mon, Jul 10, 2017@03:04:52PM +0300, Sagi Grimberg wrote:
> And if your keep-alive did not make it in 35 seconds, then its an
> indication that something is wrong... which is exactly what keep-alives
> are designed to do... So I'm not at all sure that we need to compensate
> for this in the driver at all, something is clearly wrong in your
> fabric.

Not that I disagree with you, but two different (not connected) fabrics
(OmniPath and IB) and both are broken, while I see no problems on IPoIB?

Not sure how likely this is.

But still trying to figure out what's going on.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
