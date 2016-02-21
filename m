From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 21 Feb 2016 08:20:48 -0800
Subject: [PATCH-4.6 3/3] NVMe: Don't allow unsupported flags
In-Reply-To: <1455837677-23248-3-git-send-email-keith.busch@intel.com>
References: <1455837677-23248-1-git-send-email-keith.busch@intel.com>
 <1455837677-23248-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160221162048.GE21896@infradead.org>

On Thu, Feb 18, 2016@04:21:17PM -0700, Keith Busch wrote:
> Alternatively I have a different patch that builds SGL's if the flags
> has it set and the device supports SGL. Any interest?
> 
> I didn't post it since the fast path only gets PRP-able scatter lists,
> and the additional logic to handle SGL's complicates handling the NVMe
> IO descriptor.

I don't think we should allow applications to control the SGL use.
There are a couple reasons for that in upcoming specs that I can't talk
about, but I think it should be common sense to not expose these sorts
of low level details to userspace.

>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 33ad10d..d8c3a55 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -398,7 +398,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>  
>  	memset(&c, 0, sizeof(c));
>  	c.rw.opcode = io.opcode;
> -	c.rw.flags = io.flags;
> +	c.rw.flags = 0;

Shouldn't we check that flags is zero in the user structure and reject
the command if not?  Otherwise we can't safely add back support for
flags in the future if useful ones appear that we might want to support.
