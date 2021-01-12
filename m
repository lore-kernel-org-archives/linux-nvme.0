Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251EC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:15:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CE923117
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CE923117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=utVVrFyx1HoVUDcERFSymBtOcHJCjWTfNRnl31uy0ao=; b=Hbw7xDkDQgw3734PsrWB0/RWX
	inVIOwBjJbJgiqzv3PkIPkF6f2DBSvWlp16Dm94/1s6RplNJA+G7s/ITqTf/M2agYp7EM+XFBAOyK
	6ltaH5DlWCSHLmyGCFa3VMBsBZLR+3S2Q022iMHPhCJLm6VzjmGPOxHhzKyi1LtitUUqpY7nLYfxd
	d00SLxSKgBkBksK+sV7Z/Ubh4GEeliQ5zINfDjhdlvA2I5TFt2TDnDoPuz3Z8oTKMaRTkewW48bRb
	e+RAKz3+aixUXM2rd3+gpUL8ujzJqU3J0cQ5r/LioG6jxYirv+K7SI4m4AB6P6pr6jLnnUm9T/JJE
	YNzIEgOXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzR05-0005As-Kl; Tue, 12 Jan 2021 21:14:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzR01-00058n-Ff
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610486085; x=1642022085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H6WKAOvS9K42+IxKmAFc7sFIm6sD4xp2WIr4KjkcEQk=;
 b=jycerl+TyKKtaTGHFk4G0JHqtLe2cYH8A18vjf51Bz2wRVOekB6btjqX
 cvfE4T/z/CSgJAEu50vS0WepOzqhvBO4H5kbaIUxyh3ghdpcfrIfc9yfQ
 lSBrHgc8stUJQ3pnDHsr6O1+6a0AP4ZMEmzRw4MBebs2hIpZcAvT4rHOy
 TMr13yOYyE7RonC0gMu7OsC8N2jVxb/jM9n9tK8BHRbNmNNKD2gKG29sa
 iyN3D6vKv8DxXyLSuBWBZG4JitIThvTdGuNcoE/GL75Cxrj7Sl+VQo0qU
 ejsX5Q76E57Q4GKIFZyKK6lSNzevQdz3RkNKDB6FchoQD4KN4clED2KRv A==;
IronPort-SDR: d/ZF1g3Tq7bvgzgqONODagd6qiqSURnK2zbrJRxthEv4XmR0MZg65yPpOMY4ttAOWlbrQhktrS
 zcJ9WCl3gz0DE3Fbr989TKTxPKYSQxwoKDB2Vvk/3EIbLftCWmR5aFeSfXJZDu2qvZlLweSGJf
 FDSD0yhlS17+TjPrjEjp4mXN+Y3TOWmwjA6f2l7Zz0XMO71QdJqPm/y7FG3kiCEH7WZ2/BwCU7
 Bey1et6E2CaeBT1JopHwDEJ+M7AG2LWd4/g1S1aIPYo1d+1L19D0tkBfYFFQ8+WUrcXnmzJw7g
 lqw=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; d="scan'208";a="267576977"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 05:14:44 +0800
IronPort-SDR: Rb+9j4GXjLncRii461ovbP+BNE1v9mY7mO68ZUHzddrtGQUu0HIZooU0qmS5ljsRDBkCOCYGED
 twGjnREAN5ZHby99lhLeN0du344qW8mJODVP3vkDWIlC4lZ9AcEGhNDQVOmxqM1Yz6CqbWRgNp
 j5QRBSOZx2zXldmEXqtKcpCMbtj7zcf+Wf3UZz1h/Sbs65+lsUmo2wqColRHclSXi6WDyDuBL+
 GCSr6kwmAebUnbHYp85JSlagA2nJK2RZCVmQGQHhsCdle2MxUHQM4DhLEvgiC37xihCipq1A//
 lb/JzHgUxoUwhtnVSnC9IQY3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 12:59:28 -0800
IronPort-SDR: nDGSH+p0kz10LfPAjYXD/oB5hqEzOPDJ4CZrVbh9ctWYT6rVZM1Ogit8ZT7bgINadEkM59Ngca
 X0+YHaP3rMLpUPV0BeFTy9xTzVGnasIJDBGSlPS8RHlr3GPYgFuMvhVukKWZoIoDuPmByk22D6
 SqLbkMJ8qYqqoHlz7a1bGhz4qoMSFlJsh7h7tfvf8juNsMPPMmxRYD6ZSaFYgneCW8eZ7l9s0+
 14Z48Oz46972MrjJ+VZ9viLQrCnFFJdXGMtq1ppYmSsHQkFTdgl9cZCYJrOoSI4DNHKkdUVt2h
 Q3k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2021 13:14:44 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [V3 4/4] nvmet: remove extra variable in identify ns
Date: Tue, 12 Jan 2021 13:14:10 -0800
Message-Id: <20210112211410.24742-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_161445_839399_CC15B332 
X-CRM114-Status: GOOD (  16.57  )
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
nvmet_execute_identify_ns() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5a75676da259..1952ff28f95c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -467,7 +467,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
 
@@ -484,20 +483,20 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/* return an all zeroed buffer if we can't find an active namespace */
-	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		status = NVME_SC_INVALID_NS;
 		goto done;
 	}
 
-	nvmet_ns_revalidate(ns);
+	nvmet_ns_revalidate(req->ns);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
 	 */
-	id->ncap = id->nsze = cpu_to_le64(ns->size >> ns->blksize_shift);
-	switch (req->port->ana_state[ns->anagrpid]) {
+	id->ncap = id->nsze = cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
+	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
 		break;
@@ -506,8 +505,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		break;
         }
 
-	if (ns->bdev)
-		nvmet_bdev_set_limits(ns->bdev, id);
+	if (req->ns->bdev)
+		nvmet_bdev_set_limits(req->ns->bdev, id);
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -521,25 +520,24 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * controllers, but also with any other user of the block device.
 	 */
 	id->nmic = (1 << 0);
-	id->anagrpid = cpu_to_le32(ns->anagrpid);
+	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 
-	memcpy(&id->nguid, &ns->nguid, sizeof(id->nguid));
+	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
 
-	id->lbaf[0].ds = ns->blksize_shift;
+	id->lbaf[0].ds = req->ns->blksize_shift;
 
-	if (ctrl->pi_support && nvmet_ns_has_pi(ns)) {
+	if (ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
 		id->mc = NVME_MC_EXTENDED_LBA;
-		id->dps = ns->pi_type;
+		id->dps = req->ns->pi_type;
 		id->flbas = NVME_NS_FLBAS_META_EXT;
-		id->lbaf[0].ms = cpu_to_le16(ns->metadata_size);
+		id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
 	}
 
-	if (ns->readonly)
+	if (req->ns->readonly)
 		id->nsattr |= (1 << 0);
-	nvmet_put_namespace(ns);
 done:
 	if (nvmet_copy_to_sgl(req, 0, id, sizeof(*id)) && !status)
 		status = NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
