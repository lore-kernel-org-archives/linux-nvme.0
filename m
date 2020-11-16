Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64455C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:07:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E672122240
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0PCEunJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5dNhGax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E672122240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YGVnU0UUDPXmxL0RGdVunSzJP7lpGBOGGU67GCb369w=; b=B0PCEunJ6qmgrhHlN4NQqeWDn
	Fh+VdbsR6B1mPsj8eWxASn9kh+dplBMA0JwgXyJDjWo+GsYoAKuVscUhfFXTA8hGi3iz6dQ5RwSB0
	uRGgDyrPnw5O5K7TKNnkYU8azNd7DSFwCUB78Eis1Xvz8ojwsPNfoxwccO7HclRyPbfzXNqdkv5Qa
	EFxPO/EEIhT4oUcLBtMcjsjLHMCGLfzy14EdZ0uQ7RXe/0JcXOn/Tmi4wIt+RGpkjbl5kbqnATXB4
	FsMwo9fDtyFT2rTtGL3qpU7rAned4VLdK0o28vTpH+01qTg0PtfkCmf2gFx8lxbGi5ijPnbsJRUeD
	sZl83/JOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg6K-0000yh-R5; Mon, 16 Nov 2020 15:07:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyN-0003m6-Ck
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=K+kkAiIfWzB4syRFt+33j5OXLPH83fZlF9ACMDZkYhg=; b=k5dNhGax8VxlBfuaj9EQBdAXgt
 4072QYhm07kKi1w+W9nEyoMSW3ELii8kjNeM1F9XviJBMC0uEQv6MPhU9nRzHBDI1yZZmWAy9Q0N2
 fTvPwi+VC8nhfIjC7jFXt9leIcNNiMb0XmPx9eg/JoTwye7h/y7KHjVMVYweaBNLQMktbr4A8iWEt
 dOTjTgdEq+CLoKYrid8bVvBdmQLTGWBIgPYXUmyZ/n6rnRuKWj+UuQ5XIshtknCUOMSkMwKUNjD5w
 dJBoojTYMzEvaH9mPATlftM3BLIRcn7GZkGadLtxoUQdZeeK4Y0pHIv111cNROAtxxvV+mZxdO2Kj
 KOai2cDA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyL-0003zc-NO; Mon, 16 Nov 2020 14:59:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 45/78] md: use __register_blkdev to allocate devices on demand
Date: Mon, 16 Nov 2020 15:57:36 +0100
Message-Id: <20201116145809.410558-46-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use the simpler mechanism attached to major_name to allocate a md device
when a currently unregistered minor is accessed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/md.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fa31b71a72a35d..b2edf5e0f965b5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5764,11 +5764,12 @@ static int md_alloc(dev_t dev, char *name)
 	return error;
 }
 
-static struct kobject *md_probe(dev_t dev, int *part, void *data)
+static void md_probe(dev_t dev)
 {
+	if (MAJOR(dev) == MD_MAJOR && MINOR(dev) >= 512)
+		return;
 	if (create_on_open)
 		md_alloc(dev, NULL);
-	return NULL;
 }
 
 static int add_named_array(const char *val, const struct kernel_param *kp)
@@ -6532,7 +6533,7 @@ static void autorun_devices(int part)
 			break;
 		}
 
-		md_probe(dev, NULL, NULL);
+		md_probe(dev);
 		mddev = mddev_find(dev);
 		if (!mddev || !mddev->gendisk) {
 			if (mddev)
@@ -9563,18 +9564,15 @@ static int __init md_init(void)
 	if (!md_rdev_misc_wq)
 		goto err_rdev_misc_wq;
 
-	if ((ret = register_blkdev(MD_MAJOR, "md")) < 0)
+	ret = __register_blkdev(MD_MAJOR, "md", md_probe);
+	if (ret < 0)
 		goto err_md;
 
-	if ((ret = register_blkdev(0, "mdp")) < 0)
+	ret = __register_blkdev(0, "mdp", md_probe);
+	if (ret < 0)
 		goto err_mdp;
 	mdp_major = ret;
 
-	blk_register_region(MKDEV(MD_MAJOR, 0), 512, THIS_MODULE,
-			    md_probe, NULL, NULL);
-	blk_register_region(MKDEV(mdp_major, 0), 1UL<<MINORBITS, THIS_MODULE,
-			    md_probe, NULL, NULL);
-
 	register_reboot_notifier(&md_notifier);
 	raid_table_header = register_sysctl_table(raid_root_table);
 
@@ -9841,9 +9839,6 @@ static __exit void md_exit(void)
 	struct list_head *tmp;
 	int delay = 1;
 
-	blk_unregister_region(MKDEV(MD_MAJOR,0), 512);
-	blk_unregister_region(MKDEV(mdp_major,0), 1U << MINORBITS);
-
 	unregister_blkdev(MD_MAJOR,"md");
 	unregister_blkdev(mdp_major, "mdp");
 	unregister_reboot_notifier(&md_notifier);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
