Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0CBC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F6264DF2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F6264DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AyECunEWsMlH/SUGMQBNU19u2dYvicnzKpVJ8rEtphY=; b=Z6RHPcu8Uw1DWk/HPJLX5IBgY
	c8CBxBpCQuHT/y8VKm/RCEIO24vKEsxSz3bmSQkX8v10DcT/49TJRbhIRbwon4875arCzzMAABffh
	ug9Wa3IvokroL+g1COrwBP3ShC3jTt8n6ZWBxAnQOAR/bH+cZBqb4qxhDhArWRlRVTpeYZOrlGX2e
	lzMFa9AjWhCyzW3sK5slFhohIbaRr4PcH6vvRuaKY8S/UqIrrduv2SpqXWxLAUlP/6DWPnIO1gb5N
	FMKyo6/uQLzbmQrI9ZCBzonvWVQMWkUqcLnEaT8NGO3oaPQPpeAEUp03o+rTYVyDGs1W6tIDQpzQ4
	JEJB18O3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxM-0004R3-TC; Mon, 01 Mar 2021 02:06:44 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxI-0004PD-Gf
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564400; x=1646100400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KBj7B5EP4kcBn0EvPMdQ3QPqdqSKZ7Ky5yaq61qRnow=;
 b=H/BIjDihVqIa7D9AXDZkE/YVHZmMR5xS13/rd9E+6OMBpkeGLdwAMyLl
 gCvHckqat/LMMsyscsyhgHH5mMNotp/xvDP48ugXYAt/RJ/w2gbjaX7Po
 LQkolo1XBxVicTk9WLY/+WnSi8k37jwQwH7l8sw4zHUKrE7yugaK7rosf
 4zCunhPOtoGHEzi15AJUuIcA8QxANCSVxJd7/p1cXMZKApkSPaVCx+YFl
 58QmhqnI91MAaG6TLCwa2WMsYm2rXGNGdrjPZd6ah3G2jWNnzB6EVE2jm
 nOBnRt9mfuVDKRbJyDEppixJM7L5O63Uigmf19mPdTNnmR3mUeoJ8oDtJ A==;
IronPort-SDR: 2gv8LA0OwqQW9HJURrrrB+KqcvMxoqEY+akQVjhxU1Zbs7sVpnJbqz5WoioHsYSGzjKlYcwnky
 gFh/MciBh4syObh6zh5N4UhAqGwTNqLGVp/ySPgtrOad0ueTFuxhxTFuc0hQNwpwz31nWY5189
 i/HjB5EXJwgHxI4pGqLhGrnIs3QX9Df7DS9tWHP84TsfsYJROSHAxlOyrIbhRR7oJKtZkPxLxF
 Ax498Y1gFicrRjE0zhd2zGW7A/1T5F57zhA2oHpHxrul6SF9o9pzIRUN++gPerbKqRU0FE40qu
 is0=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="271615100"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:06:39 +0800
IronPort-SDR: lwriXjjoRsImqVZ9KuV1ANWAQcjwj/87aHUgERS3m+eoAvoeDEVjOshN7A4wAV/ESlRk8vFOVV
 vx1DcqetpcDGcCC2pE5i85m2VzIjFjKwpsjvPN0+0isjFxIioE/1Rsp/hZpGvTmTqf/ghGS9EZ
 3He/mMYkIwqWnyZG+ovN3F27dIkfQL6vxv40LTterwJUTmHZr2e/EPshQr0WC3IhTSTlpPdLTy
 wskoiLFcFVFz581CLtkougDIJV2ZvQxgBXmarZ8/BlCnARuPcFF5nNg4Ee18F3iU7rxvQ+Ou8X
 Xx33HI7RvSJ1yumGSpGkHD9w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:47:57 -0800
IronPort-SDR: vm8dHvZ1v16h+9k3ViTzOsow8pCAlOmI0X2KoypFOl/N5OKTgzWAeilB9bItmv+1c5vrCWKJrV
 p5x1zEiq9RTQuAEIMsAd7eUa82FlOt2+8gw4TRWAD0SMd+Y2NxJ9BOS95+v/ahXw+0KgURuygw
 /OEW1BE3505L4Qw08l68SoaHv7CJ1MFcSrPmwjNLUwwoH0QsC0gOV8e6eDxpxO8Y+hbslYU1a6
 3BkuW5wejnFixyNczXUHqyw9AV/Zhq/tuUpjsSGXeETgZBZliqFr6eidoji8WBc4nVZcpPYqRO
 9Sc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:06:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/8] nvme-core: mark nvme_setup_passsthru() inline
Date: Sun, 28 Feb 2021 18:06:06 -0800
Message-Id: <20210301020611.18669-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210641_995779_F73A08BC 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since nvmet_setup_passthru() function falls in fast path when called
from the NVMeOF passthru backend, make it inline.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 379ebb54f5dd..484866e52ba7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -725,7 +725,7 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
 		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
 }
 
-static void nvme_setup_passthrough(struct request *req,
+static inline void nvme_setup_passthrough(struct request *req,
 		struct nvme_command *cmd)
 {
 	memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
