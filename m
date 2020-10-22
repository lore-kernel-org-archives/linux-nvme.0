Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2878C55179
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6902244C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LLzlSwzx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lwml0aQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6902244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s/jjQQaE+y6kD38TIFTdZFYWbz6pw+05U31mlul2p20=; b=LLzlSwzx49NjvFMeX1yCwgcLB
	08GM4a1EqT24i0NT1z9Habkf8jurMo8M4NTvm1I2xWb4FIMebVCrXZt7neJRscVUPEP03l/cUgZSW
	zXu9zSbAB4iKFAUsJCqllB/7YDC0aMMsUCsT6AYUXfy5MddRUw3GH8VRnKFDGQqycMk2GWmG0Mqa5
	G5no6+6S557F+if2aOmquu9sO0Lb2xAu/lGWySqOx8O0qaZKyX/LTUQM8PCapyjg0sQpltJONODnz
	ebPlOs+vNd9TwKEjTadCpMzF6v/PUPSwLUN63Y1G2HHd9c7qam8A+evO+4pO4n/ybktteMCt/Ksdp
	tgFbo2G4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVP0D-00044V-Rr; Thu, 22 Oct 2020 01:02:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVP0B-00043w-6f
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603328567; x=1634864567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6Qu06twpDWdtgyaEYknFhF6JbcU21xCqovBDAlsLidY=;
 b=lwml0aQWpo6ajS2Tb9fu3l6zqst4LGf4h2tPhOETBwe+2cXtpJDUGKJe
 xPCH+cvi1Iy3ptilXyR3uQ2CHijVNtnmmhCQ+ar3Bz4r3qF8cXw77F3Vx
 egMF61f0McNBTieuvQP1v7BMgHMDWWLqIjBLjLbw7UkOytUSBBPKHdn6O
 9SgCiAY7EvWxrWTDnXUmVGLu9gFmFg+r9Zvvv0UzvqQ2lclHIEGP0Ed+v
 Hi7XJ2I36+XDnOmOKHExfgVR65CCGdjm7y3CNMgx/g2diu06Vtyd9YNuC
 HIETtp7VfxcgPaFZdB2hA+7GgmJ9n+0M38aLyY4M7V9XBDKYp0yKW3sMt Q==;
IronPort-SDR: tb4DBEhbGTyL0foC66XznB9+Avhx9PUK+G1i31+NezBRLr/a3vkf7Q/6y4/w0DLjoZaNKEuPp3
 xvUZJBJLluV7AV2QVLo/45X07eflttKPBcCR+65/ai/aGNkQvnqQr1pbF+O74aeTxd0k5RBMS3
 hwEU6uBM+vruAlwd20q5UvBpDHMAVQrMHjb9P/NaJf3nVCCwXQlXbzdBhhMLWQeovCwr3St37e
 WCegbbMsFFuNFmGDJmQcECm/2XguKEroHaVUXjlA2ztK1+LHTUsSU+SNnexXuDKA3rgKt+jzt7
 Fpc=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="151797976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:02:46 +0800
IronPort-SDR: 7Jle4Mf63jBT4lrkbCzvU4wS4cg/HRccoFZOvoFN+j+6bpZLCg73WddwmpXi1n+DcxRBIj0WvG
 p1WWjyLBCffA6BEcW4LAJKR6NBkWZML1SVtX3Y71cZjXh1QRi5KQBXPQjYV8AX64NsWW1lUFiv
 8Njw5MG8pKAZTDCQ5KmaVWWuVO1lAwbZVcfodiHX0GqTQBsQHztWsjLrEbbzlR4NlWAsqL0Iw7
 WQjynzaIC4jks60Qj1u0o48Nt6rm8lZbSdKll/9uAnTJRW2ik+vO8AdFaPQuKz2bl3/3KoS7f8
 LCXIgxm75KSP81H821AP7s1o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 17:48:18 -0700
IronPort-SDR: Lmfm8H8beSCgrYyPjwizv4+CTO+vvNtMMd56nRYSxBxHr8A9WM7b7PKHELXms/4+7QjVpZUBfr
 epGCZKz1Dw4pTuCmo74lQTlwd+wGsl3+IvkM7yN1qxErbxOaUS8Rj+wOzvGHfsyXxnpEf2TO4R
 7mxzyp7FFS6tivVFOOGNR3HBxWF+vx/tpV6tqt1WItH35gyEAH/4xby2cw0liI04e6STpOmER8
 WTTdR1OIIZOvD0M5XjdBogzWh3aEXWGIDtRX/XJbJI97VNeMf7SFuKt3UY5Ot66+W8dN8I4Bpm
 +gM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:02:46 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/6] nvme-core: add a helper to init req from nvme cmd
Date: Wed, 21 Oct 2020 18:02:29 -0700
Message-Id: <20201022010234.8304-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_210247_687590_AD7A7248 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch which adds a helper that we use in the next
patch that splits the nvme_alloc_request() into
nvme_alloc_request_qid_any() and nvme_alloc_request_qid(). The new
functions shares the code to initialize the allocated request from NVMe
cmd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 56e2a22e8a02..5bc52594fe63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -514,6 +514,14 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	}
 }
 
+static inline void nvme_init_req_from_cmd(struct request *req,
+		struct nvme_command *cmd)
+{
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	nvme_clear_nvme_request(req);
+	nvme_req(req)->cmd = cmd;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
@@ -529,9 +537,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	nvme_clear_nvme_request(req);
-	nvme_req(req)->cmd = cmd;
+	nvme_init_req_from_cmd(req, cmd);
 
 	return req;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
