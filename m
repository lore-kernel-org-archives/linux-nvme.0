Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C0FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:56:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A72A6058D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A72A6058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LWTwNNfIkiTu12ECJeWJdXF4qZh6ZoxV8l1om/s+nCI=; b=RzX1GawH1qptnO
	preUaoEISzxlu1SpDRPCyvx8lp9Lp4KHv2+uQ76niHeXIJo0pbefTf0x2ekOErVZCbcrd7DtlvGMq
	7JvPw497ZsMVOxCxa6GiOkk2eQZNSllHJn9Mz+WeVqesb0XaaaaVhsrWK7GEhNELNlN+Syp/NAYuG
	/SzWLvbf5R+DqeUiedallD1x9nWT/LxKx8SdBXiIa6TkCJ1Ee1TZ7fBnqR+g/MpmaLaD5Qt4Ij9hI
	rJzOOhMZbKGxnLchUyXQZJQbpIk0bsOjgwTP67FsmRiU3cQpufCtYEtbmBIYMlw57v1bhScsScT1f
	DIzZTuMhateWrVkiEHzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPUdo-00Gxwv-4M; Sun, 12 Sep 2021 18:55:48 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPUdO-00Gxqa-G2
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 18:55:23 +0000
Received: by mail-wm1-x332.google.com with SMTP id
 r128-20020a1c4486000000b003065f0bc631so680476wma.0
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pCT0QorwpS7G+5MsAUIRUF3wCwS3K59GE+8Pf7OGEeg=;
 b=Pq/vKLuva0m0ODnPnYjtLx/3NR5WOAtqQJKm94uBqPKpZJ0x17myvuO6N+SvEW1g12
 reSS999gMj5aRN10w2T9egaxiBNy1Lp9yOYsTulc8x6BNPMQwaIvBltu1p7cpOqTS3BM
 B0GBI1KE8LL/0c2BlD4umzWQPBexk/Mmf7DClcFyGE2lQ4P8aRNDD+sGLbt+EH3HkOyJ
 uTVzvJbf+E0CtG+liILh1x9OIJ9JOLuO7iqfZWbyTYjfbTZsm+o388hgSNh396OqlWX9
 GjNMFqV6aTNFeLN9NHcUClyZDPl3+2wR6SrJVtxceqzJERYw8PeHTjI021waGHcXhfYq
 HXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pCT0QorwpS7G+5MsAUIRUF3wCwS3K59GE+8Pf7OGEeg=;
 b=OWp3UPK9AnxcqBKDMdVdzUfYJVQ9FXnL5rYlvmv5iB+jYJxXq7kP8JH+xqpAdIK1Uf
 8SD3L9pQfq1MX4wwVDhLBeEFkugjLc+fbToHHdD3ut0FkJd/weuphxd+Bd6a87ARVGmi
 6sKoaTtkmzWARqLt2oQGqHYRoowfIuj/ycbEltFZNLJM6kTzMzLPwhXDL274I1FI5JuR
 JH+szaBmo1JXJKS2TE1yWRcs5SJTRqeAG4HC6gdV643aulafjq3n3jITTSoIaStzUs+Q
 sGiHvoQH+0GKZOnkDxH1y5MO3Lxq2rZZ5pj53vMKyafFcBOxCtXUVNPYPVppbkP3IZSK
 Qxag==
X-Gm-Message-State: AOAM5327v3LXvQ+RplWTzNPKeM0/YXCBZyyq0fulVm1IcHuN9bxfPUYV
 b0PSkHv/e9QqfmuyVK9CbjN/evqUrLyiyA==
X-Google-Smtp-Source: ABdhPJzgCSxDmhIKEMrh5loXtI4OHzDFTOlE4qsycQ+I7+sER/B0wvP+K4rwx9CEaeQtONzpU+s4Nw==
X-Received: by 2002:a05:600c:281:: with SMTP id
 1mr7619775wmk.151.1631472920622; 
 Sun, 12 Sep 2021 11:55:20 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id s15sm5196974wrb.22.2021.09.12.11.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 11:55:20 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Date: Sun, 12 Sep 2021 12:54:58 -0600
Message-Id: <20210912185459.13496-3-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912185459.13496-1-anton@lightbitslabs.com>
References: <20210912185459.13496-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_115522_601567_2BD6CA1E 
X-CRM114-Status: GOOD (  12.47  )
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

Keep the nsid of the current namespace in a local variable.
Change the type to unsigned int to make checkpatch happy.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f78..a51561d67b93 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -600,16 +600,18 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid;
+		unsigned int nsid;
+		unsigned int ns_nsid = ns->head->ns_id;
+
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
-		if (ns->head->ns_id < nsid)
+		if (ns_nsid < nsid)
 			continue;
-		if (ns->head->ns_id == nsid)
+		if (ns_nsid == nsid)
 			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
-		if (ns->head->ns_id > nsid)
+		if (ns_nsid > nsid)
 			goto again;
 	}
 	up_read(&ctrl->namespaces_rwsem);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
