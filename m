Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D629C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:25:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B157D206C0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C7jFRI3W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f6qHUuYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B157D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=niE+4AA8Cj1qajgEPk94TPHZorShGIq6JleY4wGCuYk=; b=C7jFRI3WYm2K2c1fIAJYUFvLp
	gmQa5bPjzqa38iJCsUSshDCw7cNX8nlWGuI0EPOmvs7zXw7TQoRgxWY4OxPueRWCWGsSctaln+Uqq
	WaRmRzK3QsZe+yuJ6a850rd+octEK3tn5DukgtajmQYyZvq+SiaTJ8LrZFo2jsvGzpQB56aua2PDc
	ptym37RBleZB6RNUsgaFKRYh3CUrQ7N7FB1gpPjt8VaLdUyQxHLSMxMS2KzUSnekelenTo+7ZcCSZ
	BxdxDvqBZzEE41NqT/0yQXOzG/VhoSawQ04hTaXr0KvTgH9K2MC34t+jqAHHQtpViAsJMBiN89Noy
	ZU2qszD4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJL5-0006Lj-Bp; Tue, 10 Nov 2020 02:24:55 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJKu-0006Fj-MF
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975084; x=1636511084;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1LQfy4MRoLNkEPF2WpyasCEthNejxsNzCQhgw0uUJ4=;
 b=f6qHUuYxAFSI0TWr0zpcdmsXGO8iQudWzX55vdIcgIqwiLIWd/CherZ+
 vGzBHkcymdWl6YZbgkzA9CGdqngRDsm+j5LF72LKyDDQrWTNzo+6hxtKJ
 7eJDWVuzWCO01uyM1OX5OsJjcARwaa6Km/cxcYlJaU2Uv3UuSyBzW0X16
 doNNru6hyL61X43oH2Xd7istkKImc5LQw1ixbiSOovaVUNDfdgE5WHraw
 xC7w4jccBIGSqjZRQIiWFQlHiLClK9dHh/qIicW6EbCKKpqtQaCUsQ710
 3uSY/K1BPFL34RbPQixG69AF7MyVI+5McdBV+65aZmxJq0Q2BKiLj/BXo A==;
IronPort-SDR: 9NngnWk6FMZyXj6VqU0k/AOwhwFeNVgPLjUNgTT7LUBWJAztGo60y4ALztj4SgBLchQN5Euoau
 +8uBYPLqr8Ca8b34GH/EwUSM3hsA44zBad7Iedl5v7HqCALDvB7frcW/lrzcb6+ALfDPqCg4R0
 La8VXOSh27MxI4rkoDiYWVtW5ZffNM+hGNftPBNLqh6WTd6I6oKEqKQbUmUeezD3TuT+XbgnEm
 pbimiXeepsmWS7HF1tFIFemEkflW6iKI9u/xqvDTIzLLXLTOCnpPmJXuGg/98M4rba7QNVody3
 kGo=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="156720779"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:43 +0800
IronPort-SDR: to+Z8UNW5gVQ0eZnfiSocTVPRpNtvtJa9S+CMf/UYVaYQwx61T05iqnQevWZbZiILGIYnSDn4O
 t3EN/g6+w21LrOAx0u2ite4cbv7zd05BwVR52YJpDOJJsGs62XhoIAKSuyjOClEpC9LiYV1NOf
 0BwrJ0pzvI+jn88QTaTosJfUCaLvqKv/ZThXqjocQAegF7vA0eXpBEARSrzeEUSH8xhkcEa5ce
 a3T9fEMk8oJ+HvVDat/zH6kCNnu6iS8DqoH1n8AIYVMwPj1s5H2xLv3B0NMN05otx9iRRbPdug
 Yy/ln5ennFJwCc0yVvd3dQfn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:09:31 -0800
IronPort-SDR: P8mz4sKNOXfIpKb8h8P194X/N7Oaeqr06qSPde+ZymKxBLG91oXcpOAjn4YZnr40gtDXWrHRXN
 bvIzeKzgdNfzuBbWmw8OVuwI4i0kqj+u3sqUUDvuUnDZ+yX12rahpH9KnBgAEYFe/N3D+/L6ka
 QX66VbLpzNUsebw953vQlluu8ePzZNTh3NiZAJIYirdf+dDDpBg1SOnrw1B2Snjm+PlFRZRGLz
 vBgiStmcTGtc0c6rfOch3kcOxxGcWwi379bcJScomLimKHoItwMiugXbS1vxsTOQkxnw7aw5CV
 Cek=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:43 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 5/6] nvmet: use minimized version of blk_rq_append_bio
Date: Mon,  9 Nov 2020 18:24:04 -0800
Message-Id: <20201110022405.6707-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212445_018236_1EA09AC7 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbusch@kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function blk_rq_append_bio() is a genereric API written for all
types driver (having bounce buffers) and different context (where
request is already having a bio i.e. rq->bio != NULL).

It does mainly three things: calculating the segments, bounce queue and
if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
case.

The NVMe PCIe and fabrics transports currently does not use queue
bounce mechanism. In order to find this for each request processing
in the passthru blk_rq_append_bio() does extra work in the fast path
for each request.

When I ran I/Os with different block sizes on the passthru controller
I found that we can reuse the req->sg_cnt instead of iterating over the
bvecs to find out nr_segs in blk_rq_append_bio(). This calculation in
blk_rq_append_bio() is a duplication of work given that we have the
value in req->sg_cnt. (correct me here if I'm wrong).

With NVMe passthru request based driver we allocate fresh request each
time, so every call to blk_rq_append_bio() rq->bio will be NULL i.e.
we don't really need the second condition in the blk_rq_append_bio()
and the resulting error condition in the caller of blk_rq_append_bio().

So for NVMeOF passthru driver recalculating the segments, bounce check
and ll_back_merge code is not needed such that we can get away with the
minimal version of the blk_rq_append_bio() which removes the error check
in the fast path along with extra variable in nvmet_passthru_map_sg().

This patch updates the nvmet_passthru_map_sg() such that it does only
appending the bio to the request in the context of the NVMeOF Passthru
driver. Following are perf numbers :-

With current implementation (blk_rq_append_bio()) :-
----------------------------------------------------
+    5.80%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.88%     0.00%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.86%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.17%     0.00%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd

With this patch using blk_rq_bio_prep() :-
----------------------------------------------------
+    3.14%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    3.26%     0.01%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.37%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.18%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.84%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.87%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 1c84dadfb38f..2b24205ee79d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -189,7 +189,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	struct scatterlist *sg;
 	struct bio *bio;
-	int i, ret;
+	int i;
 
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
@@ -206,11 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 		}
 	}
 
-	ret = blk_rq_append_bio(rq, &bio);
-	if (unlikely(ret)) {
-		bio_put(bio);
-		return ret;
-	}
+	blk_rq_bio_prep(rq, bio, req->sg_cnt);
 
 	return 0;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
