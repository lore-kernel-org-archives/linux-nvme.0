Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E44FC531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=; b=ZZFeQtMpjyu9hFsLWmT2rvUccr
	4j+EzRjZi3++8togRrmf0zMSLcxTom88aDldT6KfiV1BlE1zrRQnpp2gyqOwZGmpPx2saQb6714cS
	uDpUHwthbLF80sVhsX6AuGxKbYt7f5e4fuDqe6VYq3trQCGisAtMuhAazLDD7PiWHTVJM/wPQBN5n
	WE5dMx+YoU1Bm005K/6CjNPGagcvP/r213TUqAqcuYBaEdpFlac/8A4ymUrKDNfgQPIdJBSrhEGK5
	oXLylQhQJtvUJ1oDds1KayHYgqtLV/hn+wKE526Dlq8bRwCak/Zf707ZXsKD62iZKNKytwXUymuWD
	GdCN3wdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0GC-0000000F3m5-3nzq;
	Thu, 23 Jul 2026 20:43:16 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G8-0000000F3fS-1UvG
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:13 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso7501045e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839391; x=1785444191; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=daIec9e9dgii4KQ9ed/N27oPex9/wy+BA01WskumUe2HPLQ83sy+sac2TVTMQZJbm8
         9tfYFBufAH3N/o7ssqZlf20P7hZD7kt4M5IGRUWX/oH7O0l6f/e/l9mtoiP4mPBU/Xav
         zLZbaQI6tNyF3iBpa7SWcT/HuhRuaH8/RsZ0Boc2kMqXQpJQWdyhzyIHwLnQcou58jg1
         FDG0yjuJY4pbu1graxpTqsvNB38QjzbfDjLtWfhmteIGhgFo+VAMs4rnEfdNzHXXXkYe
         aqLTCWpaLU/saSNGSx3+s87fIkQokePgNttEOUhAodao5XXQnVMvl11PjMu+M9lNhmu7
         FD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839391; x=1785444191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=i5VlvamMK9p/WhTte/DyrwNcyG3R6yzE28a/7VWsqaU7TKtppHECXFMt4vRbsMz4EB
         tPKZ8WoEogAs8qZeYe4dS/YK0rb2JQ+Uj1v+BdKeZkcdT8QC8PuRTP5RefNhiswa7vfd
         NZ+RVI1jxg6rjmHmmZaxDhQCvDdiVz0zf9coMIvvweizy5XwgAzW1+LihuC7vHbEd4o4
         nhOxy+fb7H19yBCH6qVIyqZ2/xvi3fsdotIzRz6TonMyjwgQLi/L60ks19o/lcgRSEUI
         BRdmZRXDK6y1tavdZbzj6HbmWRX/FcfvlZnxirYbnMRHy/h7az1YNfY9hVHkgyHnikys
         aiuw==
X-Forwarded-Encrypted: i=1; AHgh+RrHwnwL8YSw4f9AumN0T6DWZ8EnNPEWasl9oEBrT/qjt9yoIBa3DzhNA9ORPloYqtnhg3Mt8viqg0m4@lists.infradead.org
X-Gm-Message-State: AOJu0YykyNGWQN1+CKmHAubqd/cxuSvKSxhnrByRa9jOYByTNV8UXVcn
	Bwe2fXGYO6jiCzPwo2KJZ6FKlsK18L2vccu2s0lsIUJ1dbdEfQ7ucvOGSxssuoKK2dtSl22Rm26
	Nzt72zQ==
X-Gm-Gg: AR+sD11xMVj/5pGs4dvZTTLHORSgeJ/fbK2fOgqTvOtv8OBRcl52hbjgwtN2l7jY7zx
	67zzcAnwR3NJl9HgVI9+yTqqf/xp2WFK2YsGLGu5hiUSGKGNyRBQnfzuhuJmy8xilFi3mSItdQg
	6OkDX8NA/y1PvuXBbeO9uGjzjP9jdI6A5YqsKSn0uOzYd0l40awJPurMjFYWC3QZRYLCMJIeBuK
	Q9Msds8i3OMDo3WbqWv1Kx2oAVszpmOsHmsHdt3BemHj3PwoLPiUFqxbk68Fik/jfRr0DXalA+p
	gB7tHBdFY9B2jogk0HhViYKkUBesVHDFNNvzQbRVN5+AzNJshcGCjD61Hz75NORiG16o0VYDNgN
	U3CDLUZbeiewU4o6JWV18t7sX0NMmV0PnNabxf31Rse64AFgnfyg5vMNBgBmzpZGR9hnzNqpg56
	GDSqg4FlGuHzkDWEJGqLrXjHkcMd//iYiOvXa4OEj+Tjn1cX0geaEpEbG0JEtSA3IdOQKLni/nj
	of1FxdOoYWq8iCMO/QaKW8LxUyGxfpM0zHecvrcUg==
X-Received: by 2002:a05:600c:6a07:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-49573c8d700mr36854855e9.8.1784839390786;
        Thu, 23 Jul 2026 13:43:10 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:10 -0700 (PDT)
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
Subject: [PATCH v5 08/10] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
Date: Thu, 23 Jul 2026 22:42:04 +0200
Message-ID: <20260723204206.76930-9-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134312_419633_45072303 
X-CRM114-Status: GOOD (  16.49  )
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

A read that fails with BLK_STS_P2PDMA cannot succeed against that
member, so mark the leg IO_BLOCKED and let the retry redirect elsewhere.
Skip the read-error machinery: there is nothing on the medium to fix,
fix_read_error()'s probe reads into host pages and would "succeed", and
charging the read-error budget would evict a healthy member under a P2P
read workload.  FailFast eviction is skipped for the same reason -- the
request never reached the wire.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 4 +++-
 drivers/md/raid10.c | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 83ebf40237d5..16a47568679f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2657,6 +2657,8 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	/* evaluate before the bio_put() below */
+	blk_status_t status = bio->bi_status;
 	struct mddev *mddev = conf->mddev;
 	sector_t sector;
 
@@ -2674,7 +2676,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	 * read error.  This is all done synchronously while the array is
 	 * frozen.
 	 */
-	if (mddev->ro) {
+	if (mddev->ro || status == BLK_STS_P2PDMA) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	} else if (test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 77c7d8a59916..462f622556ed 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2847,7 +2847,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int slot = r10_bio->read_slot;
-	struct bio *bio;
+	struct bio *bio = r10_bio->devs[slot].bio;
+	/* evaluate before the bio_put() below */
+	blk_status_t status = bio->bi_status;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 
@@ -2859,11 +2861,10 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 	 * This is all done synchronously while the array is
 	 * frozen.
 	 */
-	bio = r10_bio->devs[slot].bio;
 	bio_put(bio);
 	r10_bio->devs[slot].bio = NULL;
 
-	if (mddev->ro)
+	if (mddev->ro || status == BLK_STS_P2PDMA)
 		r10_bio->devs[slot].bio = IO_BLOCKED;
 	else if (!test_bit(FailFast, &rdev->flags)) {
 		freeze_array(conf, 1);
-- 
2.52.0


