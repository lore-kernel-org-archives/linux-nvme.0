Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBB8C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E47E206EB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GhdDfkiZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k2qZddWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E47E206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FhRaRWmZYn548n6jSChVuddnuF2a6y1AonE446OATCs=; b=GhdDfkiZNCt0RZCG+QgehSSdQ
	wK1emTg/rgOgSwue9reWW//YSB4wknlBGHP1FSWSBhBlOpAAIJVv4fUf/1PyWh4uDEtWqFT9e+qIJ
	s5jnnseaGw9EAPecXpXHoubDi+HOo7+aSB7jZVWpfnxBgX9uiGXBhSVTdIRm8bRV79i1R1nts/Mxe
	JbUdE3tvewikV3A+UxYzQOdith1V+lxrHfABJCjZrU3h8wuEDBwn6NCi/O4nQVfWUsbuRO7/pP8/O
	JE4HknAE5EY6lGIm469XMy4YPrKB6LWtEyX2fCcYh5dXmk54UGOVoxE6LqnAma5GoSY13wZ4Lk502
	pkXMFfJ8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fv-0002bq-DR; Tue, 01 Sep 2020 15:58:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fc-0002Oi-GR
 for linux-nvme@merlin.infradead.org; Tue, 01 Sep 2020 15:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=nRA6JK+4aMp60Yu0KbqG4/pNdu09ibxhHSJ5/A99bDI=; b=k2qZddWw1U3EZJUTGVu0rHSLJs
 W5NgwgDkMU4Tctn8sp6QDS8uXrMAVU8TzWoAL6ToIpC7KJoKBS+hR10VJaRx7HUlCrn23sdr2GXXV
 PivvROx3tTElb1yMRSSSuseDaTpRWJpVWM5KD/wTw/IT+YTPLspEFsL9wpeIKfruOS68OSavOcO3b
 eKoyZN9jt6fhjHPyiO1n+Ltd23usEmrStZ0nhKSCgpp0vMkbLWmtuxBHj1SB6Hdbonp7qcS/5sHw1
 h6xT9GKSHXVkxt4Y/hHRE/O0vpV4ONoMUaFGKU12gPJqvqq6SOLh88NGCQe1kbJ3s68Vas9hCHfw2
 AZ8ApNWw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fa-0004R3-Ip; Tue, 01 Sep 2020 15:58:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] sd: open code revalidate_disk
Date: Tue,  1 Sep 2020 17:57:46 +0200
Message-Id: <20200901155748.2884-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
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
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of calling revalidate_disk just do the work directly by
calling sd_revalidate_disk, and revalidate_disk_size where needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 95018e650f2d0c..2bec8cd526164d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -217,7 +217,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 			sd_print_sense_hdr(sdkp, &sshdr);
 		return -EINVAL;
 	}
-	revalidate_disk(sdkp->disk);
+	sd_revalidate_disk(sdkp->disk);
 	return count;
 }
 
@@ -1706,8 +1706,10 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 static void sd_rescan(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	int ret;
 
-	revalidate_disk(sdkp->disk);
+	ret = sd_revalidate_disk(sdkp->disk);
+	revalidate_disk_size(sdkp->disk, ret == 0);
 }
 
 static int sd_ioctl(struct block_device *bdev, fmode_t mode,
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
