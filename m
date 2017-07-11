From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 11 Jul 2017 11:21:41 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <a0656ff3-f2b9-4580-bf6f-8206cd73b680@grimberg.me>
References: <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
 <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
 <20170710115003.GH5105@linux-x5ow.site>
 <4df0a8a8-168f-06c4-6112-dfd2893d6e06@grimberg.me>
 <20170711085204.GA7846@linux-x5ow.site>
 <a0656ff3-f2b9-4580-bf6f-8206cd73b680@grimberg.me>
Message-ID: <20170711092140.GB7846@linux-x5ow.site>

On Tue, Jul 11, 2017@12:19:12PM +0300, Sagi Grimberg wrote:
 
> I didn't mean that the fabric is broken for sure, I was simply saying
> that having a 64 byte send not making it through a switch port sounds
> like a problem to me.

We're trying to setup a new test setup w/ RoCE today to rule out eventual
OmniPath and old InfiniBand HW problems. Still this all is a bit mysterious to
me currently.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
