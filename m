Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A120EC4452D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RI/ofRS9U+6ig5kLdN1LCndM4I9pFM5i9E2zRYc1mtk=; b=zLzfBuTbm9/2TRc+w+A0IWiGQT
	vburAdOMk8aAH0xiSVNyaq9j83ZVRPzYaDqeCQaBqa0ALS5fy1KgEr6lrIhtkE4I7Zwe2XTOYk6kf
	jW1x7o5huuzcK3lwqbVUHFwJ7rGmgWSCYRUIGWRbc9VAvNRz7mScUahQIvhB2PRQvtctfVr01i1+S
	1n9syaDYhItbuVSQNIIRr9W3nde8RynhgVp9T2+r1IRLM13e/k6uaNjRrEZIlEmkGxgk4Lu62LGB0
	w1X4gVVsubs+Gf5fe6Nd71pflN5Aqu5owOpbJp0V6oyqV3Rf27+0WBSl/ohCWmm5J6dTslQ3azMpU
	ga8+qrgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXq-0000000A5Xh-0dAG;
	Tue, 21 Jul 2026 17:46:18 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXm-0000000A5RY-09Az
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:16 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47de0093c42so6679269f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655972; x=1785260772; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RI/ofRS9U+6ig5kLdN1LCndM4I9pFM5i9E2zRYc1mtk=;
        b=aFO7SXVTpU7tnltpvbm1pMZek7naV9ufyIy+xWTc/5RDkYgGgKK/rO1z892HkLTnQu
         QeVJhAEIxpQSGLX2B8T7os/JG0MvR65OaXTa4ky1/Wh7CgJVh0mrhBssudalZh9pA/xB
         TmRWnAxtjRVuCXiUzZ7DkY7Yyvtk8p/lhN00GJTYVovROWvxu0jdf68JXIY2A0yNP+Rd
         +lgWs9a9NjI3lZxQqlZerQmRYVvd7BDmhlFwS0XQUao9+3MqhXDb+Tz5oo5cgK1P3/Ia
         zSmjMXQliYoRy04PEtAzC1YYqdHw17AYfInHaNAqN75oVGMfQZNIPbTzzY1ofk0vMtYC
         FCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655972; x=1785260772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RI/ofRS9U+6ig5kLdN1LCndM4I9pFM5i9E2zRYc1mtk=;
        b=QA41JFeokjBr+yQI4zQU03+eJCioV5LqF5i4aZYhK7JpTOYRQ+8j7wxu75Bw13PjGf
         IXOweVEsfLY6ykBE4yqg9bE5BUcLQQu2YxoxyaN4LGTcdCHjm08+JIsr/RlAkDxVLnMX
         VpaCVNcPQtS9kwFYqj7/powJ/3TPt4VIphnQR1bG6u81ItE9ebT7N/DoyJjKyE7XKAGI
         A7SOgA8UY6GV7eq2mD2HpSzauPiB+tpqz0OmlJ8r4up9xM+lPv1mrRfRomasmjYBNyKG
         s36dyY/HGwXsDUezBlbwepZMAKq5jlg0Ur06VhXVeUdD1fFeKUpb3g9kq/iQFriaZ5+R
         3/NA==
X-Forwarded-Encrypted: i=1; AHgh+RrFOBK5vq4UzpPczXcLeaCdbkcV3/dDbvmLj+VCfKVISaXjr2J8BT6EUpr8cU6HJpyi97kDlLRoridt@lists.infradead.org
X-Gm-Message-State: AOJu0YxoOt67gA9VsS/E2AvU1rV7kn6AMVYuFG0nGMWGIi8i5VNRzFgx
	Yw3DrI151K99EsodUqs+SS0oWbRGycekPHBT3CQgkpHOWFZ6vGKBRLtIc0V+NKag7A==
X-Gm-Gg: AR+sD12Qm2vbVJgmtss/axOBjgLFgDDW+9tfqIQV6qp61yQCFCqHpu64z7hdx+I5S8u
	jCRCeZOwMT33z6rXZ/i2QOYzuTyl89U+DcEDWAZ3b6lISkUUkXjEsfT2gf5mrvybYNqNhsK0wYB
	+cZ/HCieApWYj1m5xz3v/fJoD6Y0exRBKR2NH8IjoVf0AjbEex2LV9LEc91YOxBlpm+kAtnC1Ms
	EiB7sEoS+8wyDtv+XdTdfJBFFMgOkVrTYomJhLiFvFm6jPTETRXYYq4k1p7Bjxk33dKeJGRq4Ku
	E0PfCYR4MeyTTOKAR0MxuhCmJcKZ6NpICp/CIymRPu3Cci8vZoyYCbsuQSm5EQZxHbCaSFANB/v
	cO1M9TvMYG13OHUrg1hZ0qqNeec+DdN/Kb3DCpzpqEmworu8OAgN7M+vUNYxDpCYsTTP4GG0LFH
	mxVCi/efEurHzIMEZXreB408eoKWxyQv/KPW1VhFZRmhM9ons=
X-Received: by 2002:a05:6000:41e1:b0:47f:6d9a:d7a6 with SMTP id ffacd0b85a97d-47f6d9ad948mr17562857f8f.25.1784655972302;
        Tue, 21 Jul 2026 10:46:12 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:11 -0700 (PDT)
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
Subject: [PATCH v3 6/8] md/raid1: skip futile retries on P2PDMA mapping failures
Date: Tue, 21 Jul 2026 19:45:00 +0200
Message-ID: <20260721174502.111503-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104614_241940_E70D6AA7 
X-CRM114-Status: GOOD (  21.77  )
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

A member that cannot DMA-map peer memory fails the leg bio with
BLK_STS_TARGET.  The failure is a property of the peer/member
pairing -- retrying the same pages against the same member cannot
succeed, and there is nothing on the medium to repair -- but the
error machinery treats it as a medium error: narrow_write_error()
grinds through hundreds of doomed chunk retries per write,
WantReplacement burns a spare and evicts the healthy member,
fix_read_error()'s host-page probe "succeeds" so mixed host/P2P
reads charge the read-error budget until a healthy member is
kicked (~1s in testing), and FailFast evicts on the first
unroutable I/O.

Flag P2PDMA master bios with a new R1BIO_P2PDMA state bit at
submission.  On a BLK_STS_TARGET leg failure for a flagged bio:
retry writes once as a single whole range, recording one bad range
if that also fails (TARGET can be a transient device condition,
e.g. NVME_SC_NS_NOT_READY, so the retry is not skipped outright);
don't set WantReplacement; mark failed read legs IO_BLOCKED without
charging the read-error budget; and don't treat the failure as
FailFast evidence -- the request never reached the wire -- as
commit f7b24c7b41f2 ("md/raid1,raid10: don't fail devices for
invalid IO errors") did for BLK_STS_INVAL.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 54 ++++++++++++++++++++++++++++++++++------------
 drivers/md/raid1.h |  2 ++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 16b7465c233a..6334032c4bb8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -483,16 +483,22 @@ static void raid1_end_write_request(struct bio *bio)
 	 * 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !ignore_error) {
-		set_bit(WriteErrorSeen,	&rdev->flags);
-		if (!test_and_set_bit(WantReplacement, &rdev->flags))
-			set_bit(MD_RECOVERY_NEEDED, &
-				conf->mddev->recovery);
+		/* Peer/member pairing failure, not member health. */
+		bool p2pdma_unmappable = bio->bi_status == BLK_STS_TARGET &&
+			test_bit(R1BIO_P2PDMA, &r1_bio->state);
 
-		if (test_bit(FailFast, &rdev->flags) &&
-		    (bio->bi_opf & MD_FAILFAST) &&
-		    /* We never try FailFast to WriteMostly devices */
-		    !test_bit(WriteMostly, &rdev->flags)) {
-			md_error(r1_bio->mddev, rdev);
+		set_bit(WriteErrorSeen,	&rdev->flags);
+		if (!p2pdma_unmappable) {
+			if (!test_and_set_bit(WantReplacement, &rdev->flags))
+				set_bit(MD_RECOVERY_NEEDED,
+					&conf->mddev->recovery);
+
+			if (test_bit(FailFast, &rdev->flags) &&
+			    (bio->bi_opf & MD_FAILFAST) &&
+			    /* We never try FailFast to WriteMostly devices */
+			    !test_bit(WriteMostly, &rdev->flags)) {
+				md_error(r1_bio->mddev, rdev);
+			}
 		}
 
 		/*
@@ -1378,6 +1384,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	else
 		init_r1bio(r1_bio, mddev, bio);
 	r1_bio->sectors = max_read_sectors;
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R1BIO_P2PDMA, &r1_bio->state);
 
 	/*
 	 * make_request() can abort the operation when read-ahead is being
@@ -1557,6 +1565,8 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_sectors;
+	if (md_bio_is_p2pdma(bio))
+		set_bit(R1BIO_P2PDMA, &r1_bio->state);
 
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
@@ -2522,7 +2532,7 @@ static void fix_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	}
 }
 
-static void narrow_write_error(struct r1bio *r1_bio, int i)
+static void narrow_write_error(struct r1bio *r1_bio, int i, bool coarse)
 {
 	struct mddev *mddev = r1_bio->mddev;
 	struct r1conf *conf = mddev->private;
@@ -2536,6 +2546,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 	 * It is conceivable that the bio doesn't exactly align with
 	 * blocks.  We must handle this somehow.
 	 *
+	 * With 'coarse', retry the whole range as one bio: P2PDMA
+	 * mapping failures fail every block identically.
+	 *
 	 * We currently own a reference on the rdev.
 	 */
 
@@ -2550,9 +2563,12 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
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
@@ -2633,8 +2649,12 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			bool coarse = r1_bio->bios[m]->bi_status ==
+					BLK_STS_TARGET &&
+				test_bit(R1BIO_P2PDMA, &r1_bio->state);
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
+			narrow_write_error(r1_bio, m, coarse);
 			rdev_dec_pending(conf->mirrors[m].rdev,
 					 conf->mddev);
 		}
@@ -2661,6 +2681,9 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	/* evaluate before the bio_put() below */
+	bool p2pdma_error = bio->bi_status == BLK_STS_TARGET &&
+		test_bit(R1BIO_P2PDMA, &r1_bio->state);
 	struct mddev *mddev = conf->mddev;
 	sector_t sector;
 
@@ -2680,6 +2703,9 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	 */
 	if (mddev->ro) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
+	} else if (p2pdma_error) {
+		/* Peer can't reach this member: just redirect the read. */
+		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	} else if (test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
 	} else {
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index c98d43a7ae99..61b788a99d14 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -184,6 +184,8 @@ enum r1bio_state {
 	R1BIO_MadeGood,
 	R1BIO_WriteError,
 	R1BIO_FailFast,
+/* the master bio carries PCI P2PDMA (peer device memory) pages */
+	R1BIO_P2PDMA,
 };
 
 static inline int sector_to_idx(sector_t sector)
-- 
2.52.0


