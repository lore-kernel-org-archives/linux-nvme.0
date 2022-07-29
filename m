Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20C8C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BIH70xRZZ1TM6Aszd0TH8RU+FWuSRyEC20i8C8+7ayM=; b=MDsPuoEtwgpigwiMc0JPVYXcjv
	oSu3UMqIXiDj7A4D92ogFmvTJTz1YB4hJAtFjpAx5pJDXxGhBfcIXsIlYuPBByWl0jtcik9dQd6gj
	WiRjf3irGxAWf5oNfRLrMUmUGyHgbVTSz+Ca1xE6AYr2SGaqYrMpQYCY+tnsRh1Y0RgVhEcPjBu7I
	z4FuwiNBf95zmJdrwMzmfuWbHOoKYiwS24X0f0e8kJNkp8YvxVBw1qGld4FNzd0MdY2uZ/qtu6LMj
	lqpc07NZSpylzjYq6LB7CjQkXkLKasXArL1RUIswAUxs1hpzU28eQQjg3lf+M2c+ZqSNvxkrj5MN7
	XeMmWKbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHH4Q-000KGa-2q; Fri, 29 Jul 2022 03:53:50 +0000
Received: from out199-4.us.a.mail.aliyun.com ([47.90.199.4])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHH3u-000Js3-A9
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 03:53:20 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKjh8af_1659066785;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VKjh8af_1659066785)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 11:53:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3] nvmet: avoid unnecessary flush bio
Date: Fri, 29 Jul 2022 11:53:05 +0800
Message-Id: <1659066785-88807-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_205318_654808_0EE91AF9 
X-CRM114-Status: GOOD (  10.82  )
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

For no volatile write cache block device backend, sending flush bio is 
unnecessary, avoid to do that.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Changes on v3:
- Remove file backend change.

Changes on v2:
- Use bdev_write_cache instead of open code.
- Use NVME_SC_SUCCESS instead of translation, and remove "else".

Test log:
- Add printk log at new if branch.
- Use nvme_loop to emulate nvme device.
- Use tcm_loop and tcmu to emulate no volatile write cache block backend
  by setting emulate_write_cache=0.
- Send "nvme flush /dev/nvme0n1", there is a log print, and cmd return success.
- Send "nvme set-feature /dev/nvme0n1 --namespace-id=1 --feature-id=0x84 --value=1",
  there is a log print, and cmd return success.
- Format nvme0n1 to ext4 filesystem, then create a file, write data and save, there
  is a log print, and no error. 

 drivers/nvme/target/io-cmd-bdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2dc1c10..8d527a8 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -334,6 +334,11 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
 
+	if (!bdev_write_cache(req->ns->bdev)) {
+		nvmet_req_complete(req, NVME_SC_SUCCESS);
+		return;
+	}
+
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
@@ -347,6 +352,9 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
+	if (!bdev_write_cache(req->ns->bdev))
+		return 0;
+
 	if (blkdev_issue_flush(req->ns->bdev))
 		return NVME_SC_INTERNAL | NVME_SC_DNR;
 	return 0;
-- 
1.8.3.1


