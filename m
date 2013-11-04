From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Mon, 4 Nov 2013 11:44:54 -0600
Subject: [PATCH] NVMe: Add a buffer length parameter to struct
 nvme_user_io. Check
 buffer length in nvme_submit_io to avoid buffer overflow.
In-Reply-To: <alpine.LRH.2.03.1311041022000.4763@AMR>
Message-ID: <OFCFFBC5FE.B1F60569-ON88257C19.0060BAE8-86257C19.00617F0B@hgst.com>

The patch was for a reported problem. I have a testcase that segfaults 
after the user buffer is over written. I created a request to read 1 LBA, 
and passed in a buffer of less than 512 bytes. The driver wrote past the 
buffer, corrupting storage leading to the segfault. There is a similar 
param and length check in the sg ioctl path. Look near the end of 
nvme_trans_io. In my case, the buffer is allocated on the stack, as a 
local variable. that might explain why get_user_pages does not catch the 
mistake.





 

"Linux-nvme" <linux-nvme-bounces at lists.infradead.org> wrote on 11/04/2013 
11:27:29 AM:

> On Mon, 4 Nov 2013, David Darrington wrote:
> 
> > Added a buffer length parameter to struct nvme_user_io so that
> > nvme_submit_io can prevent writing past the end of the user buffer.
> 
> This extra check seems redundant. Doesn't get_user_pages_fast already
> fail if the user buffer is too small?
> 
> >
> > Signed-off-by: David Darrington <david.darrington at hgst.com>
> > ---
> > drivers/block/nvme-core.c |    6 +++++-
> > include/uapi/linux/nvme.h |    4 +++-
> > 2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index da52092..2aa4346 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -1381,6 +1381,10 @@ static int nvme_submit_io(struct nvme_ns 
> *ns, struct nvme_user_io __user *uio)
> >    if (copy_from_user(&io, uio, sizeof(io)))
> >       return -EFAULT;
> >    length = (io.nblocks + 1) << ns->lba_shift;
> > +
> > +   if (io.dxfer_len < length)
> > +      return -EINVAL;
> > +
> >    meta_len = (io.nblocks + 1) * ns->ms;
> >
> >    if (meta_len && ((io.metadata & 3) || !io.metadata))
> > @@ -1390,7 +1394,7 @@ static int nvme_submit_io(struct nvme_ns 
> *ns, struct nvme_user_io __user *uio)
> >    case nvme_cmd_write:
> >    case nvme_cmd_read:
> >    case nvme_cmd_compare:
> > -      iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
> > +      iod = nvme_map_user_pages(dev, io.opcode & 1, io.dxferp, 
length);
> >       break;
> >    default:
> >       return -EINVAL;
> > diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
> > index 989c04e..40b5b52 100644
> > --- a/include/uapi/linux/nvme.h
> > +++ b/include/uapi/linux/nvme.h
> > @@ -441,7 +441,9 @@ struct nvme_user_io {
> >    __u16   nblocks;
> >    __u16   rsvd;
> >    __u64   metadata;
> > -   __u64   addr;
> > +   __u32   rsvd1;
> > +   __u32   dxfer_len;   /* length of data xfer buffer */
> > +   __u64   dxferp;      /* pointer to data xfer buffer */
> >    __u64   slba;
> >    __u32   dsmgmt;
> >    __u32   reftag;
> > -- 
> > 1.7.1
> >
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://merlin.infradead.org/mailman/listinfo/linux-nvme
> >
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
