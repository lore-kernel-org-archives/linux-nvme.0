Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB02C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD62206DB
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vmK3fhFA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ioIyko0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD62206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Z4YQCO74ACn6wOTgMZsQe4x1Kb/SbPOaFfU02/tm/0=; b=vmK3fhFA3zaVhkoPb0Z5QhYhJ
	TqCxwFkQ7Z4p9coXVEBgAGu5l2p3PsSTfteQtlcLZIWNGwAdFaHPszQ4UmkcP8yS71bz+Oejy8VBO
	tMY5ByCwQN7O+8rQDEn7Q/j0Rk50U/O3UEvPb0w+JBS/9qNW7ETv9Tw0tz2b2yqPeuNw/KbLmQjHo
	/DcN6HRO7Hlsm1ciRZnBoijsONf1rV5HJ7/rPInNPVvzb93OXY3Ht7JNHgMK6g4joMttBrqzr+bUT
	CFI0ke8XxutS664BC1QHSngI9RmiJxaKWHDhcoQ2z7P+eUh5ylzQTC72O1ZZq/uH5zJjvZctN1iMe
	xvedizhvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIiSC-00073n-HT; Thu, 17 Sep 2020 01:11:16 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIiSA-00072h-2V
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 01:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600305074; x=1631841074;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m59R+ke5fNYPuJL22qqIZ9ZT8UvQ9geHe0r+mKptpng=;
 b=ioIyko0Wq93mSr9e8CY07TJMCpyrre6arTXO+UMnrYvBMgSWLg83wCXP
 yIVWEhkLiU+YHsu7IxGjs61M12eW+5NLYV83GhjPlXizhax1BQr/NmupV
 7rWTvdaS9H3eIiI7nHlReB/WEXrV5j3TX5JQfLIkJxj6VRW35SUqjKUzK
 Ts5mwqkLPK+nXMLg9aOkQPvOr4iPEyRD2YRGhPHqJ7cR3r/n9wq8u8PVY
 0Wlbm31/b3fHT0Ek7iL8rDDiKHHaXEsodpJ5XXuPnXAkT/wozIfsV2TR0
 XkojP0GtgiSjGNBKN5lS8VXrXBE9Yk+HWn+q0pGnUZV6iQpEBif6xYEBr w==;
IronPort-SDR: lPLtajFfld1MIfqS54v/DOQfwhh54gK1kKirXfA4kBsvjHBajUZCK/mbAS5H1vEqdTZAhu2CWl
 Ihs6dmcFlGBuWecG8InFfXvZQsXa7kFAxv27URPqxco4wkMKX4h/xhZCQ1awFq82y0tVGXwCM7
 A0A8g0ja2N33J19tXemL1AXhVtPp58ozJSYtd6f3BSsB/NraQgSaj+IiWHPcWgQKQLI2YLNTrI
 bodBOOSpNXLR8R3QiHcDkZUtxXbbJaFRUPH5hWtHNW1ewbxDFJ/stn3zZMIr1wcT+3NhAZe0Ha
 /e8=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="257236098"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 09:11:13 +0800
IronPort-SDR: xaGV0INA05eCPzSvuxrpW7UUBtDDqmlwHsZgC10ol46PHEFQIr5HFHDyZ/0jcNSJlFOr+cZ7TM
 9kT5LflYfs6w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 17:58:22 -0700
IronPort-SDR: vQPGWQFBREVGMAD84UXpdhPfXzdpd3Ix+zQMRd2sf0rlL8CQb7m35hig/EYv9bWTiAPYC2sAVn
 rSAhpJ9WqWoA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2020 18:11:14 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/3] nvme-core: get/put ctrl in nvme_dev_open/release()
Date: Wed, 16 Sep 2020 18:11:00 -0700
Message-Id: <20200917011102.14819-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
References: <20200917011102.14819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_211114_336221_70AD1325 
X-CRM114-Status: GOOD (  12.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Get and put the reference to the ctrl in the nvme_dev_open() and
nvme_dev_release() before and after module get/put for ctrl in char
device file operations.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5f9d64b2bec..c013eb52fdc8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3261,6 +3261,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 		return -EWOULDBLOCK;
 	}
 
+	nvme_get_ctrl(ctrl);
 	if (!try_module_get(ctrl->ops->module))
 		return -EINVAL;
 
@@ -3274,6 +3275,7 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
 	module_put(ctrl->ops->module);
+	nvme_put_ctrl(ctrl);
 	return 0;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
