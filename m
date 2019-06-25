From: zwp10758@gmail.com (Weiping Zhang)
Date: Tue, 25 Jun 2019 22:46:02 +0800
Subject: [PATCH v3 2/5] nvme: add get_ams for nvme_ctrl_ops
In-Reply-To: <20190624201256.GC6526@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <2c916063e19cc3f33376d7bb0fb8a5ff10ea42db.1561385989.git.zhangweiping@didiglobal.com>
 <20190624201256.GC6526@minwooim-desktop>
Message-ID: <CAA70yB4DJdN8qJAMs7D3tzHxrsHofB65pTzk5mn8UY=1aKWyZA@mail.gmail.com>

Minwoo Im <minwoo.im.dev at gmail.com> ?2019?6?25??? ??6:01???
>
> On 19-06-24 22:29:05, Weiping Zhang wrote:
> > The get_ams() will return the AMS(Arbitration Mechanism Selected)
> > from the driver.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping at didiglobal.com>
>
> Hello, Weiping.
>
> Sorry, but I don't really get what your point is here.  Could you please
> elaborate this patch a little bit more?  The commit description just
> says a function would just return the AMS from nowhere..
>
I will add more detail description for this operation in commit message,
when we enable nvme controller, we need to know the correct AMS setting.

 There two cases for NVME_CC_AMS_RR:
1. nvme controller doesn't support AMS, now we set ams to NVME_CC_AMS_RR.
2. nvme controller support AMS, but the user did not want to enable
it, for example
set all wrr_xxx_queue to 0.

We only set ams to NVME_CC_AMS_WRRU if nvme controller support WRR and
the user want to enable it explictly.

nvme_enable_ctrl is a common function for nvme-pci, nvme-rdma, nvme-tcp,
it needs to konw the correct AMS setting from different nvme driver by
this operation.

> > ---
> >  drivers/nvme/host/core.c | 9 ++++++++-
> >  drivers/nvme/host/nvme.h | 1 +
> >  drivers/nvme/host/pci.c  | 6 ++++++
> >  include/linux/nvme.h     | 1 +
> >  4 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index b2dd4e391f5c..4cb781e73123 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1943,6 +1943,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
> >        */
> >       unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12, page_shift = 12;
> >       int ret;
> > +     u32 ams = NVME_CC_AMS_RR;
> >
> >       if (page_shift < dev_page_min) {
> >               dev_err(ctrl->device,
> > @@ -1951,11 +1952,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
> >               return -ENODEV;
> >       }
> >
> > +     /* get Arbitration Mechanism Selected */
> > +     if (ctrl->ops->get_ams) {
>
> I just wonder if this check will be valid because this patch just
> register the function nvme_pci_get_ams() without any conditions.
The nvme-pci, nvme-rdma,, should make sure that the ams is valid,
for example check CAP.AMS and other conditions.
>
> > +             ctrl->ops->get_ams(ctrl, &ams);
> > +             ams &= NVME_CC_AMS_MASK;
> > +     }
> > +
> >       ctrl->page_size = 1 << page_shift;
> >
> >       ctrl->ctrl_config = NVME_CC_CSS_NVM;
> >       ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
> > -     ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> > +     ctrl->ctrl_config |= ams | NVME_CC_SHN_NONE;
> >       ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> >       ctrl->ctrl_config |= NVME_CC_ENABLE;
> >
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index ea45d7d393ad..9c7e9217f78b 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -369,6 +369,7 @@ struct nvme_ctrl_ops {
> >       void (*submit_async_event)(struct nvme_ctrl *ctrl);
> >       void (*delete_ctrl)(struct nvme_ctrl *ctrl);
> >       int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> > +     void (*get_ams)(struct nvme_ctrl *ctrl, u32 *ams);
>
> Can we just have a return value for the AMS value?
Both these two methods are acceptable to me.
>
> >  };
> >
> >  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 189352081994..5d84241f0214 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2627,6 +2627,11 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
> >       return snprintf(buf, size, "%s", dev_name(&pdev->dev));
> >  }
> >
> > +static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
> > +{
> > +     *ams = NVME_CC_AMS_RR;
> > +}
> > +
> >  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
> >       .name                   = "pcie",
> >       .module                 = THIS_MODULE,
> > @@ -2638,6 +2643,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
> >       .free_ctrl              = nvme_pci_free_ctrl,
> >       .submit_async_event     = nvme_pci_submit_async_event,
> >       .get_address            = nvme_pci_get_address,
> > +     .get_ams                = nvme_pci_get_ams,
>
> Question: Do we really need this being added to nvme_ctrl_ops?
>
> Also If 5th patch will make this function much more than this, then it
> would be great if you describe this kind of situation in description :)
>
> >  };
> >
> >  static int nvme_dev_map(struct nvme_dev *dev)
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index da5f696aec00..8f71451fc2fa 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -156,6 +156,7 @@ enum {
> >       NVME_CC_AMS_RR          = 0 << NVME_CC_AMS_SHIFT,
> >       NVME_CC_AMS_WRRU        = 1 << NVME_CC_AMS_SHIFT,
> >       NVME_CC_AMS_VS          = 7 << NVME_CC_AMS_SHIFT,
> > +     NVME_CC_AMS_MASK        = 7 << NVME_CC_AMS_SHIFT,
> >       NVME_CC_SHN_NONE        = 0 << NVME_CC_SHN_SHIFT,
> >       NVME_CC_SHN_NORMAL      = 1 << NVME_CC_SHN_SHIFT,
> >       NVME_CC_SHN_ABRUPT      = 2 << NVME_CC_SHN_SHIFT,
> > --
> > 2.14.1
> >
