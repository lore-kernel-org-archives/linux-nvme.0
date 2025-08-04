Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7E0C87FCF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Aug 2025 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fp3cUkx4BfhRvbD0ThNopsC3ryv+hEARBo44UvU4dcA=; b=WcocAXz8nQybf6ierQKxVXairW
	81h4XSVwU+3IEme+dmidAw7bd+dJ5ej7PtXMKC7ua0gPDmpjO9VO21md11jAccycvHtBA50hhMir2
	gmJkMwxnukquVbIqaOKh8Sv0lBy7KCTDH71/6d9rI/2au3CI/9HisvV3fECo7J3JMcoZg6WLq2NXf
	L6AAFVh+TrY+zP+Fs6FdlICZYr4Agk1TkV6ALwP5w1EIvGJP0HptoNnTnwX9a4dCSU06NdLE3Z1+9
	r9KFG78CEB00dtlLQVHaNa7KP4ZH5uaST2xZQX0+uN60PjXSXo9SpnO6xls6ar5k3ec5v/5Eh+vQB
	ZbVr6/UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uixUH-0000000AsxC-0pvU;
	Mon, 04 Aug 2025 15:52:33 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiwzT-0000000Am3n-2VLp
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 15:20:45 +0000
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bwgDZ2Q8Lz67MfC;
	Mon,  4 Aug 2025 23:18:22 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id C58031402F4;
	Mon,  4 Aug 2025 23:20:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Aug 2025 17:20:34 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 4 Aug 2025 17:20:34 +0200
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Chaitanya Kulkarni <kch@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Konrad.wilk@oracle.com"
	<Konrad.wilk@oracle.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, Lei Rao
	<lei.rao@intel.com>
Subject: RE: [RFC PATCH 1/4] vfio-nvme: add vfio-nvme lm driver infrastructure
Thread-Topic: [RFC PATCH 1/4] vfio-nvme: add vfio-nvme lm driver
 infrastructure
Thread-Index: AQHcBCEeW2m/ZRTCHEOFPJNpa8d47LRSmWZQ
Date: Mon, 4 Aug 2025 15:20:34 +0000
Message-ID: <6169cedfd63b4158a8b115c5f505f59c@huawei.com>
References: <20250803024705.10256-1-kch@nvidia.com>
 <20250803024705.10256-2-kch@nvidia.com>
In-Reply-To: <20250803024705.10256-2-kch@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_082043_927285_55711A6A 
X-CRM114-Status: GOOD (  32.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Chaitanya Kulkarni <kch@nvidia.com>
> Sent: Sunday, August 3, 2025 3:47 AM
> To: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me;
> alex.williamson@redhat.com; cohuck@redhat.com; jgg@ziepe.ca;
> yishaih@nvidia.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; kevin.tian@intel.com;
> mjrosato@linux.ibm.com; mgurtovoy@nvidia.com
> Cc: linux-nvme@lists.infradead.org; kvm@vger.kernel.org;
> Konrad.wilk@oracle.com; martin.petersen@oracle.com;
> jmeneghi@redhat.com; arnd@arndb.de; schnelle@linux.ibm.com;
> bhelgaas@google.com; joao.m.martins@oracle.com; Chaitanya Kulkarni
> <kch@nvidia.com>; Lei Rao <lei.rao@intel.com>
> Subject: [RFC PATCH 1/4] vfio-nvme: add vfio-nvme lm driver infrastructur=
e
>=20
> Add foundational infrastructure for vfio-nvme, enabling support for live
> migration of NVMe devices via the VFIO framework. The following
> components are included:
>=20
> - Core driver skeleton for vfio-nvme support under drivers/vfio/pci/nvme/
> - Definitions of basic data structures used in live migration
>   (e.g., nvmevf_pci_core_device and nvmevf_migration_file)
> - Implementation of helper routines for managing migration file state
> - Integration of PCI driver callbacks and error handling logic
> - Registration with vfio-pci-core through nvmevf_pci_ops
> - Initial support for VFIO migration states and device open/close flows
>=20
> Subsequent patches will build upon this base to implement actual live
> migration commands and complete the vfio device state handling logic.
>=20
> Signed-off-by: Lei Rao <lei.rao@intel.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/vfio/pci/Kconfig       |   2 +
>  drivers/vfio/pci/Makefile      |   2 +
>  drivers/vfio/pci/nvme/Kconfig  |  10 ++
>  drivers/vfio/pci/nvme/Makefile |   3 +
>  drivers/vfio/pci/nvme/nvme.c   | 196
> +++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/nvme/nvme.h   |  36 ++++++
>  6 files changed, 249 insertions(+)
>  create mode 100644 drivers/vfio/pci/nvme/Kconfig
>  create mode 100644 drivers/vfio/pci/nvme/Makefile
>  create mode 100644 drivers/vfio/pci/nvme/nvme.c
>  create mode 100644 drivers/vfio/pci/nvme/nvme.h
>=20
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 2b0172f54665..8f94429e7adc 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -67,4 +67,6 @@ source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
>=20
>  source "drivers/vfio/pci/qat/Kconfig"
>=20
> +source "drivers/vfio/pci/nvme/Kconfig"
> +
>  endmenu
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index cf00c0a7e55c..be8c4b5ee0ba 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -10,6 +10,8 @@ obj-$(CONFIG_VFIO_PCI) +=3D vfio-pci.o
>=20
>  obj-$(CONFIG_MLX5_VFIO_PCI)           +=3D mlx5/
>=20
> +obj-$(CONFIG_NVME_VFIO_PCI) +=3D nvme/
> +
>  obj-$(CONFIG_HISI_ACC_VFIO_PCI) +=3D hisilicon/
>=20
>  obj-$(CONFIG_PDS_VFIO_PCI) +=3D pds/
> diff --git a/drivers/vfio/pci/nvme/Kconfig b/drivers/vfio/pci/nvme/Kconfi=
g
> new file mode 100644
> index 000000000000..12e0eaba0de1
> --- /dev/null
> +++ b/drivers/vfio/pci/nvme/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NVME_VFIO_PCI
> +	tristate "VFIO support for NVMe PCI devices"
> +	depends on NVME_CORE
> +	depends on VFIO_PCI_CORE
> +	help
> +	  This provides migration support for NVMe devices using the
> +	  VFIO framework.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/pci/nvme/Makefile b/drivers/vfio/pci/nvme/Makef=
ile
> new file mode 100644
> index 000000000000..2f4a0ad3d9cf
> --- /dev/null
> +++ b/drivers/vfio/pci/nvme/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_NVME_VFIO_PCI) +=3D nvme-vfio-pci.o
> +nvme-vfio-pci-y :=3D nvme.o
> diff --git a/drivers/vfio/pci/nvme/nvme.c b/drivers/vfio/pci/nvme/nvme.c
> new file mode 100644
> index 000000000000..08bee3274207
> --- /dev/null
> +++ b/drivers/vfio/pci/nvme/nvme.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, INTEL CORPORATION. All rights reserved
> + * Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved
> + */
> +
> +#include <linux/device.h>
> +#include <linux/eventfd.h>
> +#include <linux/file.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <linux/vfio.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/kernel.h>
> +#include <linux/vfio_pci_core.h>
> +
> +#include "nvme.h"
> +
> +static void nvmevf_disable_fd(struct nvmevf_migration_file *migf)
> +{
> +	mutex_lock(&migf->lock);
> +
> +	/* release the device states buffer */
> +	kvfree(migf->vf_data);
> +	migf->vf_data =3D NULL;
> +	migf->disabled =3D true;
> +	migf->total_length =3D 0;
> +	migf->filp->f_pos =3D 0;
> +	mutex_unlock(&migf->lock);

May be we can use guard(mutex) here and elsewhere for this driver now?

> +}
> +
> +static void nvmevf_disable_fds(struct nvmevf_pci_core_device
> *nvmevf_dev)
> +{
> +	if (nvmevf_dev->resuming_migf) {
> +		nvmevf_disable_fd(nvmevf_dev->resuming_migf);
> +		fput(nvmevf_dev->resuming_migf->filp);
> +		nvmevf_dev->resuming_migf =3D NULL;
> +	}
> +
> +	if (nvmevf_dev->saving_migf) {
> +		nvmevf_disable_fd(nvmevf_dev->saving_migf);
> +		fput(nvmevf_dev->saving_migf->filp);
> +		nvmevf_dev->saving_migf =3D NULL;
> +	}
> +}
> +
> +static void nvmevf_state_mutex_unlock(struct nvmevf_pci_core_device
> *nvmevf_dev)
> +{
> +	lockdep_assert_held(&nvmevf_dev->state_mutex);
> +again:
> +	spin_lock(&nvmevf_dev->reset_lock);
> +	if (nvmevf_dev->deferred_reset) {
> +		nvmevf_dev->deferred_reset =3D false;
> +		spin_unlock(&nvmevf_dev->reset_lock);
> +		nvmevf_dev->mig_state =3D VFIO_DEVICE_STATE_RUNNING;
> +		nvmevf_disable_fds(nvmevf_dev);
> +		goto again;
> +	}
> +	mutex_unlock(&nvmevf_dev->state_mutex);
> +	spin_unlock(&nvmevf_dev->reset_lock);
> +}
> +
> +static struct nvmevf_pci_core_device *nvmevf_drvdata(struct pci_dev
> *pdev)
> +{
> +	struct vfio_pci_core_device *core_device =3D dev_get_drvdata(&pdev-
> >dev);
> +
> +	return container_of(core_device, struct nvmevf_pci_core_device,
> +			    core_device);
> +}
> +
> +static int nvmevf_pci_open_device(struct vfio_device *core_vdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev;
> +	struct vfio_pci_core_device *vdev;
> +	int ret;
> +
> +	nvmevf_dev =3D container_of(core_vdev, struct
> nvmevf_pci_core_device,
> +			core_device.vdev);
> +	vdev =3D &nvmevf_dev->core_device;
> +
> +	ret =3D vfio_pci_core_enable(vdev);
> +	if (ret)
> +		return ret;
> +
> +	if (nvmevf_dev->migrate_cap)
> +		nvmevf_dev->mig_state =3D VFIO_DEVICE_STATE_RUNNING;
> +	vfio_pci_core_finish_enable(vdev);
> +	return 0;
> +}
> +
> +static void nvmevf_pci_close_device(struct vfio_device *core_vdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev;
> +
> +	nvmevf_dev =3D container_of(core_vdev, struct
> nvmevf_pci_core_device,
> +			core_device.vdev);
> +
> +	if (nvmevf_dev->migrate_cap) {
> +		mutex_lock(&nvmevf_dev->state_mutex);
> +		nvmevf_disable_fds(nvmevf_dev);
> +		nvmevf_state_mutex_unlock(nvmevf_dev);
> +	}
> +
> +	vfio_pci_core_close_device(core_vdev);
> +}
> +
> +static const struct vfio_device_ops nvmevf_pci_ops =3D {
> +	.name =3D "nvme-vfio-pci",
> +	.release =3D vfio_pci_core_release_dev,
> +	.open_device =3D nvmevf_pci_open_device,
> +	.close_device =3D nvmevf_pci_close_device,
> +	.ioctl =3D vfio_pci_core_ioctl,
> +	.device_feature =3D vfio_pci_core_ioctl_feature,
> +	.read =3D vfio_pci_core_read,
> +	.write =3D vfio_pci_core_write,
> +	.mmap =3D vfio_pci_core_mmap,
> +	.request =3D vfio_pci_core_request,
> +	.match =3D vfio_pci_core_match,

Any reason why this driver don't need the iommufd related callbacks?
bind_iommufd/unbind_iommufd etc?


> +};
> +
> +static int nvmevf_pci_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev;
> +	int ret;
> +
> +	nvmevf_dev =3D vfio_alloc_device(nvmevf_pci_core_device,
> core_device.vdev,
> +				       &pdev->dev, &nvmevf_pci_ops);
> +	if (IS_ERR(nvmevf_dev))
> +		return PTR_ERR(nvmevf_dev);
> +
> +	dev_set_drvdata(&pdev->dev, &nvmevf_dev->core_device);
> +	ret =3D vfio_pci_core_register_device(&nvmevf_dev->core_device);
> +	if (ret)
> +		goto out_put_dev;
> +
> +	return 0;
> +
> +out_put_dev:
> +	vfio_put_device(&nvmevf_dev->core_device.vdev);
> +	return ret;
> +}
> +
> +static void nvmevf_pci_remove(struct pci_dev *pdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev =3D
> nvmevf_drvdata(pdev);
> +
> +	vfio_pci_core_unregister_device(&nvmevf_dev->core_device);
> +	vfio_put_device(&nvmevf_dev->core_device.vdev);
> +}
> +
> +static void nvmevf_pci_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev =3D
> nvmevf_drvdata(pdev);
> +
> +	if (!nvmevf_dev->migrate_cap)
> +		return;
> +
> +	/*
> +	 * As the higher VFIO layers are holding locks across reset and using
> +	 * those same locks with the mm_lock we need to prevent ABBA
> deadlock
> +	 * with the state_mutex and mm_lock.
> +	 * In case the state_mutex was taken already we defer the cleanup
> work
> +	 * to the unlock flow of the other running context.
> +	 */

I am not sure this is relevant for this driver. This deferred logic was add=
ed to avoid
a circular locking issue w.r.t copy_to/from_user() functions holding mm_loc=
k=20
under state mutex.=20

See this,
https://lore.kernel.org/all/20240229091152.56664-1-shameerali.kolothum.thod=
i@huawei.com/

Looking at patch #4 it doesn't look like this has that issue. May be I miss=
ed it.
Please double check.
=20
Thanks,
Shameer

> +	spin_lock(&nvmevf_dev->reset_lock);
> +	nvmevf_dev->deferred_reset =3D true;
> +	if (!mutex_trylock(&nvmevf_dev->state_mutex)) {
> +		spin_unlock(&nvmevf_dev->reset_lock);
> +		return;
> +	}
> +	spin_unlock(&nvmevf_dev->reset_lock);
> +	nvmevf_state_mutex_unlock(nvmevf_dev);
> +}
> +
> +static const struct pci_error_handlers nvmevf_err_handlers =3D {
> +	.reset_done =3D nvmevf_pci_aer_reset_done,
> +	.error_detected =3D vfio_pci_core_aer_err_detected,
> +};
> +
> +static struct pci_driver nvmevf_pci_driver =3D {
> +	.name =3D KBUILD_MODNAME,
> +	.probe =3D nvmevf_pci_probe,
> +	.remove =3D nvmevf_pci_remove,
> +	.err_handler =3D &nvmevf_err_handlers,
> +	.driver_managed_dma =3D true,
> +};
> +
> +module_pci_driver(nvmevf_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Chaitanya Kulkarni <kch@nvidia.com>");
> +MODULE_DESCRIPTION("NVMe VFIO PCI - VFIO PCI driver with live
> migration support for NVMe");
> diff --git a/drivers/vfio/pci/nvme/nvme.h b/drivers/vfio/pci/nvme/nvme.h
> new file mode 100644
> index 000000000000..ee602254679e
> --- /dev/null
> +++ b/drivers/vfio/pci/nvme/nvme.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022, INTEL CORPORATION. All rights reserved
> + * Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved
> + */
> +
> +#ifndef NVME_VFIO_PCI_H
> +#define NVME_VFIO_PCI_H
> +
> +#include <linux/kernel.h>
> +#include <linux/vfio_pci_core.h>
> +#include <linux/nvme.h>
> +
> +struct nvmevf_migration_file {
> +	struct file *filp;
> +	struct mutex lock;
> +	bool disabled;
> +	u8 *vf_data;
> +	size_t total_length;
> +};
> +
> +struct nvmevf_pci_core_device {
> +	struct vfio_pci_core_device core_device;
> +	int vf_id;
> +	u8 migrate_cap:1;
> +	u8 deferred_reset:1;
> +	/* protect migration state */
> +	struct mutex state_mutex;
> +	enum vfio_device_mig_state mig_state;
> +	/* protect the reset_done flow */
> +	spinlock_t reset_lock;
> +	struct nvmevf_migration_file *resuming_migf;
> +	struct nvmevf_migration_file *saving_migf;
> +};
> +
> +#endif /* NVME_VFIO_PCI_H */
> --
> 2.40.0


