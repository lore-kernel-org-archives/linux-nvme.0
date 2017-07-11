From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Jul 2017 12:19:12 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170711085204.GA7846@linux-x5ow.site>
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
 <20170711085204.GA7846@linux-x5ow.site>
Message-ID: <a0656ff3-f2b9-4580-bf6f-8206cd73b680@grimberg.me>


> Not that I disagree with you, but two different (not connected) fabrics
> (OmniPath and IB) and both are broken, while I see no problems on IPoIB?
> 
> Not sure how likely this is.

I didn't mean that the fabric is broken for sure, I was simply saying
that having a 64 byte send not making it through a switch port sounds
like a problem to me.
