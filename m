Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C86CCF9C5B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2024 07:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V97BVWlce4lAW9nQcW1VxnmF4xqf2Pp0RTRwsx7QsHQ=; b=CqvhiRjM3eKuxqVbZKQ2lPOIaX
	mMElORwHg3W6vOCQ5tHaYSSFRYYqgK9n+L9xNEqvaigU38eu4swQI0LK0qpoh1ikrSogTfCcB5V8Z
	13IV+pmiocWlKG/JtABHDtHgYzah0c8e6aR4qT5HXmExlT7Ff/AqdWeaB7g0m+grAFImZVGSZFgU5
	TPQTX2wQvx7Fk5c/PClwF8nkStmB8+ZAIVfGmhyBptyH+ZHTe7p5Xpi3MKtzUh1tJrHX6WDVyxM3m
	DhHM9DJ5bqLuoLIZVOGuDa42JW+UHevPnqvC6eXh+oE/XR4WnAC7JATaBZ+TYN8nCMT2KP+TMGxY7
	KkRHmGfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sruC3-0000000DOc6-3vjc;
	Sat, 21 Sep 2024 07:06:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sruC1-0000000DObe-0Kmj
	for linux-nvme@lists.infradead.org;
	Sat, 21 Sep 2024 07:06:10 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48L3ZSb9016646;
	Sat, 21 Sep 2024 07:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=V97BVWlce4lAW9nQcW1VxnmF4x
	qf2Pp0RTRwsx7QsHQ=; b=UAVYlskHYy0qtB+eXWk7FDxLFw04Tj2AWE6i1i7A/V
	Ek8oC7TPhaX4av6lTyHmRAQKA46CsCAgNztDXX3Mx5J74lOb67/CIiTpbsZtduFH
	4biIdFJWInfqjitdWvgQQmy9yyUedZU+kB4HFtedrZFCHmJzJYKNoIl5Gccg3teJ
	yKGg+EOmf1WaynpTiWN93ViCcXtqF2mmgXiZ8kFSayeeravj9iqG/8iBA1PfDsph
	uj79tyYpDbWFfz2+9FA1xTygotTNjtKMbrOdXGH1l0GPAS/kmw9jhiPUfcfVBbDO
	4bnFkJszF2TdlA1ZGwYVpVmEWVA48qHBuDPD3H3jMUCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvagmcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Sep 2024 07:06:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48L5afrn000642;
	Sat, 21 Sep 2024 07:05:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn71uh37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Sep 2024 07:05:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48L75t7W21889438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Sep 2024 07:05:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F12C20081;
	Sat, 21 Sep 2024 07:05:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D14320073;
	Sat, 21 Sep 2024 07:05:53 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.13.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Sep 2024 07:05:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, axboe@fb.com,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2] nvmet-passthru: clear EUID/NGUID/UUID while using loop target
Date: Sat, 21 Sep 2024 12:35:33 +0530
Message-ID: <20240921070547.531991-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gfPDtS2-9FwTtgZf4c8W_LCnFSdJIB80
X-Proofpoint-GUID: gfPDtS2-9FwTtgZf4c8W_LCnFSdJIB80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-21_02,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409210051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240921_000609_356895_A4993332 
X-CRM114-Status: GOOD (  18.16  )
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

When nvme passthru is configured using loop target, the clear_ids
attribute is, by default, set to true. This attribute would ensure that
EUID/NGUID/UUID is cleared for the loop passthru target.

The newer NVMe disk supporting the NVMe spec 1.3 or higher, typically,
implements the support for "Namespace Identification Descriptor list"
command. This command when issued from host returns EUID/NGUID/UUID
assigned to the inquired namespace. Not clearing these values, while
using nvme passthru using loop target, would result in NVMe host driver
rejecting the namespace. This check was implemented in the commit
2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique").

The fix implemented in this commit ensure that when host issues ns-id
descriptor list command, the EUID/NGUID/UUID are cleared by passthru
target. In fact, the function nvmet_passthru_override_id_descs() which
clears those unique ids already exits, so we just need to ensure that
ns-id descriptor list command falls through the corretc code path. And
while we're at it, we also combines the three passthru admin command
cases together which shares the same code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
	- Update the commit subject line (Christoph Hellwig)
	- Avoid using "fallthroug" when there's no statement
	  in-between cases (Keith Busch) 

---
 drivers/nvme/target/passthru.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 24d0e2418d2e..0f9b280c438d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -535,10 +535,6 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		break;
 	case nvme_admin_identify:
 		switch (req->cmd->identify.cns) {
-		case NVME_ID_CNS_CTRL:
-			req->execute = nvmet_passthru_execute_cmd;
-			req->p.use_workqueue = true;
-			return NVME_SC_SUCCESS;
 		case NVME_ID_CNS_CS_CTRL:
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
@@ -547,7 +543,9 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				return NVME_SC_SUCCESS;
 			}
 			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
+		case NVME_ID_CNS_CTRL:
 		case NVME_ID_CNS_NS:
+		case NVME_ID_CNS_NS_DESC_LIST:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
-- 
2.45.2


