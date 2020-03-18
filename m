Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F7C4332D
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 21:41:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E158620714
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 21:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hXX6+fVs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir1Oui+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E158620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=w3XuqdoRjhxyOACCZgoIqm5AuNVdQy8eG9aFVtIulCg=; b=hXX
	6+fVsQHnhjbJoYQbjkEXn0xDJ5xRxVpJn8gSWKz7Z6r2MJVxtgmxjnbIgRcJb8XAwWVJE601J1yu3
	gt9OBFw8j+Q2rKRE8KIaa35KQVMiRvdzEOpdAaFCaKyfGkfVu4OU6wpq4qf6taYgi63l9etID0N9x
	GhWz7KHIEfrL6ADNKsE7BehtSnpJYyTp6WA5yHPujOaK84yqgCX7mlIRb11ebykt3K789dwFPpeQl
	oRv6pLUxwgX0KK9uMNIBy2rUsyHacEErwixUHSDDAPIPkAgdprsHGhN0ox14mRfkwlLs3sXzX56oP
	fQHgTRai1ktSnkNJnOg388sS82OtX+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEgQs-0002NB-Sj; Wed, 18 Mar 2020 21:40:58 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEgQp-0002M9-S8
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 21:40:57 +0000
Received: by mail-wm1-x341.google.com with SMTP id d1so3551984wmb.2
 for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2020 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=1lUdwkTHGbkpT/JLChlC5RG6RvWARF+Xzpm6/g2rbmk=;
 b=ir1Oui+BUYyMtCLJ744QN/aTNAxuXuda29DZIEuEp/bde1evlZBtwMfogLbulJZ82P
 oWGV0rb8SIvP/+DpH0FMVCiPJJ+17yZwY+IweTu4yXMZyZ9UcsrWvArpxOqKTOVEGjCV
 wXvrkuwtlX20KQNbvdEiITUSzbKn54n0kdEiGABxPKXwJrsh/hKfK+oQZvczZ7rQSMjK
 4e/S0hR1ZMx/TxpzmvGxN/Yi/hLOiqx3feZLsLngG9duEOdUjxnApuBX9w7H9Lm7K7rr
 bNt3Oc4ne5b2cPgaMx0Oh3/kQ5hAbhABcFPGrJuIRRE1Dy1qhaYFbRW20+3GZRgr2NLH
 2hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1lUdwkTHGbkpT/JLChlC5RG6RvWARF+Xzpm6/g2rbmk=;
 b=Dc8jDPdXXdFcE6F36xfU5TRHrFNEJ24LawomxfP49408BWCAJi39+872SrY4yesD9n
 BFq+r6Ko8yW/72FZlqIldOYb7Is2IfBBGklx7/tqVYxlVgfbmhZM1vbwfskfo7lCmt2v
 6ym+GvAyUyW0OWURgiM/p/y6n8CNa9lyVEJ0e6PMjX7r//ZW6NHYXpsjP2yLr7GzSOlc
 c5Hr87lCtmoulCQvNWZsV/NBiyxfDgCBbmgTEYoN5QtGM+g/+NUAURWNypZ89A6PTpB4
 1io7tJIa87zjdJE5kyriLCDF01V0l1J4swADAFrJ/gr1yK1diflu/W3OZXIHfVci6Q94
 qgJA==
X-Gm-Message-State: ANhLgQ0BX88ziJLkOKwmEiN+JhSAaW31hDDo9DSyYKDY/7bpuPzE1bv1
 TakeIaZ0ZSQyel7bRUxO5ADpacLN
X-Google-Smtp-Source: ADFU+vsLbZVVf8i25jR+w+BI+OMZD1jaxhEatktsEt+fuODZtuPRfH5Ytny+l/fScRPK0UgwiCPc7w==
X-Received: by 2002:a1c:4342:: with SMTP id q63mr4177249wma.137.1584567652355; 
 Wed, 18 Mar 2020 14:40:52 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id q13sm161235wrs.91.2020.03.18.14.40.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2020 14:40:51 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-fc: fix typo in comment
Date: Wed, 18 Mar 2020 14:40:43 -0700
Message-Id: <20200318214043.18211-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_144055_934876_B2AAE56F 
X-CRM114-Status: GOOD (  11.78  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix typo in comment: about should be abort

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a0db6371b43e..a8ceb7721640 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -684,7 +684,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	disconnect = atomic_xchg(&queue->connected, 0);
 
 	spin_lock_irqsave(&queue->qlock, flags);
-	/* about outstanding io's */
+	/* abort outstanding io's */
 	for (i = 0; i < queue->sqsize; fod++, i++) {
 		if (fod->active) {
 			spin_lock(&fod->flock);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
