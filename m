Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27434EE645D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YL2K6TWV1eJi+XrksEL+5w1GyG0I2O5LfHSXq9U28f0=; b=NK8y0+Fq0rftsUCyeHDvwOiiW/
	Qk7anmR3ToxJGhGk73jyeCF26aAO0RheWvwuq9IAn1qYLuNe/lpca+jJuAALmNHNMvpYVIOKiQX5w
	IOR0D0RJ+W7pvFkbhF9wmKoN7yfPxIXJO/M4eHOZWhD2XdORKe4UL3nUsJFzPoMmFwO9FZD7GHWip
	5+eqlr57y9IfduXletbyqy3L+q5yu+XS8TMmz3kL0d/gTbAKrKIqotSHDoAJXbdF38MhPbg3hNze8
	/0wzbXBiEi0pkZd1PB0hr1G3ELBQEsAhRYE7h+eP1NbrNL7sibA5z9x4o025NTH9Y7fxth50sFi8Y
	J//DB+Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1S-0000000CKwy-1uei;
	Thu, 12 Sep 2024 08:17:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof0g-0000000CKlh-215g
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726129021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YL2K6TWV1eJi+XrksEL+5w1GyG0I2O5LfHSXq9U28f0=;
	b=bHwkvelHw/1lL2drPOHk5RLXGFKJginyEO0p3ekt5tCCy2OmrRYS2OmFp2YU2Hfkh1M2fC
	cSwkuSC3CYbP4jSd/O4STupYpiIF/QVKtQro1n7155hYuy4YHKikQLBCaVn2bahm3D8VHn
	+q68zQZn/RvUG7fpvdm2KqnYOsyrS74=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-wRh7C0Z8NZ-_BxGBRpALZQ-1; Thu,
 12 Sep 2024 04:15:18 -0400
X-MC-Unique: wRh7C0Z8NZ-_BxGBRpALZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F92E1954B1B;
	Thu, 12 Sep 2024 08:15:17 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFF0319560AA;
	Thu, 12 Sep 2024 08:15:14 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 1/7] nvme: add definitions for cancel command
Date: Thu, 12 Sep 2024 10:15:04 +0200
Message-ID: <20240912081510.171857-2-mlombard@redhat.com>
In-Reply-To: <20240912081510.171857-1-mlombard@redhat.com>
References: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011702_619155_C13A6991 
X-CRM114-Status: GOOD (  12.74  )
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

From: John Meneghini <jmeneghi@redhat.com>

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
index 983909a600ad..3768b1d778fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4964,6 +4964,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_cancel_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7b2ae2e43544..439f2abb6542 100644
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
@@ -844,6 +847,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_cancel		= 0x18,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -1357,6 +1361,22 @@ struct nvme_abort_cmd {
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
@@ -1812,6 +1832,7 @@ struct nvme_command {
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
+		struct nvme_cancel_cmd cancel;
 		struct nvme_get_log_page_command get_log_page;
 		struct nvmf_common_command fabrics;
 		struct nvmf_connect_command connect;
@@ -1954,6 +1975,7 @@ enum {
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
 	NVME_SC_ONCS_NOT_SUPPORTED	= 0x183,
+	NVME_SC_INVALID_CID		= 0x184,
 
 	/*
 	 * I/O Command Set Specific - Fabrics commands:
-- 
2.43.5


