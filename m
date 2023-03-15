Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF4BC6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B6hoERJuZrs1tHir3uq90nOoe/14U0zWQcSdL8E8DAU=; b=TF0LW0AO2NmLwD2BXCazZcfnzC
	MDGUKtOWCwsRQbf9uSmWPgQc3A+ZSEv3MGHs3BL2ny+r4MNJuPz1ccXvRKr4qZmSu7UerPbm69AwQ
	bgbRK0hPpNPgQgiZiTYceHl9kquCcZ1tWxNRytdmDYWx6L4oS8MIgLURsom8nI8wrGL8rXWL08MTM
	ryTtiyT34VbplnLPBI4cx4FCCMavYrfWvQDTU/7P7O66ibvXgzrC0DydoxgTYFzYacDJBw8NzrW7v
	CeC40kZJncnyx0SLi+Vm96sD1mSv1/ex5UX4Jsj/uuHF03ksaT6uP1u0H/P5/QQvEIqZZTMulSKvP
	me1gac2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrP-00D8EO-2y;
	Wed, 15 Mar 2023 10:59:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrH-00D87Z-1y
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678877991; x=1710413991;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WksZ+nnpU53A1WPX8JDOcQJtCnmS9VCB4tLS6ZrPU00=;
  b=DCdIeH3/31+dHMdGzXNq26a22VRbdc1mY7JK2ZX+0FKpBWVQ8EzP4X0+
   gCk8qQ/GIEMwf/bSxSX2lcYYYuYjhmi2Ic50WBQr0fFHr/adBjH4ZIjkT
   GQK5AngRphO5z2fj6gt7FamUTU7pOYUIL3tkgvBpAutbgcCwntcnAc3Ia
   Jf9skOarG+4sZVMi6ZpNiwKN5hKm0rY2/AMOD1QYDfFpogN+40AlYBVR1
   iVO88SyqbSg8PLQR8zKDWNMwRfNA7YMzpF6kD7NhcwdURWSTCg5y9ekWU
   itf3EMFg5LPjRfsEOxglBIg1y447SN82ijhmX43/mkYmVqf75hyf1vYqg
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223966398"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 18:59:46 +0800
IronPort-SDR: X62e0yHuc5f85If0+MOrlTAHsNWhArXOsqcCt3/JBDgoLVxN2UImjbued8eE/BjKz3kxhQSNSr
 S3sGpLxhNDSpZyrkzOGL8hgxA/eK/6bVPlxHxzBBtaYIgdZ/UpF+7R7L8dmGUWwONBIA73vTDV
 g62Q+1FIhZNmkW/uO8EGOfadOw7fL/vIm9DG8AT2dAtIi5obYg2FeFyOCjGIMLcMSbiMFiqrbo
 TRV9gUl+3s271jciW5xUA91sUjEssUbwy2uBXzkQaZGwKXwnLYOiz5jpFL1Ivjk2lszZNLwydL
 7P0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:16:13 -0700
IronPort-SDR: IRFHaf0f5Rgf3XI8U7glstOE7OQcoFiTed6mQlkoBzI4x+UcNSs16rwNtAMQ4uvQty6GTuG2jM
 enezguUoFbs5CsU3XaurPnXmaIUtMa9+mFCwl75dID/14q0yCwCkoUY4f3PPbyGt6xSe2XETJv
 NF5RSsivfVqHLcNp25Fe3A7klWtDVbyfEVHU9pwVeWlVXoCU6IHMk2tLI+sI9f1lnHc1+naTxH
 ilcnly6vuMcXoq4WUp/hvOTUGUnbS0jgw21T4vOZyRmLyYcystzSxtsN3DA7mptPOf//pVewBz
 FqI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:59:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc6q611B7z1RtVp
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:59:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1678877985; x=1681469986; bh=WksZ+nnpU53A1WPX8J
	DOcQJtCnmS9VCB4tLS6ZrPU00=; b=mGEDN5brdy5hKeOBp2QEWGp8Sbhv/s4PMu
	7oLP8ZrHaFzL1/ZMbfKAAsB5mk2fmviZVfh4c1YbF69hRy6dZ2zxYQ/4MUZ0NW+j
	TX24Ik1vp3gyuZC2uQV5rb7/H1H6LqhUTMrGeTJ3ensQ0L4NYW7e5Sof1xxTq9Qf
	l7bvQKlzegJHMgbLvXnzcpmSk7FYNsjWLl16EnGs8fFoCQdHZ99VnzpWZ1sUo8nn
	aFnzDW1NKNIqhmZJ1vMehSxVcj0Wu8G6kpq4uhBoEY3c6S8bejpEhj7Cgej4WwE7
	bbgXNIpI/ETgZ8HIM5Nh8Uf0xKQBXtGY2ammuO3isPG+4fPdug5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n2l5T5_uy8g3 for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 03:59:45 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc6q46bHlz1RtVm;
	Wed, 15 Mar 2023 03:59:44 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/5] nvmet: Fix I/O Command Set specific Identify Controller
Date: Wed, 15 Mar 2023 19:59:38 +0900
Message-Id: <20230315105939.305825-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_035952_114420_3866E31A 
X-CRM114-Status: GOOD (  21.38  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For an identify command with cns set to NVME_ID_CNS_CS_CTRL, the NVMe
2.0 specification states that:

If the I/O Command Set specified by the CSI field does not have an
Identify Controller data structure, then the controller shall return
a zero filled data structure. If the host requests a data structure for
an I/O Command Set that the controller does not support, the controller
shall abort the command with a status code of Invalid Field in Command.

However, the current implementation of this identify command in
nvmet_execute_identify() only handles the ZNS command set, returning an
error for the NVM command set, which is not compliant with the
specifications as we do support this command set.

Fix this by:
1) Renaming nvmet_execute_identify_cns_cs_ctrl() to
   nvmet_execute_identify_cns_cs_ctrl_zns() to continue handling the
   ZNS command set as is.
2) Introduce nvmet_execute_identify_cns_cs_ctrl() helper to handle the
   NVM command set, returning a zero filled nvme_id_ctrl_nvm data
   structure.
3) Modify nvmet_execute_identify() to call these helpers based on
   the csi specified, returning an error for unsupported command sets.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++++------
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/zns.c       |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index ed8faf7a3b2f..545f98b2cbd9 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -668,6 +668,13 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)
 	nvmet_req_complete(req, status);
 }
=20
+static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+{
+	/* Not supported: return zeroes */
+	nvmet_req_complete(req,
+		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -691,13 +698,16 @@ static void nvmet_execute_identify(struct nvmet_req=
 *req)
 		nvmet_execute_identify_ctrl(req);
 		return;
 	case NVME_ID_CNS_CS_CTRL:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			switch (req->cmd->identify.csi) {
-			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ctrl(req);
-			default:
-				break;
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			nvmet_execute_identify_cns_cs_ctrl(req);
+			return;
+		case NVME_CSI_ZNS:
+			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+				nvmet_execute_identify_cns_cs_ctrl_zns(req);
+				return;
 			}
+			break;
 		}
 		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 89bedfcd974c..34cced5652cc 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -581,7 +581,7 @@ bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
=20
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_cns_cs_ctrl_zns(struct nvmet_req *req);
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 77ef0a86ff61..fb99c3f15356 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -70,7 +70,7 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 	return true;
 }
=20
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+void nvmet_execute_identify_cns_cs_ctrl_zns(struct nvmet_req *req)
 {
 	u8 zasl =3D req->sq->ctrl->subsys->zasl;
 	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
--=20
2.39.2


