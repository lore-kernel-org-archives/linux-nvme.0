Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022C9C4451C
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jul 2026 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0MziNpD1hbsOVuiqO219eZKFpG+B3dliOI3daA6CJJA=; b=B1D/uQ9YjdeZBEXsgNIywWfILk
	RlTS0JSzlXOPVUi+Kbnu33St0OKBM/kiB/lNysFsAO576G2BNVFqVf1RWezQdwYXSmdxeId8iniX8
	s9X5AFRmsN4HuoeQv+VGwpSpeV/oIFn/qC+KCzzU7zyY6cVmimAOSJw+wbNbozUQh+MtCwkTr1w/M
	lt4jaT7g8DWXcwon1id6Iq1D7c4UT1y2+qErAmsg1dsAjadzkiOIsXymywECb0Z0ZvoWt3qScH505
	YoEX+KAhwDUeAJlBripIzMEwyzJfKB7ER1eCnTDmFVLMRdEVay31EsR4rceOr9XgOqJY1yfZQvr6w
	ebHSiCng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7s3-00000004HAG-2LqS;
	Sat, 18 Jul 2026 16:26:35 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rw-00000004H4X-3cre
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jul 2026 16:26:33 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4955484387cso1717605e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 18 Jul 2026 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391987; x=1784996787; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MziNpD1hbsOVuiqO219eZKFpG+B3dliOI3daA6CJJA=;
        b=Ey0vzimbWw/itV3tSGHzp0k5v2pCHqdwKewyeYK4Ia2giPUPpS/XCoVCrobF+EylUD
         k9vYsEns21pyOnkS+r0NmYKoFAP6rXXhlIZba4r09fSGLb6XtFut/AM4RzBEANe0E5Dy
         BoZWlxkQSO1LjYzZTdtERBqtOxTnhEr13uYPfpk2QcERbGU28bylQu9BIc6ScjjpCVxg
         Qhy1Cujh4KM4DMOebCKWLYOk7LruPLyLnPxyFUvSqUkO/2YVoxOGZFkbar6kPcnPOx+w
         6ZpRgmICBePJQpin0y87VpI8L1I6aFi8xgGQIKUH0QXs3iP6KeyU8lyH2pmP0mFDE8wW
         EjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391987; x=1784996787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MziNpD1hbsOVuiqO219eZKFpG+B3dliOI3daA6CJJA=;
        b=IhTwmuHqLNvc5DokQRU0/RbUPPlVGOVbyed7CRqq64dtJSxim2hmuZ+kT2pH7bA+XD
         jeukDFeYj1vyW0djgyE/tWTdlKNmawAK1IJAXL2AcHyHOVIwhv732N4lReAEO88nssmy
         jnQykwjeR5lfW3Eat1nDy5/uD8euhNf6+xHhUMbULrAAcGrMFifbnqXBZF1ViQDIFLot
         94MAjiPXl/yQL4BRhVDaRqbJA6ymAyYieyyvShx3DyS/Kfg06zhOciRvCrCdu05gGfwd
         ffqHMB8jP3UL25DTIMUUmhMnmfwSwtGmfmo0BR71jhkUElg+7AotAViMt6loBTnRNsiM
         SQDw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0X/ecg0f0KUBZu9LlDIaYL73bHtIw01vbap+1NaGvnWcy3G5uyMUjupKjq6AFnTyK3w4arij4kiyr@lists.infradead.org
X-Gm-Message-State: AOJu0YwC2AfXklQvMN61/ItCrfUAXX5zg4MoNWcewXbIpbMPQDKshbbs
	FJNpIFTsIp6ozFCBo+nkEIyNj6QBS3bCMrPcHFo0VyLDVSee2yGOXK0s5IzFlfB7MQ==
X-Gm-Gg: AfdE7ck++KT+NfDv2wODofP1kc30xUmnF+PV1Sl2c94HXTQ1s83r0wXitX+MZfqpt/y
	rEkrmfC1x/Y065sNk8VwL9RWwuGhp3kPER3ImLHmWihJJmlOHMAx/4Rw6yDtkwJgrWQk8pDnYLR
	UtdCsujRm6r2D65WSbSVyIcOizURai5xFH0ZiruNIOuoAORGzuniR1eOMfmFKHNJK/21vjcJhLz
	XWQeecuX/qxkILvKEhRseJkgFq3QyIJB0Wee0mLxiXAkcF2DAxExLrXkBo4A49NVZHtQY/TJ+0H
	FB1ilojGQX4ybQsaVfVakVFywLumC3khKiQBO+pFx/owukXsh1/NKq7UIGqNXiQxl5yNtkAK/rH
	KYSB//s2CQuyjyEr63DpmwgQuz4iI4NrUD9NQISLbEnIoxOgr4bfYbNys2pqgSw==
X-Received: by 2002:a05:600c:19c8:b0:495:43ab:4f78 with SMTP id 5b1f17b1804b1-4954a3d0ad9mr79922245e9.7.1784391986433;
        Sat, 18 Jul 2026 09:26:26 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:26 -0700 (PDT)
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
Subject: [PATCH 5/6] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Sat, 18 Jul 2026 16:25:46 +0000
Message-ID: <20260718162547.448892-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260718_092631_984909_C954B917 
X-CRM114-Status: GOOD (  28.84  )
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

Since commit 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from
member devices to RAID device") raid1 and raid10 arrays accept P2PDMA
(peer device memory) bios, and a member that cannot DMA-map the
peer's pages fails its leg bio with BLK_STS_TARGET (from
blk_dma_map_iter_start()).  That mapping failure is a property of the
peer-device/member pairing, not of the medium: re-submitting the same
peer pages to the same member cannot succeed, and there is nothing on
the disk to repair.  Routing it through the stock error machinery
misfires on all three paths:

 - narrow_write_error() re-issues the failed write in badblock-sized
   chunks, serializing hundreds of guaranteed-to-fail synchronous bios
   through raid1d/raid10d per failed write (256 for a 1 MiB write on
   4K logical blocks, 2048 on 512e).

 - fix_read_error() probes members with kernel pages, starting with
   the failing member itself.  That probe succeeds (the member is
   healthy for host memory), so the routine rewrites nothing, records
   nothing, and logs nothing -- but each invocation costs a full
   freeze_array() quiesce and a tick of the read-error budget.  The
   budget exists to evict members whose medium keeps producing
   corrected errors; its hourly decay is sized for sporadic medium
   errors, while mapping failures are deterministic and arrive at I/O
   rate.  On an asymmetric PCIe topology (peer reaches one member but
   not the other) a mixed host/P2P read workload charges 20 errors to
   the unreachable leg within a second and kicks a perfectly healthy
   member -- destroying redundancy for all I/O because some I/O
   cannot route, while every P2P read is meanwhile served correctly
   by the reachable mirror.

 - On FailFast members both paths short-circuit into md_error(), so a
   single unroutable peer-memory I/O evicts a healthy mirror outright.

Handle the mapping failure -- BLK_STS_TARGET on a bio carrying PCI
P2PDMA pages -- explicitly:

 - Writes: probe the whole range with one retry and record one bad
   range if it also fails.  BLK_STS_TARGET is also produced for
   device conditions that narrow_write_error()'s retry loop recovers
   from (e.g. NVME_SC_NS_NOT_READY and NVME_SC_CMD_INTERRUPTED via
   nvme_error_status()), and md cannot tell the two apart from
   bi_status alone, so it must not skip the retry outright.  A single
   whole-range retry observes the outcome instead of predicting it: a
   mapping failure fails deterministically and is recorded in one
   call, collapsing the chunked storm to a single bio, while a
   transient error that has since cleared succeeds and records
   nothing, exactly as the chunked loop behaves today.

 - Reads: mark the leg IO_BLOCKED so read_balance() picks another
   mirror, and skip the freeze/fix cycle and the budget charge.  If
   no mirror can serve the read the master bio fails with EIO as
   before, now without kicking healthy members on the way.  The P2P
   page check is what keeps this narrow: a member that keeps failing
   with a device-produced BLK_STS_TARGET (e.g. stuck not-ready) must
   still be evictable, so the status alone cannot gate the skip.

 - FailFast: a mapping failure is rejected at map time and never
   reaches the wire, so it is no evidence of device unreliability;
   don't let it trigger the FailFast md_error() -- the same reasoning
   commit f7b24c7b41f2 ("md/raid1,raid10: don't fail devices for
   invalid IO errors") applied to BLK_STS_INVAL.

The first bvec is representative of the whole bio: the block layer
never mixes P2P pages from different pgmaps with each other or with
host pages in one bio (zone_device_pages_compatible()), and reads
bi_io_vec[0] the same way in bio_iov_iter_get_pages().  md's P2PDMA
support is otherwise declared at array setup time through queue
limits, but whether one leg's completion was a mapping refusal is a
property of that bio alone, so the completion path has to look at
the bio.  A distinct block status naming the mapping failure exactly
would remove the remaining ambiguity against device-produced
BLK_STS_TARGET and is left as a follow-up.

This belongs in the same release as the BLK_STS_TARGET restoration:
with that fix alone, an unroutable leg costs the retry storms and
the healthy-member evictions above.

Measured on QEMU q35 rigs (one CMB provider, two NVMe members),
8KiB peer-memory I/O, reads x90 under concurrent host reads:

  scenario       before (patches 1-4)      after (this patch)
  asym reads     90/90 ok, healthy far     90/90 ok, no eviction,
                 leg kicked after ~20      no budget charge
  unreach reads  all EIO, one healthy      all EIO, no members
                 member kicked             kicked
  p2p TARGET     16 chunk retries from     1 whole-range probe,
  write          raid1d, then badblocks    same badblocks, master ok

A transient TARGET recovers through the single probe with no
badblocks recorded, and a mapping failure no longer trips FailFast
eviction while a genuine I/O error still does -- both verified on
the same rig.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/md.h     | 13 +++++++++++
 drivers/md/raid1.c  | 46 +++++++++++++++++++++++++++++++-----
 drivers/md/raid10.c | 57 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 101 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 140e2b3670d8..b1abfc89cfc0 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -40,6 +40,19 @@ static inline bool md_bio_is_p2pdma(struct bio *bio)
 	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
 }
 
+/*
+ * True when a leg bio failed because its P2PDMA pages cannot be DMA-mapped
+ * to this member (BLK_STS_TARGET from blk_dma_map_iter_start()). Usable at
+ * completion time, unlike md_bio_is_p2pdma(): leg bios are clones sharing
+ * the master bio's bvec table, which outlives the leg's end_io, but their
+ * iterator is consumed by then, so bio_has_data() cannot gate the access.
+ */
+static inline bool md_bio_p2pdma_mapping_error(struct bio *bio)
+{
+	return bio->bi_status == BLK_STS_TARGET && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a30032321191..241c2994b6a3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -491,7 +491,9 @@ static void raid1_end_write_request(struct bio *bio)
 		if (test_bit(FailFast, &rdev->flags) &&
 		    (bio->bi_opf & MD_FAILFAST) &&
 		    /* We never try FailFast to WriteMostly devices */
-		    !test_bit(WriteMostly, &rdev->flags)) {
+		    !test_bit(WriteMostly, &rdev->flags) &&
+		    /* A mapping failure says nothing about device health */
+		    !md_bio_p2pdma_mapping_error(bio)) {
 			md_error(r1_bio->mddev, rdev);
 		}
 
@@ -2517,7 +2519,7 @@ static void fix_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	}
 }
 
-static void narrow_write_error(struct r1bio *r1_bio, int i)
+static void narrow_write_error(struct r1bio *r1_bio, int i, bool coarse)
 {
 	struct mddev *mddev = r1_bio->mddev;
 	struct r1conf *conf = mddev->private;
@@ -2531,6 +2533,12 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 	 * It is conceivable that the bio doesn't exactly align with
 	 * blocks.  We must handle this somehow.
 	 *
+	 * With 'coarse', retry the whole range as one bio and record
+	 * one bad range if it fails: used when per-block narrowing
+	 * cannot find a good block (P2PDMA mapping failures fail the
+	 * whole range identically), while a single retry still tells
+	 * a since-cleared transient error apart.
+	 *
 	 * We currently own a reference on the rdev.
 	 */
 
@@ -2545,9 +2553,12 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		block_sectors = roundup(1 << rdev->badblocks.shift, lbs);
 
 	sector = r1_bio->sector;
-	sectors = ((sector + block_sectors)
-		   & ~(sector_t)(block_sectors - 1))
-		- sector;
+	if (coarse)
+		sectors = sect_to_write;
+	else
+		sectors = ((sector + block_sectors)
+			   & ~(sector_t)(block_sectors - 1))
+			- sector;
 
 	while (sect_to_write) {
 		struct bio *wbio;
@@ -2629,7 +2640,20 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * errors.
 			 */
 			fail = true;
-			narrow_write_error(r1_bio, m);
+			if (md_bio_p2pdma_mapping_error(r1_bio->bios[m]))
+				/*
+				 * A P2PDMA mapping failure fails the whole
+				 * range identically, so narrowing block by
+				 * block cannot find a good block -- but a
+				 * transient device error also surfaces as
+				 * BLK_STS_TARGET, so don't assume.  Retry
+				 * the range once: if it fails, record it in
+				 * one go; if it succeeds, there was nothing
+				 * wrong with the medium.
+				 */
+				narrow_write_error(r1_bio, m, true);
+			else
+				narrow_write_error(r1_bio, m, false);
 			rdev_dec_pending(conf->mirrors[m].rdev,
 					 conf->mddev);
 		}
@@ -2656,6 +2680,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	bool p2pdma_error = md_bio_p2pdma_mapping_error(bio);
 	struct mddev *mddev = conf->mddev;
 	sector_t sector;
 
@@ -2675,6 +2700,15 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	 */
 	if (mddev->ro) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
+	} else if (p2pdma_error) {
+		/*
+		 * The peer pages cannot be DMA-mapped to this member;
+		 * there is nothing to fix on the medium and the member
+		 * is healthy for host I/O: don't charge the read-error
+		 * budget or fail a FailFast member, just keep this leg
+		 * out of the retry.
+		 */
+		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	} else if (test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
 	} else {
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f7ef903a3d4e..b24429a19254 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -489,7 +489,9 @@ static void raid10_end_write_request(struct bio *bio)
 
 			dec_rdev = 0;
 			if (test_bit(FailFast, &rdev->flags) &&
-			    (bio->bi_opf & MD_FAILFAST)) {
+			    (bio->bi_opf & MD_FAILFAST) &&
+			    /* A mapping failure says nothing about device health */
+			    !md_bio_p2pdma_mapping_error(bio)) {
 				md_error(rdev->mddev, rdev);
 			}
 
@@ -2786,7 +2788,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	}
 }
 
-static void narrow_write_error(struct r10bio *r10_bio, int i)
+static void narrow_write_error(struct r10bio *r10_bio, int i, bool coarse)
 {
 	struct bio *bio = r10_bio->master_bio;
 	struct mddev *mddev = r10_bio->mddev;
@@ -2800,6 +2802,12 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 	 * It is conceivable that the bio doesn't exactly align with
 	 * blocks.  We must handle this.
 	 *
+	 * With 'coarse', retry the whole range as one bio and record
+	 * one bad range if it fails: used when per-block narrowing
+	 * cannot find a good block (P2PDMA mapping failures fail the
+	 * whole range identically), while a single retry still tells
+	 * a since-cleared transient error apart.
+	 *
 	 * We currently own a reference to the rdev.
 	 */
 
@@ -2814,9 +2822,12 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		block_sectors = roundup(1 << rdev->badblocks.shift, lbs);
 
 	sector = r10_bio->sector;
-	sectors = ((r10_bio->sector + block_sectors)
-		   & ~(sector_t)(block_sectors - 1))
-		- sector;
+	if (coarse)
+		sectors = sect_to_write;
+	else
+		sectors = ((r10_bio->sector + block_sectors)
+			   & ~(sector_t)(block_sectors - 1))
+			- sector;
 
 	while (sect_to_write) {
 		struct bio *wbio;
@@ -2856,6 +2867,7 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int slot = r10_bio->read_slot;
 	struct bio *bio;
+	bool p2pdma_error;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 
@@ -2868,17 +2880,28 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 	 * frozen.
 	 */
 	bio = r10_bio->devs[slot].bio;
+	p2pdma_error = md_bio_p2pdma_mapping_error(bio);
 	bio_put(bio);
 	r10_bio->devs[slot].bio = NULL;
 
 	if (mddev->ro)
 		r10_bio->devs[slot].bio = IO_BLOCKED;
-	else if (!test_bit(FailFast, &rdev->flags)) {
+	else if (p2pdma_error) {
+		/*
+		 * The peer pages cannot be DMA-mapped to this member;
+		 * there is nothing to fix on the medium and the member
+		 * is healthy for host I/O: don't charge the read-error
+		 * budget or fail a FailFast member, just keep this leg
+		 * out of the retry.
+		 */
+		r10_bio->devs[slot].bio = IO_BLOCKED;
+	} else if (test_bit(FailFast, &rdev->flags)) {
+		md_error(mddev, rdev);
+	} else {
 		freeze_array(conf, 1);
 		fix_read_error(conf, mddev, r10_bio);
 		unfreeze_array(conf);
-	} else
-		md_error(mddev, rdev);
+	}
 
 	rdev_dec_pending(rdev, mddev);
 	r10_bio->state = 0;
@@ -2948,7 +2971,23 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
+				if (md_bio_p2pdma_mapping_error(bio))
+					/*
+					 * A P2PDMA mapping failure fails
+					 * the whole range identically, so
+					 * narrowing block by block cannot
+					 * find a good block -- but a
+					 * transient device error also
+					 * surfaces as BLK_STS_TARGET, so
+					 * don't assume.  Retry the range
+					 * once: if it fails, record it in
+					 * one go; if it succeeds, there
+					 * was nothing wrong with the
+					 * medium.
+					 */
+					narrow_write_error(r10_bio, m, true);
+				else
+					narrow_write_error(r10_bio, m, false);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
-- 
2.43.0


