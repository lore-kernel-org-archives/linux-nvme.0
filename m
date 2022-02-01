Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C545C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Ydr4Jei8XLKuYryDQ/KNBEWNoVkiGdf0qIDeXw985I=; b=tgzy2trgbri3Oa4vY8pKBu9xdv
	x+9CJVJWskzUsvEl55XaQo/cMxQlxqTm5siG5ChzwMRqjJoNC1QxditG3xlkRxdjZJ+d3JVWt5sXm
	jOutTB55f0W+oMUdCO4EvwAusuxkR5/SwEzDv6aK/lWIAVnzK7UCpNnWO3ely1bk3ISCVSQuv5kHh
	cThJCD20m4NOKVT9FTq1cqc/sUEPz1eaIkhwC4xYoXPtUwuc4+ydFWEXQXAii3OtJ4rENRQC8ojQY
	SK+aX/pyPMoGszpIXFI5hEX1LSm1BOEIsB9YnMe+uG9Bb3LWI4OnobEIuqmH03HoxEe1v7zhd9yzf
	kSenpQaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyPT-00DSn3-M8; Tue, 01 Feb 2022 19:01:47 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPH-00DSeH-45
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D4D94B82F70;
 Tue,  1 Feb 2022 19:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2A3C340EC;
 Tue,  1 Feb 2022 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742092;
 bh=GrtbTf1Rj5TYujMR5IK/cjbF8b6EXlbBJqH+i+ZpCrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EeXFzP/3FUbyl5S2WL9ttZHUd0YAhONcie3CTjP9+PTTuC1BkF11ZfVQbqMHQ1VM1
 840extsqygByK0KKJntevBMULrhuqqmJJ5biYn8xMQ6NCuIJ2Dmqa5l1Ouf4qKspfL
 yRPo+9GSIpf+3FUdBATAjwgoEIN6Hy8WcSxry9686/HnJIIz+C6g15ErGUNHp/1ZGH
 JVmaJhsTAe+4nKmwSBJQmiOaomJc5xk4ko5vuWyxL48wa31wTv/Y2vIEIv91PnaKjN
 hGxOL1fSySdVxWHG4JuYVF+jayd1+txzLFYw3DaDU8lmOJdc1xDmGz1dRR6UYvmkHw
 qDGZRPS0Aq+hg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/7] block: support pi with extended metadata
Date: Tue,  1 Feb 2022 11:01:22 -0800
Message-Id: <20220201190128.3075065-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110135_323535_78597AF2 
X-CRM114-Status: GOOD (  12.49  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme spec allows protection information formats with metadata
extending beyond the pi field. Use the actual size of the metadata field
for incrementing the protection buffer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 1 +
 block/t10-pi.c                | 4 ++--
 include/linux/blk-integrity.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index d25114715459..e40b1f965960 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -165,6 +165,7 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 
 	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	iter.interval = 1 << bi->interval_exp;
+	iter.tuple_size = bi->tuple_size;
 	iter.seed = proc_iter->bi_sector;
 	iter.prot_buf = bvec_virt(bip->bip_vec);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 25a52a2a09a8..758a76518854 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -44,7 +44,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 			pi->ref_tag = 0;
 
 		iter->data_buf += iter->interval;
-		iter->prot_buf += sizeof(struct t10_pi_tuple);
+		iter->prot_buf += iter->tuple_size;
 		iter->seed++;
 	}
 
@@ -93,7 +93,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 next:
 		iter->data_buf += iter->interval;
-		iter->prot_buf += sizeof(struct t10_pi_tuple);
+		iter->prot_buf += iter->tuple_size;
 		iter->seed++;
 	}
 
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 8a038ea0717e..378b2459efe2 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -19,6 +19,7 @@ struct blk_integrity_iter {
 	sector_t		seed;
 	unsigned int		data_size;
 	unsigned short		interval;
+	unsigned char		tuple_size;
 	const char		*disk_name;
 };
 
-- 
2.25.4


