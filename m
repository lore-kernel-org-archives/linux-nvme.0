Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C9C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79842610A0
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79842610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+qYGfgsqI0rBN3W61kspjcmQyRnAMngtBWbj/B9OIw=; b=GGUoRB6jSBBSjmUxTHUiQLwKPG
	YhbqdPQ+Ieu69fm+Z49nJktPkAFe7uecVsM4ONwfTTlSZFtotAbMOOCk/2gpBC0OvZxcjR+bdG+Pa
	uIX0sReHztL9BlP2xSBpZIeFLRDmIZ9pPoaKGTJWFKGlu7sEA+zUju6aRwxuHVKFGCNld/Sck+Okt
	/7T21Z7Yi5lHyx65Hh4Hn246F1uGBAiTGeUnca9ZvRXihAuuI55bKWDV4LWkrLwZEupUy+QNZ1fyJ
	sFI4qYPx+XS4d2ZqHRHV5eBlaftzaiuR71qbqp6ZihwXhHBGi7iTPzgRmaxlvVJsSBGj2sKLkQF9G
	aAfnIRkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldwUI-00GOtW-GO; Tue, 04 May 2021 14:57:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTw-00GOrL-J8
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 14:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RYD8RRucaAzqeGjd6Ytt7XvlL0p6kAatmWAHDfp/Aqo=; b=BakfRVsa4lMhyEkFujD9atiJyi
 zvwRGtm7vVOp2Wx4ni7czVzsca5AvLjwZi+MCLkEoPjenOQ9jpFtFEOMlzkfDRMEVdww/ENIRkjx8
 y74RVVmzcp8WMA4ODDVfTFtwzsdqYDg4q0575ZMebvZ4n2okCbAgVXXb88nOZq66uHlSakcZ2qRkF
 C/mQcXmbyEYzE0O/KGOrFtsTfK3dJ0/DBGEyud9ItES7OzlmxOh5GgD04OkxkwkR/w7VM8zf+Uj9f
 1C3cb04yR+U8Nm4CEFqwmdvE82USbW7kd1CNj6xq3ALsA+rcA8xmrulmAjV2JbRZIS4Se35OTO/jF
 3bKoOUgw==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTs-0043Gr-Sp
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 14:57:03 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 144EXZET126816; Tue, 4 May 2021 10:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=RYD8RRucaAzqeGjd6Ytt7XvlL0p6kAatmWAHDfp/Aqo=;
 b=a9Y3B7OuE3fzFZ2F0/eIFcEfCiDspQ9+A5zRCqDTYfm5+Am79inxhzfUjqdDIpzGz+v2
 taUO4KCM4Gko5tB/FMUTe4SLdJmv0uQ7T7nGM1gm5NrD8Op+/oAwo6nbor8ohHhkSNVg
 zKDXoT9juSVpm3KrRNQitCa+eIHarUJgb7R8GsZo7A/ZGcDuuYBrWFLnyel9ZIpcPlvA
 qZPbWCwjmKjdBRf1eDoRFioUz4QYIFg7odK5xNuRVcEM893j0UDRP4CwLhhwJqLpBf3X
 X6sxgM31vdp7WvASpe3HHa+Zxqxfbw3ru+OM4dnvOr6gqsXMZcigRQBEGODq+T1viuav Pw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38b7m7hxdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 10:56:58 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144ErUvS003325;
 Tue, 4 May 2021 14:56:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03wdc.us.ibm.com with ESMTP id 38aym4336s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 14:56:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 144Euurk28508656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 May 2021 14:56:56 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE57BBE058;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E5CDBE053;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH V2 3/3] nvme-cli: Update in persistent event pel code
Date: Tue,  4 May 2021 08:33:47 -0500
Message-Id: <1620135227-21783-4-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TO6z5rXFiVbuVoGT7sJa8C1dSO_XMxNW
X-Proofpoint-GUID: TO6z5rXFiVbuVoGT7sJa8C1dSO_XMxNW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-04_08:2021-05-04,
 2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_075700_983848_64FBD133 
X-CRM114-Status: GOOD (  23.80  )
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

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

Update several improvement in pel:
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
 linux/nvme.h |   9 +--
 nvme-print.c | 180 +++++++++++++++++++++++++++++++++++----------------
 nvme-print.h |   1 +
 nvme.c       |   6 ++
 4 files changed, 135 insertions(+), 61 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 91ee8be..4212dd9 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -755,7 +755,7 @@ struct nvme_fw_commit_event {
 
 /* persistent event type 03h */
 struct nvme_time_stamp_change_event {
-    __le64 	previous_timestamp;
+    __u8 	previous_timestamp[8];
     __le64 	ml_secs_since_reset;
 };
 
@@ -767,7 +767,7 @@ struct nvme_power_on_reset_info_list {
     __u8     rsvd4[12];
     __le32   ctrl_power_cycle;
     __le64   power_on_ml_seconds;
-    __le64   ctrl_time_stamp;
+    __u8   ctrl_time_stamp[8];
 } __attribute__((packed));
 
 /* persistent event type 05h */
@@ -845,7 +845,7 @@ struct nvme_persistent_event_entry_head {
 	__u8	ehl;
 	__u8	rsvd3;
 	__le16	ctrl_id;
-	__le64	etimestamp;
+	__u8	etimestamp[8];
 	__u8	rsvd14[6];
 	__le16	vsil;
 	__le16	el;
@@ -884,7 +884,8 @@ enum nvme_persistent_event_types {
     NVME_SANITIZE_START_EVENT       = 0x09,
     NVME_SANITIZE_COMPLETION_EVENT  = 0x0a,
     NVME_SET_FEATURE_EVENT          = 0x0b,
-    NVME_THERMAL_EXCURSION_EVENT    = 0x0d
+    NVME_TELEMETRY_CRT_EVENT        = 0x0c,
+    NVME_THERMAL_EXCURSION_EVENT    = 0x0d,
 };
 
 enum nvme_persistent_event_log_actions {
diff --git a/nvme-print.c b/nvme-print.c
index f22cc55..90fb776 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1003,6 +1003,26 @@ void nvme_show_predictable_latency_event_agg_log(
 	}
 }
 
+const char *nvme_pel_event_to_string(int type)
+{
+	switch (type) {
+	case NVME_SMART_HEALTH_EVENT:		return "SMART/Health Log Snapshot Event(0x1)";
+	case NVME_FW_COMMIT_EVENT:		return "Firmware Commit Event(0x2)";
+	case NVME_TIMESTAMP_EVENT:		return "Timestamp Change Event(0x3)";
+	case NVME_POWER_ON_RESET_EVENT:		return "Power-on or Reset Event(0x4)";
+	case NVME_NSS_HW_ERROR_EVENT:		return "NVM Subsystem Hardware Error Event(0x5)";
+	case NVME_CHANGE_NS_EVENT:		return "Change Namespace Event(0x6)";
+	case NVME_FORMAT_START_EVENT:		return "Format NVM Start Event(0x7)";
+	case NVME_FORMAT_COMPLETION_EVENT:	return "Format NVM Completion Event(0x8)";
+	case NVME_SANITIZE_START_EVENT:		return "Sanitize Start Event(0x9)";
+	case NVME_SANITIZE_COMPLETION_EVENT:	return "Sanitize Completion Event(0xa)";
+	case NVME_SET_FEATURE_EVENT:		return "Set Feature Event(0xb)";
+	case NVME_TELEMETRY_CRT_EVENT:		return "Telemetry Crt Event(0xc)";
+	case NVME_THERMAL_EXCURSION_EVENT:	return "Thermal Excursion Event(0xd)";
+	default:				return NULL;
+	}
+}
+
 static const char *nvme_show_nss_hw_error(__u16 error_code)
 {
 	switch (error_code) {
@@ -1031,6 +1051,30 @@ static const char *nvme_show_nss_hw_error(__u16 error_code)
 	}
 }
 
+uint64_t int64_to_ulong(__u8 *data)
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
+	time_t timestamp = int64_to_ulong(ts) / 1000;
+	char *ptr = buffer;
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
@@ -1125,20 +1169,24 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 
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
+			int64_to_ulong(pevent_entry_head->etimestamp),
+			persistent_event_show_ts(pevent_entry_head->etimestamp));
+		json_object_add_value_string(valid_attrs, "event_time_stamp", str);
 		json_object_add_value_uint(valid_attrs, "vu_info_len",
 			le16_to_cpu(pevent_entry_head->vsil));
 		json_object_add_value_uint(valid_attrs, "event_len",
 			le16_to_cpu(pevent_entry_head->el));
+		json_object_add_value_string(valid_attrs, "event_type",
+			nvme_pel_event_to_string(pevent_entry_head->etype));
 
 		offset += pevent_entry_head->ehl + 3;
 
@@ -1216,10 +1264,12 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
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
@@ -1234,8 +1284,10 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 			break;
 		case NVME_TIMESTAMP_EVENT:
 			ts_change_event = pevent_log_info + offset;
-			json_object_add_value_uint(valid_attrs, "prev_ts",
-				le64_to_cpu(ts_change_event->previous_timestamp));
+			sprintf(str, "%"PRIu64" (%s)",
+				int64_to_ulong(ts_change_event->previous_timestamp),
+				persistent_event_show_ts(ts_change_event->previous_timestamp));
+			json_object_add_value_string(valid_attrs, "prev_ts", str);
 			json_object_add_value_uint(valid_attrs,
 				"ml_secs_since_reset",
 				le64_to_cpu(ts_change_event->ml_secs_since_reset));
@@ -1247,8 +1299,9 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
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
@@ -1262,8 +1315,10 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 					le32_to_cpu(por_event->ctrl_power_cycle));
 				json_object_add_value_uint(valid_attrs, "power_on_ml_secs",
 					le64_to_cpu(por_event->power_on_ml_seconds));
-				json_object_add_value_uint(valid_attrs, "ctrl_time_stamp",
-					le64_to_cpu(por_event->ctrl_time_stamp));
+				sprintf(str, "%"PRIu64" (%s)",
+					int64_to_ulong(por_event->ctrl_time_stamp),
+					persistent_event_show_ts(por_event->ctrl_time_stamp));
+				json_object_add_value_string(valid_attrs, "ctrl_time_stamp", str);
 			}
 			break;
 		case NVME_NSS_HW_ERROR_EVENT:
@@ -1357,10 +1412,11 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
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
@@ -1387,31 +1443,31 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
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
@@ -1436,39 +1492,43 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			le16_to_cpu(pevent_entry_head->el)) >= size)
 			break;
 
-		if ((event_type != 0) &
+		if ((event_type != 0) &&
 				(pevent_entry_head->etype != event_type)) {
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
+			int64_to_ulong(pevent_entry_head->etimestamp),
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
@@ -1481,9 +1541,9 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_TIMESTAMP_EVENT:
 			ts_change_event = pevent_log_info + offset;
-			printf("Time Stamp Change Event: \n");
-			printf("Previous Timestamp: %"PRIu64"\n",
-				le64_to_cpu(ts_change_event->previous_timestamp));
+			printf("The Previous Timestamp is : %"PRIu64" (%s)\n",
+				int64_to_ulong(ts_change_event->previous_timestamp),
+				persistent_event_show_ts(ts_change_event->previous_timestamp));
 			printf("Milliseconds Since Reset: %"PRIu64"\n",
 				le64_to_cpu(ts_change_event->ml_secs_since_reset));
 			break;
@@ -1493,9 +1553,10 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 
 			por_info_list = por_info_len / sizeof(*por_event);
 
-			printf("Power On Reset Event: \n");
 			fw_rev = pevent_log_info + offset;
-			printf("Firmware Revision: %"PRIu64"\n", le64_to_cpu(*fw_rev));
+			printf("Firmware Revision: %"PRIu64  "", le64_to_cpu(*fw_rev));
+			printf("(%-.*s)\n",
+				(int)sizeof(*fw_rev), fw_to_string(*fw_rev));
 			printf("Reset Information List: \n");
 
 			for (int i = 0; i < por_info_list; i++) {
@@ -1510,8 +1571,9 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 					le32_to_cpu(por_event->ctrl_power_cycle));
 				printf("Power on milliseconds: %"PRIu64"\n",
 					le64_to_cpu(por_event->power_on_ml_seconds));
-				printf("Controller Timestamp: %"PRIu64"\n",
-					le64_to_cpu(por_event->ctrl_time_stamp));
+				printf("Controller Timestamp is : %"PRIu64" (%s)\n",
+					int64_to_ulong(por_event->ctrl_time_stamp),
+					persistent_event_show_ts(por_event->ctrl_time_stamp));
 			}
 			break;
 		case NVME_NSS_HW_ERROR_EVENT:
@@ -1519,10 +1581,16 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
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
@@ -1541,7 +1609,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_FORMAT_START_EVENT:
 			format_start_event = pevent_log_info + offset;
-			printf("Format NVM Start Event: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_start_event->nsid));
 			printf("Format NVM Attributes: %u\n",
@@ -1551,7 +1618,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_FORMAT_COMPLETION_EVENT:
 			format_cmpln_event = pevent_log_info + offset;
-			printf("Format NVM Completion Event: \n");
 			printf("Namespace Identifier: %u\n",
 				le32_to_cpu(format_cmpln_event->nsid));
 			printf("Smallest Format Progress Indicator: %u\n",
@@ -1565,7 +1631,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_SANITIZE_START_EVENT:
 			sanitize_start_event = pevent_log_info + offset;
-			printf("Sanitize Start Event: \n");
 			printf("SANICAP: %u\n", sanitize_start_event->sani_cap);
 			printf("Sanitize CDW10: %u\n",
 				le32_to_cpu(sanitize_start_event->sani_cdw10));
@@ -1574,7 +1639,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_SANITIZE_COMPLETION_EVENT:
 			sanitize_cmpln_event = pevent_log_info + offset;
-			printf("Sanitize Completion Event: \n");
 			printf("Sanitize Progress: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->sani_prog));
 			printf("Sanitize Status: %u\n",
@@ -1598,7 +1662,6 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			break;
 		case NVME_THERMAL_EXCURSION_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
-			printf("Thermal Excursion Event: \n");
 			printf("Over Temperature: %u\n", thermal_exc_event->over_temp);
 			printf("Threshold: %u\n", thermal_exc_event->threshold);
 			break;
@@ -1608,6 +1671,9 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 		offset += le16_to_cpu(pevent_entry_head->el);
 		printf("\n");
 	}
+	if (event_type != 0 && !found && nvme_pel_event_to_string(event_type))
+		printf("Current PEL: No %s\n", nvme_pel_event_to_string(event_type));
+
 }
 
 void json_endurance_group_event_agg_log(
diff --git a/nvme-print.h b/nvme-print.h
index ce4f0c9..7301c04 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -53,6 +53,7 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	__u8 action, __u32 size, const char *devname,
 	enum nvme_print_flags flags);
+const char *nvme_pel_event_to_string(int type);
 void json_endurance_group_event_agg_log(
 	struct nvme_event_agg_log_page *endurance_log,
 	__u64 log_entries);
diff --git a/nvme.c b/nvme.c
index 0c8d669..59b4d42 100644
--- a/nvme.c
+++ b/nvme.c
@@ -961,6 +961,12 @@ static int get_persistent_event_log(int argc, char **argv,
 		goto close_fd;
 	}
 
+	if (cfg.event_type !=0 && !nvme_pel_event_to_string(cfg.event_type)) {
+		printf("Not support 0x%x event in Persistent Event Log\n", cfg.event_type);
+		err = -EINVAL;
+		goto close_fd;
+	}
+
 	err = nvme_persistent_event_log(fd, cfg.action,
 			sizeof(*pevent_log_head), pevent_log_head);
 	if (err < 0) {
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
