Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED564C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKcyvM4r/2P84aZxmwMfKhF19qmlYUHCRYKugbswj8M=; b=4qskUemSwY3iB+Zs4GzpTmNrpO
	8keEA3oTN2/M7seP7FGXGz4HDl5gqk4fVIqwii0ZVg7BMTewdRv+u9MqyR23bUxm0UlsRBF8MStsl
	AqOYNlnHDf5z5ei7OZhRRurWfTcQhb6j/JLkub31eSiIffNoniBtcUJCWviHhJcf/ED6wlVUtuO/4
	jnACu3HHCvhoktCbzrNwg+qRc3DM2d9ESg64j9xBnD6aA76Lhmt4/7D8LbkRXtEes3nfzF9/BcrfC
	QHdbLOwLTrXLvt8cbF/svCqhgyYEzX1zTUp4lr6LJt578N6bpQvhuDQs0nbqAQ9b+9+tCloqoPicu
	5xkJAIWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8b-0000000Fn6b-1w5c;
	Thu, 13 Jun 2024 08:48:53 +0000
Received: from 2a02-8389-2341-5b80-034b-6bc2-b258-c831.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:34b:6bc2:b258:c831] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8Z-0000000Fn3n-0mAX;
	Thu, 13 Jun 2024 08:48:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 03/12] md/raid1: don't free conf on raid0_run failure
Date: Thu, 13 Jun 2024 10:48:13 +0200
Message-ID: <20240613084839.1044015-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The core md code calls the ->free method which already frees conf.

Fixes: 07f1a6850c5d ("md/raid1: fail run raid1 array when active disk less than one")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid1.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7b8a71ca66dde0..1f321826ef02ba 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3204,7 +3204,6 @@ static int raid1_set_limits(struct mddev *mddev)
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
-static void raid1_free(struct mddev *mddev, void *priv);
 static int raid1_run(struct mddev *mddev)
 {
 	struct r1conf *conf;
@@ -3238,7 +3237,7 @@ static int raid1_run(struct mddev *mddev)
 	if (!mddev_is_dm(mddev)) {
 		ret = raid1_set_limits(mddev);
 		if (ret)
-			goto abort;
+			return ret;
 	}
 
 	mddev->degraded = 0;
@@ -3252,8 +3251,7 @@ static int raid1_run(struct mddev *mddev)
 	 */
 	if (conf->raid_disks - mddev->degraded < 1) {
 		md_unregister_thread(mddev, &conf->thread);
-		ret = -EINVAL;
-		goto abort;
+		return -EINVAL;
 	}
 
 	if (conf->raid_disks - mddev->degraded == 1)
@@ -3277,14 +3275,8 @@ static int raid1_run(struct mddev *mddev)
 	md_set_array_sectors(mddev, raid1_size(mddev, 0, 0));
 
 	ret = md_integrity_register(mddev);
-	if (ret) {
+	if (ret)
 		md_unregister_thread(mddev, &mddev->thread);
-		goto abort;
-	}
-	return 0;
-
-abort:
-	raid1_free(mddev, conf);
 	return ret;
 }
 
-- 
2.43.0


