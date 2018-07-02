From: zwp10758@gmail.com (Weiping Zhang)
Date: Tue, 3 Jul 2018 00:13:35 +0800
Subject: [PATCH 2/2] nvme-pci: release nvme_ctrl if failed to alloc memory
 in nvme_probe
In-Reply-To: <ae68b07d-9b30-a85e-61e5-b76f4e1a2937@grimberg.me>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
 <4c6892da67db3aada7ee4ca5087b44fcb8dde30c.1530457943.git.zhangweiping@didichuxing.com>
 <ae68b07d-9b30-a85e-61e5-b76f4e1a2937@grimberg.me>
Message-ID: <CAA70yB5B29czbcAfGpkAB9LwzbWj4X3uVfh_4KeQ4qCyGF_acw@mail.gmail.com>

Sagi Grimberg <sagi at grimberg.me> ?2018?7?2??? ??5:54???
>
>
> > +release_ctrl:
> > +     nvme_uninit_ctrl(&dev->ctrl);
> > +     nvme_put_ctrl(&dev->ctrl);
>
> Hmm, put_ctrl would trigger nvme_pci_free_ctrl which will
> do some of what you fallthru down here, won't that cause
> double free/put?
>
You are right, I plan to move all this cleanup to nvme_pci_ctrl_free,
If failed before call nvme_init_ctrl, do cleanup by these goto.
if failed after call nvme_init_ctrl, direct use nvme_put_ctrl to release
all these resource.

I'll send V2.
> >   release_pools:
> >       nvme_release_prp_pools(dev);
> >   unmap:
> >
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
