Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B8C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08ED20658
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hxBr/hQg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kHYpW7FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08ED20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IlyoGSu1N18vEvTwdPn3Ml2pliuiv1rpvdrn1pDQFzg=; b=hxBr/hQgl0boTHOqpxTmYu9ic
	4obMZawlkaqd2dEb3dIimAQx5ATCs+P5hRpmJI1FGHxenjN0qSpMdrrNVMN0NSJ5+KqqM1m6B9xN4
	qJ+tm2MiNQbESyfpVTpvlt5RFJOfcfSmlsjf2KRdVEK36cfL5e/yZZEy9ZeAQ6IU7F1HHeHozXR6Y
	LQLHE4nWuqUiiPIGuFTI6ZRklk7wUcTfY1szvw6FquF9vdkUUb/yXAWOPzJdRgDXZApb9XJzyiQjT
	9rpbcUOtV30K8P/NZKLuZdIFc07C7iA78yM09lRqt+64xRrmmuQeJl9HLSgzw4fN5bvfxmNdpA5CL
	X6yRAovzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vmx-0001Dj-Qf; Tue, 18 Aug 2020 07:12:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmb-00014Q-2b
 for linux-nvme@merlin.infradead.org; Tue, 18 Aug 2020 07:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MifmZSPpFLXD0MTunSfN1TuIaNrf5GOpRSEmtCogPo0=; b=kHYpW7FZklGPzbOQPafUFEEH/7
 1Vaci71LGtDgrdw+o9cSoQzIWpDtJopjXKzYS3+vdADlJhbfdLwMPX5wG87OheoOdlXq9Yi5zeqr9
 GbhyhFPrSERLxoelMP95uBIEmACBxLG8tHwdJckPyFar+hbTawdsqEl3M9kg8pYNh2VehTurwI9ap
 0yRzmItg58mof5cm4TSan0aiw86I+0qzBYozWWuTnb1Cm9q4dWmEpdOXc9bH0sqmjsq1L4WSeP/YG
 kb2u4QwYeu9S8RqoxlZprNJEVGdlCmWk8vjL62Csqv89eaShP+72mdfxA2Fblz8DbZevaj4RVzqSo
 U0OCaqKQ==;
Received: from [2001:4bb8:198:f3b2:a8c9:886a:f150:c8c6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmZ-0005Z3-II; Tue, 18 Aug 2020 07:11:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
Date: Tue, 18 Aug 2020 09:11:31 +0200
Message-Id: <20200818071132.1136033-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818071132.1136033-1-hch@lst.de>
References: <20200818071132.1136033-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Check the SCT sub-field for a path related status instead of enumerating
invididual status code.  As of NVMe 1.4 this adds "Internal Path Error"
and "Controller Pathing Error" to the list, but it also future proofs for
additional status codes added to the category.

Suggested-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/nvme.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4ff6fd2890821d..e9cf29449dd17f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -537,16 +537,8 @@ static inline bool nvme_is_ana_error(u16 status)
 
 static inline bool nvme_is_path_error(u16 status)
 {
-	switch (status & 0x7ff) {
-	case NVME_SC_HOST_PATH_ERROR:
-	case NVME_SC_HOST_ABORTED_CMD:
-	case NVME_SC_ANA_TRANSITION:
-	case NVME_SC_ANA_INACCESSIBLE:
-	case NVME_SC_ANA_PERSISTENT_LOSS:
-		return true;
-	default:
-		return false;
-	}
+	/* check for a status code type of 'path related status' */
+	return (status & 0x700) == 0x300;
 }
 
 /*
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
