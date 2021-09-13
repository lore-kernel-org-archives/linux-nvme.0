Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2270AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E407D610D2
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E407D610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V3UIqYemly9U9NVaMbLqgouzAhYZh7eO1P0HUczOPXo=; b=GQX/eSIG6DpigN
	PEhMXEgx5RMME2Emn1RCTAo4M983lu9zNubHOnStRU6tkFMfOI1hlWFVkb1fAClt5gqKBF5PEBxye
	HYjfqremmrPPXv9T5FIt07eN6V56Mh0pPb87syZX4Go90ujBO3xH86toDQ7NsZPh9LXs7S+Brhbym
	umJF5hHSdb968RJRvHYi7hwH85hFRkn974P3ip6C3RJwg1+fpULUVCBp5KFvhgCEU/YZNc+GvVFER
	3f5XXGTFKLJ9ERe8Bzte1D/EPypINwgpJ5QN3RmNqA0WtuRXY/Ld5DA3dNCzIk4pIpAH+/HaBTiZN
	MEGENWVZC1o0KfiQElSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPtnD-003MCN-L2; Mon, 13 Sep 2021 21:47:11 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPtmu-003M9r-Kj
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 21:46:53 +0000
Received: by mail-wr1-x42b.google.com with SMTP id t8so11813352wrq.4
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXdSp+29CI3O9XE2sPjue9b2FpAu50E07xzq/lOm8vg=;
 b=bdKFM5nsiQoYshudOPS7ILuJQml+iNkJ2yOXtePXOiRdyCKY7m53oXYq4xm6gf3gC4
 q97Iq7lJpGrJWey68CFDo5mHvK2k+ruS4R6nORJdPNFbzP80eOOna+Tnmhrdi74lislq
 VyR7H9j7m1tvzln2kApTwcLB1vPu8Pi6p9H42q7IVdmmLdYjxCEexe2muDAM8W0OOwrJ
 eotuRa4rF8aYVX2MgWsJYoE2EmvQ9EV0PhrDEuSdKQMN7EZJYp2dpIJ1VEYSeJHONWns
 j1tslLkoBOdwWM4nTOYvcEbym6rYXX/qmXXi+eKUeEcsAQ/Emi3MTbAgGF1qGd9MfRqu
 c8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aXdSp+29CI3O9XE2sPjue9b2FpAu50E07xzq/lOm8vg=;
 b=ag0pqob06WtM+dBan/8cwBS9pF+2HVxpr8oLHCVRficdNVO4qZOi7uiFDmKR+uvbkk
 R4qPJ+c2oijqVRBEorK5NGgISgEFpMu1MjxDHF0jWvwQqjoI9HucF0Y9zL/yhOINMWTd
 oPm8yodeHaWkhEprPS/7Az6F1dLJ/Kmp9jo9QiGK5y2obEYlsvwwRrmPIj01k03vUARB
 ApoKXoWSy0sLDPoh2qQjLR8lKVzfvDys3EJ/l0RhyKrS0cMfGhTmdlCUCouaZeBy6G63
 Il1rp7NKU7ZjxUNNbpXcW6FHwjysue/itUnxvMNwRmMojz2+5ZeVRBFVLpSmFUbD16zA
 +Zbg==
X-Gm-Message-State: AOAM532/3WG3JWNm5XJ0oaTUKa+e5rLXpZqL6F+XlVnj7to94DU7hogU
 LWcqkPJqgIMk+GM0iOq8TdzYbphQHjHKfQ==
X-Google-Smtp-Source: ABdhPJwJLU4LR21TctcmcPr/IS/ag2Qsom2iwgrav6bSgFAwhXCLeaS79FEFcgYFILWFe5pFl0fS9w==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr8577781wrw.228.1631569610910; 
 Mon, 13 Sep 2021 14:46:50 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id f7sm7776194wmh.20.2021.09.13.14.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 14:46:50 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Date: Mon, 13 Sep 2021 15:46:31 -0600
Message-Id: <20210913214632.88294-3-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913214632.88294-1-anton@lightbitslabs.com>
References: <20210913154229.71757-1-anton@lightbitslabs.com>
 <20210913214632.88294-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_144652_726110_59FACB10 
X-CRM114-Status: GOOD (  11.99  )
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

Keep the nsid of the current namespace in a local variable,
in order to avoid multiple occurrances of "ns->head->ns_id".

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f78..e1ce80c12815 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -601,15 +601,17 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		unsigned nsid;
+		unsigned ns_nsid = ns->head->ns_id;
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
