Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD78C433E1
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:20:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888E820855
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JMFNINDE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kpCcNKIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888E820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I1AINN/z/flZc4MxEgQ4C5rKxpFNYdVJD21tQ7rOKbQ=; b=JMFNINDEtcdhHWsfc/6dQXFK3
	tAPvJKttwyM7AM8nV8H4wSFYfbnOYscdTmdU2miKPgRmPB0PstRKxWdNs2P3L3O4PYocft87OlAUm
	oktXVTUNhtxVlpPZuQEh5DiYN8YlZun1SAWwb1NhjXvFGEKCq3pPMArIW/ONFtBpAaAczNu2P3uds
	d0XakPx7jZ+10R3mrAl6jKaI2I9cIE0t+KsK3MdeHXF2JIcyIOXKockb43q4PIqp367QAslq909Oi
	gJZ6EQSfVmtVGpboeIHnDk7He2oN5Qk1Hl4qYd9dnimWhGOHgdyuLCPbndp70bKdDI0OkgHq/uHg8
	AcvyWdNrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3s03-0007Tj-IW; Fri, 07 Aug 2020 02:20:51 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3s00-0007Ra-Im
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 02:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596766848; x=1628302848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jee79AsQDOLOGhrzxMtbp2/esOPaAIssnRPz990UMJU=;
 b=kpCcNKIWbVVRW589dCBvGBGZ9GlRt98TKTEeyOO2M/8EeUj3hO5BjYn2
 uylz+cArDRAC7cRdI5pNibWgX81rJUcbUOYPqXHeoFApWFwuIu3O4HWto
 4lsnj96kIKKhwaaVFrNf6p1M0e0vF2/Schjqf15gWuX5hlxXpMHVSL/BE
 95yuyx9wqdZ9TIaCBYKXDSKiCruiJOywhDx7IzPK4sr4ib0SPijJHEF1/
 mPsIjamiGUCSkngAkL6Y79RveiF8wJG0QnSk84XIFVKyc8SQ4jbn/ceLm
 cLbMXSyMRlc8feYLx3d1WRjBbkV0PSA26osHjC0KZJYbMbuY3P6bGEmD+ A==;
IronPort-SDR: j8B/8z492MkRkey6QSVfnV2pnh5NZ8lxGWHm3xySDVLNoqJ55nUC2DV7LS1VhNAeB4ZqtOpMSE
 WiZ7wv+YSSfoZctGi7pE+z6B82xlRaugnTC/i/rwKzGNGDSClvpYbI3ygy15PzoiIFC65g+a+g
 b1BhSODv1bhqFqa9w5HBxNTL4Nf+VJF8qHuliwSZrt0sPRSM3pQGxse5DIquAhIZrQcneoiecZ
 2usXR7JpUNp4kKHHMmJ12cwGMRGNqEetp3mdTbMF3jYg1Q5vdmiZ0rqlMvBL0CFQGC8PrkHXrv
 xAw=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="253717280"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:20:48 +0800
IronPort-SDR: hPksL+pFOBZnyGrxr5ye/OOrI6l+1j0Xl8UjAy3BL3YpB25qf7ecf7pZ53PDn93pRa7ChLxt/h
 nKUy0nWVUQhA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 19:08:04 -0700
IronPort-SDR: MdWjTLeTfqgj4sbbM4UcKwgA6MEodBxUJYSI9l1h/fDrIw0iI881Ho/qQ/KTzdTwWKZmymIb86
 AY/2AYxjvwhg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2020 19:20:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
Date: Thu,  6 Aug 2020 19:20:30 -0700
Message-Id: <20200807022032.48873-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
References: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_222049_126735_A26513CE 
X-CRM114-Status: GOOD (  13.41  )
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
Content-Type: multipart/mixed; boundary="===============7269399632011215041=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7269399632011215041==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

In the current implementation before submitting the passthru cmd we
may come across error e.g. getting ns from passthru controller,
allocating a request from passthru controller, etc. For all the failure
cases it only uses single goto label fail_out.

In the target code, we follow the pattern to have a separate label for
each error out the case when setting up multiple things before the actual
action.

This patch follows the same pattern and renames generic fail_out label
to out_put_ns and updates the error out cases in the
nvmet_passthru_execute_cmd() where it is needed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d91dc999a6..e7dbca12785d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -230,7 +230,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		if (unlikely(!ns)) {
 			pr_err("failed to get passthru ns nsid:%u\n", nsid);
 			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-			goto fail_out;
+			goto out;
 		}
 
 		q = ns->queue;
@@ -240,14 +240,14 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	if (IS_ERR(rq)) {
 		rq = NULL;
 		status = NVME_SC_INTERNAL;
-		goto fail_out;
+		goto out_put_ns;
 	}
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
 			status = NVME_SC_INTERNAL;
-			goto fail_out;
+			goto out_put_ns;
 		}
 	}
 
@@ -274,9 +274,10 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 
 	return;
 
-fail_out:
+out_put_ns:
 	if (ns)
 		nvme_put_ns(ns);
+out:
 	nvmet_req_complete(req, status);
 	blk_put_request(rq);
 }
-- 
2.22.1



--===============7269399632011215041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7269399632011215041==--
