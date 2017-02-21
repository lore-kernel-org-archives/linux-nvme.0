From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 21 Feb 2017 23:20:25 +0200
Subject: [PATCH] nvmet-rdma: Fix error handling
In-Reply-To: <20170219194657.GA6591@lst.de>
References: <20170219190438.19371-1-christophe.jaillet@wanadoo.fr>
 <20170219194657.GA6591@lst.de>
Message-ID: <bea43248-6c09-2a2e-56cc-59c707c2226b@grimberg.me>


> On Sun, Feb 19, 2017@08:04:38PM +0100, Christophe JAILLET wrote:
>> According to the surrounding goto, it is likely that 'out_destroy_sq' was
>> expected here.
>
> s/surrounding/preceeding/ ?
>
> But the patch itself looks good, thanks.
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Picked it up and reworded, thanks.
