Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD68AEE645E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPJcttC+rTzmYILfO4V9v/6fnP8TCIFOLnQzdXWZrJ8=; b=r1eUXzJT/le6M04f3Qrq4dXONy
	fT6nOOKYbtdbmPQwCJCT0g9/NFdE3gdyCBqWWBYOgg1Vx36lrDhL4kLyg7rV5/8zI3Ad5ujPNTHci
	ykFMVn9sndsjbSRFz3dW8+5pPXg2EYJe06KMQ/WK+hdJm2zkQvPrY47iHXu0Vges8fQEV6wOao5SN
	NIepVGG0td4vnU2RnWUAytKhN39AMjb90tRf4+K1n+dVWyTOMwLjw7R+MkZ7/+HESPgG9JoN0QP7u
	4WB3MPVI0xlEcMhUeGQ44iOTxRQiSuHxG2ZiXArFGjOLGOp1ufZJSjXWfMAhWmdZQSczONKJM55ck
	2U86qkhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1H-0000000CKoj-0Qsf;
	Thu, 12 Sep 2024 08:17:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soez9-0000000CKTg-3KUx
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726128924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPJcttC+rTzmYILfO4V9v/6fnP8TCIFOLnQzdXWZrJ8=;
	b=MwQoMqvnjDdlsKZUFwQ2oZvPST6B02N7gm2vHXVmc2VoipyWt/vKLIeSoEPzOHbgwlwIkV
	qGmSJUmdbxLa9odg+G0hVo68zI7GUJgAOczgRCOFP04zcd1GXvRY5n9g8YzAmRPoDgUTx+
	OC9OdjDw3J+JgBB5UfK0i8KavmNjP1E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-QafTxUrZNhSwI2kV06haxQ-1; Thu,
 12 Sep 2024 04:15:21 -0400
X-MC-Unique: QafTxUrZNhSwI2kV06haxQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06B23195394E;
	Thu, 12 Sep 2024 08:15:20 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AFAE195605A;
	Thu, 12 Sep 2024 08:15:17 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 2/7] nvme-core: function to check if a controller supports a specific I/O cmd
Date: Thu, 12 Sep 2024 10:15:05 +0200
Message-ID: <20240912081510.171857-3-mlombard@redhat.com>
In-Reply-To: <20240912081510.171857-1-mlombard@redhat.com>
References: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011528_008257_5840AB77 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

Add a function (nvme_io_command_supported()) that checks if a
controller supports a specific I/O command.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3768b1d778fb..d1e87d74c48b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1191,6 +1191,14 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
 
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da57947130cc..c014192bd623 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1153,6 +1153,7 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
+bool nvme_io_command_supported(struct nvme_ctrl *ctrl, u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
-- 
2.43.5


