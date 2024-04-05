Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B69CD1297
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nDj5DHl0oA/T4tJMWNVpkmsvsZjAK7EoJlBBzYHpv2Q=; b=Grfsl3Ph2sqNHu
	DKnIpMms30dS6Me6lxH31ZXXBQPpX8l7+GJ9K6FLc3h+asbl6qmAZfKtkub+Ggfp6QyL0xiNZFQjI
	+/ZyEn48zSeYnzhmS/KpSVtraLouLcjBupjegvRgj/k7hyuiEajeX+PYc0ZWP84sdr8CZ5GY7ZF29
	sWGhpaNDyWrW1rnGRXE0SgKIyrqF1AytRz/6KVDaqfzdaiEYKCY47Rg1apZ59pIhS1zke3nURN2EV
	bvm2P5jPVDB9sTATNoV2lF5I1lxZRMosXtFPQC16yP6LB7ETcG6alhXqS1DAIVnEN8sHSEl3bk4vl
	HUENdyNDJMMryb+tH7tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsiPb-00000006qCe-2lXC;
	Fri, 05 Apr 2024 12:11:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsiPY-00000006q9H-2rsZ
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 12:11:14 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435C140n011009;
	Fri, 5 Apr 2024 12:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=nDj5DHl0oA/T4tJMWNVpkmsvsZjAK7EoJlBBzYHpv2Q=;
 b=IW95BEB4A3Rl84ZB00t9vi2K4W4sKHU9yiE5EH2pvqeJqbpTWx2zECdGfwDXUPYZODDE
 k2omOXqNN0jlk9rZo9f/utIYORzyX25MXccbglU1cwsPNB0hcdVbmAfArDOh8As4rGsa
 4A5AH9/iojlADYQrk92fgZ3CLBeUk6zGyr1eahdFeBLCw8ns6EKGpWdrgl/lRbatghID
 V0picRvhhoLfkSqHn1zIxxxISLJtMIgkPNHaKp6lJ1PoZupyZNTsMDxcDIftNcndyzk8
 1C8lMdA3fPgk7Iz4Pr571qS2gAX1iKm9r/0uIGl1R/flOnPrCKAZhzQbrLqjOdFRcwuB lQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xag2u05e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 12:11:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4359AqaE003622;
	Fri, 5 Apr 2024 12:11:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epyjcms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 12:11:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435CB0w147186232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 12:11:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2F8A20040;
	Fri,  5 Apr 2024 12:11:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E01E2005A;
	Fri,  5 Apr 2024 12:10:59 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 12:10:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com, nilay@linux.ibm.com
Subject: [PATCH nvme-cli] nvme-print: Print cntlid number for controller
Date: Fri,  5 Apr 2024 17:40:36 +0530
Message-ID: <20240405121057.297071-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GzAQG1MajXuOLs8oqJLZ4F4mncbVHLXg
X-Proofpoint-GUID: GzAQG1MajXuOLs8oqJLZ4F4mncbVHLXg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_051112_754457_FA11BB34 
X-CRM114-Status: GOOD (  16.34  )
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

Print the controller identifier number (cntlid) for the
nvme controller. The cntlid is printed if nvme list
verbose is specified.

Link: https://lore.kernel.org/all/20240326065752.164286-1-nilay@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-json.c   |  1 +
 nvme-print-stdout.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/nvme-print-json.c b/nvme-print-json.c
index fec72b9d..8cf057f2 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -3899,6 +3899,7 @@ static void json_detail_list(nvme_root_t t)
 				struct json_object *jpaths = json_create_array();
 
 				obj_add_str(jctrl, "Controller", nvme_ctrl_get_name(c));
+				obj_add_str(jctrl, "Cntlid", nvme_ctrl_get_cntlid(c));
 				obj_add_str(jctrl, "SerialNumber", nvme_ctrl_get_serial(c));
 				obj_add_str(jctrl, "ModelNumber", nvme_ctrl_get_model(c));
 				obj_add_str(jctrl, "Firmware", nvme_ctrl_get_firmware(c));
diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 795087ee..1b62a8e4 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -4802,8 +4802,9 @@ static bool stdout_detailed_ctrl(const char *name, void *arg)
 	c = htable_ctrl_get(&res->ht_c, name);
 	assert(c);
 
-	printf("%-8s %-20s %-40s %-8s %-6s %-14s %-6s %-12s ",
+	printf("%-8s %-6s %-20s %-40s %-8s %-6s %-14s %-6s %-12s ",
 	       nvme_ctrl_get_name(c),
+	       nvme_ctrl_get_cntlid(c),
 	       nvme_ctrl_get_serial(c),
 	       nvme_ctrl_get_model(c),
 	       nvme_ctrl_get_firmware(c),
@@ -4882,10 +4883,11 @@ static void stdout_detailed_list(nvme_root_t r)
 	strset_iterate(&res.subsystems, stdout_detailed_subsys, &res);
 	printf("\n");
 
-	printf("%-8s %-20s %-40s %-8s %-6s %-14s %-6s %-12s %-16s\n", "Device",
-		"SN", "MN", "FR", "TxPort", "Address", "Slot", "Subsystem", "Namespaces");
-	printf("%-.8s %-.20s %-.40s %-.8s %-.6s %-.14s %-.6s %-.12s %-.16s\n", dash,
-		dash, dash, dash, dash, dash, dash, dash, dash);
+	printf("%-8s %-6s %-20s %-40s %-8s %-6s %-14s %-6s %-12s %-16s\n", "Device",
+		"Cntlid", "SN", "MN", "FR", "TxPort", "Address", "Slot", "Subsystem",
+		"Namespaces");
+	printf("%-.8s %-.6s %-.20s %-.40s %-.8s %-.6s %-.14s %-.6s %-.12s %-.16s\n",
+			dash, dash, dash, dash, dash, dash, dash, dash, dash, dash);
 	strset_iterate(&res.ctrls, stdout_detailed_ctrl, &res);
 	printf("\n");
 
-- 
2.44.0


