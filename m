Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3547BC531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4MB1a8SGwpT1QjQoRQS2ZuK0+ZQ40FMd+Zf8vNPulpg=; b=SlKoYc1ssQZnP7vkD9ExrMjdBo
	xmXK8joxj8GpSxaRullYfpnl5xeKiKfd8nfUp9Wxiw/I099ipRJIg8xw4y4fN499/gMA8fPzRyMuO
	w+LL229ebtsNIN0SPT+Lw8rWpJRxxBrB4Mo/F+OkArFNjo+vornGInos8katl5hZrsdXQUwXHeT1W
	0NDLZc5DCkGcYtzBRakel7R1iM8aguoXoB5N3f8rhqhF4crj2n63XzvFf6fP3uSsPGI37/6nAbgUy
	BAX5KoxeMZ2jX1Fe8AlczzmLbWLfVySQc4rIRtbP6WT4lbNd7FPLVm4o4ULJTtC71+tqxDdrm58Vm
	D3fRA++g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoU-0000000GF8E-3UbU;
	Fri, 24 Jul 2026 11:11:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoT-0000000GF7C-2hoN
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C34AF600AF;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A5A4C4FF61;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=N993Tbovv/OJQ5ehKfsCLbLkOsyM+Z9sDhkUcBQFuG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hG6veWoJn+mVs92hN+5uRUO3eDs5wzOhIBNAvEYaaEeOtb64wBgkDAglvGOYZbTrR
	 qpi+pk37uHfm7eLZHiu88eZW5oJZyOFhIGCZbcMRHWRwBHZPICXDw+YmX29e7mlkJg
	 h+81vQf8w4+hf5LAVCmtf98SXJ0ayQuBT9g2gCRtap8+EAkSKBLy4opLvO4ZacDzDL
	 6Xm90neu8FKD182y01aA3erEEr2ANw03xoE/qgsq8R9zIwVzfoMWKXuaCEF6Q2+Cm8
	 Wxx6oFmSXuycI9LxSKdkTckJs5lcATLthfZuUjAdYahPBa8+sonb95TQ+VcG67Az3t
	 brxRgo1OJvOag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44376C531FA;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:10:55 +0200
Subject: [PATCH RFC v2 01/14] nvme: Add NVME_AER_ONE_SHOT callback handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-1-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3112;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=N993Tbovv/OJQ5ehKfsCLbLkOsyM+Z9sDhkUcBQFuG8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSFlHhZ043yqa49QINd5arkgepGt3mncd+
 qhtRiKsRCU2ZIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0hZAAoJELqXzVK3
 lkFPicML/iLuIyhE/0iBKriMsaxVZwdhPTF/Z4e1nEVOMBpWzRHnCu81fF8lUnEe3WwK1Xoaikh
 f5QSSghOdiijY8KpkkGHUFOt9svSWOXAA20TQGcaatvhoBZSlbnjzzktKoyMbLFZ3pW/doLiec6
 k+zm5eHolzH9XBEC1rYszYV9f3A+1MsX350Gk1leOqrUH6yOCoRnf2tCG7a98H7fgArpox79j3Y
 VBJ5tw/eIgWma73KvzQVHxBHLG0cWCOlH+svBiYM2SHCCCexNikfSxx9AK9S32m7dTHBw3m4VzW
 G0M4iNR9GuSKdYNguZga3QFqIMy3ABKqnY41OwYqYs/IuuKVHXpsEsIgGugnpKoYPuA5GmQ9mmq
 xn2NC4gb3hqRQgMsPSFOrhY5wU6AQ3hG4YiGELPkZW1cJaY3YsOG30ADj63VOVRHAxPeC3HsCf9
 lGvLzUx4Xnx+Ou+roLWg0uTlCKJQcssgT3uRsWtOk0MUTld4nsCq7G4MF/MbwKZWkhs6aAOyWR5
 mk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Handle NVME_AER_ONE_SHOT asynchronous event notifications by extracting
the event parameter from the 64-bit result and passing it to the
handler.

Stub nvme_handle_aen_oneshot() with warnings for now; it will be
extended by subsequent patches to handle specific one-shot event types
like CDQ tail pointer events.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++++
 include/linux/nvme.h     |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fb13f85dd7844331566f05915dda21d91abfea30..6e7533ccf24bfe3df7188f442986ec18a3200660 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4748,6 +4748,30 @@ static u32 nvme_aer_subtype(u32 result)
 	return (result & 0xff00) >> 8;
 }
 
+static bool nvme_handle_aen_oneshot(struct nvme_ctrl *ctrl, u32 result, u32 event_param)
+{
+	u32 aer_subtype = nvme_aer_subtype(result);
+
+	switch (aer_subtype) {
+	case NVME_AER_ONE_SHOT_CDQ_TAIL_PTR:
+		WARN_ONCE(1, "CDQ Tail Pointer one shot event ignored");
+		break;
+	case NVME_AER_ONE_SHOT_CDQ_FULL:
+		WARN_ONCE(1, "CDQ Full Error one shot event ignored");
+		break;
+	case NVME_AER_ONE_SHOT_PWR_TH:
+		WARN_ONCE(1, "Power Threshold Exceeded one shot event ignored");
+		break;
+	default:
+		WARN_ONCE(1, "Unrecognized One Shot Async Event %d (ignored)",
+			  aer_subtype);
+		break;
+	}
+
+	/* Return true in all cases to reque after handling */
+	return true;
+}
+
 static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	u32 aer_notice_type = nvme_aer_subtype(result);
@@ -4796,6 +4820,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
+	u32 event_param = 0;
 	u32 aer_type = nvme_aer_type(result);
 	u32 aer_subtype = nvme_aer_subtype(result);
 	bool requeue = true;
@@ -4808,6 +4833,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_NOTICE:
 		requeue = nvme_handle_aen_notice(ctrl, result);
 		break;
+	case NVME_AER_ONE_SHOT:
+		event_param = le64_to_cpu(res->u64) >> 32;
+		requeue = nvme_handle_aen_oneshot(ctrl, result, event_param);
+		break;
 	case NVME_AER_ERROR:
 		/*
 		 * For a persistent internal error, don't run async_event_work
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 69a8c48faa6ce19e695286d15be2585a4d4401d4..60fb5b6808615ff7388f30e12ffe6ed5da2ef4f6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -862,6 +862,7 @@ enum {
 	NVME_AER_ERROR			= 0,
 	NVME_AER_SMART			= 1,
 	NVME_AER_NOTICE			= 2,
+	NVME_AER_ONE_SHOT		= 4,
 	NVME_AER_CSS			= 6,
 	NVME_AER_VS			= 7,
 };
@@ -877,6 +878,12 @@ enum {
 	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
 };
 
+enum {
+	NVME_AER_ONE_SHOT_CDQ_TAIL_PTR	= 0x00,
+	NVME_AER_ONE_SHOT_CDQ_FULL	= 0x01,
+	NVME_AER_ONE_SHOT_PWR_TH	= 0x02,
+};
+
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,

-- 
2.50.1



