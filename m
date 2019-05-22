From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 23 May 2019 00:24:27 +0900
Subject: [PATCH v2 1/4] nvme: Export get and set features
In-Reply-To: <DM6PR04MB57543310310DD72F98E361AD86070@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-2-git-send-email-akinobu.mita@gmail.com>
 <DM6PR04MB57543310310DD72F98E361AD86070@DM6PR04MB5754.namprd04.prod.outlook.com>
Message-ID: <CAC5umyg9_46ckKXnZG54ZyJxdpZSQm+yA9FXdW16bQW-qFkT4Q@mail.gmail.com>

2019?5?22?(?) 2:23 Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>:
>
> On 5/21/19 9:05 AM, Akinobu Mita wrote:
> > From: Keith Busch <keith.busch at intel.com>
> >
> > Future use intends to make use of features, so export these functions. And
> > since their implementation is identical except for the opcode, provide
> > a new convenience function that implement each.
> >
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> > ---
> >  drivers/nvme/host/core.c | 22 +++++++++++++++++++---
> >  drivers/nvme/host/nvme.h |  4 ++++
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index d352145..c04df80 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
> >       return id;
> >  }
> >
> > -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> > -                   void *buffer, size_t buflen, u32 *result)
> > +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,
> > +             unsigned dword11, void *buffer, size_t buflen, u32 *result)
>
> Your patch is generating warnings, can we please avoid these warnings ?
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #28: FILE: drivers/nvme/host/core.c:1116:
> +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,

OK.  I'll convert all 'unsigned' to 'unsigned int' in this patch.
