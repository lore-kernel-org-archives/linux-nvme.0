Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCAAC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:15:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E431E23117
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E431E23117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G/vwaWJELbohaOzKuf9ESd9dP4MNJ+UmyhrqmyOmDNs=; b=k7azPUzDQ9bviFyR3CdE3wBLB
	i+chA6nCaZoMXAN4qyomTXYKRDynxvgAX1PJd7En2eb/NT5EIeWe8TbYpoRbmlsgP9oLD1SGSYwK7
	4eNUOLJHzODxdILo7yG3N5G0vAd6zXoglm+chsvgubMWXUVN45YWKsuKeYsbz+PNxEXZ6exR213h/
	6FmoAQGzS/PsIG6962dKv95CznX5r7GUn3qzJNCNY1MmJGuSRZ6hBwL0Zv1t9wrwggL74URIXz3uM
	JtVDHCtu8u8e6pcHYWu0mMuqAIlKrovviHnqNikL/BVFnqRMcquKgCw4Xak5vN6xjefj0Z8nseHbn
	C/GHXfWmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzQzy-00057K-41; Tue, 12 Jan 2021 21:14:42 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzQzu-00055E-BH
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610486078; x=1642022078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uyjCMQqY3Np/PjmwiZ78wPcvHpLOXQQJcg5ChL/AY6c=;
 b=q1FE0aY/1aZLSiPH8sHSNMW8m0P6HF6RwviNfRa4CAWPQXRy+WUyunl9
 a7YzApUfMfcQYLTqmqU7qyP+EDFmgohGJkAoW/m35G9I4qIF7JinLQtxI
 frBFYpRzlyJMlpqzYjx5x+rg0pbxuUJSqZcDH18Z0FVz6ZzrQ+GZRVNYw
 TL5nOVm5rgmW/imXtSulRdA2aFHXYZjnCWt0+zu1vfpHTfiXqwpl9qXFJ
 og7wWmNiyJ9KVYLm26QX5QGWQNvMMOvZ7NOkymavS4NhmlhLOvz1ytEzN
 2R9imz3FTaPBTM2/oQWb94y/M5kWh/MRM8QHE1366WA10gQMlbtq1HtNe A==;
IronPort-SDR: kFSpAQ5ACzr9FwJNa93CnfKFu+l33tnql5blUqQdd6JMpFhn9HkzK7ITLc51G0pqS9cB4iH4eb
 5JespOfWtW/5HtMMSUKnSi+3VCGyk93CJkkmVsRTZFrHNxsCZAn/vHxZ3CzJH30u1l5OioVkuT
 XVNilQMjBZqiJxCtN0Xf5j2PVIv5fsRSsQdH0sDCeHMnMRLGZQOoY2IimPSZQo7jxGk4UTXFMF
 hVWb7AguNT3WR/C6My70I9jWYVfyoWOnOIyH/oqJ2DFZNm4hT4d72s181mnKdZJn1S15Ngqiyp
 bH0=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; d="scan'208";a="157272249"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 05:14:36 +0800
IronPort-SDR: 0mnAki61f7EPwZnTUCi60KnKkLUoZsz6n9YdHx7aXK4nAgZYqa2srkDawAA6mMGH6QM4oKBHgX
 Jlog7xswqRzuwM8Tg00vy7HjUry8Ew3DK0419SstCeFsEzVsVx4GpeKkZhNyrPr7enpmZDuX0l
 57jGfBsRGDbiLgOAKZrcNVBiLdnOZscg9QZV3e0Pwb4SoeLYGOVp8LmUoa1xn9dFYqz/hz46+c
 y8LHhiCpJzdGm3cA2yfLGtj8kXKmCPxu9TeTIzWWCGhfPwlTsIXLvDAf2UJWzBZlBk5RgEEHzn
 Gdka+r4dKJSy44wg8ZS90gvV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 12:59:21 -0800
IronPort-SDR: cLMAQc2fud/DNb2qN1QydCEJ2tq/p59Gq+0zdCh3jxRusE5YuhCGl4fJVv8wRp2vYbmlbkzlHy
 0bDYHu4Y6CLlS3DVW1rs/BsYN5mRZGyGqVewyLaXGi4VtIHwApllhKQlxhYtRyjFq3i+/suZT4
 LtO6/fgeNHZsSUo1sB4TPID5DSYJfqI9ce7h+lW5WR/5CqvxSXcuS1gsTk0dbL60raIxBBMBYG
 VebrOJ4apzhCaJ562LoHhbJIcm8vniJGNPHZq/xOvSbb+EkjX4ZnDV8c/sgA1NSgP95sqB/5V4
 jpI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2021 13:14:37 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [V3 3/4] nvmet: remove extra variable in id-desclist
Date: Tue, 12 Jan 2021 13:14:09 -0800
Message-Id: <20210112211410.24742-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_161438_613301_0C325735 
X-CRM114-Status: GOOD (  13.96  )
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

We remove the extra local variable struct nvmet_ns in
nvmet_execute_identify_desclist() since req already has ns member that
can be reused, this also eliminates the explicit call to
nvmet_put_namespace() which is already present in the request
completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d6713139708a..5a75676da259 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -605,37 +605,35 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
 	u16 status = 0;
 	off_t off = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
 
-	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
-						  &ns->uuid, &off);
+						  &req->ns->uuid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &ns->nguid, &off);
+						  &req->ns->nguid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-out_put_ns:
-	nvmet_put_namespace(ns);
+
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
