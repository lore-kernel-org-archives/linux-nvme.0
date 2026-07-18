Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE9C4451B
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jul 2026 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhGxTEOOON4RkKT9KdpeyXrdqn2SrMJKFWwPDsn11x4=; b=EFIge4SZbrefpHoC4y7VfRJm4r
	9Gqq1okdHehJ0mSxl1hTTf4HFdP/d0jCHG7F7Tij5tN7lKVs7Mo9fb4K3x8s1llIBTni6FCfhzoNJ
	34/HHMKvGE6I+4J0Fk7aOniHe0E3J29ctOwSGlIYzZHCvFJ00Kkv4LCc319SWmYtmzph/DQYPHiuE
	iWWFVOQAOxGf8VI848IUDw+YhNmKYwG+XsPSqBpP8Pd3YTvB1QrBeRu0iauOCRDdr2Rki5nSk5iU8
	sjSQ+y6AXB+FajTgcprpJTVOWL5ZliTrC1aHsRz61KaAYEnkcJ5TVSXk8RMzj+yl/Gfdhd2qdAbtB
	PnOBkCDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rv-00000004H4k-4AGh;
	Sat, 18 Jul 2026 16:26:27 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rq-00000004H0y-3cA2
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jul 2026 16:26:27 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-493f75f7172so67867305e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 18 Jul 2026 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391978; x=1784996778; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FhGxTEOOON4RkKT9KdpeyXrdqn2SrMJKFWwPDsn11x4=;
        b=Kh0RJxjgElho/rj9CIAJav//VnrYrkeASS1LDgwChJl4PqPbJ1wHPVOTOpWfg56tgG
         ZUKu7yOu6yH68Jde64aPYOCY1QcEIp4lO4Mf3lpx+SlaDRP08/dIVr1FGagTn4RYLDP8
         5Rs8sPTrH+agSwhga/sqSk/Uuc6jF+A8BU1TMHHRmM4Tj+UFi+H/RwytA1pCz/B3qpnt
         fu1Ia7vTRiMjrQfO0Liuy/Kg3lzjxj6fxOySxWcKZ+kikSUBdTu5ZMf3bJ6sKwGg7sLc
         YiK5nSWVj7XZYzFFR2l4RG02X3rjATQKVqX69RUR8MeUp32+TjIkoIthQygPVpgIyCBb
         ESHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391978; x=1784996778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FhGxTEOOON4RkKT9KdpeyXrdqn2SrMJKFWwPDsn11x4=;
        b=GJuwdpFcYK9h/7VfUrAIso4nbcweOOJvTB1tCtA+xBdJaUAnaluK86uF0YqGYevTX+
         Rtf8zIt2YHh61rDHQPBFmUfPnLSqoWBkKr5SrZCdN/TVHvqh9mD8jl373it3uBTT1MxY
         mKYYXFF/vgnzMuUuAkrTB98yRNB5uzUQ3gM0GruHJvl1I9rWpJOu8mVwbHF2Gq2+Vfwf
         CQeVJWi7v0Cvog7zU0FPxGaIl2B74fKM785qmMUGfEO20SeiEbb7NZPGkQswJP7Xhf+4
         jU+vRvHPxdjHQ+ksMfPW88Z348lA2ozsVFZtuW8gpmi2/MWSk85QcDxJ5y5cFlTgDscE
         Qi5g==
X-Forwarded-Encrypted: i=1; AHgh+RpPov5JPZN5FUL7NiMG8g8Szg4RlIgCkk3CKpSUP8C5VCePwLriqkIFtAjj/G3nby3S2pOzdoIH6JVH@lists.infradead.org
X-Gm-Message-State: AOJu0Yz92nrVC+U0ttQxtazhPnP2s9TfhMQXzyD333MH+1CC1cJPIwVS
	1UjmNvxIrt3l9PPtLK8+CxHyu888GAwZets5f25pVTCoTpv51a00/eUhob00VsonCg==
X-Gm-Gg: AfdE7ckgAdg6NYTINQ1pRSZeCY79aCs3oKV1MS1IcVzt+O+RVeEK9PegeqZTOHaewFH
	EW22H9fNvnSajym6p/D4Yd6ByduClhrUTZIYK7fbtLQKboNy1eDKvyBBM8/mB266uvlTycIS+UM
	0TNLJJWBERPgZUmzoOZr2pWgxxHfobmWbr5MnNx7PlQR9SLjzT2RZ0BGxrN4re959Hpt8FahxAp
	N3NuIHZNKYNjTozAqnrCYeVC7q9dQGtJX8lkcWyxoxL1Sv6oZz2B5G/nVrIw9td53HTWZW1nEYR
	aENh8bFljSwAOnkPVf2GZtNzco8DHm4tPtdWBRTCDSfj5atBedj7VCf3wWTdJ7n1QYZ7vNto4fr
	CIUuUdZx50igBNb6PzxHZQ7AMfZotJMFdW8J5B/5Y8MUbIzALMCxdkEBttszQWg==
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr78278195e9.10.1784391978225;
        Sat, 18 Jul 2026 09:26:18 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:17 -0700 (PDT)
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
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/6] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Sat, 18 Jul 2026 16:25:43 +0000
Message-ID: <20260718162547.448892-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260718_092622_924958_1447E44D 
X-CRM114-Status: GOOD (  17.65  )
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

md_submit_bio() unconditionally strips REQ_NOMERGE before passing the
bio to the personality, an optimization from commit 9c573de3283a ("MD:
make bio mergeable"): a bio that md has split may become mergeable
again below md.

For PCI P2PDMA bios the flag is load-bearing, not a hint. The block
layer sets REQ_NOMERGE on P2PDMA bios (__bio_add_page(), and the
extraction path of bio_iov_iter_get_pages()) because the DMA mapping
type of a request is resolved once, from its first segment
(blk_dma_map_iter_start()), and request-level merging is prevented
only by REQ_NOMERGE. Stripping it allows the member queue to merge a
P2PDMA bio with a bio carrying pages of a different pgmap, or host
memory, mapping the merged segments with the wrong bus address:
silent data corruption on the member.

Set the flag for P2PDMA bios instead of merely preserving it. No
in-tree path currently submits P2PDMA pages through the bvec-iter
path (bio_iov_bvec_set()), which skips the flagging -- but nothing
structural prevents one, so setting rather than preserving hardens
md against that gap at the cost of one branch. Everything else keeps
the original optimization of clearing the flag. This covers every
personality that advertises BLK_FEAT_PCI_P2PDMA (raid0, raid1,
raid10), which is why the fix lives in the shared md_submit_bio()
path.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/md.c | 14 ++++++++++++--
 drivers/md/md.h | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3ae4fd4ef381 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,18 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split could be mergeable again below md, but for P2PDMA
+	 * bios REQ_NOMERGE is load-bearing: the DMA mapping type of a
+	 * request is resolved once, from its first segment, so requests
+	 * must stay single-provider (see __bio_add_page()). Set the flag
+	 * rather than merely preserve it -- bios built through the
+	 * bvec-iter path arrive without it.
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..140e2b3670d8 100644
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
@@ -22,6 +24,22 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * Check if the bio carries PCI P2PDMA (peer device memory) pages. Read
+ * bi_io_vec directly rather than using bio_first_bvec_all(), which WARNs
+ * on cloned bios: md routinely handles split clones, which have
+ * bi_vcnt == 0 but a valid bi_io_vec shared with the parent. P2PDMA and
+ * host pages must not be mixed within one bio, so the first bvec is
+ * representative. Only valid before the bio's iterator is consumed:
+ * bio_has_data() is false at completion time.
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
2.43.0


