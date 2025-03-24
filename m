Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F2FC36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OQTgzKQuZXgG/W+k4toSptoRobo8PhNNoKdyw5KryU=; b=2lFMhlR3dc5pHRMF3XqaVPymR7
	VUcEiJxkLN1T1zfiQW/ANSxx/cSKXW2KLaOuGLF6Z44e2nyIB1QoHqXW7LtoasV2biXt0Zm+1M+NX
	4kRgNtww5zZ8yaA7HNGWYPRypvzeETxHgzVGhOckwpFuc5k10wB9Am+kf+gywIS37FXvhJWTYp2Of
	q0ri3xuCJpRQPOOam+EhksZMjY+wJlXlSXNIdErU3n/XAe0SejvnZvRABkuRQL1fOQRBqlMm8PKNX
	6bSujbJv5FxF4wDTiJjccHxGb0kgW2fjwD8lNYy1Av29MB997iK163L0XJCY9Ad5C9KG81SL7v3Rn
	xj173TZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyt-00000002oN7-28Cq;
	Mon, 24 Mar 2025 10:24:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twexr-00000002o8m-0xL7
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OQTgzKQuZXgG/W+k4toSptoRobo8PhNNoKdyw5KryU=;
	b=gWpXgCJyXvCMb+exg46EUpoeMc+2Q77v6hWTWfEN6zYgKNOeb9QF4M+b1gJMEfaJqBJdVG
	bRJttKfecfJ2BTFeEDEqKBrQ2NkAOxy0Fsun3mn4A5MMzekr+MhGMWpmBb/d1QXb4/Nq+W
	p70LHU81zxzs/RTbJSrDWYHwy/8ks28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-WAnfGraoPA2TByl4gpMFLw-1; Mon,
 24 Mar 2025 06:23:22 -0400
X-MC-Unique: WAnfGraoPA2TByl4gpMFLw-1
X-Mimecast-MFC-AGG-ID: WAnfGraoPA2TByl4gpMFLw_1742811800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DE5C180AF6E;
	Mon, 24 Mar 2025 10:23:20 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65746180A803;
	Mon, 24 Mar 2025 10:23:15 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 01/11] nvme: add definitions for cancel command
Date: Mon, 24 Mar 2025 11:23:00 +0100
Message-ID: <20250324102310.658007-2-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AlQQU5Mg6Dy_QEwAtP7JRa2mcp9YOxbBlgKxdIna-Rc_1742811800
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032327_362627_FF2AEE00 
X-CRM114-Status: GOOD (  12.49  )
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

Add new definitions needed to support TP4097a.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      |  1 +
 include/linux/nvme.h          | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 2b9e6cfaf2a8..ff6e965b372d 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -19,6 +19,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_report] = "Reservation Report",
 	[nvme_cmd_resv_acquire] = "Reservation Acquire",
 	[nvme_cmd_resv_release] = "Reservation Release",
+	[nvme_cmd_cancel] = "Cancel",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
 	[nvme_cmd_zone_append] = "Zone Append",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 870314c52107..95aeace93b75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5087,6 +5087,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_cancel_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bfb5688363b0..cdf22a859f9b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -28,6 +28,9 @@
 /* Special NSSR value, 'NVMe' */
 #define NVME_SUBSYS_RESET	0x4E564D65
 
+/* Maximum number of reserved commands for Cancel */
+#define NVME_RSV_CANCEL_MAX     2
+
 enum nvme_subsys_type {
 	/* Referral to another discovery type target subsystem */
 	NVME_NQN_DISC	= 1,
@@ -890,6 +893,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_cancel		= 0x18,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -1425,6 +1429,22 @@ struct nvme_abort_cmd {
 	__u32			rsvd11[5];
 };
 
+struct nvme_cancel_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u32                   rsvd1[8];
+	__le16			sqid;
+	__u16			cid;
+	__u8			action;
+	__u8			rsvd11[3];
+	__u32			rsvd12[4];
+};
+
+#define NVME_CANCEL_ACTION_MUL_CMD	1
+#define NVME_CANCEL_ACTION_SINGLE_CMD	0
+
 struct nvme_download_firmware {
 	__u8			opcode;
 	__u8			flags;
@@ -1887,6 +1907,7 @@ struct nvme_command {
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
+		struct nvme_cancel_cmd cancel;
 		struct nvme_get_log_page_command get_log_page;
 		struct nvmf_common_command fabrics;
 		struct nvmf_connect_command connect;
@@ -2069,6 +2090,7 @@ enum {
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
 	NVME_SC_ONCS_NOT_SUPPORTED	= 0x183,
+	NVME_SC_INVALID_CID		= 0x184,
 
 	/*
 	 * I/O Command Set Specific - Fabrics commands:
-- 
2.43.5


