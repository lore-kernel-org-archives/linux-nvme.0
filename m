Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3819C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515572332A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515572332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HQ/v/6x3n09kIQPTaE2EpY8xrPJTi7UEOHUFxrD84xQ=; b=a3gRtCV8AMaRiV7qcHZafNlz8
	FnvBghwtdND1LdLWTeI8UTBh2Ci/DuONwO7tAnE1HihkJT3Ogd4ffUf+b9/1zszGDTkF6jd68nN3y
	uU6+QZ3jIrhOTHumvgaZpgx+B5jH3tEbJnExl9wUggsbekIuMZTP646sFdsoMspbyPxiBIg2ANJB4
	lIkhsYHwFoyyEqBtk9+lgJS6PNaVNwK7JvmBZAqY1NicKXf6Nd7Ll4lgduCOwcdKiuZ9Ho3aLkAsJ
	nZRQHp5n1xfGnqqajPX+6i85n+QHT4j2otSdA+Ll1FlYWj/wrSsdoq81OsrDqq87v19IFMWj79Cp7
	f68NMS44A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCAW-0000D9-Fa; Thu, 10 Dec 2020 02:59:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCAS-0000BH-ES
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 02:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607569751; x=1639105751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OY4vbICgytmL5IWLArxE/DC2aQl9ShGYUVut3uV33S0=;
 b=PPBQrF4/oA3t6sgE3xvccJ0VWBgWQEkHRhAG6gVLyjJlsgTxYABbYD1v
 sIdN+jHstCWdJpkLuJFrJTFWkKEXtXBXfhp406pCluiH/jk47hUTu/slM
 nNuzemGbul5RdAeCOnYzjCC99T3kImt5vCqCUc60b+Q0+JRTL2RoYppTB
 +b31PnZNQZGjvVQmBzvpRIzt5Y55MSotweKqir1DqdSvlu4ghg1M1Tfht
 KpISuxf01JLOUXzqIzKCtjhmyFh1cIPnRYkIA4rcjl3siF8JwmFOe7nWB
 CMBFxGowoHXRCCnRTFEFBMtD6tmWGpK0z1y+XRjqJbK2XJPjSF6nOTo3E w==;
IronPort-SDR: 9+p96GYjxykhlWH20BqMtxdJdi1JpvL5AI2ikMy2kYrrQpF4igA6UtwvAUX5DeSgpUV9TXilBa
 Q2ikNP443SZDhBcpywqKkA297bITO3XyNnq9LBx+PXWuJBRV/8xsQerms0kiwS3z8rClAPrZ6/
 /LqDnSXnf1LUZS52GzW4ObyroL3eNPXMysxPDBJmgGWrSOv3+m4I3VCRclLbMgsvQ7jnAfu36C
 /iggeP33zNgb9yc3X9ofiYKhysxB/IZA4mGkHOhFy1AqR/6TBL/TKlld7TIip9JhqqpBxYD4Pd
 Egc=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="258549077"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 11:09:04 +0800
IronPort-SDR: dAaN1cKM1RtuhYmlV2iYdn/TnKaaeXJOFmooiWKoBVWedylWcFJ//r4FXU8rBLU9zDLkrsJ8mj
 lZVRWrdkqeewlxVboGLenIegfJaD+9YXI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 18:44:18 -0800
IronPort-SDR: rYTryYsSel5xD22WKR7p32tWMV2DawXY1fsbWcm7ECJBaEtDQ7kg2akBDxft4w/8fISsxDbguJ
 CsjY84Lt2c7A==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2020 18:58:53 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvmet: remove extra variable in smart log nsid
Date: Wed,  9 Dec 2020 18:58:45 -0800
Message-Id: <20201210025848.46903-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
References: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_215856_697125_142E1CA1 
X-CRM114-Status: GOOD (  14.00  )
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

We remove the extra local variable struct nvmet_ns in
nvmet_get_smart_log_nsid() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dca34489a1dc..4241cb072f64 100644
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
@@ -86,14 +86,14 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	}
 
 	/* we don't have the right data for file backed ns */
-	if (!ns->bdev)
+	if (!req->ns->bdev)
 		goto out;
 
-	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
-	data_units_read = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
+	host_reads = part_stat_read(req->ns->bdev->bd_part, ios[READ]);
+	data_units_read = DIV_ROUND_UP(part_stat_read(req->ns->bdev->bd_part,
 		sectors[READ]), 1000);
-	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-	data_units_written = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
+	host_writes = part_stat_read(req->ns->bdev->bd_part, ios[WRITE]);
+	data_units_written = DIV_ROUND_UP(part_stat_read(req->ns->bdev->bd_part,
 		sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
@@ -101,7 +101,6 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
 out:
-	nvmet_put_namespace(ns);
 
 	return NVME_SC_SUCCESS;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
