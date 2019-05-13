From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 13 May 2019 16:41:20 +0900
Subject: [PATCH v3 6/7] nvme-pci: trigger device coredump on command
 timeout
In-Reply-To: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <CGME20190512155533epcas4p110edff15ebf5b2efae32e43f0f10ab59@epcms2p5>
Message-ID: <20190513074120epcms2p54e3a031668274ac1ebace6c5edc0a3f7@epcms2p5>

> -static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
> -static void __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
> -static void __maybe_unused nvme_coredump_complete(struct nvme_dev
> *dev);
> +static void nvme_coredump_init(struct nvme_dev *dev);
> +static void nvme_coredump_logs(struct nvme_dev *dev);
> +static void nvme_coredump_complete(struct nvme_dev *dev);

You just have added those three prototypes in previous patch.  Did I miss
something here?
