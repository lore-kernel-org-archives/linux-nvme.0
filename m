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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C778C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:40:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B823206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7ia/sfC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5/amErR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B823206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lmIYQjL12iwUyUQPITSAGCWvyzfpj17/cMlmnON23iU=; b=c7ia/sfCJOJfAUDU7U1HsW+Ezv
	aIIH9vdCK3WQTE+/bahT3JW6ZTbCJfwZ8DVFdpxSPn/s6sK8Cem+qpf1uPVWTZsUjJQhvc1MNYeof
	glMNXbDVkql8i2tTLLr1cBFz7pWUtcMaAY44vinE95m9wbqRITavQRFdtOYHfdba8S22a09a1d7Eo
	LbTwqrGFpZLBMo3CfwrUfRx1vjT9JTnSu5qbc807xSqqKON9fTRa3pEkkUZ2MCINpvHz77BhKM+LS
	/pfIXM321T+YCaEa/dtZ7KXIlGe/ihUWbMtlGf3slIAjxvU1llX5HpuPQScB/4CeCqKK0U+l/PEXx
	P4DpxjlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz0k4-0006jl-Hh; Fri, 24 Jul 2020 16:40:16 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz0k1-0006jM-QM
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 16:40:14 +0000
Received: by mail-pl1-x642.google.com with SMTP id x8so4744058plm.10
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tlJd9orHKq/rtrA1Xd6kXOERBk/VzMwk1ZpXRWFiVQA=;
 b=P5/amErRSQKFhd+dsX4Yf60R8vYBqAF2AeDvbM2yeevjdXfklgy/nJbyuGbamVE65I
 U7/jL2hT4Aauk40hgKvRX8zA4VSLkg3VKUgLL5BLK8Yw6BhMaTY/nFgU5w3S944FVQc6
 E8lR288eClbI4KE1xFvS2+gIu2zhjcEZJbGQYov53KdZJvnI8wEFsW45mrXN3u53AZ6d
 SD8MvZHg8LD2NLbPr0yYQVw2NRPI+7yJfGQm4TeloWazLuCyd1r01YUacOskQp2adu+w
 3E7qe9e1gagZo5tdd+v4gPemYYX80Uqu8/uI5Arcx1QgNRY7q58A3szjtjzbp/iqWrSt
 Dd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tlJd9orHKq/rtrA1Xd6kXOERBk/VzMwk1ZpXRWFiVQA=;
 b=X6qovSqBAA0PTJPMXoJNjovgBGOlsyGxpKeZjrFac8M86wNF+f8s3iK11LICsppjPN
 IxUb2GI/JoeblqqShmddDvC0cSzF9Jh49hnJ1zo7+q5wK3QvUQ2mLMjFr5wAMIxbiPqT
 PP+4igMZs0NmMZnMm0RRvGU6RqqKkuZBArwYa1i70HhOEPm8r37Ix1raB6edIjuqVgVV
 Tm8BBUZwmKWLyT3VEtyO0E2XBn8f3dCYuY4EEwaICmGcndo8t8kpMWpKVJL94Xclxwbs
 KUzd9GY/ffXCRUYCuEPeeEze+kIYcFpUpxF31P6hcUuNY+8nXe3de797C7+jf1q8+EGT
 RWlQ==
X-Gm-Message-State: AOAM530Rf1t6l68nI0S4tjNbFeQfwHWNS7SGl0LpOnNH4GHe5/2KNdq8
 qw9bq3U9sRXqyTAfG7TEVWqsdJFO
X-Google-Smtp-Source: ABdhPJyzcDPpbo7YFMwV5FUWeHXnmWiJ3q5kqKIjOTH4ahCtvoX0Q6daeaK2w2w+rGSsb4OHlj2gZg==
X-Received: by 2002:a17:90a:ee95:: with SMTP id
 i21mr6436915pjz.77.1595608809329; 
 Fri, 24 Jul 2020 09:40:09 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s10sm6555786pjl.41.2020.07.24.09.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:40:08 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-fc: check successful reference in
 nvmet_fc_find_target_assoc
Date: Fri, 24 Jul 2020 09:40:00 -0700
Message-Id: <20200724164000.49831-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_124013_872276_9D9FAF2B 
X-CRM114-Status: GOOD (  11.93  )
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

When searching for an association based on an association id, when there
is a match, the code takes a reference. However, it is not validating
that the reference taking was successful.

Check the status of the reference. If unsuccessful, the device is being
deleted and should be ignored.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 27fd3b5aa621..c15356b5e09f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1243,7 +1243,8 @@ nvmet_fc_find_target_assoc(struct nvmet_fc_tgtport *tgtport,
 	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
 			ret = assoc;
-			nvmet_fc_tgt_a_get(assoc);
+			if (!nvmet_fc_tgt_a_get(assoc))
+				ret = NULL;
 			break;
 		}
 	}
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
