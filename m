Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0611EC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:47:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B106108E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B106108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DyJK2BpDxsa9ZT9HnZhOPFKGQILQ8q29aQwuWV5r6VQ=; b=PaglMqAlxVpjqh
	lfL2djJslMhB0YyrvcNSbsW6anL3Gzx2qOtdFocNzylfsE+VISGZhzWJFynM/DWqh/aPXWVU8NtnA
	OU6BYzAffUjc5GQeAztQTDFO10DrEpDedp0V8fwCqViWlvZsRht3eHAUrdduwYgu1FmM5ADquhvSO
	CXdS0mK3hsEGFjZ/pb8YprspezpnY7xulPIdLzgik2eWvfvEDHyyzdw7VRRSjSpizDqFylV9hQ3cx
	qj6BbUSQ+lKCljKoBUEvIpgQU2tghEoa+85IvTL222qiIhKJc8chI6u5zWIKBkAgNu4JbrHZlP/Yq
	k6+B0hjGvwMbqUhEZbtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUZn-006aP9-SX; Tue, 08 Jun 2021 05:46:59 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUZb-006aKz-Rt
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623131206; x=1654667206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YPjGl1c5cgDOyFgwCx+oIrg/d6n2QsQ44GLXoyASJbY=;
 b=LfSRec02QYYJ8WoYt6UapHtqeezPtLKhM6RV64Pt6qHpCzkN1ScVbkLY
 1K8LmkxyPJXb2IIqdEtIJMIbb9AIG/bP3stSAkQyHzLZWp+RxL28bXZD8
 vE87TqUQENJbXfu9VaOhf5rPfY+FQd3aDPgXG2ke7tvIX+ocklQELo4Cj
 GRoEPI/NG6lQ1F6QyN31qhanzYy5zeZpRL8rU+YX2kMXI+nQP/G7W2EBl
 pbQ6f2h31ffaBhCjqw2ydWd6TYPBoEj6rSQLz0Ny3fbB/Q1oYd8XMl7O+
 O4hGLuopN46YTRdOd9e99/5btMb8fL533ZeUNPZxk8RjMzhDzu7yF18wM w==;
IronPort-SDR: xSjYlZLael/jT+J2OardswZdnsNHUcWFbZFOsCUMobOHTfo6akeXh/YdSkgImVdUipeJ43T3yM
 2coG4s86hPPCrLIbKJ6WFFdCa9I8K0NU0nIrHzere+Ek0R37pzJX6JdHTKBk2M6U4Z8AZses/G
 s+JNmjzKgVVWz2+wZ1XMSBIcCpvdOxdOrjiZk2s0iog2JoNmSyvgWYWuBlS4BZo8U+5hmBDpIP
 HrLA71mBVgvchyl7HO19RMNjnbYP7G0VQf+dZL3fEW+UqWNRNYVC9EVZgIwQt3EVAAfj4IbIgK
 mKw=
X-IronPort-AV: E=Sophos;i="5.83,256,1616428800"; d="scan'208";a="175868505"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 13:46:46 +0800
IronPort-SDR: ObEJ1UKLJLlsCYcDsC4xWG1/nlwpWKW04yFntjDrfn/1sDNR/mZ7pu4yvPJwkASJ502iL+nrxH
 3/uYj6mYHxFHfZ6XwRTIsW2/DwwduNkyS5uqMuIVSXc1bFZbvx2UTsBlepX8GSk203bVB20zS/
 SgxCwFU5c4e4C64WXa9XcYfB9r0kW07L705ROgJ4C2+hZDjuKUtBclaPZ1NqYfvgtwPwfrcC6h
 flw2b3CSzP6Zej/gsepwfNDmSk6l91/NEAxEgm8KNx/iboekkSfvctOI3tjPqG5VdLpnbcm8lF
 FjMADYGHQ7Wv6yIiTqUJNiA7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 22:24:28 -0700
IronPort-SDR: N3MlXdFyqDNUo0T2qq079LRIemnbZFACIk+e5jK+FGZfVxQpQcCD3PgEOGIvmJvEO2zHq6Z5x8
 +HKjm1y0ONS57HKRrngrXAlD9P9VM0vNdNqPfL/XWQ9iBn2BYatD+79PxqpjJ/5ic0u0Y5UW21
 dBvAMMHkynGGx3GWlim+zoidw1u+s8gQSYDdBnAigVmk0/eIvmKK4ewIwsddn4KeE0Aipg8LwP
 KxbuB5iHDxOSnSRGZd+Eol3bKBVMei3G7JjYeaXxoonROSY+k8mMY7EHGb8EkloFa3MV9+Fank
 Wg0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2021 22:46:48 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/5] block: export blk_next_bio()
Date: Mon,  7 Jun 2021 22:46:31 -0700
Message-Id: <20210608054635.5661-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_224647_942997_BC28C2EE 
X-CRM114-Status: GOOD (  11.37  )
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
