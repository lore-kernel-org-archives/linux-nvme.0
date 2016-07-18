From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Jul 2016 19:34:36 -0400
Subject: [PATCH] NVMe: Fix max hardware sectors calculation for non zero
 MDTS
In-Reply-To: <OFD7F1545F.4D6ABB60-ON86257FF4.0066B34F-86257FF4.007C4012@notes.na.collabserv.com>
References: <1468864076-6809-1-git-send-email-pandit.parav@gmail.com>
 <OFD7F1545F.4D6ABB60-ON86257FF4.0066B34F-86257FF4.007C4012@notes.na.collabserv.com>
Message-ID: <20160718233436.GA15409@localhost.localdomain>

On Mon, Jul 18, 2016@05:37:08PM -0500, Murali N Iyer wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1a51584..9a162b1 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1120,7 +1120,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >     memcpy(ctrl->model, id->mn, sizeof(id->mn));
> >     memcpy(ctrl->firmware_rev, id->fr, sizeof(id->fr));
> >     if (id->mdts)
> > -      ctrl->max_hw_sectors = 1 << (id->mdts + page_shift - 9);
> > +      ctrl->max_hw_sectors = id->mdts * (1 << (page_shift - 9));
> >     else
> >        ctrl->max_hw_sectors = UINT_MAX;

> Looks like specs could be interpreted differently.

It's not the easiest wording, but I don't think it's ambiguous.

> I have seen some controllers assuming 2^(mdts + MPSMIN) and setting the
> value like the code is written today.
> Example, to limit op size to 512KB, mtds been set to 7, which is 2 ^(7 +
> 12) = 512KB (-9 is to convert number of 512 bytes sectors).
> With the proposed change it will become 7 * 8 = 28 sectors or 14K max op
> size which seems wrong.
> With the proposed code maximum op size would be 255 * 8 = 2040 sectors
> (1020 KB) and not sure that is the intention of the specs.

Yeah, the change is not equivalent or spec compliant, so Nak.
 
> Also, when "mdts" is zero NVMe specs says no restriction on op size which
> might be true from controller perspective.
> When looking at NVMe I/O commands (Read, Write, Compare) number of Logical
> Blocks (nlb) field is defined as 16 bits.
> Should it be ctrl->max_hw_sectors = USHRT_MAX; to limit max of 0xFFFF?  Am
> I reading the specs correctly?

The NLB field is in units of logical blocks, and at the point we're
setting max h/w sectors in 512b units, we don't know how large a namespace
logical block is. The spec allows a lot of flexibility here. If we set
max h/w sectors to 0xffff as suggested, that's only 32MB transfer. If
a logical block size is 4k, that means NLB maxes at only 0x2000 when it
could have handled 0xffff. Even worse for larger namespace block sizes.

But yes, the code doesn't set max sectors on this over flow condition
correctly for devices that have such a high MDTS. I think transfer size
probably needs to be re-checked when the namespace is discovered and
change the queue's setting accordingly.
