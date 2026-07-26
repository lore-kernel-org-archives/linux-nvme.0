Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C08C53200
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=; b=IQMuoJ9POKxRTtKvtbia2KOhV7
	TUOAByXg0tUHPtKdN1jgAnmX5Rqq1o6eru0Ncfg14NVkHgCOT5G0v65koKjZZWeyrnWSfbQ8JXqD9
	9ObPloyT/MiMZCCs6Kl4FE8zhfaCH9MkFXk/pPYzhD7Lqj/NsFOu5Gi5TGdi3m+/tSocsaMuInxVw
	g8rkA4C75nEheaGNIlqAUBFL227OINyVyaqukm74nks9JicZ/dMcRkhNSc/ekubZlnkDRktGEuFq4
	iE0aQdM2+Q9p3WYaaeGaJjtlb9qiGBJqC5P6tRim8tQhoessQSZC1Pf/3ueSq8hmZ0z2d0An2vzqq
	JnTyrJOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6H-0000000176w-0VDd;
	Sun, 26 Jul 2026 11:32:57 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6E-00000001742-1Kyf
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:55 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47f71156e1aso781682f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065573; x=1785670373; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=kCVuMvngAoWbTou07tpgmof8EFiWyyjzfGMi53TeBPwT8KE+qITqw7YzUfq+WaXFVd
         QX3Ms9F7ym2OTWjF2OwzndKjlM6exekyhXimqXKggrrLVLNzz8oyMqskH9eSBa8i6Rv8
         jFmRQTluOb45iLq1xrXwv0Ci/o76Q+Qxj1TmZZzNIBhogT6aljnIuZbmpATTpmnHHBrE
         Nyje/EUglKuQQDHDfZn/2MbeMS9rlLIUVgWWjQ/28jNVf/kUxf2/o93+UTB54zhNv5rv
         2KEeYShE6zFxwLbsjdz3OKIayXsI5Zwphf0BgjKCdDmATMckXuCMnLnE3ZJEySftRBFC
         QcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065573; x=1785670373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=Rb3astNZGA715gtPfF2GMU+9C/QDOo8oIwj4Y81+0+ZF6jf8pzHHBY1t129+VzlAHo
         jQ9sdxP7mn1iBEuSKkWV7UiIUiJKx4c2pHhmjTlHAse95X+WAY/ROzcjHxnPeHI9fFR8
         7EdG7yCZd89Q1+UJySqH0gfFstvalMinH+73SQfZpUapBsB4wgm3vvt2FMJSwkR49Px2
         o26HP/eEnOA34O0HmZ6FcXDyFN6OYZa8LL5w8+m3L1pWyyPncivdQ6qoGdojdHgg2/P7
         uH5WG72GMxhcz5Xcutu+WkbiClIBQ+vlgRWjszfUNj8iuERj7dL56bJiKRH9+OBL/tYZ
         2l0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrWxCuoyN6LkvWfkKK3jInYgkVB2caGZL47GGNEuV4AYYSqe+1QeMU8+rJNyelh/xguFmgtTChcGZtK@lists.infradead.org
X-Gm-Message-State: AOJu0YxVHi279G0RLlB+yKX3RAKN6qaWlsiJTYe+r35ch2fExRFJ0/hj
	DV9Iwh69dKAtjKFkzkea6tjzSKPyKfITbvq9uveBKau/Jgd21KPDansCNn84Fa3Ycg==
X-Gm-Gg: AR+sD13a+UiP4C0OIDxHcX28Hg89tHou+evWHX1bZPoykqZ2RIP/9XTOa9wtZ7yHJXw
	znoXNwO83f2LMWD4R0T0ITnWWcLDcABGxy1Qrs22u3xwQXhpylE9WAbXmE5xbroSHuw8NGzuha9
	CLAZ1sgk6OYY1dpK01Z4ZgnGe2KlZOK2nANLw9xoNNSggwlVpAdhhN8yEajb3WHKPTTPA3eP6DM
	M8Tg28+o0NOj6k58tWIfFSDn0Rt5FNcfCfMJr61zeYoeYKt2imr4MmJN0MzE7xmf5PpOtwcmyIt
	zcTvquKG/56H/RAybxiST/Olf+JLfGpk8v3+kOiFMnXd3kli9Wa0Pfd5DgEsa6agnrZErTbi+j+
	lhcix0n0P9IcfASkZCOLNi6B0y0v2vuaJ8UQTIO/nuGRfNg2dakQSzD5BelKeMAtMw4pw4t3hWO
	qND0nf7E/bXW1AeS1Q3bw2JiyUFYkLl4YOgfocaTU2o98TrB/t35pAP8OMVOb+x2DbBAP46bt0I
	MejzHsHCOxGE/8k0YYsCPzZ50nBcDDtZQVPRiCXzQ==
X-Received: by 2002:a05:6000:40e1:b0:47f:8fb6:c32e with SMTP id ffacd0b85a97d-47f9fea93b1mr5573278f8f.46.1785065572724;
        Sun, 26 Jul 2026 04:32:52 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:52 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 08/12] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
Date: Sun, 26 Jul 2026 13:32:25 +0200
Message-ID: <20260726113229.2154269-9-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043254_373671_ECA30F23 
X-CRM114-Status: GOOD (  16.63  )
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


