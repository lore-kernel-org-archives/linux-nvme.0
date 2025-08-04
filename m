Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B0DC87FCF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Aug 2025 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifPoPArnPhl3u1Iy0qR8vOTQVHkP75PNuOwsPMhVK0s=; b=UHSEYV84eptZWwZc1c2qBR1UHX
	Wruoi7SpC5hdy7j53ntOszhAQmZxAoPKQxNSorHOTeq351jM+vLjPwU/e+XOnkBzIDPKSEoIIFOhZ
	TyrRWRXfwQ7PgVCsb57vCCSxAhkVEVBaIPpATRek+apJvHBc0KzXCpMEooN7UI9fH+k/Z/2QPaUEF
	VwRszsVWOU553J8Ldwy4AsHZEUZpdM5yVlIqae9KI9lIjgH8XiyJTFBWFQwde8YMqLFKM9cwg1f+U
	wI9i2Wbz1wcFSsM0jOVCX4QoOYYZJ694eVfFP5WAkg3o6k2GaEWleVnNT3J5mnKio4Qxp3KeaWXqv
	Z9a/ZoVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiynB-0000000B4y6-1NEb;
	Mon, 04 Aug 2025 17:16:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiyn6-0000000B4xj-0Nji
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 17:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754327761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifPoPArnPhl3u1Iy0qR8vOTQVHkP75PNuOwsPMhVK0s=;
	b=Zuz1v+IUNO44LuL6E1Nzv5S08rxQ+LqvkD6ED7fEj9oLorChgEWtRvKdERLC96bd83h6Qx
	rfKf4pBJZo7cf0oVRm+Cnb81+85CBAjnlZNUW/Sj84Kbz9WrxRYT8Uy33RteJIRYoxhfbL
	W3q4w4yvGEr2qon+HwCRKH+zk1CvJaQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Zwr2b_jSMF-0qb-TXWiXlg-1; Mon, 04 Aug 2025 13:16:00 -0400
X-MC-Unique: Zwr2b_jSMF-0qb-TXWiXlg-1
X-Mimecast-MFC-AGG-ID: Zwr2b_jSMF-0qb-TXWiXlg_1754327759
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3fee1d6f2so5381915ab.2
        for <linux-nvme@lists.infradead.org>; Mon, 04 Aug 2025 10:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327759; x=1754932559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifPoPArnPhl3u1Iy0qR8vOTQVHkP75PNuOwsPMhVK0s=;
        b=LTQQF5RM/IIoRnkQxVyW8wkzMwcRetcbS8813FdU5I7NDnUa5U0AmfgKFR/2iZkiV0
         KEMEhh7Ecw7A33SDhKI/Eo3b5ur/T8Q2p2IyWZF2Yxh9BZEjiq2otLQyaN6UeSSUS+aC
         +oQwsGxm6oKzSO8ilrQfnJi24ATM60EXKLFWBFMzz5L7BpybAg+7DbB/HRSuNwvWRq0J
         8hgEBOzbvhi43FHQPVZeYZX7F82Ltil0qgLhLcvdtIUeUelUDke/Co7iY1P3kvrtnlML
         d3eRU+/dGDbfWDz89ofpDmKQFaKjsvCFXO4KJiwvpbhITZ/nYlkQ4sGqHk4NzoM0VLGH
         ewcg==
X-Forwarded-Encrypted: i=1; AJvYcCX2fcyAEaJrpoPEKATE5SiK43dnAe8fzCZqWjDVgb6uV5VjksB9HPR24z7946kirOLfMGZ3s9zLn5Ct@lists.infradead.org
X-Gm-Message-State: AOJu0YyVmh7lZOXzLDmjN5mLwE/kGoYjLInlzVa4qRwv2EZCZEeV88qi
	EqTc38z7qh80RcZLk5VvAd1BCpYXNEaMDj19BfkeD/7rtNLrDIUFlaMUI5leXZLlYanP4btyoo6
	31X6AQrJvPK+HypGHn6FMo1HaXLEGmo3qTif3vP/xpgCa7LcJQv+GdEUJ4TGDOg54FovU
X-Gm-Gg: ASbGncvrj0PSxHtKqLsA6glf70gbNq0ch5rGJ8czwpW/RNCSk1FKJoBCYnvAlNZhBuz
	wRJvGMiBwMBa+CZ+K4iVnrjUbfWrZuXV/Asjdl9X3/Dz+lsHRM9FOv9tc8QaGnvjWVpIM5XffrL
	M3aTM8DeN1HRjXYAI/J3J+WQ6IqteozkGqrKCUvcpF0GxrpFPDXy/XKkv/Rdhcdn653R0qPCJGq
	JnLHffNPY/xVpf4zb7RwILO86XuWCj9c/0OYZmxCYKtn7788/uiLlLWOaqFljtzu8Ru8ke6ISQR
	8K0QPVhf77DRYO9opXW8zcwgBKFF9y/5odRbt3AKn+A=
X-Received: by 2002:a05:6602:1652:b0:87c:3321:b568 with SMTP id ca18e2360f4ac-881683f05bamr459133039f.5.1754327759308;
        Mon, 04 Aug 2025 10:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Ti+Aql/PL1H1/VgAsxX08jNfn8kHbDDIc3cnViriiWYiYbsqZOmahbVtbKW/GjIxamJpkQ==
X-Received: by 2002:a05:6602:1652:b0:87c:3321:b568 with SMTP id ca18e2360f4ac-881683f05bamr459129439f.5.1754327758736;
        Mon, 04 Aug 2025 10:15:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8818b151319sm40810839f.0.2025.08.04.10.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 10:15:57 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:15:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <cohuck@redhat.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <mjrosato@linux.ibm.com>, <mgurtovoy@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <kvm@vger.kernel.org>,
 <Konrad.wilk@oracle.com>, <martin.petersen@oracle.com>,
 <jmeneghi@redhat.com>, <arnd@arndb.de>, <schnelle@linux.ibm.com>,
 <bhelgaas@google.com>, <joao.m.martins@oracle.com>, Lei Rao
 <lei.rao@intel.com>
Subject: Re: [RFC PATCH 1/4] vfio-nvme: add vfio-nvme lm driver
 infrastructure
Message-ID: <20250804111556.3ba2c832.alex.williamson@redhat.com>
In-Reply-To: <20250803024705.10256-2-kch@nvidia.com>
References: <20250803024705.10256-1-kch@nvidia.com>
	<20250803024705.10256-2-kch@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I1uAE_KfQG4sql4OSJpLxJCtsojJR7grRlvY1MOtARk_1754327759
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_101604_285899_B5569074 
X-CRM114-Status: GOOD (  33.28  )
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

On Sat, 2 Aug 2025 19:47:02 -0700
Chaitanya Kulkarni <kch@nvidia.com> wrote:

> Add foundational infrastructure for vfio-nvme, enabling support for live
> migration of NVMe devices via the VFIO framework. The following
> components are included:
> 
> - Core driver skeleton for vfio-nvme support under drivers/vfio/pci/nvme/
> - Definitions of basic data structures used in live migration
>   (e.g., nvmevf_pci_core_device and nvmevf_migration_file)
> - Implementation of helper routines for managing migration file state
> - Integration of PCI driver callbacks and error handling logic
> - Registration with vfio-pci-core through nvmevf_pci_ops
> - Initial support for VFIO migration states and device open/close flows
> 
> Subsequent patches will build upon this base to implement actual live
> migration commands and complete the vfio device state handling logic.
> 
> Signed-off-by: Lei Rao <lei.rao@intel.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/vfio/pci/Kconfig       |   2 +
>  drivers/vfio/pci/Makefile      |   2 +
>  drivers/vfio/pci/nvme/Kconfig  |  10 ++
>  drivers/vfio/pci/nvme/Makefile |   3 +
>  drivers/vfio/pci/nvme/nvme.c   | 196 +++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/nvme/nvme.h   |  36 ++++++
>  6 files changed, 249 insertions(+)
>  create mode 100644 drivers/vfio/pci/nvme/Kconfig
>  create mode 100644 drivers/vfio/pci/nvme/Makefile
>  create mode 100644 drivers/vfio/pci/nvme/nvme.c
>  create mode 100644 drivers/vfio/pci/nvme/nvme.h
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 2b0172f54665..8f94429e7adc 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -67,4 +67,6 @@ source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
>  
>  source "drivers/vfio/pci/qat/Kconfig"
>  
> +source "drivers/vfio/pci/nvme/Kconfig"
> +
>  endmenu
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index cf00c0a7e55c..be8c4b5ee0ba 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -10,6 +10,8 @@ obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
>  
>  obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
>  
> +obj-$(CONFIG_NVME_VFIO_PCI) += nvme/
> +
>  obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
>  
>  obj-$(CONFIG_PDS_VFIO_PCI) += pds/
> diff --git a/drivers/vfio/pci/nvme/Kconfig b/drivers/vfio/pci/nvme/Kconfig
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
> diff --git a/drivers/vfio/pci/nvme/Makefile b/drivers/vfio/pci/nvme/Makefile
> new file mode 100644
> index 000000000000..2f4a0ad3d9cf
> --- /dev/null
> +++ b/drivers/vfio/pci/nvme/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_NVME_VFIO_PCI) += nvme-vfio-pci.o
> +nvme-vfio-pci-y := nvme.o
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
> +	migf->vf_data = NULL;
> +	migf->disabled = true;
> +	migf->total_length = 0;
> +	migf->filp->f_pos = 0;
> +	mutex_unlock(&migf->lock);
> +}
> +
> +static void nvmevf_disable_fds(struct nvmevf_pci_core_device *nvmevf_dev)
> +{
> +	if (nvmevf_dev->resuming_migf) {
> +		nvmevf_disable_fd(nvmevf_dev->resuming_migf);
> +		fput(nvmevf_dev->resuming_migf->filp);
> +		nvmevf_dev->resuming_migf = NULL;
> +	}
> +
> +	if (nvmevf_dev->saving_migf) {
> +		nvmevf_disable_fd(nvmevf_dev->saving_migf);
> +		fput(nvmevf_dev->saving_migf->filp);
> +		nvmevf_dev->saving_migf = NULL;
> +	}
> +}
> +
> +static void nvmevf_state_mutex_unlock(struct nvmevf_pci_core_device *nvmevf_dev)
> +{
> +	lockdep_assert_held(&nvmevf_dev->state_mutex);
> +again:
> +	spin_lock(&nvmevf_dev->reset_lock);
> +	if (nvmevf_dev->deferred_reset) {
> +		nvmevf_dev->deferred_reset = false;
> +		spin_unlock(&nvmevf_dev->reset_lock);
> +		nvmevf_dev->mig_state = VFIO_DEVICE_STATE_RUNNING;
> +		nvmevf_disable_fds(nvmevf_dev);
> +		goto again;
> +	}
> +	mutex_unlock(&nvmevf_dev->state_mutex);
> +	spin_unlock(&nvmevf_dev->reset_lock);
> +}
> +
> +static struct nvmevf_pci_core_device *nvmevf_drvdata(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(&pdev->dev);
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
> +	nvmevf_dev = container_of(core_vdev, struct nvmevf_pci_core_device,
> +			core_device.vdev);
> +	vdev = &nvmevf_dev->core_device;
> +
> +	ret = vfio_pci_core_enable(vdev);
> +	if (ret)
> +		return ret;
> +
> +	if (nvmevf_dev->migrate_cap)
> +		nvmevf_dev->mig_state = VFIO_DEVICE_STATE_RUNNING;
> +	vfio_pci_core_finish_enable(vdev);
> +	return 0;
> +}
> +
> +static void nvmevf_pci_close_device(struct vfio_device *core_vdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev;
> +
> +	nvmevf_dev = container_of(core_vdev, struct nvmevf_pci_core_device,
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
> +static const struct vfio_device_ops nvmevf_pci_ops = {
> +	.name = "nvme-vfio-pci",
> +	.release = vfio_pci_core_release_dev,
> +	.open_device = nvmevf_pci_open_device,
> +	.close_device = nvmevf_pci_close_device,
> +	.ioctl = vfio_pci_core_ioctl,
> +	.device_feature = vfio_pci_core_ioctl_feature,
> +	.read = vfio_pci_core_read,
> +	.write = vfio_pci_core_write,
> +	.mmap = vfio_pci_core_mmap,
> +	.request = vfio_pci_core_request,
> +	.match = vfio_pci_core_match,
> +};
> +
> +static int nvmevf_pci_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev;
> +	int ret;
> +
> +	nvmevf_dev = vfio_alloc_device(nvmevf_pci_core_device, core_device.vdev,
> +				       &pdev->dev, &nvmevf_pci_ops);
> +	if (IS_ERR(nvmevf_dev))
> +		return PTR_ERR(nvmevf_dev);
> +
> +	dev_set_drvdata(&pdev->dev, &nvmevf_dev->core_device);
> +	ret = vfio_pci_core_register_device(&nvmevf_dev->core_device);
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
> +	struct nvmevf_pci_core_device *nvmevf_dev = nvmevf_drvdata(pdev);
> +
> +	vfio_pci_core_unregister_device(&nvmevf_dev->core_device);
> +	vfio_put_device(&nvmevf_dev->core_device.vdev);
> +}
> +
> +static void nvmevf_pci_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct nvmevf_pci_core_device *nvmevf_dev = nvmevf_drvdata(pdev);
> +
> +	if (!nvmevf_dev->migrate_cap)
> +		return;
> +
> +	/*
> +	 * As the higher VFIO layers are holding locks across reset and using
> +	 * those same locks with the mm_lock we need to prevent ABBA deadlock
> +	 * with the state_mutex and mm_lock.
> +	 * In case the state_mutex was taken already we defer the cleanup work
> +	 * to the unlock flow of the other running context.
> +	 */
> +	spin_lock(&nvmevf_dev->reset_lock);
> +	nvmevf_dev->deferred_reset = true;
> +	if (!mutex_trylock(&nvmevf_dev->state_mutex)) {
> +		spin_unlock(&nvmevf_dev->reset_lock);
> +		return;
> +	}
> +	spin_unlock(&nvmevf_dev->reset_lock);
> +	nvmevf_state_mutex_unlock(nvmevf_dev);
> +}
> +
> +static const struct pci_error_handlers nvmevf_err_handlers = {
> +	.reset_done = nvmevf_pci_aer_reset_done,
> +	.error_detected = vfio_pci_core_aer_err_detected,
> +};
> +
> +static struct pci_driver nvmevf_pci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.probe = nvmevf_pci_probe,
> +	.remove = nvmevf_pci_remove,
> +	.err_handler = &nvmevf_err_handlers,
> +	.driver_managed_dma = true,
> +};
> +
> +module_pci_driver(nvmevf_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Chaitanya Kulkarni <kch@nvidia.com>");
> +MODULE_DESCRIPTION("NVMe VFIO PCI - VFIO PCI driver with live migration support for NVMe");

Without a MODULE_DEVICE_TABLE, what devices are ever going to use this
driver?  Userspace needs to be given a clue when to use this driver vs
vfio-pci.  We also don't have a fallback mechanism to try a driver
until it fails, so this driver likely needs to take over defacto
support for all NVMe devices from vfio-pci, rather that later rejecting
those that don't support migration as patch 4/ implements in the .init
callback.  Thanks,

Alex

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


