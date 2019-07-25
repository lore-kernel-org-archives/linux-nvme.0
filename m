From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Jul 2019 22:46:09 +0900
Subject: [PATCH 1/5] lnvm: make data_len to sizeof() instead of magic
 number
In-Reply-To: <80d59219-12b7-47da-d37e-9fd9941260de@lightnvm.io>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-2-minwoo.im.dev@gmail.com>
 <80d59219-12b7-47da-d37e-9fd9941260de@lightnvm.io>
Message-ID: <20190725134609.GD3018@minwoo-desktop>

Hi Matias,

On 19-07-24 14:33:39, Matias Bj?rling wrote:
> On 23/07/2019 20.35, Minwoo Im wrote:
> > We can have it as a sizeof() instead of the hard-coded value for the
> > data structure.
> > 
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: Matias Bjorling <mb at lightnvm.io>
> > Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> > ---
> >   nvme-lightnvm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
> > index 0b99786..e8cdccd 100644
> > --- a/nvme-lightnvm.c
> > +++ b/nvme-lightnvm.c
> > @@ -442,7 +442,7 @@ static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
> >   		.opcode		= nvme_nvm_admin_identity,
> >   		.nsid		= nsid,
> >   		.addr		= (__u64)(uintptr_t)nvm_id,
> > -		.data_len	= 0x1000,
> > +		.data_len	= sizeof(struct nvme_nvm_id),
> >   	};
> >   	return nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
> 
> Works for me.
> 
> Please use use my Signed-off-by instead of Reviewed-by - traditionally Keith
> has been kind to wait to pull in patches until I got a chance to look at
> them on Github. Having the review here on the mailing list and later as a
> pull request on github makes it explicit that I signed off on it.

Oh okay.  I'll keep that in mind.  But now I'll prepare a V2 series so
that if you review that one also, I'll put your tag below into the
commit and post as a PR on Github once Javier gives some comments on the
previous patch review.

Thanks!

> Signed-off-by: Matias Bj?rling <matias.bjorling at wdc.com>
> 
> Thank you!
> 
> - Matias
