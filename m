Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA1DC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24723207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qn+FhDzl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r8gFSLjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24723207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RD2u9L0FoXcURiAtwqEGYFaxwHvRTkVEwHZ4FXc1cuw=; b=qn+FhDzlkFKMrQPuVmSGML7K6
	SYUa1+gKrE6TLZiokHv7lEPqcj78shHpBRFFua0pMDLv1CPY3zE0mJM5mlFXADOBCOqZ98eK1sqma
	6s9mDx3MN0VYZyUyTePofcwhNJWhezVKuot+xYrz2rrbPG7dmyR+zEBpNTjKqfnTyNZQB4NyHRCcO
	GQL0LpXdRSHcv856t+zmpxoew7vOj44UwOO+3hbhvkCEKMlGPTaLFEtpSd4RonsYmd8rigHXxAeQl
	QHLggH5yb7g8eBlUkDcmghLbdw1WAAgKLyMvZgNlDfMSAxMfDlN3bDa0bqwNgN1Ns2uubL7jHdlp3
	Tz1KN0B+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7DY-00057R-T2; Thu, 26 Nov 2020 02:41:09 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7DR-00055X-R3
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358461; x=1637894461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nbiHUyaUtN1lM/VRyvOM4VWz5z/jZqsgAj2Gp0q3iN4=;
 b=r8gFSLjpObTuHkKAEP0J0agB/iNIurK7HlqtCF4LY5tBGWVRlPKZLeyI
 pcC6z4NPu4sbLI/AveBjt7qwcE8/CvRUHP1Jc2+RF8hbJK5xw0i/CJgxI
 jU3T47XwRpBhqaPbxXIYetU1fN0E+JCTQG0IW3cbozNoP8DP9v3v6TuIT
 QQh+F7Ov2AFKiRLqwi/nR9yp7cWMxnWZrw56mgVeVvhuNZx4lUYLr3Rho
 0F03DR4sWOtB/5jxgOAMstz0ZxwUvEdTdMRabh5UVEe9ns0mzBNEn9aPI
 udRUPIJhUkNwd1wkZjsGc47gTarCZdJRngfeyyVrUHO7bQ34vwHYE+fZI Q==;
IronPort-SDR: dOznk2/3dAFDayFXMlMJCFh5yWdytPPXx4dMZb0P/0moJlrFuC/uo3te+3S+paFqKqC+j8vH5r
 OEhhfgJ/zw9xY/A5E8O+Pl726xClxODmLTl6+mAUU3jZLKWi6TO0IEqYNUEFPpUpXCsl0M5yfb
 u7AxwqxDx56tZCOggkIhMcD4EEOA7X43nbd1IkoFrEvhJfSqWPZ3qIDFp81QBAjkV3uoY5iB3P
 fQnQYvxUHwezdJ5wpgMS3w7uhQA0ZycODj9dht7HyGYcX+Q5fJALsK0sn/zSDsA0gpOGEMI+id
 gLc=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="263593202"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:01 +0800
IronPort-SDR: qETcwneF3EzLrcVL1g1ZIPCo1TyOsOHbUfsy0JyLofxid1COzO0guPVDtazphFPFwqgCKiD8KW
 iT3uIev22XrT2qzn5Vpz2vUyy60pNSfos=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:25:23 -0800
IronPort-SDR: ZyEMxOWvdD8XQuA7Y526ukWDP9tbl0QoTpA+aWhZCWlxv1AvF4tvB2OK9OVNecmJu91Cw24OXG
 FgeDloELiWEw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:01 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/9] block: export __bio_iov_append_get_pages()
Date: Wed, 25 Nov 2020 18:40:35 -0800
Message-Id: <20201126024043.3392-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214104_417419_A79B88B7 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In this prep patch we exoprt the __bio_iov_append_get_pages() so that
NVMeOF target can use the core logic of building Zone Append bios for
REQ_OP_ZONE_APPEND without repeating the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c         | 3 ++-
 include/linux/bio.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..de356fa28315 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1033,7 +1033,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
-static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
+int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
@@ -1079,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_advance(iter, size - left);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__bio_iov_append_get_pages);
 
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..47247c1b0b85 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -446,6 +446,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
