Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADF0C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2eTtoG0DlrlgjjFJI5g26IKsQduZFwoWgq2U+FbKbnk=; b=n3Vvg2iw8Q2x8QxQhpto4WgNBe
	x5vf11E82O1dea5hog4PCCHktKu4ddZVr8yOezF9q6RH0eOEOTPQoQ0oAfeSRGWqLdgPAF4De9c+e
	ho0R+NzRoZjMAojAvSgzxYq5afPmDehhqcS0ZECMU02PYaKXF5+hzM6rRzE3sPmmKfTtHUNBqM27Z
	No4h6PaWYO9FwY+TKwvhvrdaqT+rjBOJW4Tm9dyaIsdKUmyzDoYxdlwh1WomFxaoNkkCDFHhZtdNU
	PR9IItExTPQriOQWph4ZXKI0oaYZPyCNXAhNQ/Rk9I2ZG+Ah+3Bd583qD4WDQavVDiaP3ZwxzFNIB
	c+ExTweQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oko5a-007Q6c-2o; Tue, 18 Oct 2022 15:01:06 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oko5V-007Q4t-Fw; Tue, 18 Oct 2022 15:01:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	linux@roeck-us.net
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH, RFC] nvme: add Guenther as nvme-hwmon maintainer
Date: Tue, 18 Oct 2022 17:00:56 +0200
Message-Id: <20221018150056.681478-1-hch@lst.de>
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

Given that non of the overall NVMe maintainers knows this code very
deeply it probably makes sense to add Guenther as an additional
MAINTAINER for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Guenther, does this work for you?  I think it's better for everyone
if you are Cc'ed on any patches and bug reports for this code.

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12984711f2fe3..fde92782fbbdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14640,6 +14640,12 @@ F:	drivers/nvme/target/auth.c
 F:	drivers/nvme/target/fabrics-cmd-auth.c
 F:	include/linux/nvme-auth.h
 
+NVM EXPRESS HARDWARE MONITORING SUPPORT
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	linux-nvme@lists.infradead.org
+S:	Supported
+F:	drivers/nvme/host/hwmon.c
+
 NVM EXPRESS FC TRANSPORT DRIVERS
 M:	James Smart <james.smart@broadcom.com>
 L:	linux-nvme@lists.infradead.org
-- 
2.30.2


