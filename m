Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F87CC25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BB5jRRAHL5wuMJv/yBA2mpj6NCxlU59fz3DhmW/9J84=; b=3tSBjNHRewoyLJpfpyNJ9nqmnS
	Y/DLlmZOvJoCglsWW6YEldlaqiuypMM6aFiS563E/X27s3OjYkHR8xmsnLjUHWbAiS1F5bm9SXxc8
	yz1iWcV+NSot0s/RSL1z5xrTiE2XJdGs+GVTKrntgKnDnAcRLWpGjpWfgCRsJkhUZjahFDoG77CFk
	C6Za3QjUP/2mSkKiF2w2bwSpw0ov2Zb+5hf7Y5Q2proFxxEOPwATE4YKv7ZEl3xkrGaMHPXxxKVje
	dCzY6MhpYa9y513vNfSW+P01FuNS4gHLFa869IN2KbqjiqMaJpzz7/xV3QBV9tEgCgbAHKSTJvF1c
	MySp1cfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8s-00000005s2k-073x;
	Fri, 10 May 2024 16:30:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8o-00000005s0f-12tg
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715358634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BB5jRRAHL5wuMJv/yBA2mpj6NCxlU59fz3DhmW/9J84=;
	b=bnj19RT1xuOR3i5UPbxh7TvaU9P2uXYebqQ3oKNT7ms3W0itewblOK2UJO2bOlVIBHdLVX
	1EQgcYg55g7wkALGgFe3QEBDzc+lRzOsI48Sa83fHfbP2U270xIBJZHDv3qQAaZRwGx01Z
	vqr2z82L0Wnx1e6kvCxu7r9Ir7Vt95c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-6NUUHYUmPUC9wmp--S5cQw-1; Fri, 10 May 2024 12:30:31 -0400
X-MC-Unique: 6NUUHYUmPUC9wmp--S5cQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B418A8025FC;
	Fri, 10 May 2024 16:30:30 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.42.28.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9546B207CDF0;
	Fri, 10 May 2024 16:30:29 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/5] nvme: add definitions for cancel command
Date: Fri, 10 May 2024 18:30:22 +0200
Message-Id: <20240510163026.786898-2-mlombard@redhat.com>
In-Reply-To: <20240510163026.786898-1-mlombard@redhat.com>
References: <20240510163026.786898-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_093038_398231_C4E79220 
X-CRM114-Status: GOOD (  11.03  )
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
---
 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      |  1 +
 include/linux/nvme.h          | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 6f2ebb5fcdb0..d1fb08a0cc42 100644
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
index 095f59e7aa93..b48967c98114 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4835,6 +4835,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_cancel_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 425573202295..8efebc805e19 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -830,6 +830,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_cancel		= 0x18,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -1343,6 +1344,22 @@ struct nvme_abort_cmd {
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
@@ -1798,6 +1815,7 @@ struct nvme_command {
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
 		struct nvme_abort_cmd abort;
+		struct nvme_cancel_cmd cancel;
 		struct nvme_get_log_page_command get_log_page;
 		struct nvmf_common_command fabrics;
 		struct nvmf_connect_command connect;
@@ -1938,6 +1956,7 @@ enum {
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
 	NVME_SC_ONCS_NOT_SUPPORTED	= 0x183,
+	NVME_SC_INVALID_CID		= 0x184,
 
 	/*
 	 * I/O Command Set Specific - Fabrics commands:
-- 
2.39.3


