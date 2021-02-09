Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D5C43381
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B83F64EB1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B83F64EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B6jptdz4QbWK3md6zkh9fsuhMkrIizxhe/vybyFPsu4=; b=ZOqIJzimB6Pn+AuXUfVYNKUg4
	lysha3hHk+ozq1VGgKcXsqlXsv4PSQIHfFoXJul0J1omHC5QxKfbx4/hH8qKQ0Q7wpwNy0viJHGYM
	Ywngc0MQ6KU1UzuldxczkURhdcj47LDWpVLW9x+MoVEgrVdhl15yF30GzihTDP8kttXoMqkf+DBYP
	vyxT/DvlBBbiFbjhs2CENFGvogzeqkZFt0uG26woogHu6BFtDGeeCkQvMsOYtDRaLEfiN3P5ZqGB+
	5JYcIMcwKswmLrpkV3oitWqnGzpjEg9UDHdJN7O/isgjPdT8g+xnfTvNcJiU8GzJ/t67F6TpHMpIv
	t+kV6F2uA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKg-0002vt-TL; Tue, 09 Feb 2021 04:08:58 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKa-0002sC-06
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843732; x=1644379732;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b9WyTE74L8mTYOidDGJI0anp8Aw/5F6xkKRdT/iZJak=;
 b=HUTY5NbLo4SHfDl6f/urekYUeBBei6xD36pnK/QXUCJY70Pyvn4rg1pR
 VqNUaJXQxZ+eRT66VEOgz0psTyEcCCy8FJEAaH3qXLvm+RSwQUtPowMwj
 TPajY8n9RQjvP2M/twxgqlbdCRPyUY27M3ToFtKW9TGU0JlXITAMlijxn
 BpjODOMtxIuM6zqDsJopHGMrx4PV8qpoyZjQIYXZygLVAcn7k/h9kthn1
 ctGRSHtMOwrDyl29CtC5eSr6070tODGeWxrce5h1YN4D3UUTdqOblY3/T
 vJKNpBzw1DnkXp2eycLE1vva+vjEpULC4cUhW8QATa5I+dXWZw4N6aO1R Q==;
IronPort-SDR: 6c8g1OJw5ylCJyOUbczHkFRRYLEoAoAKZybOFx/A1vkrDuaBg5rmDCddR4sJz04rnL2qbTwWER
 Fs4dNzsovIsl2bFVjdDnv2Y2hhsT/xqtAJQVe5oGxH9CNEmDElW0rv0z55SD7ePE1a96XZ6I3d
 0t7bvQRC2Dbf0PTqm8vcpc1MSRisvd1HeOdkcCfp4v7gjuN56W5f/4or9Aqu/upttFcU0GTKvC
 JiqALiGK4nhUZKV+4wtPYxkyTW/m6J5j1A+KhfXvyg5V7L6T5pkRITzRMeLtnwVRB/tdNQftgw
 bDc=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970520"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:51 +0800
IronPort-SDR: QFmwt5LEjS/yc1hry0qDF75hRBvyWLoMvQybI6GO/IrQcNZXq+Idt+evSG4U4UpS2hDo+DIksi
 4RyDjJnG5ydJTEPAV/hSnUpDXumorTWuu6WNulPiWkhIN7wB2NSZEMz31qYSfSMha8EZIp3olT
 jc2w9IWz28CDn+u4of4x1uZlQxGgT9Gvg/NIVo24EwZKzbwNnRqI6eIYPMGPCmnv2JVi5hKLoT
 Ha6D/jr+KkFhp/DPFpwuGiVJ6qKACgHCHqC7dr2J5J8yOJTHA+R4MBQlN5QQn6TWZqOhNEgwTV
 JNHBoMh93RDgr2mOCUsBm4Ao
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:45 -0800
IronPort-SDR: Qvf4z8aapTWA6DldP+/Val5y4yxljKMj2b0b0J/i0yjZTVy9RR5BWaXXbg9ln+jRQmWN++TlvP
 GR5D37/8GHeDKltA4a2KiGFEwVhSH9ASQKGYIdJ1AcUsPulCt+sWhHEw0gQ0QHioAQIu7OdqoO
 jJJNrIxC+nRh63jFWbyz7WrlA9dLgaIb/ZtxZg0h9Pk+nBz/2LP8VTLHJ4YVsRfdobbazgZuZr
 CMwNrwdCyOGbB33RTwBztWaldZxcr+NSfUDfHcHItGZaMf/tBY0RppnOXJaRPuVTDLvGahd5x4
 yLQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 04/11] nvmet: remove extra variable in id-ns handler
Date: Mon,  8 Feb 2021 20:08:36 -0800
Message-Id: <20210209040843.45572-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230852_209947_A5520624 
X-CRM114-Status: GOOD (  13.48  )
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

In nvmet_execute_identify_ns() local variable ctrl is accessed only in
one place, remove that and directly use it from nvmet_req->sq->ctrl.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 787e41d48a92..d551571b538c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -462,7 +462,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
-	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ns *id;
 	u16 status;
 
@@ -529,7 +528,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = req->ns->blksize_shift;
 
-	if (ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
+	if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
