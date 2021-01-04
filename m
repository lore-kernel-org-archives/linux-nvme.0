Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C22C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB402075F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB402075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WBVCcqTQ5PKjO+/AoIbS4us+FGyC6yV3khTt8wmfrvI=; b=fEm4nZjPWRMmK/dyYH6a8TlT3
	nluUix6OQcmF7zQZzioN/hyifWHcm5d/BWVsKOoQAGk7sYk9UvaYO7fuh60szqCIxzmb8hHc+Bl52
	m0sRvXPsClN0M97eHducMI1S2Mf2fhFwNrQwmIe2l6d/6vC5bvr4UVGlweA0+J5/plKZeQ6tm3duj
	jJluUTkh6GelI8lzMYuKNivWnuaoQfUJ8OjpjawjrQKYVPx2oczz+zQRIJfxovuzMNgMnxzo0tlV9
	yf8iYImisdelG9QWFcwik076bkANvrP3iQCUzlg3nKoeOD0EZU7ILemAEr6U12UGvOlw9DufiETss
	tqZTlffxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwHqz-0000O3-TS; Mon, 04 Jan 2021 04:52:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwHqq-0000Jz-JX
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 04:52:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609735936; x=1641271936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NU2zjC3A8mznKcakAiM2PBApV6ZmC40j+jDtA47Qsn8=;
 b=XbqvvbbsUvWoIU2PmVHoI3ElAiEVE+XHSFJHlVMDB6huMTJtMXPVv8qY
 2u3wP99J6to+qQxb5lXCORok9AM2mtxoL/DLRVTrJEapGNuuHhEQFxmJ4
 MuRsY5GF3/UoXW98qErMUFMIR3eZ1lDo/rBo7K2Go3bnfxFYwEt5toUdm
 1ARaef60g+0ulGD/wlslJVBa7rCWHVwxa5l8pNoNlLm1MIbzuHUlYBoa1
 AZtWT0+iscRwKgkCCt9J92F9h977xo3crWBrj5BLZxiDsVnyQWZJOSerG
 tgQTM13geypj6WTJqeLPnRPOqtU9dIc4IL2syIMSxiuz42mQlQz45KXEu A==;
IronPort-SDR: aEVTyVgdJECfrVQHihJz0mWs/w4AaA/ldbEk2rKDdbCDN4q2VQ0fb96+6h9qWKrr/bjDyeIe7o
 a7pOaKoUDsRtYDyYuMPvBq4gRThGnfZkysyxUeBCuFvBK1QuFBldwHvzcAnb3koElxOaFVivwg
 dies457GlICCPwtMlRu6ofoe8hpUfsyGcMkExdMS48XOrmbhSgEwRFIPYMu9dvJcVF5uLFUnbC
 RcnXO9drfl9uRn8Sm+uZvZMDMeFarbeOV0beVhtNJYcLCYuN9iC16L01ivLqzN/5y/Z+kEMUo8
 l+w=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156434432"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 12:52:15 +0800
IronPort-SDR: Xab6dvd1L0Ysgix6Fb7oXiDcD9R9buE6oC2YyZfe2v3YH8C7a3ijHzui+Pv41jPx91wmsFE5Oy
 tv4Y6CRvizEgAeYcUgNtLaP1x0nsHmqu9DU6ReKYiZBpm9cbJKxma8/oYrKTWjYFrSR8esh7hl
 NnQ9px4BZ2LR2rIbqKLaOML8iMDQQrLrtfpRyZUAPWNLuSMHLljUgd8CVNUJJe74Ic4yFTj/dZ
 UYmtyfzH+O98dqOiWd2vYy4EXI3D1ljKMVZcBtYVFLX/0ldJ5avM6O7yvo/3c9N6Y2UvAk6sr7
 XOnBqORZVX1/Z+2BmyjFH6OT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:35:25 -0800
IronPort-SDR: e86AkJnNrL9XuiOWMHE4zoBEQ0+ZLn0MKAtNjQXWoMZcGSV7qafEDM2ATIUkcPh3d0aA5/fbQD
 HGnfYSgDF9LRUmpHZ1Bp3h1FFPyon+3WkFBup5+zF3JVtoC1rS9wPriXxJPkwAvnE4BazW+D0h
 jpGqvmKH7MVHPZZKPxZffRcyxMRilEh+He1TGjtsi/ESmhPG/lNjegAR9VkAvQsCMCRPG7/soN
 BfgquSWk3nnadcf4cA0/OAIG0Qhe5i9RFeBv85r9Hg+IliAJ15vR0XMkml7OJOfkKhZL7yJk7f
 KWQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 20:52:15 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/4] nvmet: remove extra variable in smart log nsid
Date: Sun,  3 Jan 2021 20:52:00 -0800
Message-Id: <20210104045203.24472-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
References: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210103_235217_869850_28D635EC 
X-CRM114-Status: GOOD (  14.14  )
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
nvmet_get_smart_log_nsid() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8d90235e4fcc..99487dd479a3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -74,11 +74,11 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	struct nvmet_ns *ns;
 	u64 host_reads, host_writes, data_units_read, data_units_written;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl,
+				       req->cmd->get_log_page.nsid);
+	if (!req->ns) {
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
@@ -86,23 +86,21 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	}
 
 	/* we don't have the right data for file backed ns */
-	if (!ns->bdev)
+	if (!req->ns->bdev)
 		goto out;
 
-	host_reads = part_stat_read(ns->bdev, ios[READ]);
+	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
 	data_units_read =
-		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[READ]), 1000);
-	host_writes = part_stat_read(ns->bdev, ios[WRITE]);
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
+	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
 	data_units_written =
-		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[WRITE]), 1000);
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
 out:
-	nvmet_put_namespace(ns);
-
 	return NVME_SC_SUCCESS;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
