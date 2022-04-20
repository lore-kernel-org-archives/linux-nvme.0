Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6D4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/ovE2zEN2kLE1A2FRhhKOcbowUkSDsa75PAEbmLpG0=; b=jrzQ+pYc7WQrkEcKYomWFEni0Z
	9m2i3218wvGlHb1HForXlJvDaLt+9wArEZcQACQy7wTO+DMnBevdNAWbfkOqOGGExM1dbkn/fKmNJ
	X2AqoYYH/wDI+JOOrnV+dCYcHEPkJsb+G6oyfVvnL4crNRI7B4sEUIlZnNR9f2n3eTuG4kIPplWTy
	cewtNlUVsNyz7LG/EYgBH9xT8ga0whVorFEaoFXri9V7YQOEJ1pWj+s3zixp4WZdt1VKeQUxIMto9
	MhbCki+qESprhEVgzIwEH2+yAwsx1EwKQF/D1He3/K+8OX8w0A6IKeVXrQY0a7wTBgzRtjq9mGj9X
	rPo7kQcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wN-007FIz-Bp; Wed, 20 Apr 2022 04:27:43 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wH-007FFj-Jr; Wed, 20 Apr 2022 04:27:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 03/15] nvme-fc: fold t fc_update_appid into fc_appid_store
Date: Wed, 20 Apr 2022 06:27:11 +0200
Message-Id: <20220420042723.1010598-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
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

No need for this wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index caa0fff7bf1f5..7ae72c7a211b9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3857,12 +3857,10 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
 }
 
 /*
- * fc_update_appid: Parse and update the appid in the blkcg associated with
- * cgroupid.
- * @buf: buf contains both cgrpid and appid info
- * @count: size of the buffer
+ * Parse and update the appid in the blkcg associated with the cgroupid.
  */
-static int fc_update_appid(const char *buf, size_t count)
+static ssize_t fc_appid_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	u64 cgrp_id;
 	int appid_len = 0;
@@ -3890,17 +3888,6 @@ static int fc_update_appid(const char *buf, size_t count)
 		return ret;
 	return count;
 }
-
-static ssize_t fc_appid_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	int ret  = 0;
-
-	ret = fc_update_appid(buf, count);
-	if (ret < 0)
-		return -EINVAL;
-	return count;
-}
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 #endif /* CONFIG_BLK_CGROUP_FC_APPID */
 
-- 
2.30.2


