Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89648C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDB060E0B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDB060E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/mir78i55LyZcXKSdz/UhJgsxchFMSVFy2leSXFP03o=; b=16+oDRHUuMWBmn
	HVzEKOD2ryiNw5ew25nLUFcyhY9FNTI/8XU0Qw+/b7Konp3elJr6LHsPvNQOP626MmHE+lZgjeP+D
	gxr/TirXsZZxTROTtGxp8abXVVv3Byjh4NW5aQscha1vzIXG4mpo4kWW5BuDGJSb/qtb2hT5X+/pc
	Oou1BxJlgD4TOKBPCKPs+6yTYSAyxPeNo4mGsb7ySuB+4xtA0UZa26P2lXzdRsVgs1pXUO4tl8FqQ
	OvrTeErhlFJdjtKtHBd8pCtP2BWeE8eagGbXXTzHCFRCJRAndojkpunmjKCRbxgykP/bXB2si8v7U
	F8ngjJCyCLF0//glteJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjYo-006m2k-Ln; Mon, 28 Jun 2021 05:11:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjWr-006lWH-VZ
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856993; x=1656392993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s+exM8yd019bE0EW8WF+kxYnl21qsNYu606uWq38vdY=;
 b=VDvv0iE2Iwta6rzcghsMK6JEaNZX1Dffag3daI1XrWKo4e6l96gw7EhG
 MM0swtcAQ/nY/mt23MNKBI/vZfosRMbzYPDzG/RXP1WV3ZRP4e0I1NKoq
 6B3PMc2CZFqwGcJRJdQje235m68kkVK9jU3DlXcD0XlEBIp9lhR52py9J
 /wFUEE7bchWpZQ8vHHQ7xd8S9U1OIxFqOoOSpJVi3Wkfe9fcq50snvL8j
 XZoJxdohPMl+nsTMrcmpsozoORQnXygzbnJ4veq3PqeMDapakcohGyRIx
 W1XKlEcaBH/9Hgf9jbpUCgc9UCDvfsPd0FKX9DhfZub9/cd4tOq7YbM/u w==;
IronPort-SDR: JZXaWpduJ/XExW8+JluO9mroIL2Su3I/kZDceTQNAYuN2bu3KlUMvX1hYbwrTNl9cwZwRCllh2
 fwbNzFUMf0MiDqzEexrnftC2drPfRv2+Bk3OBSpzE/boZYy9Pg8gobBMDJdQioTZ36Z3KRabie
 tyeR1fXE7WhFoh6Q6kiTVtLCzHkAO8xabT6fsEC1Na0rOYZM2d3f701dEhfpK99lL4A876M/86
 wzbWXh5mLdX99zQOn57ENROcNcpIJr52w0+FxBMUY52fm+W+inKb3Ehizbd25cs1p4/VcY+AzF
 p6Y=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="173060198"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:09:52 +0800
IronPort-SDR: AxMejh9Si6+8fI5KpyexGZxpFLMTmpqnIr6x9N6jxTIdRyMO5Ckgw9yeY1+OhVTh8jBOEEIWFz
 YpGpXQWb+ZNvwPYsvnKSEB61JscNSS+vSawEu65KQRx3//Q63lSvprrH2iHQYnqmzEmiRO0szY
 5e/o4/HCGiqIpTVMazu3gjUw0ruW6kXySuaihVqCoxU5fvDR6NXsQkjyOfPd+m1vG/KwSwGUhk
 ZBUUeDoZZfwVVur1DduMagUvys8GUuM1kqGCVJtV25zenP271cyX6xOjMbY+kVFHUysZXlGftT
 oovFrg6ppHdr+uVAPp3/gFQD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:47:04 -0700
IronPort-SDR: FPsJ3Fe5ZMphy26RoHblqxu13oKw/F8SVMhud5NPlP9BE+x+Lwq9+t5ZRFK1RFNfI4q4EVshSR
 T4zjAgXs5m8tbxU4xKBeoMR/PI+o9+Y63QHWoTaRxIeZ6Y7WLzUYRyRXpLSyyL7CqxLiyAWuQP
 qTFQsvujrMeEkTDMKTa3Cmpof9n3EQkixjJvCdBn3SROLH1QGomNDHTkw67J2brtO6UtVmWHxU
 hA0Et++JHALzakZHnQ9KpwMvD74UdLDW6ec0PxuJ2tm66kA+eRdVbDBQGPxn84BW6Fri/TDhcj
 E/k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:09:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 09/14] nvmet: remove repeated call for id-ctrl
Date: Sun, 27 Jun 2021 22:08:12 -0700
Message-Id: <20210628050817.19788-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220954_081427_4F246E0D 
X-CRM114-Status: GOOD (  12.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Return status from nvmet_execute_identidy_ctrl() and complete request
in nvmet_execute_identify(). This reduces number of repeated
 nvmet_req_complete() calls for log page handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 28c24c08bd99..4f88276e0c48 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -349,7 +349,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
+static u16 nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys *subsys = ctrl->subsys;
@@ -364,10 +364,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	}
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-	if (!id) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!id)
+		return NVME_SC_INTERNAL;
 
 	/* XXX: figure out how to assign real vendors IDs. */
 	id->vid = 0;
@@ -484,8 +482,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
@@ -709,7 +707,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	case NVME_ID_CNS_CTRL:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ctrl(req);
+			status = nvmet_execute_identify_ctrl(req);
+			break;
 		}
 		break;
 	case NVME_ID_CNS_CS_CTRL:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
