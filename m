Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EBC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CF420774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CfW1qMli";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eot5oQRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CF420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E0A16uyCohfdgzZjz4JWYcECop/J7cglt0vlcGg+Lc0=; b=CfW1qMliWh5bk97NmhNMZ9aMT
	ah1DREtuZ03pagg+vkEd36MtMeHU4F4Gx36LdADDhSDsaUHqcg4o9TOOyLaBd15FW83mqc3SnJ8Zi
	ZwVWpjpQ5Du6oMlfejVvFhYlL8vqgiseobhrz3USuQcvfg+EpG++tfP/VItDU/HH9nc2CeVRicfUP
	OCYqhEU+IYV9oXb3oWybx/tmnVdvP7IgYyMrHW70rMDmZeOEZFEOw0mFfF373In4FT2uOIqQlt2tS
	ACFEKpLKTVAqhaYC6RGn2a2G8VMG/I8NbqoMv3q3w7cPThmPRPTWdSZaBxknXnjKNkrzQwlz5MMg1
	WGpqyCprg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cxk-0007Ae-V5; Mon, 10 Aug 2020 18:56:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cxh-00078m-Hi
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085822; x=1628621822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0xG4IHA/LuloKSvpJpOyiSJaao6qK+DIwDrluD+mNnM=;
 b=eot5oQRp/h2eNpaSk/9ohvXiLXBspmkWxE58NcmTFXyquwtw5TNHWry6
 sGLSoau9yxtqRUTJxnujp8lO9BMXCTu2tjbzHT18qLwkdKXJGhDBLjE8A
 l0uQIoiufbLEc3f1Ad5vl7+ECdgRVXVa3v8jy8nyzjtGCPEdzUDJttidw
 aYV3JY2waIHRREGR6IxaqxMY5fjiJml/bl8bFMvf3sLmQIl/Ec4zCisEx
 X8dxNejM2Ja7KYRocESWOznlVf1To9BmAIWaLnvFpOiOjUyzMG7LhnLum
 D+QAasuA/jhTAN7YD4gTofYcoqOH/lTi1AT37i1w3F/aei/pBP732zND0 g==;
IronPort-SDR: Fujv7wetmV09b84WW0cBR1CEglkjOFjbuKMGEqAwAxtfTg9BLvAU3Xznu/jOikdcfUBmIXpVNp
 fobd1EvLAjegz9m0NFJiEh3cyAGkSpXVQ4abjKBdULm5z0SQqiBXtmeCYTpKtFaQY2tZNYjLiW
 v289LqidfOU/QEguGYCh8kJcvH2oFNXtygO6s5d1PpbU3mVFt1YLbJvB3aMji8spnRk/mU191X
 UqSo7poZXjZldBxlWx72IesJIcnFexoOMBsfVkx8OaT5GiBKHMCmaZmwWXD2C7MAxxd0g8OJIH
 t8Y=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="247732505"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:57:00 +0800
IronPort-SDR: ZJuRCE4dNDa04Ei4BqAoTXwRTaX0NGB+NvgD5SzMzrhNEkLxeaBf1bRzM1N+/JSa5thN+yo5f/
 KOo0D9iKtk9g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:50 -0700
IronPort-SDR: 8c9PFDj81hmWIG9aXwHp66Vu20ayBX+uuVOTmBeotghBiywy/LOHwGYOicV6gi4c++ul4S0Yyi
 uPQWjmvu545w==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 07/14] nvmet: reuse pt-req-done for rq completion
Date: Mon, 10 Aug 2020 11:54:49 -0700
Message-Id: <20200810185456.7713-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145557_793390_EED2467E 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvmet_passthru_execute_cmd_work() after overriding
id_[ctr|ns] results it completes the request by assigning the target
request completion queue entry result from nvme request result,
actually completing request on the transport and calling
blk_mq_free_request().

The function nvmet_passhru_req_done does the same thing, use that and
remove the duplicate code in nvmet_passhru_execute_cmd_work().

The last parameter for the nvmet_passthru_req_done() which is
blk_status_t is not used since we derive the result from the nvme_req.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 00270e20c83a..0b18038c44bb 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -142,6 +142,15 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	return status;
 }
 
+static void nvmet_passthru_req_done(struct request *rq, blk_status_t blk_sts)
+{
+	struct nvmet_req *req = rq->end_io_data;
+
+	req->cqe->result = nvme_req(rq)->result;
+	nvmet_req_complete(req, nvme_req(rq)->status);
+	blk_mq_free_request(rq);
+}
+
 static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
@@ -163,19 +172,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 		}
 	}
 
-	req->cqe->result = nvme_req(rq)->result;
-	nvmet_req_complete(req, status);
-	blk_mq_free_request(rq);
-}
-
-static void nvmet_passthru_req_done(struct request *rq,
-				    blk_status_t blk_status)
-{
-	struct nvmet_req *req = rq->end_io_data;
-
-	req->cqe->result = nvme_req(rq)->result;
-	nvmet_req_complete(req, nvme_req(rq)->status);
-	blk_mq_free_request(rq);
+	rq->end_io_data = req;
+	nvmet_passthru_req_done(rq, 0 /* this value is not used for request */);
 }
 
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
