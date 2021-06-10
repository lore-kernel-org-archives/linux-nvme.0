Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62885C48BCD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2879A61059
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879A61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mrgoa3WglodU65P/J1dcsMaS25mp592jwvHb8k1TGQI=; b=MeOi8wMIdlUljm
	Mbgg5MXozdZpAGq1bTpMVl/Z1LGPQ4AWTqauk6jk9/Tf/hbSWNTV7Pe0lBoRYpMcZdKpPudtmjV33
	8NU12GQye0Zz1FDgU9dA5qpRtfDjTc5avRu1dQhYhp7h58GuQ106ZFL7u0aeZQdR9mhT2hbZdEVqm
	whS6JamD2CNmUdlXRH67fCTqKWqgksfsZA+hPaPetVf3uegwObdHHYXzrYzL4ET+IwD5U/K01xNFj
	xKf2ZKoYmPIZmXbXepD3JMYFbjCgHyEzPuaVDXPVGKV4KIvE6CX1bfjnnvJcoOe1bCghKWUkzF43C
	gb1Xe2UIOCGZFL9V9hyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9ZJ-00GGZs-BS; Thu, 10 Jun 2021 01:33:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9ZC-00GGYY-Mm
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:33:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288786; x=1654824786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/M7v9KrjoblbSKdC++kyP3aEZLqjL2cSbgHauomV+YM=;
 b=Jgw3UelKzsPvlh6UxYtqg3NvRz0KTphotl9GiXtz0YQa1yacqvWA/2+c
 rLnNLW9s9NDVOj79glkv3irEKTYGqKsBly0jc5LTxFqAJ5C5zm1LLWn9H
 dWRlZ/MAspT9tWXycxpVM0YlnrF+dUv1M2MdYZVQTtYOfsh0HRhjDPAKo
 a/hWfPrNjcSMr9kRxte2fDkK6b8EvnwIG5Z+2iWvOoZ8usGhnEnKKf6wo
 X+e+Xa8aDtiklx1TtQ17kbMsDhqciW4zXIYvNYOgQ+dW6ZFD6d3VfuAaV
 nPn7vv+++pmX6Mo8B6Zzc00hFcSnZrrfEq0nwa798ly0r4tSxZ03OIs5q A==;
IronPort-SDR: AIS4+YXydkK6hESKFwxFBdUPHxROdT1r0CDI00PLj6eelpSeVgNKEgnyrm7OAladY9egmqYasE
 f6tE6rrjQH0DZnFY74VJWoztDjHiyCZudi1fqSbET55LhhiZ11cgpZF4qIDZ4XjA3ijpSh1407
 3hwEQbBCY7qudJU5LXlm9EdYCqP06qwltI9lRxtMw9OxXSM4TBO3NfOTVhzb4DzBANTuS9R+A7
 AGnXt8AkCvuaaEgQ0x3hPM1huTpJDZZm1Oidu+xc0WdRIFAmq75/Ouhaa3WqYvm6Yt8eNOisiV
 cnI=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="282813620"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:05 +0800
IronPort-SDR: 93x7Od5HuWULv43Wrbs/dqGgnc4pfq174vi3HF1beEpWfBE9j+1oB9qyLo8N6oj7hw7ZnCr5uL
 9tI0Y0XaSBP/0TG3DYEHf8yu1V2MRfw/aTZvJ2/81RevExCmLvVtTkfcj3MQ7iXTUzjtFcCHtw
 1zckX0CCoPnmDgMqYZ/yhbdJYzEo6MAxjbcY3F6NdfBlyAQBcM1JGQ3zdPDfslJWNq9uIMVtNk
 qKyPbVqz8tBD7OxJgNb0TPABEBL2MTzp/MDgjuvumwavlXbd+qBr88X2bqhVUS9wReocezPSt2
 Uk1A/y+wteYprFcj9OosWYNF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:10:45 -0700
IronPort-SDR: j8CTu3QY5Pi2uCvsUK/srx86rlk/v4c2+4di1Lp05Qpk4TlG+vUR9huSY8NSGgqlU774mvH+p8
 C562OgdC7kf9FZJ/kKdVFFPQsitGsufmd9enhZ6TBv8cQY0skNo/5KpfaHU/rnYP30XKYRmci7
 RzPGtEFlQjCsEaCsJuGhDENWwWArEI3vlmUJboeGA/2hEwNMvSvdskq6cRoliAdOcRTnmPCjk+
 qdbkow16dUoAxM4cZALj684qEOmlyX8owLNyA4cZQPFN2y+iQSyF7hRntBwX6wLSMcsoAG6fbB
 0lc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 1/5] block: export blk_next_bio()
Date: Wed,  9 Jun 2021 18:32:48 -0700
Message-Id: <20210610013252.53874-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_183306_769641_0F808ADD 
X-CRM114-Status: GOOD (  11.02  )
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

The block layer provides emulation of zone management operations
targeting all zones of a zoned block device only for the zone reset
operation (REQ_OP_ZONE_RESET). In order to correctly implement
exporting of zoned block devices with NVMeOF, emulating zone management
operations targeting all zones of a device is also necessary for the
open, close and finish zone operations (REQ_OP_ZONE_OPEN,
REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH).

Instead of duplicating the code, export the existing helper from block
layer so we can use a bio chaining pattern that is present in the block
layer for REQ_OP_ZONE RESET all emulation in the NVMeOF zoned block
device backend.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c     | 1 +
 include/linux/bio.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7b256131b20b..9f09beadcbe3 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -21,6 +21,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
 
 	return new;
 }
+EXPORT_SYMBOL_GPL(blk_next_bio);
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..b2491ead22a0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -822,4 +822,6 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
+
 #endif /* __LINUX_BIO_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
