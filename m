Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABE5C77B7F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 22:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5VHYQ/YT2OyT8rAZkHJy8oKYG++8kK66ySq7P9a+LgA=; b=IdZqKPqcZ2QIry+zySDfOOii0i
	mFDWi6dacQvSwAwi6GjcxEzrHFzVKfV3y1IPdHzyI+QpGbK2ODWSuHybZpvdVU6n3rXAxYpU8rlN+
	vc3xyxfX3MoouEsW2QnTlZrjgcfq+LFQkJ7vh56tkVamSIp3oPRJsxjuZTGo9i4QKj6WoFEchb6fM
	9rdPx9rmvigYCjYHWy3InNaPbS+ktVmJL6tBzhc+fPk4HwJ4hAn4XdRhRT4n6wODLUNhH4fLRhUP4
	ZdVLJesqamb/K0lwh5y5UjHhb7xhivWI0kayF/v+RpJpMuOsjU2V8pw+AudT8Hx2UANBdkakcBjlo
	zRdLiMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUBuz-00000006xtU-1BnU;
	Tue, 24 Jun 2025 22:15:05 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUAyk-00000006r2x-0kAL
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 21:14:55 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OKqH7v002223
	for <linux-nvme@lists.infradead.org>; Tue, 24 Jun 2025 14:14:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=5VHYQ/YT2OyT8rAZkH
	Jy8oKYG++8kK66ySq7P9a+LgA=; b=Q3RPdQmroW2NOGhH21iuNQIFVtNOC4BtQ6
	wnjh4Ktm4+ke6loqpk3lTatArpPPiahgxXFxukGcgghT7JVi2cYR5eB+hBUSfx1C
	bzMk3u13sYlmvQwympoc/8hFxc2LSdN4Ya1AgIIAwNx+l8Ck7nw260MZnFA+IeU/
	hEctccWg7iWuJ+32kZHr+QGCjDBPhWW/tuj0HjcL/7HQMfGdiV7LJNtMUMP68Qr4
	2Kk7gVaoPlR2RjCWazp22UmhaApc+roVK7hNWHlW5MyU3KlRsosmh98HB2RIISA+
	oYF00t58R6iWaeAZX/oWEk+E5hxqtDWWiCy4kXmbjqUaKVMG8KNA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47dtf0y299-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 24 Jun 2025 14:14:52 -0700 (PDT)
Received: from twshared28243.32.prn2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Tue, 24 Jun 2025 21:14:51 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 9AC3783A559; Tue, 24 Jun 2025 14:14:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Date: Tue, 24 Jun 2025 14:14:44 -0700
Message-ID: <20250624211444.2835077-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RvnFLDmK c=1 sm=1 tr=0 ts=685b154c cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=lb01z-v_8Vmu6P8pEK4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2OSBTYWx0ZWRfXyW2/iH+ojBgd 42HmxMyjZ2aJqYH4Ky6/nU8QZXTUl8dJv302N19S129FDwjgGR74vArDXj8rC3IwDcMI4Ys6Tf5 1K2VymcJ9ouPSiqu9FhfPj7fo59XHLPE7FbHVPdTpGjsLghMpp2Dqk93mUgcDxBIDy1t87NtTgc
 YOQMfrJYpkAPv2gBcXlnXDBt0w8T8t/18gGa2KSsnSjU8H596c23UKMmMFDow8Dk13bij4qY8cR pxKKkMCripuy2PHkcAzC0SqUeQ2RqFc3TARCTdlWhQyWXaS5eWHtENvXHVcm5SAeVGWzeTGoX0Q MVb9Eg0WNs+hQzjZ5BxOgllOotYEc3rBTxo/2AUsGpBNYr0HcooEfXuUNblFHWza9Uk7AXC2sA3
 p12yJzBakVxVuUclwANXQgFKM+WGXdAzPYFjo95jqATIsU0u314SISHWglLqp67Jvx/6FkLC
X-Proofpoint-GUID: NmuGRk6iSSXwcSX-xVmIELE9iHKIkaAo
X-Proofpoint-ORIG-GUID: NmuGRk6iSSXwcSX-xVmIELE9iHKIkaAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_141454_222985_7085167B 
X-CRM114-Status: GOOD (  18.37  )
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

User space passthrough IO commands are committed to using the SGL
transfer types if the device supports it. The virt_boundary_mask is a
PRP specific constraint, and this limit causes kernel bounce buffers to
be used when a user vector could have been handled directly. Avoiding
unnecessary copies is important for uring_cmd usage as this is a high
performance interface.

For devices that support SGL, create a new request_queue that drops the
virt_boundary_mask so that vectored user requests can be used with
zero-copy performance. Normal read/write will still use the old boundary
mask, as we can't be sure if forcing all IO to use SGL over PRP won't
cause unexpected regressions for some devices.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  | 28 +++++++++++++++++++++++++++-
 drivers/nvme/host/ioctl.c |  2 +-
 drivers/nvme/host/nvme.h  |  1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3da5ac71a9b07..e4e03cb9e5c0e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -721,7 +721,7 @@ void nvme_init_request(struct request *req, struct nv=
me_command *cmd)
 	bool logging_enabled;
=20
 	if (req->q->queuedata) {
-		struct nvme_ns *ns =3D req->q->disk->private_data;
+		struct nvme_ns *ns =3D req->q->queuedata;
=20
 		logging_enabled =3D ns->head->passthru_err_log_enabled;
 		req->timeout =3D NVME_IO_TIMEOUT;
@@ -4081,6 +4081,27 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_n=
s *ns)
 	list_add(&ns->list, &ns->ctrl->namespaces);
 }
=20
+static void nvme_init_uring_queue(struct nvme_ns *ns)
+{
+	struct nvme_ctrl *ctrl =3D ns->ctrl;
+	struct queue_limits lim =3D {};
+	struct request_queue *q;
+
+	if (!nvme_ctrl_sgl_supported(ctrl)) {
+		ns->uring_queue =3D ns->queue;
+		return;
+	}
+
+	nvme_set_ctrl_limits(ctrl, &lim);
+	lim.virt_boundary_mask =3D 0;
+
+	q =3D blk_mq_alloc_queue(ctrl->tagset, &lim, ns);
+	if (IS_ERR(q))
+		ns->uring_queue =3D ns->queue;
+	else
+		ns->uring_queue =3D q;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *i=
nfo)
 {
 	struct queue_limits lim =3D { };
@@ -4157,6 +4178,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, s=
truct nvme_ns_info *info)
=20
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
+	nvme_init_uring_queue(ns);
=20
 	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
@@ -4224,6 +4246,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
=20
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	if (ns->uring_queue !=3D ns->queue) {
+		blk_mq_destroy_queue(ns->uring_queue);
+		blk_put_queue(ns->uring_queue);
+	}
=20
 	nvme_mpath_remove_sysfs_link(ns);
=20
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6b3ac8ae3f34b..f925a10391001 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -445,7 +445,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 {
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd =3D io_uring_sqe_cmd(ioucmd->sqe);
-	struct request_queue *q =3D ns ? ns->queue : ctrl->admin_q;
+	struct request_queue *q =3D ns ? ns->uring_queue : ctrl->admin_q;
 	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct iov_iter iter;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7df2ea21851f5..d371940bd342d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -548,6 +548,7 @@ struct nvme_ns {
=20
 	struct cdev		cdev;
 	struct device		cdev_device;
+	struct request_queue	*uring_queue;
=20
 	struct nvme_fault_inject fault_inject;
 };
--=20
2.47.1


