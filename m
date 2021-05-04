Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E27C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1715610A0
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1715610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcYWJuLvlSknIZ4cLXMxGn40z1fmC6VPHPh+qBifCAk=; b=Gin0sArLWAmK7DlQ//rW9idwmN
	Y263vGpCcAyeZuJLT/dwkT77tFZCKa+DUbfDLrwDAlm7q9ylTx0bv3dCmjCOwnxwh7C0p81z7ifH2
	e+J4XPNL48Lhzgr0tSqXCHhAqmrEdCiUTCWqYVRQea7+bZ49BXlqaGirR5Fjm4axXeAqC6tuz0spc
	zGws2AQFjGenhQtR5aGhovhJ2nGWCwX0XxkST3v0yi+cR67ngWRiF2h3G1zh6/7nlntk4N0Hqw4Dt
	SGui61mguQpxReHcGCURF2/XXI26Vnqk3GmgsnyP80zBvX84jDil14+Lmji3QcevESCAuH6fsBh7d
	FQUY+GjQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldwUT-00GOvA-7z; Tue, 04 May 2021 14:57:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTw-00GOrN-P8
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 14:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=bEMY9Q09OtAUwQNdV1+FvgCs0J/uI05YjXEdP0P/taQ=; b=g6XzsGxzm3xb3iAoCV8DC7vhZK
 WmcNV9NPZRO4Gt30uM6GMyEAMfjHX+KG2GFSQLO46Sgj1z5pv7yDmZrEsuVbah8MtZNStiJKrF7Tv
 KbL2lsWnN4l7tTaooNggp532y8i203wsZGPy/Kb2eIqYZ79MNSSLJE0hDf+SqRdmMPkBleXXqIR0R
 f/W09fNWXSdFnWizniU3dpYNGJS94KAiWD0itzle4wISOPV/XjQrdr2dkw/VEYE8YUHdstiokbwwB
 /uqE7sfVuGfzxvMvBmgTjHqO549ZPW2cyK+X/BhmKqvjJ/pl8AiGE/VJrcrUOsvlWFVMvdvlJHIMx
 7ey3G5+A==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTt-0043GY-Ke
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 14:57:03 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 144EouxI087616; Tue, 4 May 2021 10:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=bEMY9Q09OtAUwQNdV1+FvgCs0J/uI05YjXEdP0P/taQ=;
 b=juWE/onME0hxjy5T83k5tNP7hxsHAEdG/BrwRKiIHMoZERLP43UbDse+hIGs4YKm3cOW
 908UHlD/LQchegMQPsPfdyYADXiZ9ovBLfm8QbBGtspuzCQamK+s8TZ+/5UB8bN6Xgvp
 RFhv75tOQakGUqWgOGxP471//WYXEcheenOJx9iDgUErRjBXB58+2SUYsW/eQYKFPmXX
 AgOalyh5+BrYwZ4WqqHWroLnt8z/Stuf2le73V/pzgk8/0jzUAfKuAGQ1P/yHlvtD8U6
 9XHKkXgvUUOIELLDiD4mbYE6Z4XD7hTlw1MONk3uYOtY5VPcCGwQmrK9Sm3E4BiR+tNY KA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38b8d383e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 10:56:57 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144EqSJr022210;
 Tue, 4 May 2021 14:56:56 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 388xm9bg88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 14:56:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 144EutTw5374606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 May 2021 14:56:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 728F8BE054;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DB58BE056;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH V2 2/3] nvme-cli: Add set-feature(0xb) in persistent event log
Date: Tue,  4 May 2021 08:33:46 -0500
Message-Id: <1620135227-21783-3-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EysxzAkGW1uZ4Xc3RnRbiu7ii-l9Jv0M
X-Proofpoint-ORIG-GUID: EysxzAkGW1uZ4Xc3RnRbiu7ii-l9Jv0M
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-04_08:2021-05-04,
 2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_075701_705158_462ECC68 
X-CRM114-Status: GOOD (  19.42  )
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

Add "set-feature(0xb) support in pel and tested with two NVME devices.

#./nvme persistent-event-log -a 0x0  -t 0xb /dev/nvme0
Persistent Event Entries:
EVENT Number            : 302
Event Type Revision     : 1
Event Header Length     : 21
Controller Identifier   : 65
Event Timestamp is      : 846042775320587 (Fri Jan 11 13:02:00 28780 EST)
Vendor Specific Information Length: 0
Event Length            : 16
EVENT Type              : Set Feature Event(0xb)
Set Feature ID  :0x7 (Number of Queues),  value:0x4f004f
        Number of IO Completion Queues Allocated (NCQA): 80
        Number of IO Submission Queues Allocated (NSQA): 80

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 linux/nvme.h |  7 +++++++
 nvme-print.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 4ad09ee..91ee8be 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -826,6 +826,12 @@ struct nvme_sanitize_compln_event {
 	__u8 	rsvd6[2];
 };
 
+/* persistent event type 0Bh */
+struct nvme_set_feature_event {
+    __le32     layout;
+    __le32     cdw_mem[0];
+};
+
 /* persistent event type 0Dh */
 struct nvme_thermal_exc_event {
     __u8 	over_temp;
@@ -877,6 +883,7 @@ enum nvme_persistent_event_types {
     NVME_FORMAT_COMPLETION_EVENT    = 0x08,
     NVME_SANITIZE_START_EVENT       = 0x09,
     NVME_SANITIZE_COMPLETION_EVENT  = 0x0a,
+    NVME_SET_FEATURE_EVENT          = 0x0b,
     NVME_THERMAL_EXCURSION_EVENT    = 0x0d
 };
 
diff --git a/nvme-print.c b/nvme-print.c
index 7b43fff..f22cc55 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1333,6 +1333,8 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 				le16_to_cpu(sanitize_cmpln_event->cmpln_info));
 			break;
 		case NVME_THERMAL_EXCURSION_EVENT:
+			printf("No Jason format for set-feature events in PEL\n");
+		case NVME_SET_FEATURE_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
 			json_object_add_value_uint(valid_attrs, "over_temp",
 				thermal_exc_event->over_temp);
@@ -1357,6 +1359,8 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 {
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
+	int fid, cdw11, dword_cnt;
+	unsigned char *mem_buf = NULL;
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
 	struct nvme_time_stamp_change_event *ts_change_event;
@@ -1367,6 +1371,7 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	struct nvme_format_nvm_compln_event *format_cmpln_event;
 	struct nvme_sanitize_start_event *sanitize_start_event;
 	struct nvme_sanitize_compln_event *sanitize_cmpln_event;
+	struct nvme_set_feature_event *set_feat_event;
 	struct nvme_thermal_exc_event *thermal_exc_event;
 	struct nvme_persistent_event_log_head *pevent_log_head;
 	struct nvme_persistent_event_entry_head *pevent_entry_head;
@@ -1577,6 +1582,20 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 			printf("Completion Information: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->cmpln_info));
 			break;
+		case NVME_SET_FEATURE_EVENT:
+			set_feat_event = pevent_log_info + offset;
+			dword_cnt =  set_feat_event->layout & 0x03;
+			fid = le32_to_cpu(set_feat_event->cdw_mem[0]) & 0x000f;
+			cdw11 = le32_to_cpu(set_feat_event->cdw_mem[1]);
+
+			if (((set_feat_event->layout & 0xff) >> 2) != 0)
+				mem_buf = (unsigned char *)(set_feat_event + 4 + dword_cnt * 4);
+
+			printf("Set Feature ID  :%#02x (%s),  value:%#08x\n", fid,
+				nvme_feature_to_string(fid), cdw11);
+
+			nvme_feature_show_fields(fid, cdw11, mem_buf);
+			break;
 		case NVME_THERMAL_EXCURSION_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
 			printf("Thermal Excursion Event: \n");
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
