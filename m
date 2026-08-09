Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33201C5AD4E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2sYIrGP5hWBgTk9DPQ8uogsuV+ibpJpd2VlMxFMmIFw=; b=AYu7fXDCqF2K8IySQg/ZLU7sE7
	Fj+4Nt1A0M3Xb5NvDHbRyEuY4MyTi1atgGsdgLW1DcT1dwdAA39/BFB9s+EFxzOfnIhlQg11IbjJ2
	VCkbgjuv3/gIvMF0QhTJgo4wai9wfadO5KJdwABQ+UzqyOv7CHmiOidv4pyVI0ihx7tnRfP+BQQF0
	ODBPNSUK4HFahylOGTxpIUujVw5XSwuxSu4Q87zUBqbht1OzU9Z16iVPCypgTfwjM0W9QXqg2Qe6I
	/oOPNsIah3AgR8PAFTP77oVGIi63AVqDewLbosmhCismnnyxT1B/DYWatdLI5B7ldLdzNX+OlXaJm
	vBvUiNag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt7RF-0000000AY1T-3cR4;
	Sun, 09 Aug 2026 17:35:57 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt7RD-0000000AY0o-2BRo
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 17:35:56 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1080879a91.3
        for <linux-nvme@lists.infradead.org>; Sun, 09 Aug 2026 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786296954; x=1786901754; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2sYIrGP5hWBgTk9DPQ8uogsuV+ibpJpd2VlMxFMmIFw=;
        b=SU8mpUxcz50YRAoQBzX2a0bqu7Az1YHn2PW6bMZxxeHvvFqMgJaOXCFmXMZHkoNeL6
         LgF8CU8Ba2jUVgfdDpk/ON9dQF4MHEs2XeJ05fQmXdaj1PvgVm7d1/kFGjePlJryS2mO
         B3yNJvSNqHKuYvAZ3Y7T9B0hFP4ylC+iKSjjLKCw9X2RKsxsMeXCVS14KuOCwnMGSLIv
         hrwrvdXj+rSwrFMNkiQLCNNrJwBMC0VV3jW3FOFz3YNsVbRQ9+wXkWfob12wlIyZqZP7
         UL1iPA0o2aZ8shKOg6R9qfaFjGQvHqux8epNY+fQZSNIyXD7v9Le9yGa8UQ6N8bZh3sX
         vnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786296954; x=1786901754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sYIrGP5hWBgTk9DPQ8uogsuV+ibpJpd2VlMxFMmIFw=;
        b=LbpyvDFpqOOY9EZSGfhzxo8PKFaL9b0HIlFliZSnq79b/WRBRB5da3nJkhAoPRHjB5
         FLdCQucDOPWMellg/dhQnEj+3xs+HaNLpZI3nIE13n7+QFuo/aSlLTpzOCPZx4hlRrTY
         D4yCCi0IhdbG5EH5Ml8p9txFxndU1/kAM2Wet0/2kUZupYlNHm0EY5cRxATJ7S0UtO+F
         7MpXrM74tQ/H9gMI1SujqDPFqfleaQXfLvVyDH2UApqxkojxNuggFSZF6FSLrLxl24Lb
         1ZYZusiVzNZy3nfanC/w0WJO7nYZo+6E6Ry32v3AbeHPOcR2JFOXDF10bHcMIab2OQvz
         CD7A==
X-Gm-Message-State: AOJu0YxqVuVYE4GGMzWO8cfbUx5SMz8lP9y+3bBQLSR5eXXQwhQygIh+
	uDgEW7AwpNriU+es+wAXSykRkH8fS+xuvThHphUlLrvmz7Rb8lF1JdUBHcxl8A==
X-Gm-Gg: AR+sD11vxHFwWUVPhvVFs/Qrm2Q5TkDyaZOULFopQvexmPMcXkoWHxELbCxEhnW53Gh
	l0aS2XJlg0AtsxvSW4aPL8v30yKYZCOMiRhHQpQzAYYboGefVPGWg4tMb8IuLemDK8QSdMh3BE+
	6Tie3QEcsxsVJ++/Mck1lIHw8i3XVrkcfyYoHzHVP1CHumHGTajucihOd6z2nFfgCVuBibdRXjK
	i/bnIYdRlLaECGzweDStL8dPJXVFFFklNFT6CQRUueLs6XR/x56NZ5BBkWdsEM9Kzv1wvTqKkR7
	l19uRTQe43Mm3HlSUfLpUFzpCZd6cSX19HLom86K0+tmMSltXHdwNNuh+QhmQCnrkJAQoIDGpfy
	78fiK3azvyPaRZIc9whi9Wv2FVTKGa+tucl+LMNQ9rVw4wn+SF+72AzTPS4m2y6bXVU7UsTI2an
	60ivjTJTbNGMZtgpEu17xs/USgVrB8t7/atDQZCjWNehz9V2Jvb1niVDsRlhEeZsKhPBc7Edtl0
	WwhUV3J+/FY
X-Received: by 2002:a17:90b:1d4f:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3903c5381d6mr36290230a91.5.1786296954274;
        Sun, 09 Aug 2026 10:35:54 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:9610:4dcf:a256:479e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dab4sm9384112a91.3.2026.08.09.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 10:35:53 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: add crd value to output error log
Date: Mon, 10 Aug 2026 02:34:45 +0900
Message-ID: <20260809173545.54749-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_103555_561207_357639E4 
X-CRM114-Status: GOOD (  12.46  )
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

Also add NVME_CRD to get the status CRD value.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 15 +++++++++------
 include/linux/nvme.h     |  1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..0178de333ceb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -326,7 +326,7 @@ static void nvme_retry_req(struct request *req)
 	struct nvme_ns *ns = req->q->queuedata;
 
 	/* The mask and shift result must be <= 3 */
-	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
+	crd = NVME_CRD(nvme_req(req)->status);
 	if (crd)
 		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
 
@@ -344,7 +344,7 @@ static void nvme_log_error(struct request *req)
 	struct nvme_request *nr = nvme_req(req);
 
 	if (ns) {
-		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %u blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %u blocks, %s (sct 0x%x / sc 0x%x) %s%scrd=%u\n",
 		       ns->disk ? ns->disk->disk_name : "?",
 		       nvme_get_opcode_str(nr->cmd->common.opcode),
 		       nr->cmd->common.opcode,
@@ -354,11 +354,12 @@ static void nvme_log_error(struct request *req)
 		       NVME_SCT(nr->status),		/* Status Code Type */
 		       nr->status & NVME_SC_MASK,	/* Status Code */
 		       nr->status & NVME_STATUS_MORE ? "MORE " : "",
-		       nr->status & NVME_STATUS_DNR  ? "DNR "  : "");
+		       nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
+		       NVME_CRD(nr->status));
 		return;
 	}
 
-	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
+	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%scrd=%u\n",
 			   dev_name(nr->ctrl->device),
 			   nvme_get_admin_opcode_str(nr->cmd->common.opcode),
 			   nr->cmd->common.opcode,
@@ -366,7 +367,8 @@ static void nvme_log_error(struct request *req)
 			   NVME_SCT(nr->status),	/* Status Code Type */
 			   nr->status & NVME_SC_MASK,	/* Status Code */
 			   nr->status & NVME_STATUS_MORE ? "MORE " : "",
-			   nr->status & NVME_STATUS_DNR  ? "DNR "  : "");
+			   nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
+			   NVME_CRD(nr->status));
 }
 
 static void nvme_log_err_passthru(struct request *req)
@@ -374,7 +376,7 @@ static void nvme_log_err_passthru(struct request *req)
 	struct nvme_ns *ns = req->q->queuedata;
 	struct nvme_request *nr = nvme_req(req);
 
-	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
+	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%scrd=%u "
 		"cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x cdw15=0x%x\n",
 		ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
 		ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
@@ -385,6 +387,7 @@ static void nvme_log_err_passthru(struct request *req)
 		nr->status & NVME_SC_MASK,	/* Status Code */
 		nr->status & NVME_STATUS_MORE ? "MORE " : "",
 		nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
+		NVME_CRD(nr->status),
 		le32_to_cpu(nr->cmd->common.cdw10),
 		le32_to_cpu(nr->cmd->common.cdw11),
 		le32_to_cpu(nr->cmd->common.cdw12),
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 041f30931a90..56b27c3ba909 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2248,6 +2248,7 @@ enum {
 };
 
 #define NVME_SCT(status) ((status) >> 8 & 7)
+#define NVME_CRD(status) (((status) & NVME_STATUS_CRD) >> 11)
 
 struct nvme_completion {
 	/*
-- 
2.53.0


