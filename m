Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283EBC43217
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQ4ESgW0h9CMQrcwqxrNIrPn85MSIrk1H7//P0ImuCw=; b=3rkFJXwBsXKj/9QDzIyajAX6L0
	xTyrobU0SeszqOJpyR4CGPdjfmosCtNF3gBFd/5KIck55yARSVTLZDWoszz62hLp8NQ7GsGBTqYxp
	dJG0J2fDNqbqI8gYHjeVxa0BunB581lbWTYsCw730Krbpaw8t0DookjP3Ef4wVnUmgBPOzn0Y3FXo
	/uU4hF4/rueeE/xNdTy5dPADyLMU7XNLgsraJDRFE377SokIRw0KT4PiUgq+JX9MFpKuueGx/zRrl
	NxB5JPI78glBPih/c4y+9vkJ0rHhy5liSHYLxSZT32qQFSjEcSX3AR2oi8dK+iPyfVDxmitLcnJZY
	CUIMkCjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wJ-007FGs-4A; Wed, 20 Apr 2022 04:27:39 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wE-007FCk-RA; Wed, 20 Apr 2022 04:27:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 02/15] nvme-fc: don't support the appid attribute without
 CONFIG_BLK_CGROUP_FC_APPID
Date: Wed, 20 Apr 2022 06:27:10 +0200
Message-Id: <20220420042723.1010598-3-hch@lst.de>
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

nvme-fc appid support needs CONFIG_BLK_CGROUP_FC_APPID to work, so disable
the whole code if the option is not set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 080f85f4105f3..caa0fff7bf1f5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3831,6 +3831,9 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 	return count;
 }
 
+static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
+
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
 /* Parse the cgroup id from a buf and return the length of cgrpid */
 static int fc_parse_cgrpid(const char *buf, u64 *id)
 {
@@ -3898,12 +3901,14 @@ static ssize_t fc_appid_store(struct device *dev,
 		return -EINVAL;
 	return count;
 }
-static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
+#endif /* CONFIG_BLK_CGROUP_FC_APPID */
 
 static struct attribute *nvme_fc_attrs[] = {
 	&dev_attr_nvme_discovery.attr,
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
 	&dev_attr_appid_store.attr,
+#endif
 	NULL
 };
 
-- 
2.30.2


