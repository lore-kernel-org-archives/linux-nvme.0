Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4F3C4167D
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 23:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H3eZnSR0DWQIwPTcufsUp4FpvvGpDZrlxIuAE5WmxdA=; b=ouTyqV2CHUtrnWJ1tZZZkvXaNZ
	WHudvDictAi4apRsypuDC4ShHQFocj9/w76uj+4JtRPEpCPSInL46HP6RJVNH1rk5VYTS8v1JMw/a
	uY7wPjaaG4/spG6zHU5WDas8c2J4tcUFGUyEAGJiRAjWnSsMhWbQBI8XMA3suwm069ZkqnV9nUe3z
	pUX8ufZZd8lWvNeDqDWTMOf49tdm6c1Z3jzmuhqMWCDnUsB0+oslinfXddg4o6feOrObJ1Sxf1Q32
	0vB3M1wG+AKJY195zBx6m9wuxTQA0t5mY11CHOMRr2hI/WKjmd068NxwWN/U/NTrTAAtDiLjkLhAi
	yI0xCUJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r33CE-00H01m-0D;
	Tue, 14 Nov 2023 23:51:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r33C7-00H00J-0Q
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 23:51:48 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AENJ3hS016514;
	Tue, 14 Nov 2023 23:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=H3eZnSR0DWQIwPTcufsUp4FpvvGpDZrlxIuAE5WmxdA=;
 b=cDg+nHJGEkECioLufFbp/Hes44KoKQwCdxGdHFE4g3hZqRb2ES5eV+UI0W154wsbg5P+
 mwb+8DvNnVQuaFxsgW9QC+f7+/5HdNq5bGylk9t9YVw03VD8dyJcsLCn7KwJJ2vIKbUp
 8d4tx2iWtF1DHshyuGx4/c5Ts1WeZVCel2eglVKirEkIr5Lrjn4CVdz2FXCcpF/A4KGe
 /p5/UN/Hu6vguWRkSlJKLcd7Oej8lf/1t1pP6BoZ3Y6Wyu86Vz7fsdTBeJw74ayadVqM
 NsHj/plvUIdtE3CSi+PxsCs7JkBMCNBnqtXVQE/thI+SVv1SzcFtRfrRT6IZOf6ofq6y wQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucjargtuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 23:51:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEMUmEE024382;
	Tue, 14 Nov 2023 23:51:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamaybpk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 23:51:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AENpb733801724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 23:51:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE44B58065;
	Tue, 14 Nov 2023 23:51:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB4358059;
	Tue, 14 Nov 2023 23:51:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Nov 2023 23:51:36 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: kbusch@kernel.org
Cc: hch@infradead.org, chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
        wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 1/1] nvme/host: Rescan namespace if ns_id is changed
Date: Tue, 14 Nov 2023 15:57:46 -0600
Message-Id: <1699999066-5142-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tw5A4bO1KJCiSB9wlASmiEpaVek6nmA1
X-Proofpoint-ORIG-GUID: Tw5A4bO1KJCiSB9wlASmiEpaVek6nmA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_23,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_155147_290763_84DA50D2 
X-CRM114-Status: GOOD (  22.41  )
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

From: Wen Xiong <wenxiong@linux.ibm.com>

Hi all,

Namespace is not visible if we detach/delete/create/attach a namespace
on a new nvme device because of nguid is changed.

Like Keith's suggestion, we can do the 2nd ns-attach to get new
namespace available. Test team likes to fix it in the driver.

The following patch has been tested by test team and works fine.

Appreciate your suggestion for difference approach!

Thanks,
Wendy

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
Tested-by: tjo@us.ibm.com

---
 drivers/nvme/host/core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b54cdcbd68..a608a63d3108 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3721,13 +3721,15 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
+static bool nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	bool ns_id_changed = false;
 
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
+		ns_id_changed = true;
 		goto out;
 	}
 
@@ -3741,21 +3743,24 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 	 */
 	if (ret > 0 && (ret & NVME_SC_DNR))
 		nvme_ns_remove(ns);
+
+	return ns_id_changed;
 }
 
-static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static bool nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
 	int ret;
+	bool ns_rescan = false;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
-		return;
+		return false;
 
 	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
 		dev_warn(ctrl->device,
 			"command set not reported for nsid: %d\n", nsid);
-		return;
+		return false;
 	}
 
 	/*
@@ -3777,15 +3782,17 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * becomes ready and restart the scan.
 	 */
 	if (ret || !info.is_ready)
-		return;
+		return false;
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &info);
+		ns_rescan = nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
 	} else {
 		nvme_alloc_ns(ctrl, &info);
 	}
+
+	return ns_rescan;
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -3837,7 +3844,9 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_scan_ns(ctrl, nsid);
+			if (nvme_scan_ns(ctrl, nsid))
+				nvme_scan_ns(ctrl, nsid);
+
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
-- 
2.39.3


