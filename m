Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E54C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:08:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14876113E
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D14876113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWOqz807EFB4rjQVap9r1zwstZSwMDomp1Eek1/UoU8=; b=G/1L5aXzpitsJm
	ouTIlrqycv1NLXyFh+GrtEQmiwDqQAKBBH/CzuF5ni/9sxliL3gXDsGLgY/kJ43T0gMFx0+8zpjFV
	53QxVYOyqqpEg6Ym2aoETx1fRcS54MFA0TOaectSDMjxH66/i26I0BDRztyrr3h6Or7cYb69IDpGM
	2OsLksOrW65xr3kZyJWG0VzxzBHRIvaPbkc7cNhKK6RlLDavu2tfulB24wr33212riTmFmMT2FHwi
	Rsen3v7ufVOjvuFA8tTev77zs+K9WURH/SMZhRQ+1r5wcsO1GM3MlTYeYxJQS1O4Izm8qKIcBowPv
	UW84eYTSZkImY4UkoySA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPDz0-00FejD-7i; Sun, 12 Sep 2021 01:08:34 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPDyx-00FeiX-BL
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 01:08:32 +0000
Received: by mail-wr1-x429.google.com with SMTP id t8so3558321wrq.4
 for <linux-nvme@lists.infradead.org>; Sat, 11 Sep 2021 18:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=Nhf4wRuoLHXBZ8hVdtuKSqlpp1K00dc9VEZ8LS1Xq7o=;
 b=VEHMVrgV7YiWRne3mZlIR59LQqX4RSlLcDK06yUru9Iheqv+17hjeD5buVp+Ub3RiW
 W01VgEsY8n19whueqyClMPJE4dGJkgSoKROkkxYkSTP1xQAPv70XuI5dMvCQr+dOOn8G
 avSNyCDU8ZcKquXbhgiTBKOQgybkbKUpTN8n9N+AWRToY8sTciwp36Cnuo5YJB6vyzbk
 meZ3TfswR4gZ+KjC8/UvhiNNmlosbkcHyo+5hkstobBGzaZ7i1ij3jNmcY9whbldFUCd
 ntBybtcx9mV9TM2GiPBoVRutjWCxcfU6/O26cZlo0lWuzN1FYdnqh3oXnN/zEKAOCoUD
 JB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=Nhf4wRuoLHXBZ8hVdtuKSqlpp1K00dc9VEZ8LS1Xq7o=;
 b=oSOJu2P/LzR6SSkIZRBPKUi2UxgCd7V5DbaYR8IwRFw6W4fHIr3YcHsvdOFNhjq0Mk
 uW1JxlR2d6XV3N0IXrHIAb+pDHnzDbcDzEtY6tOQ8cnNFBUy1se6GKOFXk9vAwwutmCX
 ETO/cHBhZ3bRBwjrQznFGQ2BrUfEb96mIhC2arf5yOd4Lx35hqBNEpB0j9f6K1Doum2W
 TqCE9frW8QN6TSCNLcODGHUCDoXnaF3rT7W0epXsBAQ2Pc1LTJqUF/2cL41V/HY2h4KU
 3vxqmLxlChAWjAe/I5j7rP25jVyD3OmV51ENrTMM6WgWK9ivy0w4gdaKiiFz5lDOBioY
 FBpw==
X-Gm-Message-State: AOAM530LTKaA5ecGX59ZNx7HC1PKkgT6xOqmla/KJ/SPYt+8xOuQseUX
 cYUF5XvJskLX/38ilkjFMFRRAhk2b/5lh7Qjv6tyo0UEbR7G58EPyIob00YMg7yfc48/aMAt9vu
 TxE2oAdjS/ItmdISya4Td90fVnXIv
X-Google-Smtp-Source: ABdhPJznz/IHdthSIo1+FhQdS6pINP0t04IukMC8Tofc6ysqY3p5IehFDWy3BPJOs3/0Tw8VgM96DQ==
X-Received: by 2002:a5d:6ca2:: with SMTP id a2mr5131264wra.291.1631408909641; 
 Sat, 11 Sep 2021 18:08:29 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h18sm3128922wrb.33.2021.09.11.18.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 18:08:29 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 1/3] nvme/multipath: fix failure to update ns ana state
Date: Sat, 11 Sep 2021 19:07:29 -0600
Message-Id: <20210912010731.471859-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912010731.471859-1-anton@lightbitslabs.com>
References: <20210912010731.471859-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210911_180831_435335_D882D533 
X-CRM114-Status: GOOD (  12.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_update_ana_state() has a deficiency that results
in failure to update the ana state for a namespace
in the following case:
nsid's in ctrl->namespaces: 1, 3, 4
nsid's in desc->nsids: 1, 2, 3, 4

Loop iteration 0:
    ns index = 0, n = 0, ns->head->ns_id = 1, nsid = 1, MATCH.
Loop iteration 1:
    ns index = 1, n = 1, ns->head->ns_id = 3, nsid = 2, NO MATCH.
Loop iteration 2:
    ns index = 2, n = 2, ns->head->ns_id = 4, nsid = 4, MATCH.

Result: missed nsid=3 and did not update its ana state.

Solution: when ns->head->ns_id is higher than nsid,
increment n and RETRY with the SAME ns.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5d7bc58a27bd..e8ccdd398f78 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -600,14 +600,17 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid = le32_to_cpu(desc->nsids[n]);
-
+		unsigned nsid;
+again:
+		nsid = le32_to_cpu(desc->nsids[n]);
 		if (ns->head->ns_id < nsid)
 			continue;
 		if (ns->head->ns_id == nsid)
 			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
+		if (ns->head->ns_id > nsid)
+			goto again;
 	}
 	up_read(&ctrl->namespaces_rwsem);
 	return 0;
-- 
2.25.1


-- 


*Lightbits Labs**
*Lead the cloud-native data center
transformation by 
delivering *scalable *and *efficient *software
defined storage that is 
*easy *to consume.



*This message is sent in confidence for the addressee 
only.  It
may contain legally privileged information. The contents are not 
to be
disclosed to anyone other than the addressee. Unauthorized recipients 
are
requested to preserve this confidentiality, advise the sender 
immediately of
any error in transmission and delete the email from their 
systems.*


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
