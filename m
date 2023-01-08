Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04607C53210
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gdHpfeKuBPRsfRKHWoFYohwc2QWqeXqQxN7IjEZ6D2o=; b=KW8tCli9HehLmfDDQQlfDaTCDr
	BHIgvwLoylFDVVni9UzMSu8ItrHVkNHjFXgl4i2WLZPkK795GH+ZcOIUQdwyYZxGcfQ7ovIdaybGY
	TKPAkQJJVkBjL80c8WIA99O5fIww9tn89TA63ePZBdY0G8ln6zU9HFdoBdq77k6bq7c5gc0hKomdL
	cIWXFnCPRPBJxeyVdkUc9XST7ObPTLt5TyBCeuSlwcCp8Fgcrz3Fd65fXVb3scYWqiw/8rcEC3Ukq
	Lje7BEoTyM4OVIoa12CMQ9tyZVDHHNzqfZ7rD8rQaR0e9K/MxBnpo0BBvsamXpSl2ldFVSd3givCl
	XFWlIvtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsd-00EQA6-8m; Sun, 08 Jan 2023 16:50:43 +0000
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsY-00EQ7N-SA; Sun, 08 Jan 2023 16:50:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: remove __nvme_ioctl
Date: Sun,  8 Jan 2023 17:50:31 +0100
Message-Id: <20230108165033.380842-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230108165033.380842-1-hch@lst.de>
References: <20230108165033.380842-1-hch@lst.de>
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

Open code __nvme_ioctl in the two callers to make future changes that
pass down additional paramters in the ioctl path easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a8639919237e6a..c12b7c445fc0b2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -695,28 +695,26 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	}
 }
 
-static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *arg,
-			fmode_t mode)
-{
-	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, arg, mode);
-	return nvme_ns_ioctl(ns, cmd, arg, mode);
-}
-
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *)arg;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg, mode);
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
+	return nvme_ns_ioctl(ns, cmd, argp, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
+	void __user *argp = (void __user *)arg;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg, file->f_mode);
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, file->f_mode);
+	return nvme_ns_ioctl(ns, cmd, argp, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
-- 
2.35.1


