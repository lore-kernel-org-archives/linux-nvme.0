Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAB7C44523
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2026 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhGxTEOOON4RkKT9KdpeyXrdqn2SrMJKFWwPDsn11x4=; b=0qZe9kuXSDGUQH6J8GlQnlcYS0
	IOZvjf1VqjIosfhuRhTP9Us/Oy31WfTRDCFyTVTY48wyVFiuoPJKPXtDQ+OBVo5LWNmQmEUYTguAP
	4WyA9UVWBV9/vB2OsTeOzI/nlcArPL1JZFC/shPPAaJVE8mhZn83XfmTowaw0xViuxBat+1uYmhSl
	oDL8b7GXtOqPEny2HIYQK0kdtbopF8uoG1vk/smq2KWQcZXKGMDFvsEfscAyl/LvCP84Q68dEfDGA
	EsvWUazYYKZMvno1lpIt/o1SBuYGRebSpJlH3HaZIzx1pZFh5RCOJ0YZsTGz3gk8F5I+4vt2nOXEW
	kaBvGQgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9U-00000004va8-1j3p;
	Sun, 19 Jul 2026 10:53:44 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9Q-00000004vXH-0eFO
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jul 2026 10:53:42 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so9148315e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jul 2026 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458418; x=1785063218; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FhGxTEOOON4RkKT9KdpeyXrdqn2SrMJKFWwPDsn11x4=;
        b=Wj2EB7uCdnGmX5LQELw1bek+XeEi5QsmSYBcJXPf2umuumrUnJKpC4GFUJsJERHgKn
         W/baIs+eB2atrvKY/GCqluGktqslJT3YLxcdeJMXCZ731VID3O/8su8jP1OMQCVBMGnH
         R1zp8e2KUfAftcEi+IqIMBe/3yWFgg6WV1V944QysCffQZwVP6BVfqcaBSzFKCaQ3sny
         8lw9n4BrMTiZm3aCC8W+I+QG9hLBaGch44R/Cm41fndR0L1W0c0GIcHF4nUXtYejGe6Q
         z9uJ9qAtpoMd3sdCJfqUk0OYMyciTfTjMvB6dPSbNIRTHYrXXHKEo3Q4swLDz8iWghmi
         UR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458418; x=1785063218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FhGxTEOOON4RkKT9KdpeyXrdqn2SrMJKFWwPDsn11x4=;
        b=EtaE6MtlAArNtboUFP9rfYHwp5mUh6qlNWxgmL5s3d7kEYO6t0nig3kSScUO2R9wYy
         BzHJGX97RxnKookFmkyfutzKdfQT4wFyeWss+sNvfFR8b1B9XygV5x3VX+nF9IrR/1JF
         DtHbnqxcGGcJ/bw1pmbfMn4MNpSXO+mzv82nzeWVHc5r41zugDPidiZjL4tybPCHjUcS
         9ghUiihjmmOzd59kI6BGjhlZIWWz1HimmtyECjamoFjupxM+GrBmi8z6tlGOIXgkYUQZ
         1tCeMCTAJbGIkya/xfRXkgbRI8nA/17f1Fy6UFz6XA5UYsCV0EaqKZH9HzfrDUu5QMf2
         6YWw==
X-Forwarded-Encrypted: i=1; AHgh+RqH7kMiAsrmDTdB9FixzLDGz+om6IcPSrlIZuRdb5TF2uunL3AT3IRaMVEuIiGRFEkDNGTfT410d9sz@lists.infradead.org
X-Gm-Message-State: AOJu0YzoNR+0EvzERTDGx2Wd2Vc899me2O5tKMd+PNeAz/InJUswJHZ5
	6bwj9ffScgMvWA7jRDDrzfqWkgkFg73FSqk9omQFvgfTgQsFtJCrZKG/m6HRyFJ+Qg==
X-Gm-Gg: AfdE7cktCzxqwGcwv02XdajE6LLUPmmBdUB0wQUEbTHQwOoQayLhEgrm8krzUedpjCH
	p0cACs0UEA8fPkCDNhiE/Lc5cO5yRYE/OeCHW469yWNtncqm+FAcMKJmRD/TY3T5d/V6A5f3rzq
	fqHblk8OLzmz3dzdkZymTID3E6IAnL7JiVJ9M25IDQoffRSMUiVGd8FQxul+YmuiI6RNr/UVSUe
	pXkMN3oVqcPov6WGtbFD2sL64QnB7oEd4TM4hiyQqpyXSmHElyZOASwICNwmzXuwOoPDZ/0ZE1Y
	sCIs8tMBZA4v+pJDMRNU8lCP3YttqII2LT2ZlxjbcBIjK0Vyxgj1xBWd+J7VUhQruUXDL/PrBhY
	30wCQCszJoqgwO9sKd2ZIO8zEemqDAarVPpMgbLlsn6DEAI2zWX+ww1nCEjbmoQ==
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr92326745e9.5.1784458418163;
        Sun, 19 Jul 2026 03:53:38 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:37 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/7] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Sun, 19 Jul 2026 10:53:22 +0000
Message-ID: <20260719105327.864949-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_035340_216104_5F39FCFA 
X-CRM114-Status: GOOD (  18.17  )
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


