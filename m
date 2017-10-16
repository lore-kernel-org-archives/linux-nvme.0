From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 16 Oct 2017 17:00:39 +0200
Subject: [PATCH] nvmet: protect sqhd update by a lock
In-Reply-To: <db261e81-cd01-c5a3-5e60-a81d6dfc50fe@broadcom.com>
References: <20171013203800.24125-1-jsmart2021@gmail.com>
 <20171016072145.wyrp2fyw2cx2grpf@linux-x5ow.site>
 <963d2bd1-1193-7961-eafe-862ddf6f7a91@gmail.com>
 <20171016144428.ejwo5yr5p7iduftn@linux-x5ow.site>
 <db261e81-cd01-c5a3-5e60-a81d6dfc50fe@broadcom.com>
Message-ID: <20171016150038.i2sjez2bj2dnxeq2@linux-x5ow.site>

On Mon, Oct 16, 2017@07:57:31AM -0700, James Smart wrote:
> The real issue, where memory barrier isn't enough, is between the value of
> the sqhd increment followed by the modulo. Many of a time I've seen
> interruption in between these points.
> 
> As far as assignment of the cqe - as long a sqhd is getting updated
> properly, such that the cqe will return either the value just set? or a
> newer one, even if another cqe returns the same newer value, it's fine per
> the sqhd definition in nvme.
> 
> As it's no big deal - I'll repost with the lock moved

OK, thanks.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
