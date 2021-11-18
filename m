Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E71C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8229D613AC
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8229D613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tv4VawX899WHK14gWcja1coe80SfFP9VVlduGouWD84=; b=Fiy5vNcIE+YfWXPINyC8wa6Ra5
	LE7Vfrd9S5yEY06bJN8Izihn4FPl/ux1z0cN645il3WFvBuZyQiuytyDJFhf8sgiZ3Miy94wGjWcE
	VipBnRfl7Qz/kZY2HlZypXtpwbfyBQbBrY4tEACSm1FmvrtYTHy5RG+fjfnbrflc8PjEoinz8kW59
	frhFbiQUa+jqwKTKyIH+r++rKnxQtCu5a9Ws7YmHZebBDb8l5+DxrtDlRzHePDAMK30Amfk4VpY0x
	m8xAmea3b5TFWATh561o6RB9tR3WFmWsu0KtwrRz06Rqf9jHGrMV/4LvQii8ZIFNco7Zyt6JYFO7y
	VXpKtK1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm8J-008YJb-W0; Thu, 18 Nov 2021 18:27:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7u-008YEY-7d
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:15 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIChcN020985; 
 Thu, 18 Nov 2021 18:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=Tv4VawX899WHK14gWcja1coe80SfFP9VVlduGouWD84=;
 b=P6xK0SSxpBHDHoBu3syljzbaQVTzlZOwvDpAVdNqd4JsV1SCHZyw4lbYcj7glBmwTocv
 lm8UQl02XC+KdHcnNigcTxKnbABTjTLYwGKREfByiibeSNQP1vFW2/FFlRAO3XEADqcK
 TbVFuFPSuQ8FzXQVYz51cWZ9Fe3sFSLvxTXEjXNi1CJQBWwTImLKevNTB4bRwffokabt
 6en4F2WZJF7JO1tPb4eP7AM5fteenBIM6sfprNskHGKqqT6C771QhLAZcaDBtzdUEfZx
 jS+kz5g7MeQje9nJV2LSDz/8SQHerw+G+U99UEy0Pxc7SOvr7PFRx2qw7lBDgvwMJIrr Pg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cduwaraju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:13 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIIie4020357;
 Thu, 18 Nov 2021 18:27:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01wdc.us.ibm.com with ESMTP id 3cd7c38f56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIR9id45154680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A880EB2076;
 Thu, 18 Nov 2021 18:27:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4054FB205F;
 Thu, 18 Nov 2021 18:27:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:27:09 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 2/5] nvme-cli: Adds event number in persistent event entries
Date: Thu, 18 Nov 2021 10:57:25 -0600
Message-Id: <1637254648-19500-3-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bfa1mFYTGamj4Dquz5Dx7xA59kGWy9Hy
X-Proofpoint-ORIG-GUID: bfa1mFYTGamj4Dquz5Dx7xA59kGWy9Hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102714_424853_E73DBD79 
X-CRM114-Status: GOOD (  15.90  )
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

Persistent Event Entries:
Event Number: 0
Event Type: SMART/Health Log Snapshot Event(0x1)
Event Type Revision: 1
Event Header Length: 21
Controller Identifier: 66
Event Timestamp: 44392

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 nvme-print.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 1b419b7..b4bbe61 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1212,9 +1212,10 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 			le16_to_cpu(pevent_entry_head->el)) >= size)
 			break;
 		valid_attrs = json_create_object();
-
-		json_object_add_value_uint(valid_attrs, "event_type",
-			pevent_entry_head->etype);
+		
+		json_object_add_value_uint(valid_attrs, "event_number", i);
+		json_object_add_value_string(valid_attrs, "event_type",
+			nvme_pel_event_to_string(pevent_entry_head->etype));
 		json_object_add_value_uint(valid_attrs, "event_type_rev",
 			pevent_entry_head->etype_rev);
 		json_object_add_value_uint(valid_attrs, "event_header_len",
@@ -1543,8 +1544,8 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 		if ((offset + pevent_entry_head->ehl + 3 +
 			le16_to_cpu(pevent_entry_head->el)) >= size)
 			break;
-
-		printf("Event Type: %u\n", pevent_entry_head->etype);
+		printf("Event Number: %u\n", i);
+		printf("Event Type: %s\n", nvme_pel_event_to_string(pevent_entry_head->etype));
 		printf("Event Type Revision: %u\n", pevent_entry_head->etype_rev);
 		printf("Event Header Length: %u\n", pevent_entry_head->ehl);
 		printf("Controller Identifier: %u\n",
@@ -1560,12 +1561,12 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 		switch (pevent_entry_head->etype) {
 		case NVME_PEL_SMART_HEALTH_EVENT:
 			smart_event = pevent_log_info + offset;
-			printf("Smart Health Event: \n");
+			printf("Smart Health Event Entry: \n");
 			nvme_show_smart_log(smart_event, NVME_NSID_ALL, devname, flags);
 			break;
 		case NVME_PEL_FW_COMMIT_EVENT:
 			fw_commit_event = pevent_log_info + offset;
-			printf("FW Commit Event: \n");
+			printf("FW Commit Event Entry: \n");
 			printf("Old Firmware Revision: %"PRIu64"\n",
 				le64_to_cpu(fw_commit_event->old_fw_rev));
 			printf("New Firmware Revision: %"PRIu64"\n",
@@ -1582,7 +1583,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_TIMESTAMP_EVENT:
 			ts_change_event = pevent_log_info + offset;
-			printf("Time Stamp Change Event: \n");
+			printf("Time Stamp Change Event Entry: \n");
 			printf("Previous Timestamp: %"PRIu64"\n",
 				le64_to_cpu(ts_change_event->previous_timestamp));
 			printf("Milliseconds Since Reset: %"PRIu64"\n",
@@ -1594,7 +1595,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 
 			por_info_list = por_info_len / sizeof(*por_event);
 
-			printf("Power On Reset Event: \n");
+			printf("Power On Reset Event Entry: \n");
 			fw_rev = pevent_log_info + offset;
 			printf("Firmware Revision: %"PRIu64"\n", le64_to_cpu(*fw_rev));
 			printf("Reset Information List: \n");
@@ -1617,13 +1618,13 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_NSS_HW_ERROR_EVENT:
 			nss_hw_err_event = pevent_log_info + offset;
-			printf("NVM Subsystem Hardware Error Event Code: %u, %s\n",
+			printf("NVM Subsystem Hardware Error Event Code Entry: %u, %s\n",
 				le16_to_cpu(nss_hw_err_event->nss_hw_err_event_code),
 				nvme_show_nss_hw_error(nss_hw_err_event->nss_hw_err_event_code));
 			break;
 		case NVME_PEL_CHANGE_NS_EVENT:
 			ns_event = pevent_log_info + offset;
-			printf("Change Namespace Event: \n");
+			printf("Change Namespace Event Entry: \n");
 			printf("Namespace Management CDW10: %u\n",
 				le32_to_cpu(ns_event->nsmgt_cdw10));
 			printf("Namespace Size: %"PRIu64"\n",
@@ -1642,7 +1643,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_FORMAT_START_EVENT:
 			format_start_event = pevent_log_info + offset;
-			printf("Format NVM Start Event: \n");
+			printf("Format NVM Start Event Entry: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_start_event->nsid));
 			printf("Format NVM Attributes: %u\n",
@@ -1652,7 +1653,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_FORMAT_COMPLETION_EVENT:
 			format_cmpln_event = pevent_log_info + offset;
-			printf("Format NVM Completion Event: \n");
+			printf("Format NVM Completion Event Entry: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_cmpln_event->nsid));
 			printf("Smallest Format Progress Indicator: %u\n",
@@ -1666,7 +1667,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_SANITIZE_START_EVENT:
 			sanitize_start_event = pevent_log_info + offset;
-			printf("Sanitize Start Event: \n");
+			printf("Sanitize Start Event Entry: \n");
 			printf("SANICAP: %u\n", sanitize_start_event->sani_cap);
 			printf("Sanitize CDW10: %u\n",
 				le32_to_cpu(sanitize_start_event->sani_cdw10));
@@ -1675,7 +1676,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_SANITIZE_COMPLETION_EVENT:
 			sanitize_cmpln_event = pevent_log_info + offset;
-			printf("Sanitize Completion Event: \n");
+			printf("Sanitize Completion Event Entry: \n");
 			printf("Sanitize Progress: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->sani_prog));
 			printf("Sanitize Status: %u\n",
@@ -1685,7 +1686,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_THERMAL_EXCURSION_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
-			printf("Thermal Excursion Event: \n");
+			printf("Thermal Excursion Event Entry: \n");
 			printf("Over Temperature: %u\n", thermal_exc_event->over_temp);
 			printf("Threshold: %u\n", thermal_exc_event->threshold);
 			break;
-- 
2.27.0


