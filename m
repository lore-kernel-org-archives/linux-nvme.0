Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507E5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 May 2022 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/nlwTLBJIM9hBv0blr4/tLURLjeR1v4omoRmKBXmnFA=; b=OgyxwlmLKVhZdXfjjSN6zJSIrn
	wD00O0xaL2qiaOUOQfBVA7cdF9TXQwKrX4k56haUnirFwSIdIGgDXeVRWgXZJKKsXJ9qyRi4aHGnH
	UvHrYa/TgAXXPjB+0u89Mb46s+0iWx18+mUJ97BS5YZNM1SIdBbKgy6Nh7P6KlkEI17RdmhclBIiI
	uwCtAjqGzzVdFnQn9Rd5P7o2NlD1Rs4eLsWRqpWA0x3ozaP6OGP8Be0lkiT3wqMS9OBnoEpj4SGI2
	/dtfZ/ltx3uVeLkdzpeoYggTs85XOsUv1WHGJJm5KLRTxSMhzF/oDsYjV/xBQG1JniOdDod8+yJ1W
	f6UJG79g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuDzj-00F57L-5V; Thu, 26 May 2022 13:57:43 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuDzf-00F56a-FP
	for linux-nvme@lists.infradead.org; Thu, 26 May 2022 13:57:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653573459; x=1685109459;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mk64RZRjPV0j1Wb0t+wJMvF/QmFwkbVsa+ItZMu2RqM=;
  b=PzoYsp8bHof4d+DvWhBKZHfkH5F+jcfqxYrRUiEFVj4aXak2elqBy9zx
   7yDGJAm1wNcPVnu7SvMO0Bz/qt69NDerWTzQJfqid8DDXVtSvAmRQBJRS
   nh0Iw8DFT4gnN/FtnLSRLLx6Um4AcDyc8JcTkAxBl5W39aMzOwiE4azIe
   A0UYBMYrSO8tniid+/XuT8lh2ucYXMzV3uy4uPuqGnESVkRoJknzD/x8O
   YgySZvEcGxbjkRetsL182GEQLzmeFz7lNnRfwekxf05b86B3fla6L8GaS
   01jgopIMHUTyH0EfnFK0KRjxpaKCs4nqYBlAYSS2rXic5oO4AtVNyOD0K
   g==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="200288805"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 21:57:32 +0800
IronPort-SDR: 5a2qd+94F4lOl+WdJ0ZBiNsx6y3xGS4YRkYKfj+swNlWBCPnAyZAfzMxh8TFdr6kMsT8NZFG19
 22YsTeCEjw/QnDEEfGWdEtYnCBpKb2XPhAa2FvdyeBhwZMR97sVO+KIXuhvuJlkuK9MtVJU45Y
 Dx0H8vSDJdkr6uPEN5EsRch+wuX5E5cUT1vCYG9vzjMONvaThtubuQ2g3Efy1bBRc+lxs3GEyj
 UAyxvIyB2TzFBI5wFknckVdww4lBcvZS7t/Y0MPfWz9jOSlcLph3R7odBj+dv793d3zxTTwFHo
 QkLuEqjKthvf9KWQiLGbTb2y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 06:21:27 -0700
IronPort-SDR: HKZvBXVn05GWOTsJ4IOKw5d0G2y0LpjPBFPjviixBxrfaHMXZLKiSbBwqm+NFPrRogXN2As7of
 gcElD10lMT3G3RMg3p48tgTNhyCHbc1hP1DMYmGQ5jAsuCC7WT8Syx435hhQyGwGTwVeYFQk3I
 LFm6G5wdxUBN+kzpMp+IbHzt+8p2Q6afn6QCSy7UquD0LNUwSl4Ol0DtLEzAIQg7z9jYVVi6tt
 qUUpX4ffPd0grPm5cUL7ytI9bI9b0QQyWTcbiXc0B//tUxEqIgEpT1yJQMfbyXyJK9+3oBPnVY
 65Q=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.7])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 May 2022 06:57:31 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: set controller enable bit in a separate write
Date: Thu, 26 May 2022 15:57:21 +0200
Message-Id: <20220526135721.390434-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220526_065739_674655_411856EF 
X-CRM114-Status: GOOD (  14.92  )
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

The NVM Express Base Specification 2.0 specifies in the description
of the CC – Controller Configuration register:
"Host software shall set the Arbitration Mechanism Selected (CC.AMS),
the Memory Page Size (CC.MPS), and the I/O Command Set Selected (CC.CSS)
to valid values prior to enabling the controller by setting CC.EN to ‘1’.

While we haven't seen any controller misbehaving while setting all bits
in a single write, let's do it in the order that it is written in the
spec, as there could potentially be controllers that are implemented to
rely on the configuration bits being set before enabling the controller.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72f7c955c707..a4b108a720aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2227,6 +2227,16 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	if (ret)
+		return ret;
+
+	/* Flush write to device (required if transport is PCI) */
+	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CC, &ctrl->ctrl_config);
+	if (ret)
+		return ret;
+
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-- 
2.36.1


