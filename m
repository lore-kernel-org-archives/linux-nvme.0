Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A83C25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1t+OL994sjnwJbmFId7VEaNNfIJHSGn/jwgDm2jkzck=; b=F43bKhj0WZxsd0fQL8YkuBbVEx
	Zbj1MfuUhtVo8VIlKupQ/zJM9XEqJ0CkgHIX1vJjce8MP7cKrba2MokMgzMTPK0NLSD2oxna8hgnA
	kDngfkh6GrRONSGD0SfuBHszUsKGqxXKYPbUpY8llhpXgd2QT/YiQCiqx39V9zKeOj5gq4FlOZkER
	V5mKh1ZnKhvBtS3HMiD/PO49wfHR8wh/6Qld1aB+hPTOcv0PdiRF8eW78aIPP5foAaOlNnXGV9jFe
	BVntNSyGlFBbNDJjYpenWWYMHrSvuARuLtIXXwRmvx9IZ0hEoaxdkeujNUEL4vNEWsINmueIFJY8E
	HHx2h69A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GU-0000000GmHS-0Ub6;
	Mon, 03 Jun 2024 12:58:18 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GM-0000000GmDn-3d3u
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 12:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717419480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1t+OL994sjnwJbmFId7VEaNNfIJHSGn/jwgDm2jkzck=;
	b=Cx7u9wvNhPzz1jawZy2jmX6vyhWrTU7sTow4A4027neOATr0yg+1hfrhvVBLVQQmP1F59F2fikVTAfcAP0lzfrI1aLsveDsATeqgFUYwh5GZzgWHZSdr/Udagdc5J2+hXCKEqdrvqu3h6g064+sVm56FtbZZKlzVnLynR4Vdmkg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7nmJ8K_1717419477;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7nmJ8K_1717419477)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 20:57:57 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH v2 1/4] nvme: rename nvme_sc_to_pr_err to nvme_status_to_pr_err
Date: Mon,  3 Jun 2024 20:56:59 +0800
Message-ID: <20240603125702.97368-2-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_055811_167546_A5708C7E 
X-CRM114-Status: GOOD (  11.17  )
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

This should better match its semantic.  "sc" is used in the NVMe spec to
specifically refer to the last 8 bits in the status field. We should not
reuse "sc" here.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
---
 drivers/nvme/host/pr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 8fa1ffcdaed4..a6db5edfab03 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -72,12 +72,12 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
 	return nvme_submit_sync_cmd(ns->queue, c, data, data_len);
 }
 
-static int nvme_sc_to_pr_err(int nvme_sc)
+static int nvme_status_to_pr_err(int status)
 {
-	if (nvme_is_path_error(nvme_sc))
+	if (nvme_is_path_error(status))
 		return PR_STS_PATH_FAILED;
 
-	switch (nvme_sc & 0x7ff) {
+	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
@@ -121,7 +121,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	if (ret < 0)
 		return ret;
 
-	return nvme_sc_to_pr_err(ret);
+	return nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
@@ -196,7 +196,7 @@ static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 	if (ret < 0)
 		return ret;
 
-	return nvme_sc_to_pr_err(ret);
+	return nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_read_keys(struct block_device *bdev,
-- 
2.45.1


