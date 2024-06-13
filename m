Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBCBC27C75
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xt/cEzI4CksO34TKlgliy2AxvKCGUtTFve6xzQi8/jQ=; b=OWwGETrUhw4tONo/b/xREEyYuG
	zQCSMf1LPb61GqdEiUU6kVEmDmNmlttOUigY383ckxofZFcQXLpL2pg7C67z32Y6k8S4S1OmUY+2v
	nLoTAwciXVB4dsYeF8Rv3L81J9S0JIC8+r64Bo2UaRQENjqMz8Y33fIS7r222DqMKQaUeM12PSYvd
	VpAztq2t1/0+1c+dChVAkJBJmw0Z6RVA0rn5/cy2sTpf5uNvKbTchT/uGZ66IEvmZUYfUUvixxMQ6
	Yl6hNN5VDxKQxpn2wZB3b7+HskLN32IpjSjq/+v5R9ESFFCKKdwrTp1vD6cvCPTWgqsPxrQ9e2DD6
	AUOVWkPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8Y-0000000Fn43-1ACH;
	Thu, 13 Jun 2024 08:48:50 +0000
Received: from 2a02-8389-2341-5b80-034b-6bc2-b258-c831.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:34b:6bc2:b258:c831] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHg8W-0000000Fn1R-06kc;
	Thu, 13 Jun 2024 08:48:49 +0000
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
Subject: [PATCH 02/12] md/raid0: don't free conf on raid0_run failure
Date: Thu, 13 Jun 2024 10:48:12 +0200
Message-ID: <20240613084839.1044015-3-hch@lst.de>
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

Fixes: 0c031fd37f69 ("md: Move alloc/free acct bioset in to personality")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid0.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index c5d4aeb68404c9..81c01347cd24e6 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -365,18 +365,13 @@ static sector_t raid0_size(struct mddev *mddev, sector_t sectors, int raid_disks
 	return array_sectors;
 }
 
-static void free_conf(struct mddev *mddev, struct r0conf *conf)
-{
-	kfree(conf->strip_zone);
-	kfree(conf->devlist);
-	kfree(conf);
-}
-
 static void raid0_free(struct mddev *mddev, void *priv)
 {
 	struct r0conf *conf = priv;
 
-	free_conf(mddev, conf);
+	kfree(conf->strip_zone);
+	kfree(conf->devlist);
+	kfree(conf);
 }
 
 static int raid0_set_limits(struct mddev *mddev)
@@ -415,7 +410,7 @@ static int raid0_run(struct mddev *mddev)
 	if (!mddev_is_dm(mddev)) {
 		ret = raid0_set_limits(mddev);
 		if (ret)
-			goto out_free_conf;
+			return ret;
 	}
 
 	/* calculate array device size */
@@ -427,13 +422,7 @@ static int raid0_run(struct mddev *mddev)
 
 	dump_zones(mddev);
 
-	ret = md_integrity_register(mddev);
-	if (ret)
-		goto out_free_conf;
-	return 0;
-out_free_conf:
-	free_conf(mddev, conf);
-	return ret;
+	return md_integrity_register(mddev);
 }
 
 /*
-- 
2.43.0


