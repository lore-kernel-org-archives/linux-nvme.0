Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D58FC64E8A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DFF207FF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mfdiGnGu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M3ipGFI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DFF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RD2u9L0FoXcURiAtwqEGYFaxwHvRTkVEwHZ4FXc1cuw=; b=mfdiGnGuLJFrldM8jGs6flLpA
	K4DD7DYBWaBK2ERY/BJ/wQHHLL20JP/tis6P5Ykac/hGMZ1l1JETHJVP/dXIq5+bkvZyjGOFIw+Qp
	Z21VqqQXbgBETapS1BpjJKii7Mxk330q8gXJahKmuyEBqvF7sOiqocZM1N27IgNUZOo7qsctIaAI1
	2/EofP3VSBiBNNnENi6vg8g+yzIsUt7Kania6b7S091nF4au5Ur/ZDHmn0obNh6Y/3epYP+aP0eCl
	imGbBac70bSnPwHVhTc6NrVnRwlUnO2CVVMlSQrHTNljBTkFP1OVEAojEQB9yXaZrO3yEn6Dd8r9W
	ezJmq6jQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx3f-0008H2-GC; Tue, 01 Dec 2020 04:14:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx3c-0008GU-Vb
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796068; x=1638332068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nbiHUyaUtN1lM/VRyvOM4VWz5z/jZqsgAj2Gp0q3iN4=;
 b=M3ipGFI3i6RHu6Htk/Yq4hB/rFIEE8iaBmhKKW4QynakFi0Uo4w8fYzZ
 l0Vt5DdhH7hgPmRG9DZ0XMOSAD6kRIPAoYs0mMKJRaPe5EdySExpI008Q
 q1TTwznRpKPyDxPFxtjW3XE3nsMgcKU2gD9VELy8s7Pq8p5dhbAuNoe7V
 hfbyb3h+tvVWTR3nJsbn1WCY4k9PkdOTmGHt0Yh2lI4pNbhGpB+eajM3L
 6X2RpjGdqgn+MDlekXlQ6fJencyX3Eni32T03CV/oH2hwebldRe2lI6wO
 UcLF2PC0HYKC/vWXdjuTgSBa++rD6rh0oidxS5ZogQGRd3zCtXpP0dWLV A==;
IronPort-SDR: +hcasmy678be10I/vyDlBi5WxxG0oo86jHlwXbmSVLQ5QOOj7heSfYnteK3nhzmjqJde8vYU6G
 3ktbgwQ/k0J0A2naT9OfMwJDxaopz72lIZyWSqWFX/6NnsH86UvJIfqErrsJnLhu/9/ZJgUbQt
 c7cE3hfQuZ8fQ7e7GpPox3VYnm96lWnrY6vKdHgTq4efOQIYPr/DGG6T+8ecGL1fxPhvipW4RW
 OjSQ4q09N7m5bcGUmO5A7jIf9qTNeBcvV6y95xWZY7g13oPAzn4KIq3mKd0P4cNB4cozfbUBhh
 hAk=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="153814541"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:27 +0800
IronPort-SDR: f3E3f3NZuGx7CjIEE9G6yTzmqCUrXAxtmMMi/yKi1dNUYV6EM/nPnfuLGYb8VsH4zD3PrFPYx6
 Dnl7TvAPNw3SRcsN++BKYZ1OIwZLbS9t4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 19:58:40 -0800
IronPort-SDR: VgyZr1dQ9IL+lQ3EYcsF1xF7+2m6lLNNxK3KWDsAtNWYHmk1L6m/D3IuS2lpPizuVBeEj6m33O
 8nuMzvl3jPaA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:28 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/9] block: export __bio_iov_append_get_pages()
Date: Mon, 30 Nov 2020 20:14:08 -0800
Message-Id: <20201201041416.16293-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231429_148772_4A016688 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
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
