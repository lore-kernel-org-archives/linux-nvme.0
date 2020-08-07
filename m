Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C80C433E1
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 19:30:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1C0204EC
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 19:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4ECw80M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GVLCUie6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1C0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DsFHMuWIkaCV2wrl7cJQSJw/vOxYfCGmgIlt7oAr300=; b=b4ECw80M0zJb3PWJqmxOAIr4v
	QpuSMccM/eGXge3tJG1DiwC8Zeo1ZFBIQej6n61UN545/fuaK3GUuOas2ho/JHaJtqw4ct9abibHg
	j+eolwmKtqeEUxZdonY1rpOR1p5QNTmMizk8wFg/Rs6qS60Kb2LxdZsc6cxpeH0iVCigTS4Edb3H7
	THvjB3G7RhiuoC3ZNbIBZOe1JSXUXTaDgqogEr/orVkANElHWDfSvgZ74Nxpjf08werq03Ff4zm6K
	KDtHa7aioQGvG4dD4Ul+00p4eGg2Qa15VFt+wHvz8jQoDypsONKVWPVQiOKhrbRcc+TcYAK+T1cwT
	RnyLD/Jsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k484g-0004Sk-I6; Fri, 07 Aug 2020 19:30:42 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k484Y-0004R6-N4
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 19:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596828634; x=1628364634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=41tA9x/zhZrftn5xwGw/aRv4V0QuEAckuUFKJar7fOU=;
 b=GVLCUie6Eu8dPacadx4tkfguTtEdc8YrYccLm/9zyeJJmtDITUAKaGsA
 iEHfOn9+VN3N3rWlII92HIymyNIyWy15xMuux9kHxnKl3tVD8hdLkSLVW
 1JtLcTfgisSxBsZE2MkSgx3+Au+mUZto8qeM3hwHlytxEkM8e6miGpuXk
 MDHmkhSeed9nR8YqDTua2kadM6Yqj3U1Ip1F+N1bmovHHtaGjomNbwgMC
 qLgjHHoYZrFS8p/pHY6hG5XAwtjZ8hZRZXS8OJ1V1lakvO9cCymRQoPfB
 ZwlVZPu/HNPFS69G1DK87hig29AUlRqZOND6DCdan7pzzu557GQNN2SyM w==;
IronPort-SDR: DB8k/GitFKs1gBJi2UVgm8g+n+jhXhtmfiYGr5FhIWc4BZNA22sTXxu4L7aXqDu1ZUHdhFrjl4
 J+dPYDnako5oIyzM+zOzYOUkLYCkB0OGlbnzNVzTtMzd/LLGHoVpHrEDl/z1GhDshJ8FeIcEEf
 9RvHxe1gZVwBFtGx7NPzxC8iDcxRUTFB7B32fuWYEZlvDsisX23Mtp1/0unn5+pUtj/AnYAhpX
 wDZGsDJDzr9L0V27SEMu1ch2IJmztbjoJbOyBFlMd//USAj2ItF5IwwyNk6MzPqcFUf+KS+HLr
 9y4=
X-IronPort-AV: E=Sophos;i="5.75,446,1589212800"; d="scan'208";a="144423146"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 03:30:33 +0800
IronPort-SDR: sLXI2drhuvPfs5c7gAIfaNW5AKVfCxfrC/yh/GIuH2CXVJ3cIPjcnyKafWuC2A/W7poWElwGuZ
 SWvoRCp3AYjQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2020 12:18:31 -0700
IronPort-SDR: dP9Ix8aU6pvMABZgbBySfe/sz74FDgaW6Fq0IhihZCZBuxKtpT/7HpR2CubzqsVkFfWkzEbs15
 kkYEZbWtlknA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2020 12:30:33 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATVH V2 3/3] nvmet: call blk_mq_free_request() directly
Date: Fri,  7 Aug 2020 12:30:26 -0700
Message-Id: <20200807193026.9129-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
References: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_153034_868743_CD12E59C 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, hch@lst.dew,
 Logan Gunthorpe <logang@deltatee.com>, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of calling blk_put_request() which calls blk_mq_free_request(),
call blk_mq_free_request() directly for NVMeOF passthru. This is to
mainly avoid an extra function call in the completion path
nvmet_passthru_req_done().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index aecabf423df2..68701754b036 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -165,7 +165,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 }
 
 static void nvmet_passthru_req_done(struct request *rq,
@@ -175,7 +175,7 @@ static void nvmet_passthru_req_done(struct request *rq,
 
 	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, nvme_req(rq)->status);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 }
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
@@ -274,7 +274,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	return;
 
 out_put_req:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 out_put_ns:
 	if (ns)
 		nvme_put_ns(ns);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
