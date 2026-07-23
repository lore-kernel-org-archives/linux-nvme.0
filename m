Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29621C531F7
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=; b=ZO532HDBfcIpJTzHw+c4Li+8PV
	pWB3e31KIx2BGdcHB1F5RxO5DZj/g5RwFYwU/ukN/hq4xG/lZOmUHjVR0uovlYbwcqfIGpccyFB0u
	ffhBvxdmwKVU6gMyMj4vjgqWp/dN17i9aAPstmM9xOx0ftLSUoP5Zad+KMBmGD6WpDjJ2/7EvnL8F
	MZfjePvOkpxQpEuFlwuQ9uKW+ZPUIL8GFbpkGq8WwskDNTVxUptIcQWXMSpJjH3elprzBVfKlH2PK
	UXIMCMb6qgE1MsdOUFMPESHkrEKaFXT4VvSdBLI+DFst+lgguHF8VIpQv6g1iPGOBSTWqncx2tOo2
	crPITbkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fx-0000000F3Yc-3DxW;
	Thu, 23 Jul 2026 20:43:01 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fv-0000000F3Wp-1PAL
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:00 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-47f7854678cso614776f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839377; x=1785444177; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=pjHZE5Hh3qgDTBGoPQO6MxT8huUyIGX7J3batrutvByVbj05avRTygkE8ppGsCi8Uy
         GeUhr6vIfJr5iKw6EPTrfK8mMluTdev+U3mxF0+/+auPQlrTlbLWX3QsP09PGzqNEHzz
         2ftm2TjZp1Ju1R+A7ZW3mFYwvjuUXVZAprAE893y5h9ZsJaThWNI8TZ5zGJVyDCqDevD
         5m4NWfbSQ0JVf9600qaVRxarROxLQQJino3pbkWt2wk2oEuZuNFTl9tvB2y3pP0uIU4q
         SfbPiizFNdmb+IHJejFTFwUcoCQAuSsdxkeRcwkysVqCV6Eavq5pk/9x8TpFg8G96j56
         x3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839377; x=1785444177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=HMMc7P2mTKfXtvDzsMGFMvRdUFe1t6y/0bfU9LiBJgSpZYV2l3IU5W64jmVKSiHylb
         hgFSZFgx8jq7Oc39KsaFgEVO+kxl8VDJ9rwBnViHVtwn1gZKFTSrCKJLzwjlOqyCQL87
         VeuUm5W7G/67aQTiKHbAnNCIsIAvbEtwpwTU3IwJk6ddrY7NJe6OCxedF6va4amxyAsb
         qcYrq9jCEFr61LMiYyROy2LthCYkeQrA+L3dEWdypthTqjrpbH+QZAbpZ57Lv/b9kKym
         SLZN/CC199sS9scQgOnXZ26XrwQ71Kb0nHtZrXACtPQSVPMPTYVht4vjzaJQHzWHK3EQ
         iQaA==
X-Forwarded-Encrypted: i=1; AHgh+Rqc2wtr6aRZy8mfVlf8ytaEw6bw7aPLmADXppG0wePSm5odJEV8NmCE2amFapBzyQ/1nVLlr8HRurHk@lists.infradead.org
X-Gm-Message-State: AOJu0YxPsr5mumn7QlPOgEy6EsZ1IqOCPTycpQNnJXaP+XFm/qE49rQs
	0LQV/WVbcmmW72hM+Iy6uMWRCAvk5LEIifr2AbA08kjlq8BGWXiC/yGr71XlV5dxmg==
X-Gm-Gg: AR+sD104FssFusRI2ldZwk1EOG4hCjdhBf4Jk0FBhGzLiEgddvRxhLi3ABlTrFWf3N8
	eipXYFlhacLWZIrZQtrGmiUwY34H8kbqxJhtFR/lSGdLySXHKzcHMXeXzlC2GEEU8kE+Ru8xpW8
	166jpaGPLQoXKQZMdPA3ID/I5wOW8LvgWeaIbwvlAfiRRktDtXLkHeSYNR7hmi/NNjjbbxsI0Q3
	zdHieJZ02ZioyvsU166iGVDHocqDFc5jKkLg7qKzfYBaWLseEv9Z0CSwAp03xzK/tWxSJPInz5i
	Zv64yx3ErN86ouSVCiXvFcO0R9kgmADoyGCwFSCHYZEINZHJF7LGZUPpeWep/p8ASIWPAqY2n3q
	1CPsvWFF84cXoKxbUdyj3+z21RIUrrb4WyCyCKCAq2mjhyXUVZkO9sNyX9XFor4bK1gXBKV9wHT
	qQO79vOtE/IKb8KL/pnd9uQUFpJ/mdbxXhPx38W31ZpaSfhqwPBaHXzQZc/bMw5nz5Vpq8fhbDT
	zzjQz8aVJtp2DTqy8Yc4ULRjZ/IOPY7Mbxeu9lUag==
X-Received: by 2002:a05:6000:603:b0:47f:5a97:2a63 with SMTP id ffacd0b85a97d-47f8d6177bcmr6091080f8f.9.1784839377410;
        Thu, 23 Jul 2026 13:42:57 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:56 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 02/10] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Thu, 23 Jul 2026 22:41:58 +0200
Message-ID: <20260723204206.76930-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134259_388825_23BE829D 
X-CRM114-Status: GOOD (  15.06  )
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

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0


