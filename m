Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59338CCA48C
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1Y+xHoeQH3UW63rjymiD/emNoqwBnemSVoIxTF9EbY=; b=za4zca8BRv7fk6SkFjRI/bdVaW
	MU7TU7ZhR/H22Yx3BwLOFctK/7E5ZYspzpUadfdbL8q630PSh2SmEU9gFm7hskRzXYsSzdnibWilB
	Hx3ql6rG829jNmpefMIeNWPScI2LcuP+Bqkh/k4R+pe5zVMrx6iDp9zNBTXmJAWBWeKY99CjvkVHf
	L2xG+Aq7eWT/4AhWzgBrEzCMX2G8RPLqbKQ8fsBkuc9CmNN/7FdcX13ys2qYWwu9GX69AC7hn/4uV
	o/VZPTX9cKcxAI8DBU5G7jsW/AGpSklpOfrvGDyl0L76Hsf9S6UmJjBtQubIerJ0lCpSAWOeBN4+8
	UdGGHhwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1VdX-00FJfE-HV; Wed, 15 Jun 2022 16:12:55 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1VdT-00FJYP-Cn
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 16:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=X1Y+xHoeQH3UW63rjymiD/emNoqwBnemSVoIxTF9EbY=; b=iKgX6plSnGYTUQgEz3h2eQ8oq4
	FGlAIFJWTusbVwsUGEKQv5w3YldIr+Zb7y9e5Tci57QG4okfn/WNYoSJSPedAWtRsJ317QnqZ3tYN
	B1fywGUu5iwDLF9GPEgBC7jVnfl/bzFg+cc/N6mZ6JQngmxQwJYFT1EsGSRC6XIG1doRvnySpVRU/
	tzfXsXC/u1Ur26GJQGnmxT26Dpy7yBQ61LA/ooaFX1WIMUL63WFzcYKEzecykYtWm5V8bVzy+p78C
	Z+iMAawOzUWIvBjOXPztbfswoP+njdZ1jiGYb3TqxWthTb6w8cx/ik5VmwwPqeARrQ2tc76XIBIjc
	0eUneuvg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o1VdO-0084iQ-Ox; Wed, 15 Jun 2022 10:12:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o1VdJ-0004b4-QT; Wed, 15 Jun 2022 10:12:41 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 15 Jun 2022 10:12:33 -0600
Message-Id: <20220615161233.17527-22-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 21/21] nvme-pci: allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_091251_552776_2F07177E 
X-CRM114-Status: GOOD (  16.82  )
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
 drivers/nvme/host/core.c | 35 +++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 23 +++++++++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6e76f2dc293..23fe4b544bf1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3166,6 +3166,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
+	int ret = -EINVAL;
 
 	switch (ctrl->state) {
 	case NVME_CTRL_LIVE:
@@ -3175,13 +3176,25 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	}
 
 	nvme_get_ctrl(ctrl);
-	if (!try_module_get(ctrl->ops->module)) {
-		nvme_put_ctrl(ctrl);
-		return -EINVAL;
-	}
+	if (!try_module_get(ctrl->ops->module))
+		goto err_put_ctrl;
 
 	file->private_data = ctrl;
+
+	if (ctrl->ops->cdev_file_open) {
+		ret = ctrl->ops->cdev_file_open(ctrl, file);
+		if (ret)
+			goto err_put_mod;
+	}
+
 	return 0;
+
+err_put_mod:
+	module_put(ctrl->ops->module);
+err_put_ctrl:
+	nvme_put_ctrl(ctrl);
+	return ret;
+
 }
 
 static int nvme_dev_release(struct inode *inode, struct file *file)
@@ -3189,11 +3202,24 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
+	if (ctrl->ops->cdev_file_release)
+		ctrl->ops->cdev_file_release(file);
+
 	module_put(ctrl->ops->module);
 	nvme_put_ctrl(ctrl);
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
@@ -3201,6 +3227,7 @@ static const struct file_operations nvme_dev_fops = {
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_dev_uring_cmd,
+	.mmap		= nvme_dev_mmap,
 };
 
 static ssize_t nvme_sysfs_reset(struct device *dev,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 957f79420cf3..44ff05d8e24d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,6 +503,9 @@ struct nvme_ctrl_ops {
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	int (*cdev_file_open)(struct nvme_ctrl *ctrl, struct file *file);
+	void (*cdev_file_release)(struct file *file);
+	int (*mmap_cmb)(struct nvme_ctrl *ctrl, struct vm_area_struct *vma);
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 52b52a7efa9a..8ef3752b7ddb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2972,6 +2972,26 @@ static bool nvme_pci_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
 	return dma_pci_p2pdma_supported(dev->dev);
 }
 
+static int nvme_pci_cdev_file_open(struct nvme_ctrl *ctrl, struct file *file)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+
+	return pci_p2pdma_file_open(pdev, file);
+}
+
+static void nvme_pci_cdev_file_release(struct file *file)
+{
+	pci_p2pdma_file_release(file);
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
@@ -2983,6 +3003,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
 	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
+	.cdev_file_open		= nvme_pci_cdev_file_open,
+	.cdev_file_release	= nvme_pci_cdev_file_release,
+	.mmap_cmb		= nvme_pci_mmap_cmb,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.30.2


