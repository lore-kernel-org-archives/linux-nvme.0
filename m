Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D23C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZtCiF4iXmnYtH6hzqS3DcL/WUENPjnP4HFOiueRvPxM=; b=GN5QrJy4meobgmA3w3yRaoFozl
	UoJqwfkRy0Mm7sfMkbvXao1tx919FjREw4pWmXl/R5dRk4001JAcw4+ZP6UyYNDHJqO7/7ZFQ9BDe
	F26QGmE4l8EGKgVYUQtFFilak6RsjAL5D05SwWwHn527HSD4BE2xDVGW7eVedopGjA8s70aVqIBKy
	WmI2SOD8pvV7AquWOr/XcT94FiQ+WvFdNrIeF4JXfsVEHeWOs6mJyOCDzuTp3aAHUPFsMWPbDKYO4
	uF6HWb6zXJyWFkTknBqHrNVzptwywqRIXKvNyfkmCbbKoV7tN7gP1rc18KZOoeB+t13mWDAFgqlx/
	MoIqWB/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFqr8-004coa-PW; Mon, 25 Jul 2022 05:42:14 +0000
Received: from hotelhilton-1.munich-airport.com ([91.228.175.36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFqr6-004ciZ-8Y; Mon, 25 Jul 2022 05:42:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] nvme: update maintaines for the new auth code
Date: Mon, 25 Jul 2022 07:42:06 +0200
Message-Id: <20220725054206.2558965-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220725054206.2558965-1-hch@lst.de>
References: <20220725054206.2558965-1-hch@lst.de>
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

Add the common subdirectory and match all nvme* headers in
include/linux/.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c2f899a6dcc4..f0dddf38c54f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14322,7 +14322,8 @@ S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git://git.infradead.org/nvme.git
 F:	drivers/nvme/host/
-F:	include/linux/nvme.h
+F:	drivers/nvme/common/
+F:	include/linux/nvme*
 F:	include/uapi/linux/nvme_ioctl.h
 
 NVM EXPRESS FC TRANSPORT DRIVERS
-- 
2.30.2


