Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3F6C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUw4LoAQWV8RTTWIaV0932/UuAr7QgcmHm30V4yW2Mc=; b=WbYZgXjvaaZBUTEOFRIBrou0vf
	X2OHPhzbX9S74Wjp6CO5eifWTM4PAmwE8ntmp+pDQzYQOLYxpPBiBu5SDaMsXO4VjBhVzTC7Pjg9E
	sybN0VQOeRCBEYTZF6hWCEUIUcUGH2AHNMHHmNZOiD+YICbWSk7/rlCDjLHR0kOYvhf9waGtpKZkx
	LhbekgVDlUardLky/xdGFD/tl3xuTgOVvNe7YwhOBtWveSs1Sy5P/h1c0QJblhWhgkBTqVsJHHVnn
	vCBaWVq42fUIn3dXUx1IgrnEOoZw60/VBezHSuA5KKGAK/tMD2fNn8x6TAIFWbessUDVvxh3wx7aI
	L6tGNSCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkS-00000000a8J-3fvH;
	Mon, 03 Jun 2024 23:05:52 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkP-00000000a75-3Z54
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:05:51 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453N1ktI027143
	for <linux-nvme@lists.infradead.org>; Mon, 3 Jun 2024 16:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=MUw4LoAQWV8RTTWIaV0932/UuAr7QgcmHm30V4yW2Mc=;
 b=M8lEghgVnKR+3urW7hkQYs8Nk8Kyxu+fBS4otxOz2bLzm4BiyPQ55zutN3pwC+fV22Nv
 0/yhvICCDdunaRDg2VPju2Tt1kAuY2CQgWFMotOs3e7FX6H9ac3uVq0UnGBsSbJ1jCAs
 pXU5Ejteo1Os7MPpt8Wq4ViPGA4+jFVSyug1rSsbjqe3jr4EKYR8EIWUAmnSGfu1/xBC
 lnjnvWYTQBmv9e1kHf7sqRj9kq4EWlbjxSU2T0jnLClHW8L7FCXI5Rix6YHsW0Nr8AL8
 3fD6rUPCrFrdxZfiN5GTxEZIKDUeftjCqiALAKRza9nhqwBY1lcL0ETvjwwhewYhVzm/ ZA== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhq5180qe-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 16:05:48 -0700
Received: from twshared10578.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 3 Jun 2024 23:05:30 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id C62923481EC6; Mon,  3 Jun 2024 16:05:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH-RFC 5/5] nvme: split device add from initialzation
Date: Mon, 3 Jun 2024 16:05:23 -0700
Message-ID: <20240603230524.3854115-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QGV1_1aduOtXXp22dWnNA1Jw7IVlLES2
X-Proofpoint-ORIG-GUID: QGV1_1aduOtXXp22dWnNA1Jw7IVlLES2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_160550_042842_32B42265 
X-CRM114-Status: GOOD (  23.12  )
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

From: Keith Busch <kbusch@kernel.org>

Combining both creates an ambiguous cleanup scenario for the caller if
an error is returned: does the device reference need to be dropped or
did the error occur before the device was initialized? If an error
occurs after the device is added, then the existing cleanup routines
will leak memory.

Furthermore, the nvme core is taking it upon itself to free the device's
kobj.name under certain conditions. We shouldn't be peaking into these
implementation details.

Split the device initialization from the addition to make it easier to
know the error handling actions and stop the layering violations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/apple.c  |  5 ++++
 drivers/nvme/host/core.c   | 58 +++++++++++++++++++++++---------------
 drivers/nvme/host/fc.c     |  5 ++++
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    |  5 ++++
 drivers/nvme/host/rdma.c   |  5 ++++
 drivers/nvme/host/tcp.c    |  5 ++++
 drivers/nvme/target/loop.c |  5 ++++
 8 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b6ac8a1630b2b..89f60851e63a6 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1531,6 +1531,10 @@ static int apple_nvme_probe(struct platform_device=
 *pdev)
 	if (IS_ERR(anv))
 		return PTR_ERR(anv);
=20
+	result =3D nvme_add_ctrl(&anv->ctrl);
+	if (result)
+		goto out_put_ctrl;
+
 	anv->ctrl.admin_q =3D blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL=
);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret =3D -ENOMEM;
@@ -1544,6 +1548,7 @@ static int apple_nvme_probe(struct platform_device =
*pdev)
=20
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&dev->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&dev->ctrl);
 	return ret;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955d..070cc4d76b6a4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4611,6 +4611,9 @@ static void nvme_free_ctrl(struct device *dev)
  * Initialize a NVMe controller structures.  This needs to be called dur=
ing
  * earliest initialization so that we have the initialized structured ar=
ound
  * during probing.
+ *
+ * On success, the caller must use the nvme_put_ctrl() to release this w=
hen
+ * needed, which also invokes the ops->free_ctrl() callback.
  */
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks)
@@ -4659,6 +4662,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct =
device *dev,
 		goto out;
 	ctrl->instance =3D ret;
=20
+	ret =3D nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		goto out_release_instance;
+
+	nvme_mpath_init_ctrl(ctrl);
+
 	device_initialize(&ctrl->ctrl_device);
 	ctrl->device =3D &ctrl->ctrl_device;
 	ctrl->device->devt =3D MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
@@ -4671,16 +4680,36 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
 		ctrl->device->groups =3D nvme_dev_attr_groups;
 	ctrl->device->release =3D nvme_free_ctrl;
 	dev_set_drvdata(ctrl->device, ctrl);
+
+	return ret;
+
+out_release_instance:
+	ida_free(&nvme_instance_ida, ctrl->instance);
+out:
+	if (ctrl->discard_page)
+		__free_page(ctrl->discard_page);
+	cleanup_srcu_struct(&ctrl->srcu);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_init_ctrl);
+
+/*
+ * On success, returns with an elevated controller reference and caller =
must
+ * use nvme_uninit_ctrl() to properly free resources associated with the=
 ctrl.
+ */
+int nvme_add_ctrl(struct nvme_ctrl *ctrl)
+{
+	int ret;
+
 	ret =3D dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
 	if (ret)
-		goto out_release_instance;
+		return ret;
=20
-	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
-	ctrl->cdev.owner =3D ops->module;
+	ctrl->cdev.owner =3D ctrl->ops->module;
 	ret =3D cdev_device_add(&ctrl->cdev, ctrl->device);
 	if (ret)
-		goto out_free_name;
+		return ret;
=20
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
@@ -4691,28 +4720,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
=20
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
-	nvme_mpath_init_ctrl(ctrl);
-	ret =3D nvme_auth_init_ctrl(ctrl);
-	if (ret)
-		goto out_free_cdev;
+	nvme_get_ctrl(ctrl);
=20
 	return 0;
-out_free_cdev:
-	nvme_fault_inject_fini(&ctrl->fault_inject);
-	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
-out_free_name:
-	nvme_put_ctrl(ctrl);
-	kfree_const(ctrl->device->kobj.name);
-out_release_instance:
-	ida_free(&nvme_instance_ida, ctrl->instance);
-out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
-	cleanup_srcu_struct(&ctrl->srcu);
-	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_init_ctrl);
+EXPORT_SYMBOL_GPL(nvme_add_ctrl);
=20
 /* let I/O to all namespaces fail in preparation for surprise removal */
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 43bc8f16b3a78..2ce54f560e004 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3563,6 +3563,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_=
ctrl_options *opts,
 	if (IS_ERR(ctrl))
 		return (struct nvme_ctrl *)ctrl;
=20
+	ret =3D nvme_add_ctrl(&ctrl->ctrl);
+	if (ret)
+		goto out_put_ctrl;
+
 	ret =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
 			&nvme_fc_admin_mq_ops,
 			struct_size_t(struct nvme_fcp_op_w_sgl, priv,
@@ -3607,6 +3611,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_c=
trl_options *opts,
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
=20
+out_put_ctrl:
 	/* Remove core ctrl ref. */
 	nvme_put_ctrl(&ctrl->ctrl);
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3a41133ac3f9..9693490680866 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -792,6 +792,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool sh=
utdown);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
+int nvme_add_ctrl(struct nvme_ctrl *ctrl);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65ff..c92125b0238d4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3015,6 +3015,10 @@ static int nvme_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
=20
+	result =3D nvme_add_ctrl(&dev->ctrl);
+	if (result)
+		goto out_put_ctrl;
+
 	result =3D nvme_dev_map(dev);
 	if (result)
 		goto out_uninit_ctrl;
@@ -3101,6 +3105,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&dev->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&dev->ctrl);
 	return result;
 }
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dab8ade8e9489..bfe1b21974cdd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2323,6 +2323,10 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(str=
uct device *dev,
 	if (IS_ERR(ctrl))
 		return (struct nvme_ctrl *)ctrl;
=20
+	ret =3D nvme_add_ctrl(&ctrl->ctrl);
+	if (ret)
+		goto out_put_ctrl;
+
 	changed =3D nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
=20
@@ -2341,6 +2345,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(stru=
ct device *dev,
=20
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret =3D -EIO;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7f75d01dcbed0..8549ea87df6ff 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2779,6 +2779,10 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
 	if (IS_ERR(ctrl))
 		return (struct nvme_ctrl *)ctrl;
=20
+	ret =3D nvme_add_ctrl(&ctrl->ctrl);
+	if (ret)
+		goto out_put_ctrl;
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		WARN_ON_ONCE(1);
 		ret =3D -EINTR;
@@ -2800,6 +2804,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struc=
t device *dev,
=20
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret =3D -EIO;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e589915ddef85..e32790d8fc260 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -555,6 +555,10 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struc=
t device *dev,
 		goto out;
 	}
=20
+	ret =3D nvme_add_ctrl(&ctrl->ctrl);
+	if (ret)
+		goto out_put_ctrl;
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		WARN_ON_ONCE(1);
=20
@@ -611,6 +615,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct=
 device *dev,
 	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 out:
 	if (ret > 0)
--=20
2.43.0


