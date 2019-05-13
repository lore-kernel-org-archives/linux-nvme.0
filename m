From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 13 May 2019 23:59:52 +0900
Subject: [PATCH v3 6/7] nvme-pci: trigger device coredump on command
 timeout
In-Reply-To: <20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7@epcms2p5>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <CGME20190512155533epcas4p110edff15ebf5b2efae32e43f0f10ab59@epcms2p5>
 <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
 <20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7@epcms2p5>
Message-ID: <CAC5umyjrYddqtQY8LdoXG8S7s7xaAO3oZz7WRDkfnjrkUj2AcQ@mail.gmail.com>

2019?5?13?(?) 16:41 Minwoo Im <minwoo.im at samsung.com>:
>
> > -static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
> > -static void __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
> > -static void __maybe_unused nvme_coredump_complete(struct nvme_dev
> > *dev);
> > +static void nvme_coredump_init(struct nvme_dev *dev);
> > +static void nvme_coredump_logs(struct nvme_dev *dev);
> > +static void nvme_coredump_complete(struct nvme_dev *dev);
>
> You just have added those three prototypes in previous patch.  Did I miss
> something here?

These __maybe_unused are needed only in the patch 5/7.
Because these functions are still unused before applying patch 6/7.
