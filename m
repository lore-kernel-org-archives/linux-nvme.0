Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2ABC48297
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2aGrg5A40zfPWuBWrpK+X4+SYvgGNI8uYNG03tRNS4o=; b=jINNTmzq3JdLKNY3GDgQEvPdrE
	4VS8i/uPTNp31ZwuHPoMGd1XLqwCR99WLxG62HXXdylIZUztNi0Jief6Wu5qUaQf1AS2I6o0tIBx/
	AVpWAJffPfnIENDLDmKdhtRJD+XgcGws9JE5utY3RLJDFfTYf842wmrLMO53EnG3jK+y/MuX7XU3R
	Tb/zLxUB5s+3nkqYYr791MtRBi7vTEQA16K255PtbtAuLDoqGgRLleNBIwqSc9mcIm+KDfRVT9pff
	IBqTROSCQgteu45TgB+w1cv2/ZyeEe80t+jcK7JdiAmi7HA/kKQX8ghrt/ceWGqnt+pQ/+WGM4Lvo
	fPu/rFMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXPaw-00000008SkJ-1gl9;
	Tue, 06 Feb 2024 17:50:54 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXPat-00000008Sim-1N2u
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 17:50:52 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416EtOGh029772
	for <linux-nvme@lists.infradead.org>; Tue, 6 Feb 2024 09:50:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=2aGrg5A40zfPWuBWrpK+X4+SYvgGNI8uYNG03tRNS4o=;
 b=B467UWG/+21byq9erhpT23ZkKHw1SgY+K6cK4q7iLNfdb1gyjbBpKB78TQ7RlSc6V55j
 TI9XVx5GcqJA1WzlSZRmiJdK2MjJE5gwteIf9wY21aNkKr5nmBSomfK0cmN1zC8XnAUY
 SmuiC31l+MqYs53oVLE4FYLs6Tapnd0uzqmbNEZhj6jiH2heIHOYq8OEGlyj8JNlM+3/
 GD5Zqcz6lRWa7TGnceXW5zjlj4HfDm81pZCapnzdwZ28tQ9Yv+r8AyKMLjKfMopdWOlI
 0HVCc+vBRkayxxIeWJoXXUUMd6Z24ChPfknVcmotUg1g836VDu6M7yNzAimbnYCjpZWT eQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3w2wpe1q59-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 06 Feb 2024 09:50:48 -0800
Received: from twshared8168.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 09:50:45 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 860A824E28291; Tue,  6 Feb 2024 09:50:41 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>,
        Tasmiya Nalatwad
	<tasmiya@linux.vnet.ibm.com>,
        Alan Adamson <alan.adamson@oracle.com>
Subject: [PATCH] nvme: move passthrough logging attribute to head
Date: Tue, 6 Feb 2024 09:50:40 -0800
Message-ID: <20240206175040.553999-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PgIE7fGPcdpPcBgiO2LCmOch0c7Ai3QH
X-Proofpoint-ORIG-GUID: PgIE7fGPcdpPcBgiO2LCmOch0c7Ai3QH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_095051_626414_E5C62BED 
X-CRM114-Status: GOOD (  19.60  )
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

The namespace does not have attributes, but the head does. Move the new
attribute to that structure instead of dereferncing the wrong type.

And while we're here, fix the reverse-tree coding style.

Fixes: 9f079dda14339e ("nvme: allow passthru cmd error logging")
Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  |  3 +--
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/sysfs.c | 30 +++++++++++++++---------------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75927e8579857..786bebcfa4f77 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -713,7 +713,7 @@ void nvme_init_request(struct request *req, struct nv=
me_command *cmd)
 	if (req->q->queuedata) {
 		struct nvme_ns *ns =3D req->q->disk->private_data;
=20
-		logging_enabled =3D ns->passthru_err_log_enabled;
+		logging_enabled =3D ns->head->passthru_err_log_enabled;
 		req->timeout =3D NVME_IO_TIMEOUT;
 	} else { /* no queuedata implies admin queue */
 		logging_enabled =3D nr->ctrl->passthru_err_log_enabled;
@@ -3700,7 +3700,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, s=
truct nvme_ns_info *info)
=20
 	ns->disk =3D disk;
 	ns->queue =3D disk->queue;
-	ns->passthru_err_log_enabled =3D false;
=20
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3897334e3950d..7b87763e2f8a6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -455,6 +455,7 @@ struct nvme_ns_head {
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
+	bool			passthru_err_log_enabled;
 	int			instance;
 	struct nvme_effects_log *effects;
 	u64			nuse;
@@ -523,7 +524,6 @@ struct nvme_ns {
 	struct device		cdev_device;
=20
 	struct nvme_fault_inject fault_inject;
-	bool			passthru_err_log_enabled;
 };
=20
 /* NVMe ns supports metadata actions by the controller (generate/strip) =
*/
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index d099218e494a8..f2832f70e7e0a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -48,8 +48,8 @@ static ssize_t nvme_adm_passthru_err_log_enabled_store(=
struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
-	int err;
 	bool passthru_err_log_enabled;
+	int err;
=20
 	err =3D kstrtobool(buf, &passthru_err_log_enabled);
 	if (err)
@@ -60,25 +60,34 @@ static ssize_t nvme_adm_passthru_err_log_enabled_stor=
e(struct device *dev,
 	return count;
 }
=20
+static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
+{
+	struct gendisk *disk =3D dev_to_disk(dev);
+
+	if (nvme_disk_is_ns_head(disk))
+		return disk->private_data;
+	return nvme_get_ns_from_dev(dev)->head;
+}
+
 static ssize_t nvme_io_passthru_err_log_enabled_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct nvme_ns *n =3D dev_get_drvdata(dev);
+	struct nvme_ns_head *head =3D dev_to_ns_head(dev);
=20
-	return sysfs_emit(buf, n->passthru_err_log_enabled ? "on\n" : "off\n");
+	return sysfs_emit(buf, head->passthru_err_log_enabled ? "on\n" : "off\n=
");
 }
=20
 static ssize_t nvme_io_passthru_err_log_enabled_store(struct device *dev=
,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct nvme_ns *ns =3D dev_get_drvdata(dev);
-	int err;
+	struct nvme_ns_head *head =3D dev_to_ns_head(dev);
 	bool passthru_err_log_enabled;
+	int err;
=20
 	err =3D kstrtobool(buf, &passthru_err_log_enabled);
 	if (err)
 		return -EINVAL;
-	ns->passthru_err_log_enabled =3D passthru_err_log_enabled;
+	head->passthru_err_log_enabled =3D passthru_err_log_enabled;
=20
 	return count;
 }
@@ -91,15 +100,6 @@ static struct device_attribute dev_attr_io_passthru_e=
rr_log_enabled =3D \
 	__ATTR(passthru_err_log_enabled, S_IRUGO | S_IWUSR, \
 	nvme_io_passthru_err_log_enabled_show, nvme_io_passthru_err_log_enabled=
_store);
=20
-static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
-{
-	struct gendisk *disk =3D dev_to_disk(dev);
-
-	if (nvme_disk_is_ns_head(disk))
-		return disk->private_data;
-	return nvme_get_ns_from_dev(dev)->head;
-}
-
 static ssize_t wwid_show(struct device *dev, struct device_attribute *at=
tr,
 		char *buf)
 {
--=20
2.34.1


