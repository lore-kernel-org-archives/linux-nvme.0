Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:28:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8FC613AC
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D8FC613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qtwe3VXIvRgSGVHYAjdvqaH62zJVSjLyUEtsIEHCqCg=; b=d+tLsN30MCDJxEnS66/ds7w/9f
	crRGvy/xA3y38S4EQ7bMuavJmRwE22E7fUXPDHWnNpsqbjCII4qF7/ya1HeyI4zf8XaClsVSAZOla
	i68fKH3HkGixTDWaoSGBCifdcEvLIoXP+v87FWtTzgmfJX5ehluTOMol1lCkZHEKW7Uta/8it4330
	YvfzCQxfVC9Qqrw/3MlMpE2kOuReuZrrD9vyhlKz3ok3pQupjyEqT4q6TAe6IPHy1QUIQPg7gEeD4
	OCdDW4PZAL6y89fR38mKuhKTrI46puuU17MiAh8rlvckqyeIvCB5hn3JWKgGGc3lnNPknCwHh2uD9
	TqI78Rtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm8n-008YS4-Jv; Thu, 18 Nov 2021 18:28:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7v-008YFL-Tx
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:17 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIDY0P009285; 
 Thu, 18 Nov 2021 18:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=Qtwe3VXIvRgSGVHYAjdvqaH62zJVSjLyUEtsIEHCqCg=;
 b=K/OhQkB4LWgEawHqEbaHBTqBOQVK7n1Tfgl+CkH6UVgTzXXsh4sIiVdocEdTt+E5lO/o
 kKOQHqG1zmXfd5MmO1ZfU0ONbNXclT2cYV37xYsue2T6BRgUPTrc0XNK3CRWfEklhiaS
 HEWCFKdeklppynXeBgU0vRRLPVzfFFHb0PC1mgKsp1cmQlNylOzxjSqCKSwZfSTRcTvO
 CCN9sclp2OFWakN2qJYaTcERuT/D7gTatK1gysh5UgngzzjL9AMZcHg26b0riLbZq9+T
 FRbJmiAxUWtzgv6C025ci8KYblbh1Q8clj8ldWfor/WDBcbBjZP8oDJDsnzeAXSsXs9A Ng== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cdux288a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:14 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIIpnv020039;
 Thu, 18 Nov 2021 18:27:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 3ca50dcb9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIRApZ38207942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34AADB207B;
 Thu, 18 Nov 2021 18:27:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB2D8B206C;
 Thu, 18 Nov 2021 18:27:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:27:09 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 3/5] nvme-cli: Adds readable firmware level in persistent
Date: Thu, 18 Nov 2021 10:57:26 -0600
Message-Id: <1637254648-19500-4-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uZKEjOHVu5k8_o8iUaz_X7AKv_fQm0Dy
X-Proofpoint-GUID: uZKEjOHVu5k8_o8iUaz_X7AKv_fQm0Dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102716_011281_FFB6BC7B 
X-CRM114-Status: GOOD (  15.51  )
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

For example, In Firmware Commit Event:

Old Firmware Revision: 3617604718875264338
New Firmware Revision: 3833777500989048146

changes to

Old Firmware Revision: 3617604718875264338 (REV.SP42)
New Firmware Revision: 3833777500989048146 (REV.SP45)

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com
---
 nvme-print.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index b4bbe61..fb7cec3 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1132,6 +1132,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
 	char key[128];
+	char fw_str[50];
 
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
@@ -1305,10 +1306,14 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 			break;
 		case NVME_PEL_FW_COMMIT_EVENT:
 			fw_commit_event = pevent_log_info + offset;
-			json_object_add_value_uint64(valid_attrs, "old_fw_rev",
-				le64_to_cpu(fw_commit_event->old_fw_rev));
-			json_object_add_value_uint64(valid_attrs, "new_fw_rev",
-				le64_to_cpu(fw_commit_event->new_fw_rev));
+			snprintf(fw_str, sizeof(fw_str), "%"PRIu64" (%s)",
+				le64_to_cpu(fw_commit_event->old_fw_rev),
+				fw_to_string((char *)&fw_commit_event->old_fw_rev));
+			json_object_add_value_string(valid_attrs, "old_fw_rev", fw_str);
+			snprintf(fw_str, sizeof(fw_str), "%"PRIu64" (%s)",
+				le64_to_cpu(fw_commit_event->new_fw_rev),
+				fw_to_string((char *)&fw_commit_event->new_fw_rev));
+			json_object_add_value_string(valid_attrs, "new_fw_rev", fw_str);
 			json_object_add_value_uint(valid_attrs, "fw_commit_action",
 				fw_commit_event->fw_commit_action);
 			json_object_add_value_uint(valid_attrs, "fw_slot",
@@ -1336,8 +1341,10 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 			por_info_list = por_info_len / sizeof(*por_event);
 
 			fw_rev = pevent_log_info + offset;
-			json_object_add_value_uint64(valid_attrs, "fw_rev",
-				le64_to_cpu(*fw_rev));
+			snprintf(fw_str, sizeof(fw_str), "%"PRIu64" (%s)",
+				le64_to_cpu(*fw_rev),
+				fw_to_string((char *)fw_rev));
+			json_object_add_value_string(valid_attrs, "fw_rev", fw_str);
 			for (int i = 0; i < por_info_list; i++) {
 				por_event = pevent_log_info + offset +
 					sizeof(*fw_rev) + i * sizeof(*por_event);
@@ -1567,10 +1574,12 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 		case NVME_PEL_FW_COMMIT_EVENT:
 			fw_commit_event = pevent_log_info + offset;
 			printf("FW Commit Event Entry: \n");
-			printf("Old Firmware Revision: %"PRIu64"\n",
-				le64_to_cpu(fw_commit_event->old_fw_rev));
-			printf("New Firmware Revision: %"PRIu64"\n",
-				le64_to_cpu(fw_commit_event->new_fw_rev));
+			printf("Old Firmware Revision: %"PRIu64" (%s)\n",
+				le64_to_cpu(fw_commit_event->old_fw_rev),
+				fw_to_string((char *)&fw_commit_event->old_fw_rev));
+			printf("New Firmware Revision: %"PRIu64" (%s)\n",
+				le64_to_cpu(fw_commit_event->new_fw_rev),
+				fw_to_string((char *)&fw_commit_event->new_fw_rev));
 			printf("FW Commit Action: %u\n",
 				fw_commit_event->fw_commit_action);
 			printf("FW Slot: %u\n", fw_commit_event->fw_slot);
@@ -1597,7 +1606,8 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 
 			printf("Power On Reset Event Entry: \n");
 			fw_rev = pevent_log_info + offset;
-			printf("Firmware Revision: %"PRIu64"\n", le64_to_cpu(*fw_rev));
+			printf("Firmware Revision: %"PRIu64" (%s)\n", le64_to_cpu(*fw_rev),
+				fw_to_string((char *)fw_rev));
 			printf("Reset Information List: \n");
 
 			for (int i = 0; i < por_info_list; i++) {
-- 
2.27.0


