Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330FFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E9523A50
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E9523A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qiftmXgZrebEw7UXA6OyNc8B31oPdcOL1/LUnxNoH7A=; b=n63Bf50Pl3KOT0ftc5isVGZEBa
	7VUTB1gXbXJrI5nEzsDtz783FHYxD/Chh56GyIFnGpK09kbs/bKsUPCcEOkYAxBlV/oRpZD25l7LU
	F0TyL9arR9+XeOVw/B8jKJzaztvyZbzwpj7sqjOpDEkbODzfkPMaNRlI2c1E2dr1zxw3aNesnaB4m
	LojQ77F8M2bdLgodxrYcl8vl4Oo2AbMdE1iK2OMpodnE/digHBTUEp/faTjBsG7DhGBhCnwWQC8TT
	1MyJBCpwAO1lbKh7KA8Q+4COvnjxEm0SnDojtNtfCfhxErbgUEo5XS2Z5U7P7FhoEvYnnlSWpJrV0
	aL92W15g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09y2-0004SO-Oi; Thu, 14 Jan 2021 21:15:42 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09xu-0004Pp-RG
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:15:36 +0000
Received: by mail-pg1-f170.google.com with SMTP id n7so4643800pgg.2
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KILY6Mil49MoiUbqZMacpwkiuFjhmGUZBNMyXCrpv4c=;
 b=hjSMYfJ7ySP8cGe54jNM2xKAIXmj2CFSvhLhF5/y3aQQMeLnZWwJgv4V5cV7uAyC4V
 88g4Lfz7w7AtSkbdFj5qDzcyI7uCOmVKGZVCrouVDGUrf8vfmweHBtmzMjjceyC90OBX
 Cgt+LY00FY3sv4orsY4eC3OHR4k4UgdQYnOFK8ZZJYDDHQqLOYxWp5X8S50d5eeNke50
 HxATUvdB3wCPq2Tg2Q1t4xZFgkKxsan/lMbnHC2S2BGdYzfiOvbVoaKuOkKjbZ7/UULS
 7McdQ4hU6iajtdGbOi5ZLKOkd7NjrqXcgAd+Pa7JcXeW7rvxGt0WxJN1NtJX6JTNmPql
 v9sg==
X-Gm-Message-State: AOAM533/dO+uaZVEAcwf50b0U2LghoWPReX+nKNbxHo/rzK+ALi7+eR+
 SL4nN0WHYCFk7fRhlo4BD5Re7dSBqlQ=
X-Google-Smtp-Source: ABdhPJxrDCfM8lKGJZ1etnKG6IdIbBAO9Dgy3jU6Laws48SnB6N3xH9TSFS171XsQrlf+K3RoAhCkQ==
X-Received: by 2002:a62:c1c4:0:b029:1a7:efe9:163c with SMTP id
 i187-20020a62c1c40000b02901a7efe9163cmr9071408pfg.47.1610658933712; 
 Thu, 14 Jan 2021 13:15:33 -0800 (PST)
Received: from sagi-Latitude-7490.attlocal.net
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id s24sm5901165pfh.47.2021.01.14.13.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 13:15:33 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme-tcp: pass multipage bvec to request iov_iter
Date: Thu, 14 Jan 2021 13:15:26 -0800
Message-Id: <20210114211526.86946-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114211526.86946-1-sagi@grimberg.me>
References: <20210114211526.86946-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161535_026304_0C24EADF 
X-CRM114-Status: GOOD (  15.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

iov_iter uses the right helpers so we should be able
to pass in a multipage bvec. Right now the iov_iter is
initialized with more segments that it needs which doesn't
fail because the iov_iter is capped by byte count, but it
is better to use a full multipage bvec iter.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0a738ba34aca..4f8936751aa3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -223,24 +223,29 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 	struct request *rq = blk_mq_rq_from_pdu(req);
 	struct bio_vec *vec;
 	unsigned int size;
-	int nsegs;
+	int nr_bvec;
 	size_t offset;
 
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		vec = &rq->special_vec;
-		nsegs = 1;
+		nr_bvec = 1;
 		size = blk_rq_payload_bytes(rq);
 		offset = 0;
 	} else {
 		struct bio *bio = req->curr_bio;
+		struct bvec_iter bi;
+		struct bio_vec bv;
 
 		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		nsegs = bio_segments(bio);
+		nr_bvec = 0;
+		bio_for_each_bvec(bv, bio, bi) {
+			nr_bvec++;
+		}
 		size = bio->bi_iter.bi_size;
 		offset = bio->bi_iter.bi_bvec_done;
 	}
 
-	iov_iter_bvec(&req->iter, dir, vec, nsegs, size);
+	iov_iter_bvec(&req->iter, dir, vec, nr_bvec, size);
 	req->iter.iov_offset = offset;
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
