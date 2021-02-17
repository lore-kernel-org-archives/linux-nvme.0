Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7196664DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7196664DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YtVq7O6SXRo8nqiQX5UVbuAdFEaKtEIC98v8rSoQiy8=; b=ZLDFqtMVi02NSoOaw8rexzoxX
	MV7d2+bEvhP3yEkcfy4x3ggTpipQH1Oe/w4Y0qRNmx4vyln8GTwahqqxjq2wfVng1Eopl1bpsrqpq
	R4ZJlUDcavafyGN5j9iC6kyeyfyFerLoM+cT7hzRG3nsT2fKxhOVijLMxhF6zC5eLW/YTagz0Nozj
	UW2cRLU40xWWG3DTJ7kwPQLYwxtjWmG2aHTPmJ51LGKk5Ub5RWF4XCUK1/V5VAejWiinnntwcb8a9
	ww6TAfkSGnPTcYUiJzCSI2O5mSsVgdF2YKG0lIyGCwgCfjrU5j8qKLzWBtBsLvQKAQlHFOxDDcv92
	W74YWszZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCARY-0007rJ-BR; Wed, 17 Feb 2021 00:11:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARQ-0007n9-22
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520699; x=1645056699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aa30kNHNkUtXYNcc+bRBXtcO5I4rQ06/gLxAXH20U68=;
 b=j4NJxXqQ2L9dmGHpV6ciL3drCN+Txu4GZE6H3A1JekcJKD0WEGwP/Yzy
 xKXTrB8ECt1+gCwWHgfqeY0l1ZBHDWgv6Kp/MWg90dlnkr2z/sJ1E+ZkV
 yOfMqSwhnOxxJh/7sd3xNI14oz9r9hDejfzixZd6LcHLGhuacifta3vZH
 EYnuB5uoCHGDZ9HQVDWtjdpIxvgRu1YelwaRxzYcGvZF1utxs3FO2gfix
 5m6F9eOf5nDPVoM8EIp9r8bHvI8ibQ1ssict2tknjrb6vs+ArndqqbOCA
 vhqAxdCNefmSCBXV1cXoXOZfyZfHcWfKsrfXp+Ns3oV433oKc6Z73soh4 A==;
IronPort-SDR: Rtn1s0EyFFIFqmz8fYdaL9Ud7AAkL5DqY2dRps/DTQTF4drDtwrxb5TJCyPFO6qHoIj+V4KYnq
 UZxVqHdhBr9y3bk7BK+4GkzaOhUA00O/nofoNqp0hMHev7UovqY/hkQdz85OdXItELpHbOlLhU
 FhWmgff+B2Hnf3TBxa0nEkL+GcQJkBItFTH9HctSVd+5LiHsvLSIgqKoWqHYi67cvJ19OKDDQi
 C2eXNDAldhmkSi4PkLawn/XfQbxi1hPYWczVQEX9XX2Q3KFQfAbVNkJMWKZOu6ueAWN0t1Bm4b
 t5k=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160098742"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:39 +0800
IronPort-SDR: oH6xntYmb7OBlRjkvoKyO3v+hqIk2yA7yLibLQXmKS5TRxXGbvix8a7Ou9gT7KTum+JdzXePTu
 FnmZC7QBdOUV3V1poPSAWrsmXebtuY91HGdBXlTJGNg4PkjXRpb95qTzSvAr+Ntv/RxUq6U6EB
 fdTF4OHG7Bln5J4Y4tRexJKLunHxXBcLAniVtFDNyIsADL9TyeeQ9uMdbOItImTodPtKQHHGnb
 6XfTI7TWriUiM5DgbG92Vmzc8mSXQ5EwdWcEAmhMo054eVZwm5ZbjdrIEzASZuUpQ1PCqcxUwR
 KcmLGPIAIFywcjstaVPVyjtR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:55:11 -0800
IronPort-SDR: m7NsyGd9gf1zR4DH1gBy/YRMzth6hOM3TizoeYBKwpgn6QgZ91Ode8Qjmgw6yhxVX0Wirug5zi
 cBIrbLRCAD/mCA6/gN4tHmykZeq0q7VRIs4pi7RT5LNr0mdIDwM6620Gjk6NTgjolTjkIZu8/x
 XhntM4iKYxz8uiS4SN2F0uKf2OR41Yj9v0z8LbZYBwc2mv1vgZSPAFQvHpRlZlhjGD8tc4B4AK
 dyxjcM/K6TEWdubWGsvsB0aAc+D7gM4OXVRJT6aVatJONAvintNBVFjwsrKjDMz30PCixIcjVi
 3O8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 09/14] nvme-core: mark nvme_setup_passsthru() inline
Date: Tue, 16 Feb 2021 16:10:27 -0800
Message-Id: <20210217001032.25741-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191140_343417_839D7771 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since nvmet_setup_passthru() function falls in fast path when used with
the NVMeOF passthru backend, make it inline.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5cb90bd8704d..b43557ebc564 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -788,7 +788,7 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
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
