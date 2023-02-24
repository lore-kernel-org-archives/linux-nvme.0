Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ACCC61DA3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Feb 2023 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iwaPEzT96cQpT568djOJgr3K1PItxgjQwbPotxtdMaE=; b=LTOvKqhR4x49h7weyE2SFZPM0B
	HYwRFe32u+bZNaSDpaCDOL457hnp7PRS+HqCX8IOzQMSKmnxaMKZldAOVPbmSV0dN+/h9gIMsWIgk
	FMd14xE3j2bDJAgYZFnESXLPsYVSikxQZmNMCZZJyTHJnTXysM/EcmKg1N2aOxNFV1256ZRlhOQ5C
	EOyxfqhb2l58ZY9tdn5piSXpOIHSFwjjcmH2aTYaxrGyg63H+qGHo0T0w0B7EinqFeG9PEJbs3Ye0
	EpXnWSRft2IMa0Ips5w/uJ6DEQ445sOkQAE/Qyegf2IFKQAIJshJgr9O+Th+deQoCx8Bu2EbeNNhn
	1xH4bs1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVa5v-002zBs-HY; Fri, 24 Feb 2023 15:34:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVa5q-002zAo-Cd
	for linux-nvme@lists.infradead.org; Fri, 24 Feb 2023 15:34:44 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31O6TDLv007874
	for <linux-nvme@lists.infradead.org>; Fri, 24 Feb 2023 07:34:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=iwaPEzT96cQpT568djOJgr3K1PItxgjQwbPotxtdMaE=;
 b=WvzKuKAEceCTMB1ua1cZPawihBsFny7xfsRNrR8+i99cO8Ys8oSHw3agWxempg+CLnMv
 JdIAXq6BtA24RV2uzWDwDaoPu5CZju0+q1Jw11foHA45LIF7XrGsX/1U9MsXhRZ/xdEu
 YZDCOW0i0c+3DaObiQB1KgxY21hdIJUnxN56/U1wc3pkRxYxF7PvyXn3UKAQIbfWcQRF
 VjUg7LwvLFiXr0r/fb11qRoITOXUp5KsoCBd/2PZnpTCs+isECIObT71XnLtiPb4mxiH
 eS4/Lslw1NMnIJ8yf72WiutVqjXBipS2hbwXrjBALX/ERZIW8bIyx58jTQ8/uPScTETl vg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3nxm7u3w4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 24 Feb 2023 07:34:38 -0800
Received: from twshared5320.05.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Feb 2023 07:34:37 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D5815121B5E50; Fri, 24 Feb 2023 07:34:24 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        kernel test robot
	<lkp@intel.com>
Subject: [PATCH] nvme: fix sparse warning on effects masking
Date: Fri, 24 Feb 2023 07:34:24 -0800
Message-ID: <20230224153424.734731-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YkAUxJR4_dh4bYdKVTkXF2tccocGHOxY
X-Proofpoint-ORIG-GUID: YkAUxJR4_dh4bYdKVTkXF2tccocGHOxY
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_073442_594398_95395926 
X-CRM114-Status: GOOD (  15.33  )
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

The log entries are stored in le32, so use appropriate byte swapping
macros.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302242222.PevBhzvC-lkp@intel=
.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8698410aeb843..d2f88b71f92ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3104,7 +3104,7 @@ static void nvme_init_known_nvm_effects(struct nvme_c=
trl *ctrl)
 	 * Rather than blindly freezing the IO queues for this effect that
 	 * doesn't even apply to IO, mask it off.
 	 */
-	log->acs[nvme_admin_security_recv] &=3D ~NVME_CMD_EFFECTS_CSE_MASK;
+	log->acs[nvme_admin_security_recv] &=3D cpu_to_le32(~NVME_CMD_EFFECTS_CSE=
_MASK);
=20
 	log->iocs[nvme_cmd_write] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
 	log->iocs[nvme_cmd_write_zeroes] |=3D cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
--=20
2.30.2


