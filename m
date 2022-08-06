Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FFAC25B06
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Aug 2022 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wXG+Z7ExJqnbUstr0EuFLBmtrpoZThjx4LP/TS3YJKM=; b=SgUPn5vyKGRE/wxFISa4AxLHSq
	PbK6HkASHB9Z8j7HnBaD0phDpuHMQUBvxw26i7xspECLJhJMTSwkFtmNDvj7pxt0WCx2FnL77I/nC
	sTQsY2JrjIoBOj7EO4Y1JHOneNVwifGzbwatlEexSd/VmSaCgQdUOYpYHP/mr5tYKNNEzPPviKcx9
	zmw0bqqSmMP++pxHFppv1Ui38F9Lo6yiYz6hh1QkwTDtUCUeeh/LxonCXXhoS29lDKv5epgVI+k59
	TbKWjlt7LS9WLhlo7C4gAqLO+6xCOzfO9/1mND+Zm0XI5dVgQe/EuSAn4mFbYRpIhd1oafZeD0KQ6
	SepP73+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKFEY-006XxQ-CH; Sat, 06 Aug 2022 08:32:34 +0000
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKFEV-006Xw1-Tq; Sat, 06 Aug 2022 08:32:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: "Ewan D . Milne" <emilne@redhat.com>,
	James Smart <jsmart2021@gmail.com>,
	Muneendra Kumar M <muneendra.kumar@broadcom.com>
Subject: [PATCH] nvme-fc: fix the fc_appid_store return value
Date: Sat,  6 Aug 2022 10:32:28 +0200
Message-Id: <20220806083228.3826126-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

"nvme-fc: fold t fc_update_appid into fc_appid_store" accidentally
changed the userspace interface for the appid attribute, because the code
that decrements "count" to remove a trailing '\n' in the parsing results
in the decremented value being incorrectly be returned from the sysfs
write.  Fix this by keeping an orig_count variable for the full length
of the write.

Fixes: c814153c83a8 ("nvme-fc: fold t fc_update_appid into fc_appid_store")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Tested-by:  Muneendra Kumar M <muneendra.kumar@broadcom.com>
---
 drivers/nvme/host/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8d14df8eeab84..127abaf9ba5d6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3880,6 +3880,7 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
 static ssize_t fc_appid_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
+	size_t orig_count = count;
 	u64 cgrp_id;
 	int appid_len = 0;
 	int cgrpid_len = 0;
@@ -3904,7 +3905,7 @@ static ssize_t fc_appid_store(struct device *dev,
 	ret = blkcg_set_fc_appid(app_id, cgrp_id, sizeof(app_id));
 	if (ret < 0)
 		return ret;
-	return count;
+	return orig_count;
 }
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 #endif /* CONFIG_BLK_CGROUP_FC_APPID */
-- 
2.30.2


