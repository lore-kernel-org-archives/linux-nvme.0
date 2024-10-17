Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B257D3C526
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ujtw2arVjM5Rs5DsomNgJ+INHD1cLYYAot7nfqanUi0=; b=xHujM96IxIg3AZdHKua59LKuaF
	R9p7I/mgr7zYgY9QtriV+gKKyj+ZZ5aF4OPNsQl5LYe8ovFlhlg2YHI7IBssS+C+Hem34KFbpjRaa
	HKoewltFL5rqox/6U55QO3pCNMnPFtP3Q3eIBoWSjUq7ITp7S5StV0tBnUOoax3kFyJhR+HelpxNL
	V/eiVR3rnemwzMWfJAkwFDzOLhejdtQ5Nt8F9jA9qooUXOBVpqMk1gT9mS9Pv0vjl4a9OZnnRfNaY
	Psh37iR5DCxOXVmjrp934SjQRG2sQkfynG0tjJd4DPlqiAs1KkcS48YvHdiBRuiFssautdNfgb87k
	cEz28ftA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UzL-0000000Fpyl-1Ro4;
	Thu, 17 Oct 2024 18:12:43 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1UzF-0000000Fpxm-0ZpB
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 18:12:41 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HCh89O013638
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 11:12:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Ujtw2arVjM5Rs5Dsom
	NgJ+INHD1cLYYAot7nfqanUi0=; b=mE0TIvn03m9AmmgLeuvwtqNTipuTkQt2F+
	0bjarc36ttK9wg+fHiMK/EE72MGE6L4AjFXxZ6fuD8DkYWhCbROfevEldaFyUJG9
	fmADWkI9QVXNejgNcfhtn0S82+k4AHBZ8J/L+OBJJ9OVXl9ucA7XMxYCibl1fGfJ
	MS/vY7taDRk0J6EoI/B4O+uRSCT9SCPDkDigfJFVt2E7/q4KrrfO05+Sz66x+8mK
	IHl7LxJ6SKl3+UeJzH6kWS+r2gzSxMPnWENYwkYReSXcgSWIOsdsfCq9S2h0pPCY
	I8ErUXBRbeDIgr40Xe+U+tBqtKdZbYEC55SyXiX5MLFiSd9t8GmQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42a8davu8e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 11:12:35 -0700 (PDT)
Received: from twshared16992.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 18:12:35 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B18FE143B00BE; Thu, 17 Oct 2024 11:12:31 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme: enhance cns version checking
Date: Thu, 17 Oct 2024 11:12:31 -0700
Message-ID: <20241017181231.2937468-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UMtlctyT6VaY6Udi18c2zrV5D9q2dHqn
X-Proofpoint-ORIG-GUID: UMtlctyT6VaY6Udi18c2zrV5D9q2dHqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_111237_472397_B5123A56 
X-CRM114-Status: GOOD (  15.92  )
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

From: Keith Busch <kbusch@kernel.org>

The number of CNS bits in the command is specific to the nvme spec
version compliance. The existing check is not sufficient for possible
CNS values the driver uses, so enhance the check to consider the version
and desired CNS value.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Replaced the existing helper with a more complex version suggested by
  Christoph. Implemented a little differently here without a switch
  statement: I just don't trust vendors to not have mucked with the
  tertiary field.

 drivers/nvme/host/core.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e7e63e10e5a8..f4a26199e695f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1399,17 +1399,30 @@ static void nvme_update_keep_alive(struct nvme_ct=
rl *ctrl,
 	nvme_start_keep_alive(ctrl);
 }
=20
-/*
- * In NVMe 1.0 the CNS field was just a binary controller or namespace
- * flag, thus sending any new CNS opcodes has a big chance of not workin=
g.
- * Qemu unfortunately had that bug after reporting a 1.1 version complia=
nce
- * (but not for any later version).
- */
-static bool nvme_ctrl_limited_cns(struct nvme_ctrl *ctrl)
+static bool nvme_id_cns_ok(struct nvme_ctrl *ctrl, u8 cns)
 {
-	if (ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)
-		return ctrl->vs < NVME_VS(1, 2, 0);
-	return ctrl->vs < NVME_VS(1, 1, 0);
+	/*
+	 * The CNS field occupies a full byte starting with NVMe 1.2
+	 */
+	if (ctrl->vs >=3D NVME_VS(1, 2, 0))
+		return true;
+
+	/*
+	 * NVMe 1.1 expanded the CNS value to two bytes, which means values
+	 * larger than that could get truncated and treated as an incorrect
+	 * value.
+	 *
+	 * Qemu implemented 1.0 behavior for controllers claiming 1.1
+	 * compliance, so they need to be quirked here.
+	 */
+	if (ctrl->vs >=3D NVME_VS(1, 1, 0) &&
+	    (!(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)))
+		return cns <=3D 3;
+
+	/*
+	 * NVMe 1.0 used a single bit for the CNS value.
+         */
+	return cns <=3D 1;
 }
=20
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl=
 **id)
@@ -3113,7 +3126,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ct=
rl *ctrl)
 		ctrl->max_zeroes_sectors =3D 0;
=20
 	if (ctrl->subsys->subtype !=3D NVME_NQN_NVME ||
-	    nvme_ctrl_limited_cns(ctrl) ||
+	    !nvme_id_cns_ok(ctrl, NVME_ID_CNS_CS_CTRL) ||
 	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags))
 		return 0;
=20
@@ -4209,7 +4222,7 @@ static void nvme_scan_work(struct work_struct *work=
)
 	}
=20
 	mutex_lock(&ctrl->scan_lock);
-	if (nvme_ctrl_limited_cns(ctrl)) {
+	if (!nvme_id_cns_ok(ctrl, NVME_ID_CNS_NS_ACTIVE_LIST)) {
 		nvme_scan_ns_sequential(ctrl);
 	} else {
 		/*
--=20
2.43.5


