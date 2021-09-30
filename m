Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73124C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:15:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC73613CD
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AC73613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TYD5ZtnMA88dww5xM3RBT9p7wWy3jzYQH6lz6ecz5wQ=; b=FmnVkjVHqyiDwa
	rHrfgobHFjzTOFd4sv5PGYQPdd0mdfxB/90wR9WGEsZzaSlgcYQGLziVZ1ErK1vNg20RKMSo1Vem4
	3D16ht7/RX5C9Q4HAyNk8Ck9TV9nuNKiz1vEFBs1mGu2JnPtoCV3VLJllG/aiu9OqhPMYz824kjeX
	MYDuDjWctT5km96h+HJ+za83xTPRCDSt/iMpP/1lNG+bP5GToqt8tNSOcbTXNkkR9+YZz1AA6EqLr
	iyoNDEWqRCdfi48uR19xjLYjQUb7SvOc6slaGO8JLXa0TzbXiP0sbJP29IorjPoV34QtLSLrhRJjU
	+dhOjAs2H9xfQKnQGvmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVuxP-00E9yE-Jy; Thu, 30 Sep 2021 12:14:35 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVuxM-00E9vo-N0
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 12:14:34 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 05:14:26 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::8495:a8b4:1ae7:317]) by
 SJSMAIL01.us.kioxia.com ([fe80::8495:a8b4:1ae7:317%3]) with mapi id
 15.01.2176.014; Thu, 30 Sep 2021 05:14:26 -0700
From: Aviv Heller <Aviv.Heller@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: [PATCH 1/1] nvme: check for Identify CNS 06h opcode support
Thread-Topic: [PATCH 1/1] nvme: check for Identify CNS 06h opcode support
Thread-Index: Ade189kmm1qAylIDQbO/kw/1rkVxvQ==
Date: Thu, 30 Sep 2021 12:14:26 +0000
Message-ID: <5721a04a493e4f7fb87f2899d08391ef@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.148]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_051432_771897_18655329 
X-CRM114-Status: GOOD (  10.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_init_non_mdts_limits() issues Identify CNS 06h command, and
silently fails in case of command failure.

The code checks whether CNS values greater than 1 are supported,
however, CNS 06h is only supported since 2.0.

Modify the check such that the command is only issued for 2.0
compliant devices.

Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
Signed-off-by: Aviv Heller <aviv.heller@kioxia.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..8cfb4ebe1279 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2823,7 +2823,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (nvme_ctrl_limited_cns(ctrl))
+	if (ctrl->vs < NVME_VS(2, 0, 0))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-- 
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
