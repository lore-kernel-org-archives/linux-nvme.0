Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD123C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:34:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7425161221
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7425161221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NwzXa9+gmI7hqCz23CyvX5ZQi11euoGMJo8H2sYEq2k=; b=Gi8LPumqulXFtPvuL1Wl7Un8A4
	LIInfb4Zhnaz+1nmVsmFI2DBvJoRCooApS8hKdoCHkwS2RXMunfM6JCFCXxTr4LkrgL+G7hX10X90
	O0RYW7O9ydoVRemEyh7q8EcPLuoxxjEPb//1sc6ypLbEh+1J/T4EbVoG2KcsQGGbz5GrOo+ZPuo64
	TFYBsgx+R+izEAEWQm/iaamYkXt3ZxXtwh3YqEztkkS6FYk2YMYglDVUW1CqdJw3bfZECBrGAVcxi
	R6NhjxkhPId6ufHY0UJQ2D8BMCHJD8uh29Xp2DgVxhrP5j7Gu/dwJ+dHHT+tuOzfcX7w83YmTL8dE
	hUYPh1SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnOpZ-005rq3-Gw; Wed, 17 Nov 2021 17:34:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOpK-005rjx-1p
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 17:34:31 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHCelK029377; 
 Wed, 17 Nov 2021 17:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=NwzXa9+gmI7hqCz23CyvX5ZQi11euoGMJo8H2sYEq2k=;
 b=RJViY/whnBy0PHF/ZCUfAIgeeRI16WNHO9yipk4iZRKECI35ndACtVJx1f7EQIb4B2cf
 rLQD93+ofTDJaG7ofPd5cAvfhBHEWdfoPZnMX6oSSMMjmh1YVrGpit5GHdVukSTkFNiW
 EXE6xpZlVeUgWSMGRdJorllCp/NZm2JWSpWp5E+s3i08t0DFdh/kuqUtP7nGUauYetqZ
 coRQsEwGSEr85n2dumuuOHpwnjqIdo9hXiArMVFNKzNhj0WdDOpG0B98cJbxhEFS5gIW
 LsMBX27G1cKJjp5XITkLHddZ0nlI9DcFmeXPHSsMoLLHLb2Hvg7J57EV8Vl94Mo7of+k nQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cd5x78dm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:29 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHY4Ob009429;
 Wed, 17 Nov 2021 17:34:28 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 3ca50c48rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:28 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AHHYQ8D57147686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Nov 2021 17:34:26 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D4746E05F;
 Wed, 17 Nov 2021 17:34:26 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E6226E05D;
 Wed, 17 Nov 2021 17:34:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Nov 2021 17:34:25 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: anaidu.gollu@samsung.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 2/5] nvme-cli: Adds event number in persistent event entries
Date: Wed, 17 Nov 2021 10:04:45 -0600
Message-Id: <1637165088-17007-2-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j6No3vaXU7yUSnoNR0OWAI7YWJe17dE-
X-Proofpoint-ORIG-GUID: j6No3vaXU7yUSnoNR0OWAI7YWJe17dE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_093430_275976_AA6D975E 
X-CRM114-Status: GOOD (  17.52  )
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
index 16fd569..dcb0e7c 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1199,9 +1199,10 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
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
@@ -1535,8 +1536,8 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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
@@ -1552,12 +1553,12 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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
@@ -1574,7 +1575,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_TIMESTAMP_EVENT:
 			ts_change_event = pevent_log_info + offset;
-			printf("Time Stamp Change Event: \n");
+			printf("Time Stamp Change Event Entry: \n");
 			printf("Previous Timestamp: %"PRIu64"\n",
 				le64_to_cpu(ts_change_event->previous_timestamp));
 			printf("Milliseconds Since Reset: %"PRIu64"\n",
@@ -1586,7 +1587,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 
 			por_info_list = por_info_len / sizeof(*por_event);
 
-			printf("Power On Reset Event: \n");
+			printf("Power On Reset Event Entry: \n");
 			fw_rev = pevent_log_info + offset;
 			printf("Firmware Revision: %"PRIu64"\n", le64_to_cpu(*fw_rev));
 			printf("Reset Information List: \n");
@@ -1609,13 +1610,13 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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
@@ -1634,7 +1635,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_FORMAT_START_EVENT:
 			format_start_event = pevent_log_info + offset;
-			printf("Format NVM Start Event: \n");
+			printf("Format NVM Start Event Entry: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_start_event->nsid));
 			printf("Format NVM Attributes: %u\n",
@@ -1644,7 +1645,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_FORMAT_COMPLETION_EVENT:
 			format_cmpln_event = pevent_log_info + offset;
-			printf("Format NVM Completion Event: \n");
+			printf("Format NVM Completion Event Entry: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_cmpln_event->nsid));
 			printf("Smallest Format Progress Indicator: %u\n",
@@ -1658,7 +1659,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_SANITIZE_START_EVENT:
 			sanitize_start_event = pevent_log_info + offset;
-			printf("Sanitize Start Event: \n");
+			printf("Sanitize Start Event Entry: \n");
 			printf("SANICAP: %u\n", sanitize_start_event->sani_cap);
 			printf("Sanitize CDW10: %u\n",
 				le32_to_cpu(sanitize_start_event->sani_cdw10));
@@ -1667,7 +1668,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			break;
 		case NVME_PEL_SANITIZE_COMPLETION_EVENT:
 			sanitize_cmpln_event = pevent_log_info + offset;
-			printf("Sanitize Completion Event: \n");
+			printf("Sanitize Completion Event Entry: \n");
 			printf("Sanitize Progress: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->sani_prog));
 			printf("Sanitize Status: %u\n",
@@ -1677,7 +1678,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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


