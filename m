Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B6DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5333A2075F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 04:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5333A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A7wXHerAdYDfJtteSAzJ9zkGgpN4aj8HXUCJCwcTxVQ=; b=YhIdVBWoApWKiGILKo/9b8FWJ
	Mh4r2ZMefT8u28LXfTXYaXez3dxxOoUGA9o1Ch4sUOkJ91ZXmFpzJaT8Hl1BwGCwkLMi1HAGgeXJU
	vBGSROaWAC2Zyeg2YuNNAr8chkBgBq4F/yyYjWIeu3G5+TH4Xh4d4Ko1G5cqfPzRB0K7itJJEuzwC
	C6FMZJDmQOWoKt2lTLmVeHPO0atE7dOGn0+epDzTMKc+iER9GCndlamGPVcTM6TCJObroz8kAod6+
	wefJhkvKli+1ti7tsjnJcm4d4EE2V6KukvHIJ/jA+P3XnIpgJkk829Q1m9yXyVBCb9B+01lYtUEAt
	T0vF0pseg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwHr5-0000Px-3s; Mon, 04 Jan 2021 04:52:31 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwHqz-0000Nj-Hx
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 04:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609735945; x=1641271945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qkM42kcZ9zc4tBcyefLKrXf8ZYbEA6fHN+lHoYyXp3Q=;
 b=Cb0OrCZTDaAU10EuX/q62INCmqVOfOi2myTHwK73P3gC0Ab8iN6bKnui
 vgrpLuhyobbN3tejgW66A+yI3vSc9+vdNsbiFDAGMsKUDMETwAGTLlGbT
 Dy4uRzwMw8AetQzJdi9G/XCd7JGwCo0f0lNb4q/SE041YYbqlpThJSx2D
 JQLu86JtsTEV5g4HVLXhmOAcXbohUWwEjeN5XdDhMtmpjDDrOvh8ybfDx
 YaIae3sAtxoeuRuJdHEVGSWZTOb1/nxcclx3Be1Zyi1JjLb4O2CaOvGSz
 TCLj1xBCmZ8sEb/NVcuY1YtSAHAm/Tg2pRTy3iqxgOK7z41HEOeBagPpi Q==;
IronPort-SDR: HWQH6Pp/vMU/Rk5PWo9RNwiUq0x9ru+BLValuR0lh7xJxSIhfWSO5OR0348YOZG20D4MHcWkZW
 NhIRZZCwY9a0v4YMZx9eib+wcSB5xCoYgfoDTN75AtcfADpX4inmPlPrC+FDIeDkEHNjrHoNj3
 yRO9B4DlEYGDODHwXMEQJyGvcwt3lXhtplFr9RY28AKaLKf1zyWxxDp5TzoOIsdMZuLIoQdW7a
 i02DVbTZ/F4D1Ym9Iy+NsznRBG/GwCUT0A8R574LrQd7HjgA/chfAYN8C+uNIZ33skVD6lVKOO
 l6Q=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="266696293"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 12:52:23 +0800
IronPort-SDR: GXspqV+hMZK3vDkkbq9v+uzfSnX//0RyqWvy+nVZNLWLPbRwfv6gJblDOH9AxyY99rSc8qZ3Xt
 99hJy5gLm9nx85GXCjTKHEMmTbKqhx5Xc++vlHs40I3QlCsc+P4FlQvPlvpB0yqisDwM80H0Al
 6jaPpOJFVXePCquMr3T1qveGPThJn5wfxib/4jRcbjlj3FmsDdn5iUza+0TNVU5GiWQ02WkzRS
 0rKCjmv/e9gIb/MB3RHsflvQe3kQTYsX39pV6DAaQZdv+/fR3UOTFwuX9VGqR0VbaCflWuRf9P
 iSaMZbKJAjkE6kE5r/YH+tyE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:35:32 -0800
IronPort-SDR: bpKGrqjOOVAbI2Uf9j8YHqN91e8Ac58/U6Qlf3m3QqW/WTVlNB9pwwJB/I2iHIFGorBrzeRkaN
 +myIiLXydaumxtxAiWBPkrf2fv2WrZJ+HyKEeInT6Ywd5Qb1Iys0708OMnNh4fDz6dr2ZdGdIV
 gbFoA9UmNgTK6XoufgmgudBOawOYAtTdZqn2ddbvVcGkVXRkeOjm2gnx93ihphprbdFrqwRra6
 lqhYL8EqYwvTiLvqYj90wHcA+2HV4iSrSFclYoIOGhvjEqxc6XIfsjWYLDdjKFMzF0nIr6Ks37
 RoA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 20:52:23 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/4] nvmet: remove extra variable in identify ns
Date: Sun,  3 Jan 2021 20:52:01 -0800
Message-Id: <20210104045203.24472-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
References: <20210104045203.24472-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210103_235225_848219_AAAFB145 
X-CRM114-Status: GOOD (  15.88  )
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
 drivers/nvme/target/admin-cmd.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 99487dd479a3..eeee2f4a30be 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -467,7 +467,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
 
@@ -484,18 +483,19 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/* return an all zeroed buffer if we can't find an active namespace */
-	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!ns)
+	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
+	if (!req->ns)
 		goto done;
 
-	nvmet_ns_revalidate(ns);
+	nvmet_ns_revalidate(req->ns);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
 	 */
-	id->ncap = id->nsze = cpu_to_le64(ns->size >> ns->blksize_shift);
-	switch (req->port->ana_state[ns->anagrpid]) {
+	id->ncap = id->nsze =
+		cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
+	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
 		break;
@@ -504,8 +504,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		break;
         }
 
-	if (ns->bdev)
-		nvmet_bdev_set_limits(ns->bdev, id);
+	if (req->ns->bdev)
+		nvmet_bdev_set_limits(req->ns->bdev, id);
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -519,25 +519,24 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
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
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 	kfree(id);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
