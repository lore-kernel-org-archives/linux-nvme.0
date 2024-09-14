Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8A4C02192
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Sep 2024 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSPHWPA/ps66XTBPir0rQQadOBt0Bkqv2g8tE8UBoyc=; b=G6cw9zKIpIh8V7A+CvxvUp4c8a
	a6xPnMzyah0tzu9e3/ff7eaALDnpWXxtjUja0YSurPtziYQ4fIRW134PiSFibWtLeeAO2wX/oy1Fh
	pL8YoqrWvfUs8zjM2tFsKX5jebBtRvcq5k4zYX02qKaPPydEaTT4AmoexNaAR1FD43mQxg5qpTnZk
	ezgg5enHwSgCP4VPfzfNTqouxCimKi/Uk5GwQcRPFQ/NE7/7zWHtWi8INw5cwkh/2lKWP6T0Agv5S
	2BRc2W+U66ZocwHVy4Zn0StXyGhmvu3Ntm6PK9kr/5C8PdZ2Q3iAEvYvKZivX4xrjI8roqxA11xnC
	McFbkzvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spRT7-00000000e3J-3LSF;
	Sat, 14 Sep 2024 12:01:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spRT4-00000000e2B-3XVg
	for linux-nvme@lists.infradead.org;
	Sat, 14 Sep 2024 12:01:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 96C3C5C036A;
	Sat, 14 Sep 2024 12:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B691BC4CEC4;
	Sat, 14 Sep 2024 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726315293;
	bh=9F6tB9anhVr8Y2ZszY372kJY/LDrb2SgC3CWuZlDnuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyszHP6rm1JYud+xVGPkOuk3rgB3AKCREOXeuR9xnFgDXokKeFQnFz1vaPkRW4WbG
	 OZvR5Wna2S9AAN/nTcU5O1wFxoANhooBowM6EH87WrAfBJzwROWAkhzsHqjjIqh1w2
	 eWGwirLBKuAgzucHt4FnZaMuLpzgQetHvWxmBn0SvwMdSU003rhS34CNblhPahnnGp
	 a7IXhGbXjqx6E34rgJ87GpPgB6WWXtl1t8NmlkygTQqSf5jeBFRmkNAkUCmLgajsPk
	 jzSIyWEwY3V92KLCgsRLDvpmXnn3OdPZJ4FJQH78uzYBu+brPEQWMi42twa6opqKIo
	 5y9Zb85wQ1+kA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-multipath: system fails to create generic nvme device
Date: Sat, 14 Sep 2024 14:01:22 +0200
Message-Id: <20240914120123.125967-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240914120123.125967-1-hare@kernel.org>
References: <20240914120123.125967-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_050134_949329_6BD232FB 
X-CRM114-Status: GOOD (  12.89  )
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

NVME_NSHEAD_DISK_LIVE is a flag for struct nvme_ns_head, not nvme_ns.
The current code has a typo causing NVME_NSHEAD_DISK_LIVE never to
be cleared once device_add_disk_fails, causing the system never to
create the 'generic' character device. Even several rescan attempts
will change the situation and the system has to be rebooted to fix
the issue.

Fixes: 11384580e332 ("nvme-multipath: add error handling support for add_disk()")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..c9d23b1b8efc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,7 +646,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-- 
2.35.3


