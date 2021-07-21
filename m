Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC5CC07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 08:06:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD246100C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 08:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD246100C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ltFFcn/kTTmfJ44MuANksWmeZVyIr3uvFiJmlGlLbG8=; b=pF6Sa/WaBksh+E
	lUIgZsGaiPUVJjBc1J/lq1xDgBUZOatyue26WmGfUL1UfJeCourLvT7T+aZpJioIpEE7x4sIDljWP
	tB+6lK/AbWRgauK4EtPbTSsmxIaD3MNaNSTxmSHGePJVWL6VJXGD95j1WJuQ6senMRaeizC/lnCWH
	X1nkqwI2lZ7sR3jnTjL0ZCa9kQevquomzeVbyppmC/RN+hpI78sJjwl8zUjyUd6K8OPOuIt1SDetB
	g6Vn0uUG3+cbzUc7zgBRpv1y4XPwDwnOamK/BiwKIsu7Zj3BiCHi6wSdjoWRTQp7FFYtldte5GiXb
	FIQYYzLJUVkMbRUUYfMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m67F3-00EpEv-Sf; Wed, 21 Jul 2021 08:06:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m67F2-00EpEn-JT
 for linux-nvme@bombadil.infradead.org; Wed, 21 Jul 2021 08:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=irq1b6yLqXEae7dF/A+aC0D+uKqb9GhmfYC08R+EVrk=; b=FfTwd6A9MYzqXIFgNc58zdOyWO
 ZNEyKnX9gG+RmNNR8ZXVaa1PL6ZsnHdhDsx6fXFzeEhoE8FHoMW5WmE9Z84eYZJgbfh5J1OZ35g4k
 05hozYWCV6gb/dpIAd2ubkMovp8HQOVHJempzlmxbrIfUWQQM1546xTZ6tDAfk+uFpRsQNXCv5RcY
 O6ebYY/MaFrn/QTk7O3N/w3CdPgeTk1kV4+4o1D8GSEJ6WUUx3Imlhl9iDqNUPowZ8bsQLhEIdb/5
 GSJQERNT9IWRKfi9ioD//q8a7RZwrbK3hLFk5tfKE0YzPitka3ZHRVwl991x38uW+MYXtcIjAy+Mo
 rpzZKDOQ==;
Received: from [2001:4bb8:193:7660:6708:80fd:7e56:3302] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m67Es-008xg0-6z; Wed, 21 Jul 2021 08:06:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: martin.petersen@oracle.com,
	keith.busch@wdc.com,
	sagi@grimberg.me
Subject: [PATCH] nvme: set the PRACT bit when using Write Zeroes with T10 PI
Date: Wed, 21 Jul 2021 10:05:56 +0200
Message-Id: <20210721080556.600892-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

When using Write Zeroes on a namespace that has protection
information enabled they behavior without the PRACT bit
counter-intuitive and will generally lead to validation failures
when reading the written blocks.  Fix this by always setting the
PRACT bit that generates matching PI data on the fly.

Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d64b406c1a42..2f0cbaba12ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -900,7 +900,10 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	cmnd->write_zeroes.control = 0;
+	if (nvme_ns_has_pi(ns))
+		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
+	else
+		cmnd->write_zeroes.control = 0;
 	return BLK_STS_OK;
 }
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
