Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD416C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2D220674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjI4CV0M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PksnS+y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2D220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vVm8UCuegt4131WY239AtlB2e8N395g8nMGEbxU4VY4=; b=jjI4CV0MDWVfegJ5UqFiVXn2Dq
	EOv3+6Kv8MqIw8fdDxipTsB9CyYbY31ET/YxpsnOT6tbT93GgaaxbgkrJ7koBGZRZAo9QL4ovulsR
	Eyo8Bc3qp6DKFXSwzWZs5sEp5KtsT+KZs+gNJRCVgJJ5RuOwyGB84+jXMtca8ydgjdKWbLFXxdVxA
	I0KDWhXxiaQTrck761sWF/XuMpIREplJK4j/DmOnver6ueN+bRrxvx76kc00XjCEfbkFVe8JLMSUR
	L99b5aJQD3gghkKcXgoreY1ZFmK2SBCvVV8rEu6t3TZQ975Hd/eQtl8H3flFaHB+00LD02z4M61LT
	s2PDTGzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPZO-0003w5-7N; Wed, 05 Feb 2020 18:38:38 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPYs-0003Qj-TE
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:08 +0000
Received: by mail-wm1-x341.google.com with SMTP id c84so4066770wme.4
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pUXc5biqCZa5RdtqOilNBVgTNiaHjlJpDM+0vu761yw=;
 b=PksnS+y3jztzM07REtWtQQN1aSMuje0qhK7cM8byC/p+qct4ARaxONAVRDJPYwwQpP
 DDCsq5PbPFoSqV6FexszOh3H2s5sRduYDX3em3qkhF0FgIJvtPxfR7cw2Q+iJV+PnNnj
 o0gmPBdqAaNMaw5k298q6jbZhI2m7pI85XqUthjrSuOcDb64PupSQUupscBl9U+b/HA7
 qByazqiBnxML39wXRk6zS2u/6q0FGgD8DPlWcfu5KlT95FnQ7MkkLoxWcwwmnLKxWgL0
 bIcNMiFT113rJZaefRWyK3gM1GkCf5s9qVRzWe0TSxAQmpg5A25E6o9SxR77pcAp3LrS
 baew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pUXc5biqCZa5RdtqOilNBVgTNiaHjlJpDM+0vu761yw=;
 b=JprfZld2ezOEbxAlTTxpbBX0ECbqBOcNc2mtSnKf0S+FIWYng5a5zrpqqVCFm5wfKL
 +zVbLWWasD4S00VH7TXpb1vg3oxYDPjouDw+7S91AYXMsfWivzVeMre1/WSnTJlrjjjW
 H5Y2vwLKSCkwIPCSuYSWaTeODorvcmQlOHLSFqUNz+pPkHjaroJ/Tqxx6aNIDOsI2Yx3
 JgrZu6VMedYcwXiK3O0O5jEF+mJ60c7ugjwQFaCO3IKbC7ZQaytajqE0xofIcJ+jnYo9
 LkScFFeFredVAxHci1e439S9e3JoNOZHL1nXfuNsFMmx11Ssr+hU0bR2nl4RXmUi6u4s
 unDA==
X-Gm-Message-State: APjAAAV9G/0MQVUxDulKJl4C/U0zIGddoJR3xecboI8n/RlyhiN2XRCo
 gb1abu3iiESRm4LJ7zNpJRch1Fvd
X-Google-Smtp-Source: APXvYqxz4PudSgF7masuZASR/lFEFkABHI4cRBQlpJf6zj3CKLqzwLCSSVrmxONeHMPShGwHSiYKmQ==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr7022188wmi.75.1580927885281;
 Wed, 05 Feb 2020 10:38:05 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:04 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 02/29] nvmet-fc: fix typo in comment
Date: Wed,  5 Feb 2020 10:37:26 -0800
Message-Id: <20200205183753.25959-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103806_938023_48BF3CED 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix typo in comment: about should be abort

Signed-off-by: James Smart <jsmart2021@gmail.com>
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
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
