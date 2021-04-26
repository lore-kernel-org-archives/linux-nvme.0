Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344CC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:16:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AA96112F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA96112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUu2araUV6Wl/2D8wxNk6YkWDbqaHnAxMm4aFbeW0ZE=; b=erFKGxaoxlQeqHZKhB9Ewn++TD
	6lB1pAfFkKQwCwgaWu2WiN1GEDDPlrx+zXScsag3LIkKzqYVJYiZ7ldfaMasXyPvARRxdY6GsxUwS
	w0gty0sPzTGFP6d7zrB0q404rBXIwRZ1z9g+kPn6izILIWWE/Sw+TpACRnprAgYeK3Nkw0VovsMBx
	5BYrnmG2BmfkrxXobenSC2lJhr624GnoYv0yB1JCGtJ00SD5KD+1r6NRFX5AeVXl6GmdH4aMEeeVF
	pthwOujBl0CH5aK4/kC5WeIaVDyJzRK+t7IpDCgoaWd9U0y+A6lbMcGhVnsFmI1MKpTzTgljls+8T
	liKFUvkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb6iv-008MYz-BI; Mon, 26 Apr 2021 19:16:49 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6ii-008MXL-1v
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 19:16:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PaEvEVmmxNChzvLtYqaqADHETLOQKgqmJTdIIUnyjo0=; b=HQAEOyQG2GjYfgc5KFosHgJeo5
 rTdCa1+F1HRPqyJHPujFpLgE/vuojGSlS3xhyajzu7cEP8rWlw4dlexbmys34qbXvnw5ioVkxBYvn
 ZDIbN9NpSDPC7hUYJ/XM8g85OQaGLTwxQ07QQwu+wYdPNkTwhsLZyMflFnQMdSQ5nRd8K1cUdjcfU
 FJ63ILY04tum0oK2T3nytr0eGaAkywyfVCfrwCKzDTFaP58HuyXa8WcEkacSu/08qu+ZaR9N9/vaB
 nEY4lS8ZQKWoO7vqq8xhHcNo2ninQoJd6PrHGxICurMuwX96yg2/er4HfmKacDp2if8lkrPZNfFg1
 Z9MUOF4g==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6ic-00G8OK-NQ
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 19:16:34 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13QJ3RI7148385; Mon, 26 Apr 2021 15:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=PaEvEVmmxNChzvLtYqaqADHETLOQKgqmJTdIIUnyjo0=;
 b=i7ZFrAqIYjppk8Va8yiRL029taO5icBXCkpVp9wrSoaN1ZZh5ABB/1a4WV/mmqT764y0
 n9wRAnwMOe6pTxXXGeOowlWKekGwxdGfMqrrSGQA7mXfMCPaQluV95ommphWO32OkCNr
 I9rVZHaMlMt/O9kQ4Ni2+ri3VLWFTN392qKtDyZsptXC/C4bKGbM2QLCndUTk9i971VV
 qv+urvqd9fHnspoBdLlHw90VotpbJVAfRIWJ/zmHneMglmkJhNwIVWJc21EwNCtQHI7V
 jvT4ay5coSqcZvDEGx7qBvcLtk4PR3zZdSkrYIuWI6mplXK7X8grhjP2O0/oaW9XqFnj 9w== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3861yctprb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 15:16:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QJ79aq024696;
 Mon, 26 Apr 2021 19:16:28 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by ppma01dal.us.ibm.com with ESMTP id 384ay8vebg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 19:16:28 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13QJFCXh25100658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Apr 2021 19:15:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 777456E05F;
 Mon, 26 Apr 2021 19:15:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A2D96E05B;
 Mon, 26 Apr 2021 19:15:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Apr 2021 19:15:11 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH 3/3] nvme: Update several detail information in pel code
Date: Mon, 26 Apr 2021 12:52:18 -0500
Message-Id: <1619459538-3998-4-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KUe4Kxaa4OUvRj0extK2-nnvgwUBvZk6
X-Proofpoint-ORIG-GUID: KUe4Kxaa4OUvRj0extK2-nnvgwUBvZk6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-26_09:2021-04-26,
 2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_121630_920031_B0C6D4C7 
X-CRM114-Status: GOOD (  23.19  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>

Update several detail information in pel:
- Add ascii format in firmware field
Old Firmware Revision: 3617604718875264338 (REV.SP42)

- Add ascii format in timestamp field
The Previous Timestamp is : 1619458220931 (Mon Apr 26 13:30:20 2021 EDT)

- ADD additional Information for hardware error

- Nicely output format
Persistent Event Entries:
EVENT Number            : 0
Event Type Revision     : 1
Event Header Length     : 21
Controller Identifier   : 65
Event Timestamp is      : 564569411648175 (Fri Jun 29 00:34:08 19860 EDT)
Vendor Specific Information Length: 0
Event Length            : 16
EVENT Type              : Timestamp Change Event(0x3)

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 linux/nvme.h |   5 +-
 nvme-print.c | 180 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 127 insertions(+), 58 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index fed06bf..2319638 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -839,7 +839,7 @@ struct nvme_persistent_event_entry_head {
 	__u8	ehl;
 	__u8	rsvd3;
 	__le16	ctrl_id;
-	__le64	etimestamp;
+	__u8	etimestamp[8];
 	__u8	rsvd14[6];
 	__le16	vsil;
 	__le16	el;
@@ -878,7 +878,8 @@ enum nvme_persistent_event_types {
     NVME_SANITIZE_START_EVENT       = 0x09,
     NVME_SANITIZE_COMPLETION_EVENT  = 0x0a,
     NVME_SET_FEATURE_EVENT          = 0x0b,
-    NVME_THERMAL_EXCURSION_EVENT    = 0x0d
+    NVME_TELEMETRY_CRT_EVENT        = 0x0c,
+    NVME_THERMAL_EXCURSION_EVENT    = 0x0d,
 };
 
 enum nvme_persistent_event_log_actions {
diff --git a/nvme-print.c b/nvme-print.c
index 389c321..fe3b5a2 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1003,6 +1003,26 @@ void nvme_show_predictable_latency_event_agg_log(
 	}
 }
 
+const char *nvme_pel_event_to_string(int type)
+{
+	switch (type) {
+	case NVME_SMART_HEALTH_EVENT:   return "SMART/Health Log Snapshot Event(0x1)";
+	case NVME_FW_COMMIT_EVENT:      return "Firmware Commit Event(0x2)";
+	case NVME_TIMESTAMP_EVENT:      return "Timestamp Change Event(0x3)";
+	case NVME_POWER_ON_RESET_EVENT: return "Power-on or Reset Event(0x4)";
+	case NVME_NSS_HW_ERROR_EVENT:   return "NVM Subsystem Hardware Error Event(0x5)";
+	case NVME_CHANGE_NS_EVENT:      return "Change Namespace Event(0x6)";
+	case NVME_FORMAT_START_EVENT:   return "Format NVM Start Event(0x7)";
+	case NVME_FORMAT_COMPLETION_EVENT:      return "Format NVM Completion Event(0x8)";
+	case NVME_SANITIZE_START_EVENT: return "Sanitize Start Event(0x9)";
+	case NVME_SANITIZE_COMPLETION_EVENT:    return "Sanitize Completion Event(0xa)";
+	case NVME_SET_FEATURE_EVENT:    return "Set Feature Event(0xb)";
+	case NVME_TELEMETRY_CRT_EVENT: return "Telemetry Crt Event(0xc)";
+	case NVME_THERMAL_EXCURSION_EVENT:      return "Thermal Excursion Event(0xd)";
+	default:                        return NULL;
+	}
+}
+
 static const char *nvme_show_nss_hw_error(__u16 error_code)
 {
 	switch (error_code) {
@@ -1031,6 +1051,30 @@ static const char *nvme_show_nss_hw_error(__u16 error_code)
 	}
 }
 
+uint64_t int64_to_long(__u8 *data)
+{
+	int i;
+	uint64_t result = 0;
+
+	for (i = 0; i < 8; i++) {
+		result *= 256;
+		result += data[7 - i];
+	}
+	return result;
+}
+
+static const char *persistent_event_show_ts(__u8 *ts)
+{
+	struct tm *tm;
+	static char buffer[32];
+	time_t timestamp = int64_to_long(ts) / 1000;
+	char *ptr = &buffer[0];
+
+	tm = localtime(&timestamp);
+	strftime(ptr, sizeof(buffer), "%c %Z", tm);
+	return buffer;
+}
+
 void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 size)
 {
 	struct json_object *root;
@@ -1038,7 +1082,7 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 	struct json_object *valid;
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
-	char key[128];
+	char key[128], str[128];
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
 	struct nvme_time_stamp_change_event *ts_change_event;
@@ -1126,20 +1170,24 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 
 		valid_attrs = json_create_object();
 
-		json_object_add_value_uint(valid_attrs, "event_type",
-			pevent_entry_head->etype);
+		json_object_add_value_uint(valid_attrs, "event_number",
+			i);
 		json_object_add_value_uint(valid_attrs, "event_type_rev",
 			pevent_entry_head->etype_rev);
 		json_object_add_value_uint(valid_attrs, "event_header_len",
 			pevent_entry_head->ehl);
 		json_object_add_value_uint(valid_attrs, "ctrl_id",
 			le16_to_cpu(pevent_entry_head->ctrl_id));
-		json_object_add_value_uint(valid_attrs, "event_time_stamp",
-			le64_to_cpu(pevent_entry_head->etimestamp));
+		sprintf(str, "%"PRIu64" (%s)",
+			int64_to_long(pevent_entry_head->etimestamp),
+			persistent_event_show_ts(pevent_entry_head->etimestamp));
+		json_object_add_value_string(valid_attrs, "event_time_stamp", str);
 		json_object_add_value_uint(valid_attrs, "vu_info_len",
 			le16_to_cpu(pevent_entry_head->vsil));
 		json_object_add_value_uint(valid_attrs, "event_len",
 			le16_to_cpu(pevent_entry_head->el));
+		json_object_add_value_string(valid_attrs, "event_type",
+			nvme_pel_event_to_string(pevent_entry_head->etype));
 
 		offset += pevent_entry_head->ehl + 3;
 
@@ -1217,10 +1265,12 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 			break;
 		case NVME_FW_COMMIT_EVENT:
 			fw_commit_event = pevent_log_info + offset;
-			json_object_add_value_uint(valid_attrs, "old_fw_rev",
-				le64_to_cpu(fw_commit_event->old_fw_rev));
-			json_object_add_value_uint(valid_attrs, "new_fw_rev",
-				le64_to_cpu(fw_commit_event->new_fw_rev));
+			sprintf(str, "%"PRIu64" (%s)", le64_to_cpu(fw_commit_event->old_fw_rev),
+				fw_to_string(fw_commit_event->old_fw_rev));
+			json_object_add_value_string(valid_attrs, "old_fw_rev", str);
+			sprintf(str, "%"PRIu64" (%s)", le64_to_cpu(fw_commit_event->new_fw_rev),
+				fw_to_string(fw_commit_event->new_fw_rev));
+			json_object_add_value_string(valid_attrs, "new_fw_rev", str);
 			json_object_add_value_uint(valid_attrs, "fw_commit_action",
 				fw_commit_event->fw_commit_action);
 			json_object_add_value_uint(valid_attrs, "fw_slot",
@@ -1235,8 +1285,10 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 			break;
 		case NVME_TIMESTAMP_EVENT:
 			ts_change_event = pevent_log_info + offset;
-			json_object_add_value_uint(valid_attrs, "prev_ts",
-				le64_to_cpu(ts_change_event->previous_timestamp));
+			sprintf(str, "%"PRIu64" (%s)",
+				int64_to_long(ts_change_event->previous_timestamp),
+				persistent_event_show_ts(ts_change_event->previous_timestamp));
+			json_object_add_value_string(valid_attrs, "prev_ts", str);
 			json_object_add_value_uint(valid_attrs,
 				"ml_secs_since_reset",
 				le64_to_cpu(ts_change_event->ml_secs_since_reset));
@@ -1248,8 +1300,9 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 			por_info_list = por_info_len / sizeof(*por_event);
 
 			fw_rev = pevent_log_info + offset;
-			json_object_add_value_uint(valid_attrs, "fw_rev",
-				le64_to_cpu(*fw_rev));
+			sprintf(str, "%"PRIu64" (%s)", le64_to_cpu(*fw_rev),
+				fw_to_string(*fw_rev));
+			json_object_add_value_string(valid_attrs, "fw_rev", str);
 			for (int i = 0; i < por_info_list; i++) {
 				por_event = pevent_log_info + offset +
 					sizeof(*fw_rev) + i * sizeof(*por_event);
@@ -1263,8 +1316,10 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 					le32_to_cpu(por_event->ctrl_power_cycle));
 				json_object_add_value_uint(valid_attrs, "power_on_ml_secs",
 					le64_to_cpu(por_event->power_on_ml_seconds));
-				json_object_add_value_uint(valid_attrs, "ctrl_time_stamp",
-					le64_to_cpu(por_event->ctrl_time_stamp));
+				sprintf(str, "%"PRIu64" (%s)",
+					int64_to_long(por_event->ctrl_time_stamp),
+					persistent_event_show_ts(por_event->ctrl_time_stamp));
+				json_object_add_value_string(valid_attrs, "ctrl_time_stamp", str);
 			}
 			break;
 		case NVME_NSS_HW_ERROR_EVENT:
@@ -1358,10 +1413,11 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	__u8 action, __u32 size, const char *devname,
 	enum nvme_print_flags flags)
 {
-	__u32 offset, por_info_len, por_info_list;
+	__u32 offset, por_info_len, por_info_list, add_info_len;
 	__u64 *fw_rev;
 	int fid, cdw11, dword_cnt;
 	unsigned char *mem_buf = NULL;
+	bool found = false;
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
 	struct nvme_time_stamp_change_event *ts_change_event;
@@ -1388,31 +1444,31 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	printf("Action for Persistent Event Log: %u\n", action);
 	if (size >= offset) {
 		pevent_log_head = pevent_log_info;
-		printf("Log Identifier: %u\n", pevent_log_head->log_id);
-		printf("Total Number of Events: %u\n",
+		printf("Log Identifier		: 0x%x\n", pevent_log_head->log_id);
+		printf("Total Number of Events	: %u\n",
 			le32_to_cpu(pevent_log_head->tnev));
-		printf("Total Log Length : %"PRIu64"\n",
+		printf("Total Log Length	: %"PRIu64"\n",
 			le64_to_cpu(pevent_log_head->tll));
-		printf("Log Revision: %u\n", pevent_log_head->log_rev);
-		printf("Log Header Length: %u\n", pevent_log_head->head_len);
-		printf("Timestamp: %"PRIu64"\n",
+		printf("Log Revision		: %u\n", pevent_log_head->log_rev);
+		printf("Log Header Length	: %u\n", pevent_log_head->head_len);
+		printf("Timestamp		: %"PRIu64"\n",
 			le64_to_cpu(pevent_log_head->timestamp));
-		printf("Power On Hours (POH): %'.0Lf\n",
+		printf("Power On Hours (POH)	: %'.0Lf\n",
 			int128_to_double(pevent_log_head->poh));
-		printf("Power Cycle Count: %"PRIu64"\n",
+		printf("Power Cycle Count	: %"PRIu64"\n",
 			le64_to_cpu(pevent_log_head->pcc));
-		printf("PCI Vendor ID (VID): %u\n",
+		printf("PCI Vendor ID (VID)	: 0x%x\n",
 			le16_to_cpu(pevent_log_head->vid));
-		printf("PCI Subsystem Vendor ID (SSVID): %u\n",
+		printf("PCI Sub Vendor ID (SSVID): 0x%x\n",
 			le16_to_cpu(pevent_log_head->ssvid));
-		printf("Serial Number (SN): %-.*s\n",
+		printf("Serial Number (SN)	: %-.*s\n",
 			(int)sizeof(pevent_log_head->sn), pevent_log_head->sn);
-		printf("Model Number (MN): %-.*s\n",
+		printf("Model Number (MN)	: %-.*s\n",
 			(int)sizeof(pevent_log_head->mn), pevent_log_head->mn);
 		printf("NVM Subsystem NVMe Qualified Name (SUBNQN): %-.*s\n",
 			(int)sizeof(pevent_log_head->subnqn),
 			pevent_log_head->subnqn);
-		printf("Supported Events Bitmap: ");
+		printf("Supported Events Bitmap:\n");
 		for (int i = 0; i < 32; i++) {
 			if (pevent_log_head->supp_event_bm[i] == 0)
 				continue;
@@ -1442,34 +1498,38 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			offset += pevent_entry_head->ehl + 3;
 			offset += le16_to_cpu(pevent_entry_head->el);
 			continue;
-		}
+		} else
+			found = true;
 
-		printf("Event Type: %u\n", pevent_entry_head->etype);
-		printf("Event Type Revision: %u\n", pevent_entry_head->etype_rev);
-		printf("Event Header Length: %u\n", pevent_entry_head->ehl);
-		printf("Controller Identifier: %u\n",
+		printf("EVENT Number		: %d\n", i);
+		printf("Event Type Revision	: %u\n", pevent_entry_head->etype_rev);
+		printf("Event Header Length	: %u\n", pevent_entry_head->ehl);
+		printf("Controller Identifier	: %u\n",
 			le16_to_cpu(pevent_entry_head->ctrl_id));
-		printf("Event Timestamp: %"PRIu64"\n",
-			le64_to_cpu(pevent_entry_head->etimestamp));
+		printf("Event Timestamp is	: %"PRIu64" (%s)\n",
+			int64_to_long(pevent_entry_head->etimestamp),
+			persistent_event_show_ts(pevent_entry_head->etimestamp));
 		printf("Vendor Specific Information Length: %u\n",
 			le16_to_cpu(pevent_entry_head->vsil));
-		printf("Event Length: %u\n", le16_to_cpu(pevent_entry_head->el));
+		printf("Event Length		: %u\n", le16_to_cpu(pevent_entry_head->el));
+		printf("EVENT Type		: %s\n",
+			nvme_pel_event_to_string(pevent_entry_head->etype));
 
 		offset += pevent_entry_head->ehl + 3;
 
 		switch (pevent_entry_head->etype) {
 		case NVME_SMART_HEALTH_EVENT:
 			smart_event = pevent_log_info + offset;
-			printf("Smart Health Event: \n");
 			nvme_show_smart_log(smart_event, NVME_NSID_ALL, devname, flags);
 			break;
 		case NVME_FW_COMMIT_EVENT:
 			fw_commit_event = pevent_log_info + offset;
-			printf("FW Commit Event: \n");
-			printf("Old Firmware Revision: %"PRIu64"\n",
-				le64_to_cpu(fw_commit_event->old_fw_rev));
-			printf("New Firmware Revision: %"PRIu64"\n",
-				le64_to_cpu(fw_commit_event->new_fw_rev));
+			printf("Old Firmware Revision: %"PRIu64" (%s)\n",
+				le64_to_cpu(fw_commit_event->old_fw_rev),
+				fw_to_string(fw_commit_event->old_fw_rev));
+			printf("New Firmware Revision: %"PRIu64" (%s)\n",
+				le64_to_cpu(fw_commit_event->new_fw_rev),
+				fw_to_string(fw_commit_event->new_fw_rev));
 			printf("FW Commit Action: %u\n",
 				fw_commit_event->fw_commit_action);
 			printf("FW Slot: %u\n", fw_commit_event->fw_slot);
@@ -1482,9 +1542,9 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_TIMESTAMP_EVENT:
 			ts_change_event = pevent_log_info + offset;
-			printf("Time Stamp Change Event: \n");
-			printf("Previous Timestamp: %"PRIu64"\n",
-				le64_to_cpu(ts_change_event->previous_timestamp));
+			printf("The Previous Timestamp is : %"PRIu64" (%s)\n",
+				int64_to_long(ts_change_event->previous_timestamp),
+				persistent_event_show_ts(ts_change_event->previous_timestamp));
 			printf("Milliseconds Since Reset: %"PRIu64"\n",
 				le64_to_cpu(ts_change_event->ml_secs_since_reset));
 			break;
@@ -1494,9 +1554,10 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 
 			por_info_list = por_info_len / sizeof(*por_event);
 
-			printf("Power On Reset Event: \n");
 			fw_rev = pevent_log_info + offset;
-			printf("Firmware Revision: %"PRIu64"\n", le64_to_cpu(*fw_rev));
+			printf("Firmware Revision: %"PRIu64  "", le64_to_cpu(*fw_rev));
+			printf("(%-.*s)\n",
+				(int)sizeof(*fw_rev), fw_to_string(*fw_rev));
 			printf("Reset Information List: \n");
 
 			for (int i = 0; i < por_info_list; i++) {
@@ -1511,8 +1572,9 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 					le32_to_cpu(por_event->ctrl_power_cycle));
 				printf("Power on milliseconds: %"PRIu64"\n",
 					le64_to_cpu(por_event->power_on_ml_seconds));
-				printf("Controller Timestamp: %"PRIu64"\n",
-					le64_to_cpu(por_event->ctrl_time_stamp));
+				printf("Controller Timestamp is : %"PRIu64" (%s)\n",
+					int64_to_long(por_event->ctrl_time_stamp),
+					persistent_event_show_ts(por_event->ctrl_time_stamp));
 			}
 			break;
 		case NVME_NSS_HW_ERROR_EVENT:
@@ -1520,10 +1582,16 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			printf("NVM Subsystem Hardware Error Event Code: %u, %s\n",
 				le16_to_cpu(nss_hw_err_event->nss_hw_err_event_code),
 				nvme_show_nss_hw_error(nss_hw_err_event->nss_hw_err_event_code));
+			add_info_len = (le16_to_cpu(pevent_entry_head->el) -
+				le16_to_cpu(pevent_entry_head->vsil) - 4);
+			if (add_info_len != 0) {
+				printf("Additional Hardware error Information   :\n");
+				d((unsigned char *)(nss_hw_err_event + 4), add_info_len, 16, 1);
+			}
+
 			break;
 		case NVME_CHANGE_NS_EVENT:
 			ns_event = pevent_log_info + offset;
-			printf("Change Namespace Event: \n");
 			printf("Namespace Management CDW10: %u\n",
 				le32_to_cpu(ns_event->nsmgt_cdw10));
 			printf("Namespace Size: %"PRIu64"\n",
@@ -1542,7 +1610,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_FORMAT_START_EVENT:
 			format_start_event = pevent_log_info + offset;
-			printf("Format NVM Start Event: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_start_event->nsid));
 			printf("Format NVM Attributes: %u\n",
@@ -1552,7 +1619,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_FORMAT_COMPLETION_EVENT:
 			format_cmpln_event = pevent_log_info + offset;
-			printf("Format NVM Completion Event: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_cmpln_event->nsid));
 			printf("Smallest Format Progress Indicator: %u\n",
@@ -1566,7 +1632,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_SANITIZE_START_EVENT:
 			sanitize_start_event = pevent_log_info + offset;
-			printf("Sanitize Start Event: \n");
 			printf("SANICAP: %u\n", sanitize_start_event->sani_cap);
 			printf("Sanitize CDW10: %u\n",
 				le32_to_cpu(sanitize_start_event->sani_cdw10));
@@ -1575,7 +1640,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_SANITIZE_COMPLETION_EVENT:
 			sanitize_cmpln_event = pevent_log_info + offset;
-			printf("Sanitize Completion Event: \n");
 			printf("Sanitize Progress: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->sani_prog));
 			printf("Sanitize Status: %u\n",
@@ -1599,7 +1663,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_THERMAL_EXCURSION_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
-			printf("Thermal Excursion Event: \n");
 			printf("Over Temperature: %u\n", thermal_exc_event->over_temp);
 			printf("Threshold: %u\n", thermal_exc_event->threshold);
 			break;
@@ -1609,6 +1672,11 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 		offset += le16_to_cpu(pevent_entry_head->el);
 		printf("\n");
 	}
+	if (event_type != 0 && !found && nvme_pel_event_to_string(event_type))
+		printf("Current PEL: No %s\n", nvme_pel_event_to_string(event_type));
+	else
+		printf("Current PEL: Not support 0x%x event in PEL\n", event_type);
+
 }
 
 void json_endurance_group_event_agg_log(
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
