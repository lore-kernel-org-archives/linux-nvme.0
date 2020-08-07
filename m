Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DB3C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:20:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223E620855
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iVsFc8A9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="koExZSjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223E620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DsFHMuWIkaCV2wrl7cJQSJw/vOxYfCGmgIlt7oAr300=; b=iVsFc8A9BvQEHSfG7D1l+ZEpr
	Pb751Zgbs47mmZ4TvRu1sSEub+aolPtTgsMy+4LfGnFG7t9bwDP0oaKjJRHruNHJr2OBEU83aalAv
	Tw3/1BQmw0lD3U57VHeqNP/pqbP4vjZoCPkA0M/ygCBkHnAcwfS5lUKWBZi08s+Px4i4jo0NVKVwz
	NoX/rBMcd6Gl8/pa8F5ha/VrYkmyxaYudm51EZrVbW9ekK/O67TJELE1Txy9xCsZq9QaDfxCybvEV
	GfsglYYRaVfrZP+mrrhCBpT3AHKXaOXYsM0Tc+g17r9tzxgILF4Nhjv4Qoi814O72uc+TE4ZIPCBX
	sOtzR7QdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3s08-0007Vc-SJ; Fri, 07 Aug 2020 02:20:56 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3s03-0007Ra-Vt
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 02:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596766851; x=1628302851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=41tA9x/zhZrftn5xwGw/aRv4V0QuEAckuUFKJar7fOU=;
 b=koExZSjkWebkfq7SKW6DWn3WrzuzTop9GFg1NojRXrA68LyBEPJR4ao5
 KzRZ0U2oUgk7V0XxLFiYuntvGEGVR9P38E3pJK8auLUai41K/C7UZJid2
 +8/b4oJcw0aZYthROPfv8DT4/gMKyOXSbWzSVLbMUQF1/ARykoR9EFHu2
 +uJzNPmbVtVcd/q0I2D5JW6BJ9ssU83CWrOpNKUNxabckfGTRofS+6XZE
 CSi+Z2kR0efvrG31rIpFbI5FbMRDiiEpbJHMlDWKJuCZZAh9d1AEEYbPS
 wRLTSRAvdhoYDFQa3795jArBonnfvDnej1xbLo5cnYbgl5S+aH0rTHse4 A==;
IronPort-SDR: UcZp1xrxa1xSDb2KOb7dKfIxNDIS1Q61/9TlmnS8XaAiToF8dlv7WVf4Sh+EQ9KRp6iXUkbN6u
 2jCUqH6o41IyQ6qV4WJ9Nx171KWARQzF9igvYopO4Z5qcnAz6cL5NV3xrP3SxGLrlAp41/CIXf
 eh0iw2TUGlT5IuZ1DpazOvRQ985mAaLvU/2F0WqezSyJD2y4NPDa/3JKRgNMeuCvCUiSnO1aK5
 qtoabAswmjy7ET1L+XDzYGwvOr/2b5FDLoXqyvGIMLUYR07YEuoxf2iMGRANtlOgpXvapxcOIh
 3dQ=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="253717284"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:20:51 +0800
IronPort-SDR: qF+H3drM6oaUiA5F0hdIDDkXRg22EIMpPQk5EoUo5uX+kz3OeW9NyOUyScaaRRLqLCRvkfuDV4
 qHDBb1iuRxVA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 19:08:08 -0700
IronPort-SDR: qVuP27PZ3mHeXKpVwqhoxCc9lCcw59PdJPtRzSIDapmPOmtpA83dOtFCWn8cqiLixlm9PUmU6b
 i1VKHaO/JLHw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2020 19:20:51 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATVH V2 3/3] nvmet: call blk_mq_free_request() directly
Date: Thu,  6 Aug 2020 19:20:32 -0700
Message-Id: <20200807022032.48873-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
References: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_222052_377829_9E9771CB 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: Keith Busch <kbusch@kernel.org>, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
