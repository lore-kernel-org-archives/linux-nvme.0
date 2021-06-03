Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67948C47083
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 00:38:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38002613E6
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 00:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38002613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pl6S/b+e78W2a/joKEcMrH6GbNF6Y25B38GMCSOH5kQ=; b=WzCJY+4creofk3
	9l+rxYT2xpjLdn4+uKy+9nhkkqjBrwGkKdqpvngCDZVICAKdp+8N6KefmWcIr+Y9CsyLbP2xm04/J
	bm/sQOhusZwN3vHZHppJCOdrrV/q+0dctawbMxdFjqExMSAycy19O63wX0cA6bSAMMXnsVitDi5af
	0QFwlKudQfUonC7AGSmGt+qPYR5tySfcme/89FezTU9wpL2LDYTQblWen0mL1Ak7R/OjJ9BVjc1+C
	sCyzSL9+NS7O4n5dZEBtRLwbQsRXgB8oIqKPsuTCn8sePKu0kc38yxy2o+zq4kfEKaUQxg8DBQI0A
	I6Jwa9jFMiVEGmNGaMlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lobNB-006dlI-2m; Thu, 03 Jun 2021 00:38:09 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lobN8-006dkM-IF
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 00:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622680684; x=1654216684;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I92qCslpObzPJacN3oCjGjNbYDsJVusM5W7fi5/J9/c=;
 b=dv6qme6A88CWlHuHue7CGsUKE+mWKY2FSXCjqBpGg/aewkej8sB/HI8D
 7y3Q5BKJgFEpl9K0LdUrFa7udzKL3HAtZwRErp78HNCtt1tQYkl3xdpi7
 OIT9gakFaN9EK5Ggp23tP4ZD1mBQVxDMgrRVnrb8DVwpm31vPRNQpMHYu
 abOm/8FwfimDDLu85Az14rEfWNhnvxclla+b2ltHMCKg98eUPIyYkjD2X
 84qAKmvlNa0MIXeBYEHFeC6EembfJk/mQG1jN9Z09fkt5jf2VABfWGZ6k
 4ww10o5E61z/jWDQK+8BPV6gMZt5egUnolG6Qe9v9eMEvkQGoSnjJCyF8 w==;
IronPort-SDR: o8J2Egpx33aTBH08xnLi65/pTyyo/TJvtX/ipnWKOrxtKdNRMiQiqc5DH7B6pRuVWx/X8cXEtm
 WW5fiJtCiOA06mC5JGQPqRZwbonoMwHOoq11BJ8FBW7zUybIBydZbYrPdNKtbj4nOcvgQgKs6Z
 DpHzd7j8RuHRnRn6UI6m+Tdxyn0kCl5U7WJWbWTEMJgj71Bjjy7QI1uYD6umasNq55b+lvTzlO
 wF4426UOwZcfJRQa0SuF0fXiANNcxZyUACG4ygicZ9Rrdu+kGUlFZKj8dRFGIYFpyxEjje2bZu
 dQY=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; d="scan'208";a="175229232"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 08:38:03 +0800
IronPort-SDR: ad3m7QtHKygsyqsgkCPpILJin4hvyS17lp1ODzbf78g39N5BmAAiFtKRurLpLZ4slUp1h/Z0hT
 WohwTw9LO6p+iVRJxQw0XQLQJSoeeqDLRHVu5nhnvnjbiBM9t2fKOQTuEFPKuInlz4nRDUU2sO
 NHzgoq5ndySaLXsmrWX++vfHm/Y/rsFg3nCHnk3AcNZoRVi9fXCp4G/t/eUlPdMylY6+hFwOjn
 rvSe7DczWCZVJuZ73VnkK4hjGFGZuWH/k1w7dWX8z0hPPRlv+FyY4Zbzn0DQzKQwAc+C8mgETE
 shTCvLpVDsLfhp/oKphob6o/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:17:19 -0700
IronPort-SDR: uPm0aPtwSXI07p76vB5q/1Ba/Fw4JYWjazK/5Gr6HUuu5ecHBHdb4PW8nIOCx69WeQ4LYnSdst
 /rYKAbJc9V+4iLvAcyCJuqr5ASGlir8AbqHXl3qlndym6N2XKSjACfk6s89wiGgKVEqL6l7LLB
 CMOfAlK6+EFtfenl4p68GGfva2smVph1xL5zth0DHHzpyUtfn+aceWEld2cT3TEO4RhSaaIoN4
 Pi+18kV3XFhz75qNPw/CyvgOax6t11XfanVpbbDHCvwnc0+TE3uBB6Dd20+4FcfOIcmhEP9Hyf
 6/s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 02 Jun 2021 17:38:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com, israelr@nvidia.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvmet: remove extra variable
Date: Wed,  2 Jun 2021 17:37:58 -0700
Message-Id: <20210603003758.21134-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_173806_634173_1CA2F2A6 
X-CRM114-Status: GOOD (  12.50  )
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

Remove extra variable bdev that is only used once in the
nvmet_bdev_alloc_bip() and use req->ns->bdev that is used everywhere
in the code to access the nvmet request's bdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 429263ca9b97..f673679d258a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -174,11 +174,10 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 {
 	struct blk_integrity *bi;
 	struct bio_integrity_payload *bip;
-	struct block_device *bdev = req->ns->bdev;
 	int rc;
 	size_t resid, len;
 
-	bi = bdev_get_integrity(bdev);
+	bi = bdev_get_integrity(req->ns->bdev);
 	if (unlikely(!bi)) {
 		pr_err("Unable to locate bio_integrity\n");
 		return -ENODEV;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
