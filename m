Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E60FF8860
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2026 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLlXqroTI3oZ9/QsvSsSCBwRC16weMgFUIZpm4pmYYE=; b=T2uFQWBe/+3XbAnabDRDvoHHvK
	SySz5IRoOw1LZ+H6yoSZHqjDLFLp9Tug6CLlP3jN0IiLYR7zLn5ekNG+jOE0NeHHzEV0hZrUO9Q8D
	BGI4ZzsmAp/q0oxAHUc6R60QacsaYwLZjbm1+F8hlK2sHuud5VSv0BvleHJZr5CzfJ7V2VnAygLQV
	nP3C8GY+PW8iwpVroR7rqOsXq1pNiwQKdpu88oVxqysGXf7AmDloHXARlHr3IVk2ordVLtyIpmidF
	3Lx4MCMjmKpgPh82l9Hoc4L/UfeCTcUUG34e3pMv7PcSnuq/5cZDuimjX/2BD5uNqmLWNFB2+Kqnw
	mRAUgr2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcgg-0000000ESZn-1G3a;
	Sat, 25 Apr 2026 13:04:46 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcge-0000000ESZB-0Fob
	for linux-nvme@lists.infradead.org;
	Sat, 25 Apr 2026 13:04:45 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82faf871346so5394950b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 25 Apr 2026 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777122283; x=1777727083; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLlXqroTI3oZ9/QsvSsSCBwRC16weMgFUIZpm4pmYYE=;
        b=LzLn/zwB2rQa0jvZQfujAdCLnnpDP7SfGzgS3FNWp4Oi4m7VX7qdqSHWtUgQHs/WbL
         +Mew5d3aCUhG6SvLwghAjRcn+PM9QQqpl93g+ZiYgkiqWKAB8rnNNEUq9/hneaMYCSua
         6V+VXpWKVjAk0hgNw4AAjRdGF2dPKsElXDB4AMlDV2WyJq0MJyIWfqo85f8TtqTsNp+1
         GwtL82D897gv2akIBOOpaBsgEdZbG9JH1OWKuzA2nKD5A7d/C6LfD+fkipbioqYlOWDC
         YSUwcnncaNYVBWDjmeXfdapG+ZMMgIVbBF1jM7pX3XurbA2ecDLr0dSyxDAmFx9H1UqU
         hSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777122283; x=1777727083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLlXqroTI3oZ9/QsvSsSCBwRC16weMgFUIZpm4pmYYE=;
        b=aMLtEzd9T3fb+pFkGOUorFWF3tDiZeQq/uY+N/VJKymWHP69ZM0ItCjEDHVQ+ThWx+
         KZi1tXM21PmDT+sNcFE/P3U0iOOWTJLJrEacwgAdKSW254SvjJJC42Nw9ysHg1bvnOcp
         x8jJG6sQVFppstEScGIkKBOHQPqQtn70Ge6qeUDVtrZvXugoVxOZyzrzOYRUd8DyoMXx
         D2pvmRuqxL0+QaVJcATEFJHVWZ6Of9UAxVDxnPmUMICQEvcZcw6rzYJ8Gy1O4styX2Bb
         FZ/CTZVyUYnsXDYyqOXL/VnG/kORjUdwizv9iI0rUO+RHHh65IYmAcvQbKSaNbMUhraz
         ot6w==
X-Gm-Message-State: AOJu0YzaHOThpSpPbNjr9bmWq8sgW6V84kAbwrzJwmuHmTKv242wj48z
	4NXFdsfWynKvTPTJibat1VHxsDCp3dzPDJS7S9CaQPTtLYINi60vCGSB
X-Gm-Gg: AeBDiesAYFpE1Jxf8Qy8jNBZ4KLioheov1zthEUlca31K6FM0PSi+I9jljXgGFLUB4+
	B+LMeDZcVSeyKwaI0W1nXoHIVgbyrRLt9FOPisctecvJV2Hgi9xm3ExdoVHLTl8PhuSuZqsD0pH
	kl8ZB9VOhr/+7nt+EYwxLuKN1/WCNUkPqptLSr+AnUgewcwUTg4f2lGzsR0jZO/gMheMOHd+GJF
	Ab6WfqwPSi13EEgXR4I0KODNnwNap8ltml/obTmvDehLChw2BRynrtYDdmixqeBvHxJmE/gx6kC
	2zbfsPR1zibkxY1rMVBXY4UBctslyXZ9/yAZ1LKEDszzbmZNUjIzbSR3SFe65PkOl6bneWuxzQc
	TBjxdBFABNnzbt57GB7wGunvwypYavXpQBfmSSZhf/GUosY2upeJX8H8rIYEUW2iZvehq15VeRC
	m3pYUfN2v7Ne8ZCvTmpfkT5CXZKDVpU2D7VnbaExK//DQs/lA=
X-Received: by 2002:a05:6a00:9507:b0:82f:4628:4198 with SMTP id d2e1a72fcca58-82f8c8c79dcmr39984101b3a.31.1777122283104;
        Sat, 25 Apr 2026 06:04:43 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:6ec6:dcf2:7610:e61d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea0a97esm32302802b3a.27.2026.04.25.06.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 06:04:42 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v3 2/2] nvme: initialize known effects to set ns_mgmt NCC and ns_attach NIC
Date: Sat, 25 Apr 2026 22:04:13 +0900
Message-ID: <20260425130426.10061-3-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260425130426.10061-1-ikegami.t@gmail.com>
References: <20260425130426.10061-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260425_060444_102514_B3634060 
X-CRM114-Status: GOOD (  14.03  )
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

This is to make sure scan_work done for the commands.
Since nvme_passthru_end called when effects set.
Also scan_work is flushed when NIC or NCC effects set.

The change is to improvement the scan_work to make sure.
Always do scan for the ns_mgmt and ns_attach commands.
All drives supporting ns_mgmt and ns_attach should have the entries.
But no need to be depended on it as always do scan.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v2:
- Document the change explanation in both the commit message and code comments.

 drivers/nvme/host/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f973d88c830..d88813dfaf9c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3448,7 +3448,7 @@ static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
 
 static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 {
-	struct nvme_effects_log	*log = ctrl->effects;
+	struct nvme_effects_log *log = ctrl->effects;
 
 	log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
 						NVME_CMD_EFFECTS_NCC |
@@ -3473,6 +3473,19 @@ static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 	 */
 	log->acs[nvme_admin_security_recv] &= cpu_to_le32(~NVME_CMD_EFFECTS_CSE_MASK);
 
+	/*
+	 * This is to make sure scan_work done for the commands.
+	 * Since nvme_passthru_end called when effects set.
+	 * Also scan_work is flushed when NIC or NCC effects set.
+	 *
+	 * The change is to improvement the scan_work to make sure.
+	 * Always do scan for the ns_mgmt and ns_attach commands.
+	 * All drives supporting ns_mgmt and ns_attach should have the entries.
+	 * But no need to be depended on it as always do scan.
+	 */
+	log->acs[nvme_admin_ns_mgmt] |= cpu_to_le32(NVME_CMD_EFFECTS_NCC);
+	log->acs[nvme_admin_ns_attach] |= cpu_to_le32(NVME_CMD_EFFECTS_NIC);
+
 	log->iocs[nvme_cmd_write] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
 	log->iocs[nvme_cmd_write_zeroes] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
 	log->iocs[nvme_cmd_write_uncor] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
-- 
2.51.0


