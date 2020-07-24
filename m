Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E688C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:41:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AECB206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1SaNsVGS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNxqAhYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AECB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LvJVAoISsmT5rl52Ghnzl2Fke8kY9DE5RfLGYtnGQO4=; b=1SaNsVGS0hNUTfCC6h7Q9paEKI
	KpNa2ZDctFEIlHOhf4C6OF0ugfjmzGf/o+HOlPmZOFQwOJxWNZvNKqPJecivomHlS+UpBQxh6x5pQ
	plZUFGd7secE1O9qQamR8L3OJbZzuF+edrrKl8kBNM0OTYBdTslEVwrhU5cOSRxCQ3CrC41tp0SV/
	M3deSCBECG4ECkXXbZ2fKJ8yKPNi+OIEQOA0dgAnCMN2AF7rN27pKESWaXIZ9cd1uDQzGZKC5qmHo
	CKAIm7XLF0y2N3/++PDtK0ivqgur2Dm1WGd/npnvzvIGif/atF3RJtf2d1qtJOKLA95kNUUaJGjyB
	pS7ENsLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz0ko-0006na-JI; Fri, 24 Jul 2020 16:41:02 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz0km-0006mt-FR
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 16:41:01 +0000
Received: by mail-pg1-x543.google.com with SMTP id d4so5551954pgk.4
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zb7t5er96L+r13wSSvHuz6b+yAVDFlOhaazd6xK18Ak=;
 b=bNxqAhYHQL0u9qkIrgKfgeZZ3S0k8mPu2iyl7buSgJH5UE7AIFHVCUp4ln56H6QbnY
 XCbTyuOU0ng7BAa5O3/L7Le1xAFnr7uzj19PwzBOWFo4ipNmtkRMVRkwx7mgcws7V2lG
 4b6YLUc6J1zY0fry4LOlG2z2itnv/XXwB1GEZ0LYVgHyuvgXWvN8WnHDMNLhpGr+MhQy
 1lwQIkPlungHymlk2tLpsfDxvsuyVhNgfFptJ0OHvC3WVqLE/+cYNJp9YMseDscMRuWl
 zoWVXc0wu411R0zQO7SLSHW4/Cp3V94cSzZWQioICN0MmoDQ/Ej5jv2Mzp29T4zrmKs0
 iYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zb7t5er96L+r13wSSvHuz6b+yAVDFlOhaazd6xK18Ak=;
 b=IAwHVBH2RqknZY+pnVtmTz1OnXp2D9TTtFT8HWLprPiuSqeQR4uDauYrU1Wj6O1IOd
 /8RbhMhgemHY4sOV5apStkWgBUTtqdlx/2M5IVtSbVBa7M42o31onMAtcMtVF74A4NYT
 wy5Puv7UHtXAdvFwJSLG1vgHXmFLTLDvB/XZa/fGau6K63NJfPwBgj+O9xvl3X3W2eb4
 Bd9gRLGw8GwDxrfVNFEfv6Eok+0jITtOQY1EZPpMllseQvsxaSKhHUM49r9sppF0pNMa
 h/pZGNKTmdbzat4fzBW8Q/KRxfhD0xMMIKs1fSY3o652RA/CLaD8G7AuVjHn6USBzLpa
 xmmg==
X-Gm-Message-State: AOAM531Jax/ELtVu0VCLK30wUbYv0JLRFmAZ89/g8zRKJ8RxaUzdsoUP
 bWPaQJKfOfWt76qoOP3kUdCwdLAy
X-Google-Smtp-Source: ABdhPJwDAYlGQKiCxBxMWzVwyx1BrWq8SPEwWzBQetmIvPDTuj4Pv7GxC3kOPR8GHiA+TVNL0Xjdlg==
X-Received: by 2002:a63:d944:: with SMTP id e4mr9261118pgj.376.1595608857965; 
 Fri, 24 Jul 2020 09:40:57 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l207sm7431119pfd.79.2020.07.24.09.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:40:57 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-fc: remove redundant del_work_active flag
Date: Fri, 24 Jul 2020 09:40:48 -0700
Message-Id: <20200724164048.49936-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_124100_591938_BD8EC3B1 
X-CRM114-Status: GOOD (  11.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The transport has a del_work_active flag to avoid duplicate scheduling
of the del_work item. This is redundant with the checks that
schedule_work() makes.

Remove the del_work_active flag.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/target/fc.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c15356b5e09f..55bafd56166a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -167,7 +167,6 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
-	atomic_t			del_work_active;
 };
 
 
@@ -1090,7 +1089,6 @@ nvmet_fc_delete_assoc(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 
 	nvmet_fc_delete_target_assoc(assoc);
-	atomic_set(&assoc->del_work_active, 0);
 	nvmet_fc_tgt_a_put(assoc);
 }
 
@@ -1123,7 +1121,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
 	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
-	atomic_set(&assoc->del_work_active, 0);
 	atomic_set(&assoc->terminating, 0);
 
 	while (needrandom) {
@@ -1478,21 +1475,15 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 {
 	struct nvmet_fc_tgt_assoc *assoc, *next;
 	unsigned long flags;
-	int ret;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		ret = atomic_cmpxchg(&assoc->del_work_active, 0, 1);
-		if (ret == 0) {
-			if (!schedule_work(&assoc->del_work))
-				nvmet_fc_tgt_a_put(assoc);
-		} else {
+		if (!schedule_work(&assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
-		}
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
@@ -1534,7 +1525,6 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 	struct nvmet_fc_tgt_assoc *assoc, *next;
 	unsigned long flags;
 	bool noassoc = true;
-	int ret;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
@@ -1546,14 +1536,9 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		ret = atomic_cmpxchg(&assoc->del_work_active, 0, 1);
-		if (ret == 0) {
-			if (!schedule_work(&assoc->del_work))
-				nvmet_fc_tgt_a_put(assoc);
-		} else {
+		if (!schedule_work(&assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
-		}
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
@@ -1574,7 +1559,6 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	struct nvmet_fc_tgt_queue *queue;
 	unsigned long flags;
 	bool found_ctrl = false;
-	int ret;
 
 	/* this is a bit ugly, but don't want to make locks layered */
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
@@ -1598,14 +1582,9 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			ret = atomic_cmpxchg(&assoc->del_work_active, 0, 1);
-			if (ret == 0) {
-				if (!schedule_work(&assoc->del_work))
-					nvmet_fc_tgt_a_put(assoc);
-			} else {
+			if (!schedule_work(&assoc->del_work))
 				/* already deleting - release local reference */
 				nvmet_fc_tgt_a_put(assoc);
-			}
 			return;
 		}
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
