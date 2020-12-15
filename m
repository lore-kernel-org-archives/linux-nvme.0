Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E5C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:03:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1018D207A0
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 06:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1018D207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jl+bTgRo1xoCYkvsweTcij+H4DvPPLfQkAi9X8JbEoI=; b=zAcTK8kkpNEHJpYLie6H57GAN
	wOdm0VC5TWHnQSuqsgHDxF8eHRn2YN/Nm7zKLpasADQQb8fx73/hwDVnU7SD3VAn/mSxDmOtUw+PV
	l7M1UfRxxcmQ91Fp1BnKkbAuftYhgXI0O4MEqPDQ7KPKRBaX7dCrNBPgmIhiCaTk1JgP+ql9LZ+bA
	WY2+kQhSkkZ3ASGaB4lQ5hoq97AH9VyUrDQiDuN9sOMtgnUja6Z8araSV5t6q/ueZVzF5j1Bpht8v
	HQX6wICoYjpvQwbmW/iD0AO8HS4Wyygkr9siNfl1n36BjXJjnAEl2ye8SYOWwqbG90eP85tm46sZ/
	Hy9+QOvpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp3Qd-0007eg-Ro; Tue, 15 Dec 2020 06:03:19 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp3Qa-0007do-G2
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 06:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1608012196; x=1639548196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UfKvG3DF5+e1xbSx0w/6Rpv8SlZKd4h4pbL+RDgW3Js=;
 b=qMlD8KXq3fFnH2hlxiW1H02rMlhR1JfUvYLB5LjZHOdscbjBs07teIBr
 CAMw9NzLAdiHBUhOKqQquZOAg3cgl/BysCv23wQvtxv6CCGxLZhEtl+QJ
 qGoKI5eDZ8hUM3VQkSSvfQ0vo5KfvoSQYAGsxRg0O6t+7qPLte8NvQDLz
 v9SBu0Vb0lGX5AH1o89sr8gxa4fjt06+6BSWVGLH/LPlQh6/wCTvhiTeS
 YBQtMkT9x2JrkfXRyHJsJN0xZEyKYlZr9GfC/IW9egn49vYPfYwzRPN8X
 Ah00uX+DFVRKx5Igji6aEagx4vpK9CSJe/bt1qvs0s3zXQhWKZGye1uhn g==;
IronPort-SDR: c0kw33S0Hc6y1A3+HWD16VLcP/h4wf9v1g4v6t+ngduS5uNs48vDwFzn4SBBmhP2ZCvGHlu/Oj
 gdfurNt/Zum0UBQ3haoXggoiG8FWjjNqZWBF+rI95hqncMEq+h78fJJeD2N5eYx3lLNG2+qJ+x
 DTUcTyvCdh1+9+u7Y222z8cQii5QcONDf8oV9j+SrsUbehJTS4W0upu9lo4xqXpi0fvOxo5Lt9
 fA5IbMo7m86f91jFwWAvqDSVI+wlKuvQxrsURKHr+JJ5KLlrVrGUxIdJTUHa1sis0pjC7+9pd7
 XhQ=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; d="scan'208";a="155158392"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:03:14 +0800
IronPort-SDR: nE2Ne0jjIbPDB3GtIp31TOWsOdQjlWI1HKCZ69W2U1A5ia3Lw6vR08ECG2SzIeCoHL/2OSFmZ4
 uxwJAysxugLwfWGwYhDLd86yhpIdC3ivVQsGjeK3Z5es/GPsXhZmVXM4PBj8viopx15iZDAeun
 Banlhkk234Ijdn5MXzlr2lqMeE5l9SNRyRyYbkyI9zHRiOUOJwL3CpcL8tG5Pk9dVERh+4EkDU
 v9geobIEaJwXYMyxiOnv+FRw4fZDKdNUM+6RIA4K2nrndmuyuXMgKemJCiFBOt8HQsKuXe53z2
 F6FNclfcjX6IcjRXIyFjzVyS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 21:46:56 -0800
IronPort-SDR: l4I1If61PouEmATpRv5WNuoGaMD2g1GNIOgWhfrbcgIFMfd5lbAACpFAo46tzcnjDoGUhr09aH
 fkBrk7r8r6WtLlquL5MKTmLG4tScimfUigVvRw3PdsrlDnoxRvbXTZVxXe1aOhMTe9ut5UwS5h
 UHiygAOoe99Nwk3sqZWRakfnKdD665u6pP9pf9xXiRueL5tCIEio1al9jjNG+hHJBq1uqzNKc0
 8kMqGiqI9mE0T8U/15IL8Q5/KNKQKA0ATwQ6UTPEwhmbeMTYKIr1cek4wviQMubw8RQYLV/egq
 w08=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:14 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V7 1/6] block: export bio_add_hw_pages()
Date: Mon, 14 Dec 2020 22:03:00 -0800
Message-Id: <20201215060305.28141-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_010316_667925_2251C338 
X-CRM114-Status: GOOD (  14.31  )
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

To implement the NVMe Zone Append command on the NVMeOF target side for
generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
need to build the bios with hardware limitations, i.e. we use
bio_add_hw_page() with queue_max_zone_append_sectors() instead of
bio_add_page().

Without this API being exported NVMeOF target will require to use
bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
extra work which is inefficient.

Export the API so that NVMeOF ZBD over ZNS backend can use it to build
Zone Append bios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c            | 1 +
 block/blk.h            | 4 ----
 include/linux/blkdev.h | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..eafd97c6c7fd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	bio->bi_iter.bi_size += len;
 	return len;
 }
+EXPORT_SYMBOL(bio_add_hw_page);
 
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
diff --git a/block/blk.h b/block/blk.h
index e05507a8d1e3..1fdb8d5d8590 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,8 +428,4 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 #endif
 }
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2e..2bdaa7cacfa3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2023,4 +2023,8 @@ int fsync_bdev(struct block_device *bdev);
 struct super_block *freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
