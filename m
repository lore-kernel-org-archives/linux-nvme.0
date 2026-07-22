Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D93C4453C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MJ1SD6Cu8vcIcr/kUuDg+vlUw58q6JfkUpXNh8eryGw=; b=GLKlfoU+deTmU8Lf/GQMpIudTD
	q9LDuW04eEJ5m5wQTcLf7dwroUbcDWt/W1rCSkDm0vZUXl92j8KbyWHz2s/mDwdYyBMBayBVLTc8I
	RxXDs8oTe0XP2PljKJnRLCXSUA4lHep2jTU41RyB+XR1PzxrWjsN50CW/mqrs7kiOL9XplCAbe44z
	scb2/6nfHi1/c8wNrKFWQsl7N3BQ9mvO8cdJ+iPFgqIxya1Gdni3uBp88RKKBZiduI1zjBg1aL6D8
	+rBQvUGBVZsTzMHde/AV9RikksdnZ2RW0GWqDTcGdkpk6cnLoNehhWBpE08Mje5DY50cDulDGTQ6b
	K0RRirbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcA4-0000000CauT-2dr3;
	Wed, 22 Jul 2026 18:59:20 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcA2-0000000CaqE-0PHc
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:19 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so69842255e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746756; x=1785351556; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJ1SD6Cu8vcIcr/kUuDg+vlUw58q6JfkUpXNh8eryGw=;
        b=lKslJVRhHIXebaHGCf+ER3tad+dvhADwMr9s6IdNA6YU3mcSH4bRSqIqWas7575gTS
         T5nIuT+wiKaDwfIrm+wApU5c0GHq64IoN6zkIoGPfSOShjtFjo/F0e6U8MVrvr+NkphO
         o82CavKYvCDJ8PCimcSxFPClXlu31YKdfV3zpN7wItt4ibIFhVv2sMPBzF3KE2BY7DH4
         bn5sJONORgWd9b29uU+6G/yzPasfr+aiCige8vGEp3tbYAzn33WJbACKy6XBRQ36gTP3
         ofLWg0shKtR0ewV9pv0/0gBf5L4W8qWUGo/PjjSVZwnB0HTfmys7kPdWiNFSoNu4Q307
         iZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746756; x=1785351556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJ1SD6Cu8vcIcr/kUuDg+vlUw58q6JfkUpXNh8eryGw=;
        b=RSN6bAwTIrz7SwJkJOcxC6bh/rTCIbUNdr4hEIpt8WR1JKzO2glQHBfL4CPQKR2qIR
         sa5rAKPvTTUYkZPC/rV28oCyE6b/ANZag/GI70AzFdNVvok12+K3rh0nj4yEPfG6k5/X
         IxPtNvwvblwQcYpIJY+Yj21IgOI4sIYD7ITKROGJzsddSmhSH7F5FEjqeKPZX8FRq2Jg
         6C75hggLkMBbfmR+vO6AREgK/y5vzrD/NMS213bi3fW9tk/JHdCewWonQt2TRh+/kPWI
         4hfpJQB0tS3T2amq9v8zIhnYYXNwOAB8sBL3726syYJ5QCC2AwgfKaohad5vNeVfFuLl
         28UA==
X-Forwarded-Encrypted: i=1; AHgh+RqA2YspiyrpFca7a2NAeRr1I1t8TDbAQbTRxQpryPFFrzqxRLGXINjKzgwPXcvhkOgDY6Db7vFLICWs@lists.infradead.org
X-Gm-Message-State: AOJu0Yzdkdpysax3iktDgoRcdJ0HCxIs+pU7ErK47tuBFOrY/M6IZeeP
	PZaZ4CC6cqeKLRlwhAWqXLnaoEe6w5B2oB50th9uF0dkC7LK5KtWTRor5QGnKg+VGw==
X-Gm-Gg: AR+sD10zwGX1xeeIbHRAMUuZhoquTul5ZrbE2ECDduoOZNFnvtQaKXLX/q63KuGNoFX
	ZF/aGtSGG5seTKtEEQGQ5MOjbn5N+ra8+6kSbmnNhFEj5slUuZguDj+oWpBmJbKAlX0/liMwCrG
	zMUsoJVSBZuE93UshogYeXohYRyMVKI4fFLQGNAxSJHTLyZ6B4cKVHcBFCJHfPZaGSeTicorhf0
	lpXfUd7Rn8xOgaevrS0Mw3evkYvJugY1lxAc2hWWehT8IOozAGtniD1JfxmIY1M+cW4U7K63yIo
	lrnXJZRmkOCerF+h+XAP33bpvK9wudpR42GvMxDVLcOTzCnVupBpqg7/5ori6vusJYeGvOgWylI
	Ca1krvkhobqrnjcX194XobAiTKeKfiSTgQT26JjaGveORAbAmOCBAyNw+RdfF3swQheG0e1R6r7
	YMEXuNJxdcal488IZ5fq8ozTIJ1HSSnSGJY70K2P4Xhe6clV8=
X-Received: by 2002:a05:600c:4f92:b0:495:f31:7340 with SMTP id 5b1f17b1804b1-4954a3d06e4mr270795875e9.5.1784746756410;
        Wed, 22 Jul 2026 11:59:16 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:15 -0700 (PDT)
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
Subject: [PATCH v4 8/9] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
Date: Wed, 22 Jul 2026 20:58:40 +0200
Message-ID: <20260722185841.449934-9-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115918_288273_00BCAA3E 
X-CRM114-Status: GOOD (  17.49  )
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

From: Logan Gunthorpe <logang@deltatee.com>

A read that fails with BLK_STS_P2PDMA cannot succeed against that
member, so mark the leg IO_BLOCKED and let the retry redirect elsewhere.
Skip the read-error machinery: there is nothing on the medium to fix,
fix_read_error()'s probe reads into host pages and would "succeed", and
charging the read-error budget would evict a healthy member under a P2P
read workload.  FailFast eviction is skipped for the same reason -- the
request never reached the wire.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Co-developed-by: Mykola Marzhan <mykola@meshstor.io>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 4 +++-
 drivers/md/raid10.c | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 917d694ef401..76a1426e64f0 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2658,6 +2658,8 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	/* evaluate before the bio_put() below */
+	bool p2pdma_error = bio->bi_status == BLK_STS_P2PDMA;
 	struct mddev *mddev = conf->mddev;
 	sector_t sector;
 
@@ -2675,7 +2677,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	 * read error.  This is all done synchronously while the array is
 	 * frozen.
 	 */
-	if (mddev->ro) {
+	if (mddev->ro || p2pdma_error) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	} else if (test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9045a3f02dae..e35aeac29f06 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2848,6 +2848,7 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int slot = r10_bio->read_slot;
 	struct bio *bio;
+	bool p2pdma_error;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 
@@ -2860,10 +2861,12 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 	 * frozen.
 	 */
 	bio = r10_bio->devs[slot].bio;
+	/* evaluate before the bio_put() below */
+	p2pdma_error = bio->bi_status == BLK_STS_P2PDMA;
 	bio_put(bio);
 	r10_bio->devs[slot].bio = NULL;
 
-	if (mddev->ro)
+	if (mddev->ro || p2pdma_error)
 		r10_bio->devs[slot].bio = IO_BLOCKED;
 	else if (!test_bit(FailFast, &rdev->flags)) {
 		freeze_array(conf, 1);
-- 
2.52.0


