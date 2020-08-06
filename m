Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15181C433E1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:22:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A2D204FD
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IM/t2qd5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ckOEvkf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A2D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wobu2e3RKexTE26hYzI1PJxS1ITPjpWAutNl4Al4sxU=; b=IM/t2qd5bPn40ktC/aqzYc89l
	N4vIBXr6TkURVd9AIwIzCYNIxAl6XpxgEKeniUuH6fBr+FJc9eFWP3JUv0232AsdvH0xOxkOWh4pz
	dfQu2EujUUDIcrlYMmJ5aFm1aBg4yesyDInnQTMKE4T6/1pmOtb/XLmg1YrtuBrExlYtQITj5TmCD
	h2pA5shGH6pjoliFYgeDDlp5sjci+WI+/TWJSzkEHuKVrdYqItZVzlJ1d1LY85IsLKl2DY7YfPg6c
	rple0qeV+kzUu2FOvOUaMi5jNCxEjCKyQqW93FMjh0MEyFIJ301dJi4bP4ntnlbXqst30vW5RGEkA
	5HF1OwQKA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3aNf-0002d6-Az; Thu, 06 Aug 2020 07:32:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3aNa-0002aw-OT
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 07:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596699118; x=1628235118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gsIAWryqY2dj2Su3ivIQLn3D2Tqzr38JWRI8Zr7YZo0=;
 b=ckOEvkf2dG6WorWka/kZBgtnVrR9azfxpCAwFX721lzIdExPx2XgybB7
 G0vJAxtc8WeOVO7NJtxR5AbXpYPPUoMRkIaRc6KC5AbU+c8bz36j1Be0d
 VlbGHUghNGz8vo7v9bTpT+Lhncy7E4ElQGH9wCy53nfmINGJKqZhBpCNs
 aVlOY+j0DpsUAMgrdBCxuqP1Vqss8rB9OCrKtgC0dllyREyhrkMEuWbeh
 +GCqnDbKTow+5Mwu5gt4TgtT4ey3R02eJdJ90EQPH8yjAsrdUj4RSk2py
 7ZL2l6XLjUUfWiX2ZbsIvNtzubyHyc0E411PCeKliJu+HWlCmPZdg8ENI Q==;
IronPort-SDR: aLKWIZV3VS/3IeCHZFI6MzZY39c74nS7qgZL76liHb3fZTtiJr6DfVHy/PKJh+2OlOD/ydD+Jc
 i6j99NPfwOgEtBPUG8bCnJTfxpgIBSQZVmPIcWbI+1NVCG27I4iLzzRykXZXD3lUTBzOmy/Tt0
 IOS6x4J6G6uSwfflnKfNse9YSCaK4rW2rBRqujNr3Nf+oJx6Etq5v1aS5q3PfDQqvrUK1nWdVM
 oj7wc20pfZ2nZd8oEhG873XTCPyyPViQrY9kgW7ZcyjWmcCDbTHUSxfSdZPyH8I7Yz3/gm5JCL
 b3A=
X-IronPort-AV: E=Sophos;i="5.75,441,1589212800"; d="scan'208";a="144279262"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 15:31:57 +0800
IronPort-SDR: b0F7FwRiYNf+Bvwi8PWJM6bIqqv6LOx4Hq31Xao44zSO4y20wcX4Iy7C/dG9hdxwEk/1v8SYzY
 sh3LAIX62svg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 00:19:15 -0700
IronPort-SDR: cUEuVPvGnOUbX77BRGXYA6fW1kBjDaWyC7QGm8YcbyZlSPGKfAQnvZTR2r5y3Z68y6ih518sR8
 i3tPXtibWuGA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2020 00:31:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: call blk_mq_free_request() directly
Date: Thu,  6 Aug 2020 00:31:51 -0700
Message-Id: <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_033158_933751_667BA98D 
X-CRM114-Status: GOOD (  10.80  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of calling blk_put_request() which calls blk_mq_free_request(),
call blk_mq_free_request() directly for NVMeOF passthru. This is to
mainly avoid an extra function call in the completion path
nvmet_passthru_req_done().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b56292c9a76c..050e68b9f570 100644
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
@@ -279,7 +279,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		nvme_put_ns(ns);
 	nvmet_req_complete(req, status);
 	if (rq)
-		blk_put_request(rq);
+		blk_mq_free_request(rq);
 }
 
 /*
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
