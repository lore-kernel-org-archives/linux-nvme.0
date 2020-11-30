Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D5C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE575206DF
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5mK7S7q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ol6/JzZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE575206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RD2u9L0FoXcURiAtwqEGYFaxwHvRTkVEwHZ4FXc1cuw=; b=r5mK7S7qef4QOgj48ZvVyA+WN
	4mwE7LVGn8qKSJz+/+43tq/RIkVHBtD1Fa5H4qklHkqeeJ4bcmxBECJYeunixm6mK+bPZgXpeHERn
	V+s9ndCdaxhkeeFgm8iot4h+XP/14/LLurxe0sWK53IKx7PmYV+jsn9X79G1xZZCwAgLO5wArXeMl
	zl5f37NGM1ygb874h1zavxF5Sh6SJ3AaDIp3/SHJyGUgH8+jIvPftbyVgrM3IuWB+VXo7QS42qqgb
	sREo6s3vH1cq+U1veyx3x6feWgzJ7epptNVzCsHbumy4BFSjUrEpLGJCwKKg9g5MerhjEdo8FOGsG
	jROyoHUaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZsV-0000Xs-Lz; Mon, 30 Nov 2020 03:29:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZsT-0000Wo-JF
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606706965; x=1638242965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nbiHUyaUtN1lM/VRyvOM4VWz5z/jZqsgAj2Gp0q3iN4=;
 b=Ol6/JzZg4Wfzovi1lowSq1k51ZJFeoWWlPmbv0MHwkBfgDFEroDz32/K
 ZG+luzyZY7RpR7wexn626Wo19n4v1iQtS2MmkGxcwoOVSHVuqF4UCJEzD
 O33kPIyisTE4zBar17P9mHBxjVMnfTUnnIQ8TVaxfo0COGk6vVXeuNVPZ
 ZGLq1OFGnK936pQ4xjVxzTdbwkaLJrs6lwdo/mffWrdojQ6FQzzUbiAto
 1A96IkNpzYg9gUU1CRgjXc7QUk1KgXLz3ZqAXejWutggujyKin8rB/OGx
 F4WWdsJibuiSVPNQUjjO2yxo5AK2EYEjFLlT/ZZw4eZHSBME1sFVbeop3 A==;
IronPort-SDR: jfcl/yr1qHtb2VOWTkDLCUR5t8AxUWnMiuBeji0tNnUZoWBi07kdC6DaasjPgSaz/irU1DV5Da
 NS63yvib30JKpeksGgIjXuURWZ6hIDgSIOKBLCp/5cSheRH6iV35lLhF6yJamcC458KSRFma67
 RVhNv8YDiOQiux2b9s4sUgFxvEhYarRqqUSqwwWYRZWc8HnL/iE0KYgppiVopiYb+fKqFglzmS
 t5s3N5s1mNN6nEln0ho+diMCZI84/rapWXz0fRIPxXAZNdHejruj/mvQZutJzcsVZ6ykRGXwzG
 XMI=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="263892477"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:24 +0800
IronPort-SDR: z0vc/H1pAcZP2BLcIMl9R9XpU24PqRo97QbEMNVmg5KiKRZxH0xaalRO/m6R0PLHJsXrg6EjzB
 Ft7vCq/oNPpGOyp/teHDfpboCVFHOXzfs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:13:38 -0800
IronPort-SDR: GazJEliYlREQMQuOCVUEF9CAajpza3ubcbWR5sBmkfF2VRciHRbrsmjlR389fDQZ4o9PP5SJeU
 LFsLbRIPjoFA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:24 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/9] block: export __bio_iov_append_get_pages()
Date: Sun, 29 Nov 2020 19:29:01 -0800
Message-Id: <20201130032909.40638-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_222925_793321_B2028C91 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
