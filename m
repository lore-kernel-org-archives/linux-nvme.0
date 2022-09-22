Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B86C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 06:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e6m2FzZUs6xjKqRNhxINvuKJmTOI0vJdeYboeDwQ0nA=; b=hZ6gxYkvnEib+naAXetYTpSXGF
	NO6+wTB9fwzeFtNLakCyJer7jd1hiDD5mFlJ7WWqB3wDHzn0JGHWOfKqUXfzMRwb1RxSUndDPc1+2
	boMH5wf65Lh732gMb6wwBDbcRv+l+yBCJIHB5eEv74CyxF2OVJkteB0LU/+QPdlSN0cHl+wGHtTCS
	ICL95dWd/iovpaFys4vPCrede7ncIUJbITCc8EJ2jsZrzzy7ku3UXl3ttkwPZcLNab+RYjHPpOZi9
	V4oEzCKf8/392IrNeAqB5aNZN7H/SJsSvPqytuTeGdlWdwGPAIju1Dt0/WO7zPj9hKLGwn0RTCtOC
	pjUO6REQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFn9-00DaIj-56; Thu, 22 Sep 2022 06:34:35 +0000
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFn7-00DaHz-0P; Thu, 22 Sep 2022 06:34:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: hare@suse.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-auth: add a MAINTAINERS entry
Date: Thu, 22 Sep 2022 08:34:29 +0200
Message-Id: <20220922063429.1573089-1-hch@lst.de>
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

Add Hannes as the nvme-auth maintainer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe8..47f27eea29ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14542,6 +14542,15 @@ F:	drivers/nvme/common/
 F:	include/linux/nvme*
 F:	include/uapi/linux/nvme_ioctl.h
 
+NVM EXPRESS FABRICS AUTHENTICATION
+M:	Hannes Reinecke <hare@suse.de>
+L:	linux-nvme@lists.infradead.org
+S:	Supported
+F:	drivers/nvme/host/auth.c
+F:	drivers/nvme/target/auth.c
+F:	drivers/nvme/target/fabrics-cmd-auth.c
+F:	include/linux/nvme-auth.h
+
 NVM EXPRESS FC TRANSPORT DRIVERS
 M:	James Smart <james.smart@broadcom.com>
 L:	linux-nvme@lists.infradead.org
-- 
2.30.2


