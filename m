Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E082C9EC6B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBtgTXgk47jsf8E2jCDEd5p+iOAez4JsMAZ50//H3hM=; b=SiUoLBEMmShrEE1D7nK3RDbOgu
	Qlpe1ZcgennyRKJnyO7K4AYCuFdC1J4sxrFCOJRVm8u62MivDe7ydKQXvYGWRwfDi6NbEfJJllzT2
	cH5Y14ksD29inm3N7VkjhyKJnHoO54RABF7lf3Av8K0q4GXHzPyzYyWdxc/ceUorr6yYHS8WuGMKn
	6++Rq0nPSYipZaJtWdv4YLLTFVPyrFmzRt+CeIuQC/IK4qf+zxMAqodVPMYeQ3eWaWn40t1OsIWnX
	LmQZZQ61MOcIGalE5r8iG8yxNq3rPvZWOkv2YS3OuJB2wLijk2OkTK91k+NcMbRm8Ph0/C9dA568M
	W9DmheYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFvg-00000005E62-0wAD;
	Mon, 12 Jan 2026 11:17:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfFvd-00000005E5K-1b7z
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 11:17:46 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BJPFJd007230;
	Mon, 12 Jan 2026 11:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DBtgTX
	gk47jsf8E2jCDEd5p+iOAez4JsMAZ50//H3hM=; b=by034wsRMO766jGZcJR1K6
	o5PAgVoczioPV9L9csKXpia+W3C51U3PA0X/IpMFMzyPl/Tdi4Ads5s+ptf0d5Tv
	YExLhgOXlpw7WS+Gr/cxxUARkE52Trv6ySLOyDPSn44klnJdVgVf1FPG97caz2mh
	6sgAArKbwj8VPXiKPOrNryAznNNxOOGEwpFa/gjXXDra4wPEZ1oORezCc7mad0B3
	s94qdZe3mqEhifs/3viti/62+vcQreZ29e7WoIOqxzXdo0YDA0ExQkzM5K7CBH2h
	i4gfZHvvX1pjR+B9g03AzsMuzFl9K70HIVe8cgHvkptYRY1He0EQ4FkrL0pnwZ8A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92pqt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CBHg55012558;
	Mon, 12 Jan 2026 11:17:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92pqt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CB0m6W030111;
	Mon, 12 Jan 2026 11:17:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajdcb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 11:17:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CBHdJg60686800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 11:17:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABF4720043;
	Mon, 12 Jan 2026 11:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 388F920040;
	Mon, 12 Jan 2026 11:17:38 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.146.254])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 11:17:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: wagi@kernel.org, martinus.gpy@gmail.com
Subject: [PATCH 2/2] nvme: add iopolicy field in JSON output
Date: Mon, 12 Jan 2026 16:46:01 +0530
Message-ID: <20260112111731.1631091-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112111731.1631091-1-nilay@linux.ibm.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pTQp-O0xeWTAo5NY3DAjEJVZWGn9OuGM
X-Authority-Analysis: v=2.4 cv=dYyNHHXe c=1 sm=1 tr=0 ts=6964d856 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=JKOBd3O0iF-b2O76ofEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MCBTYWx0ZWRfX0c12ERtFM8WN
 OxnBV+MWpQrNqTb60G6qbPHKbsS9qW/2RNnDhOsKPhRRGjFcl/D99Ebbgdhkw7TwqT3Gehb5cId
 k/pLM3mksEO4BFYX3kqVmLuDyasf98yFczgVp10bGCPKELunUbNuXSq437zy+5xHM8W5ZKIIZyN
 f6WYoaAod57ZehWFQUzXXMXOp6lIG9kUeQUZ5NOx0hWjnb/tknoHCPtK649nRwLhNehKlkyu/yS
 RxdgibT87dt495Swz32jvQd75yE8NS6/puYUa7W7iStAK3xiewRXWrGnooqb8nLtnHw59b9DZOc
 S64oaZy1bPEWl0/KqhLxqjADlglbI5w1iOmbygpq3Fvjl7MHIGRs/+fH4tefyx+7XUAgR2PKks3
 lkFbZvbdfX4JYTgi5FPKrmKQLF8RJQk1T26ozTDpQNCcrwroN57E+TkImM2H3lDo8s4jbOEWXki
 Vmp59RQq7JCUQ4wySwA==
X-Proofpoint-GUID: Yo4rpAVNog2OPjj-6YVEq7akefo7lEa2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_031745_421244_7C2E951B 
X-CRM114-Status: GOOD (  18.66  )
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

Commit d0b4c6cf0006 (“nvme: extend show-topology command to add
support for multipath”) extended the show-topology command output
and added the iopolicy field to the subsystem header in the text
output even when show-topology command is executed in non-verbose
mode.

However, the iopolicy field was not included in the JSON output,
(for non-verbose output) resulting in an inconsistency between the
text and JSON formats. This change fixes that by adding the iopolicy
field to the JSON output when the show-topology command is executed
with the JSON output format.

Fixes: d0b4c6cf0006 ("nvme: extend show-topology command to add support for multipath")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-json.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-print-json.c b/nvme-print-json.c
index ca5d77483..72d17ca60 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -4851,6 +4851,8 @@ static void json_simple_topology(struct nvme_global_ctx *ctx)
 			subsystem_attrs = json_create_object();
 			obj_add_str(subsystem_attrs, "Name", nvme_subsystem_get_name(s));
 			obj_add_str(subsystem_attrs, "NQN", nvme_subsystem_get_nqn(s));
+			obj_add_str(subsystem_attrs, "IOPolicy",
+					nvme_subsystem_get_iopolicy(s));
 
 			if (verbose_mode()) {
 				obj_add_str(subsystem_attrs, "Model",
@@ -4859,8 +4861,6 @@ static void json_simple_topology(struct nvme_global_ctx *ctx)
 						nvme_subsystem_get_serial(s));
 				obj_add_str(subsystem_attrs, "Firmware",
 						nvme_subsystem_get_fw_rev(s));
-				obj_add_str(subsystem_attrs, "IOPolicy",
-						nvme_subsystem_get_iopolicy(s));
 				obj_add_str(subsystem_attrs, "Type",
 						nvme_subsystem_get_type(s));
 			}
-- 
2.52.0


