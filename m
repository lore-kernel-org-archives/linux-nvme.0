Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEC9C3600D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wr/cwYS24P29hOlJoPrzi84QrUvj48u5pwm5vzsn6F0=; b=sRE8PHylQShmj0UXwC+JyS4NpL
	GjysLKmF3L/q7Ls4ux5J45+BJmjo1s9LZubzB20F71q0ox8rwB9dKVUmhMYbHcD+JZAq0jxE/lZv/
	mF2s8J4lK+z2z+4cwS0S6DnSQ7RBhArcsR3VE6a0hc9yjL2N1X7KqedDZJ5FqH7LaZRxVH8v1naUj
	FiRYbHfyPdydVevlwygfIGXDK+M9GOxH0Lafepx8rg94GXTYgg621BdeW2czaq9jeI/xxZ0XDFo4Z
	/sfN2iTqgkUYSmWU6S74W6/DsKwVa4vRK3OnEwr1xRW2PS6+EXAj6NmLpOzT/wxbqxAEUjMKZOTcT
	F7L7M1nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyu-00000002oNE-0UVM;
	Mon, 24 Mar 2025 10:24:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twext-00000002oAQ-1cG0
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr/cwYS24P29hOlJoPrzi84QrUvj48u5pwm5vzsn6F0=;
	b=elvGHUhUYFdOiADhbu1Voa5bXPJrhLdhkgjHywZZD0+jCPwyhhbIKIBitJmZjpD6Tb9+bq
	0Mmu96heGlyZx7a8RoGjQQQu3+f71DGnxsuI4Zm5T5NlCbdU+alM3e+Lh2llOBFBipoBcf
	zGPk7ZyxsUEgyiP5jhGa0TI/uLNihsg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-XzSX2qTuMESTXWwSmg2VRg-1; Mon,
 24 Mar 2025 06:23:25 -0400
X-MC-Unique: XzSX2qTuMESTXWwSmg2VRg-1
X-Mimecast-MFC-AGG-ID: XzSX2qTuMESTXWwSmg2VRg_1742811804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 156151955D82;
	Mon, 24 Mar 2025 10:23:24 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC298180A801;
	Mon, 24 Mar 2025 10:23:20 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 02/11] nvme-core: reserve tags for cancel commands
Date: Mon, 24 Mar 2025 11:23:01 +0100
Message-ID: <20250324102310.658007-3-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0aGwDZ2mKfXu5stQHQNGO778YDEb7rZPwegxEXpvths_1742811804
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032329_491137_9BD24F41 
X-CRM114-Status: GOOD (  11.86  )
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

If the controller supports cancel commands, reserve
NVME_RSV_CANCEL_MAX tags for them.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 15 ++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95aeace93b75..f5e6d7cd152a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1210,6 +1210,14 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, "NVME_TARGET_PASSTHRU");
 
+bool nvme_io_command_supported(struct nvme_ctrl *ctrl, u8 opcode)
+{
+	u32 effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
+
+	return effects & NVME_CMD_EFFECTS_CSUPP;
+}
+EXPORT_SYMBOL_GPL(nvme_io_command_supported);
+
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 {
 	u32 effects = nvme_command_effects(ctrl, ns, opcode);
@@ -4675,9 +4683,14 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	 */
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
-	else if (ctrl->ops->flags & NVME_F_FABRICS)
+	else if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/* Reserved for fabric connect */
 		set->reserved_tags = 1;
+		if (nvme_io_command_supported(ctrl, nvme_cmd_cancel)) {
+			/* Reserved for cancel commands */
+			set->reserved_tags += NVME_RSV_CANCEL_MAX;
+		}
+	}
 	set->numa_node = ctrl->numa_node;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
 		set->flags |= BLK_MQ_F_BLOCKING;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..6dfc875ddfd1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1187,6 +1187,7 @@ static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
+bool nvme_io_command_supported(struct nvme_ctrl *ctrl, u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
-- 
2.43.5


