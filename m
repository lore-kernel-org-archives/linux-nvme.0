Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B2EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64vXVneAT9A14nJ5Wy4DU2Ru5X/AwQFCZoUVhV2cz8s=; b=iOG/6gLsAxSIZz83Q7LrW5G3iu
	liqs/ODtYIcDmhguASAc0LPVLQH4S58ooki2fnxZjlv0XReyBOAdIeBpLR0kFfmHTCGA2m7FWazWD
	NLBY3PRrKvAqbsi2hyslETMBB7UUJvSG9zUrP9mRyoefTz9BB437BYUxsHCVMdC94St4LdxOs3yt3
	/GLX6g7UwH8O2qmoQr7l7Qp5etRVr77e+bgGrykjNUzV/jCJ/eod4i2fn7Z6NhJ6b6X0RNEWOY8To
	y3PSPztcDKaeFpdKui1Ko+hltZOUJCWTofgPAL0tbKxa0AccnlZhBrpAXnEvFfmr8Vn2nrAeJD7Nm
	Xd88FpcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDF7j-00HT9x-6x; Fri, 28 Jan 2022 00:28:19 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDF5v-00HRvx-BE
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 00:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=64vXVneAT9A14nJ5Wy4DU2Ru5X/AwQFCZoUVhV2cz8s=; b=ZnQOa3fNCsoceXpkfTOvkkxhQ3
 YPnv8R6b2Pia3DQGSm/S40Iw4dBsQ5v3Ro2prXcn89tVI0MzOTjtMLCPtkjEysFf36McWDRAuOuxo
 ZIg7pNMDR3disto8RqevSoa5xVhahTIzavvy5qG++ccgQhBj4GG4J2IwOZXx3/P9xrXDeih/JvVcK
 uPgAqYGjZgMaZG9WePCJZWo7eMidSu1Yain3cpxonh4FHpfclfmfJsj2uv/5fCZNs0tMHmuR5Q0Db
 EF3FYDhp3FzdmOhXgut3tml0gqzsP6+8/6TBEGj1FP8uQakf6HyYBWeoW1hFJSf3CO5UxpfraTn2c
 3fUhej/g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5q-005Oca-PY; Thu, 27 Jan 2022 17:26:23 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5q-0001db-As; Thu, 27 Jan 2022 17:26:22 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 27 Jan 2022 17:26:14 -0700
Message-Id: <20220128002614.6136-25-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 24/24] nvme-pci: allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_162627_417571_ED89E422 
X-CRM114-Status: GOOD (  13.74  )
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

Allow userspace to obtain CMB memory by mmaping the controller's
char device. The mmap call allocates and returns a hunk of CMB memory,
(the offset is ignored) so userspace does not have control over the
address within the CMB.

A VMA allocated in this way will only be usable by drivers that set
FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
checked the first time the pages are mapped for DMA.

Currently this is only supported by O_DIRECT to an PCI NVMe device
or through the NVMe passthrough IOCTL.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 15 +++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 17 +++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ecb01984b55d..54a1c350098e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3142,6 +3142,10 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	}
 
 	file->private_data = ctrl;
+
+	if (ctrl->ops->cdev_file_open)
+		ctrl->ops->cdev_file_open(ctrl, file);
+
 	return 0;
 }
 
@@ -3155,12 +3159,23 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct nvme_ctrl *ctrl = file->private_data;
+
+	if (!ctrl->ops->mmap_cmb)
+		return -ENODEV;
+
+	return ctrl->ops->mmap_cmb(ctrl, vma);
+}
+
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
 	.release	= nvme_dev_release,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.mmap		= nvme_dev_mmap,
 };
 
 static ssize_t nvme_sysfs_reset(struct device *dev,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 97efc6d0b146..6b1649d50bdf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -494,6 +494,8 @@ struct nvme_ctrl_ops {
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	void (*cdev_file_open)(struct nvme_ctrl *ctrl, struct file *file);
+	int (*mmap_cmb)(struct nvme_ctrl *ctrl, struct vm_area_struct *vma);
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 330515886dfc..47e47ffc12bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2961,6 +2961,21 @@ static bool nvme_pci_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
 	return dma_pci_p2pdma_supported(dev->dev);
 }
 
+static void nvme_pci_cdev_file_open(struct nvme_ctrl *ctrl, struct file *file)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+
+	pci_p2pdma_file_open(pdev, file);
+}
+
+static int nvme_pci_mmap_cmb(struct nvme_ctrl *ctrl,
+			     struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+
+	return pci_mmap_p2pmem(pdev, vma);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2972,6 +2987,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
 	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
+	.cdev_file_open		= nvme_pci_cdev_file_open,
+	.mmap_cmb		= nvme_pci_mmap_cmb,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.30.2


