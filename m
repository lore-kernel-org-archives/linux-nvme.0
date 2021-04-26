Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F96C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:17:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDA961154
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDA961154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+5ymurCqvNEaf+e6jifaFES3EXvxOuX9EEbuaU6LDQ=; b=XJPCMnfpTAbAwtrcOAP5RGM1MG
	Kh2MUMLpMVP4CL/c2bxESZb30hcoJh1iUpZDAVcvvQKm91n6p3yXoVpgUYeiM+a2UvO3U5b8CQOy4
	E7GWMWWRE+/biMyxw5GZtMVWtACfG+S0ba+pyGgteYAvn4H9cX1/R1L3tja/4LsELGaHlsSqsN8lI
	jYIikYA4BvSv/5o1dhgNuBF8/0cRB7PrwQCQJ4KV53jVamryDlsvrdPmCtEEZVznnX8tO6rzZQqr9
	iQ5z4JqiE8pgMao0qKZnRvsok453QvX8YfRxK0v8az/2Em0lPfpAy22cO/Wsf5stVHUc5Deuax/R9
	PDBuEUjg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb6j7-008Maj-Jy; Mon, 26 Apr 2021 19:17:01 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6ii-008MXM-6n
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 19:16:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=u6VOZS0IrhJvb0MJgih9uDeGAdLYwN0HUDlvGoUP7uM=; b=qixMD4CDDmXxa6GxLaZJkLiK+1
 VLC6jManUz/9yl2W0EeV+BRQlLqxbulXS8iP9ztJVqvr7UZnbblJ8dwd0yCCgAS8t8yjqwm9HOk4p
 F1rxe8E8afJg22RVImpJtPoGsQZkjT525hYbdg94PlxM015FJnc/Qd418jX7+OpCbe5CKLvaMf/RC
 4P+eikLX0wjrnnl26CGvHntS3dS3dBvzrIQdLyfwBuZp52KaecOl5F7KknXpcEM0Ro0vLHBxVUD3c
 btJLmPnHL6FFrp2zP7v4ghLMaKS9FqElARH3EMGUSnpph5faJwTQ3Zs7v/CPCpvsjXqE1uTEzlxGH
 wenGmY8w==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6id-00G8O6-2F
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 19:16:35 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13QJ3I7F124497; Mon, 26 Apr 2021 15:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=u6VOZS0IrhJvb0MJgih9uDeGAdLYwN0HUDlvGoUP7uM=;
 b=VB+pSTLeNdWgHNBcGWA2QkwzNO/CWn7eMUPcsMj7+E0mv+pxvsnVQuHxN1ncmZ/S4St/
 hrifkrD5wXJQY8U9JmbBvCZSmiLqG1IFUK5MWLKoJPTJn6wwShJALp6w7o9rmDMrREzz
 MhhxFvlY+NkopD63ZbNz70+f9d6n1nZxFZIZrcZWUb+rxJJNcHGyzna5GRsVV/VZ0e0J
 2jziBD4b1nYOu/FQJ4Jv0CRG1TVvPQLZrMFLgT4tJ7FLtWOFLB/YVaZ4a6zSHCGn5rI/
 4ePpW5lMdoAPJzL4J6nU7tMHgb8GqhDOSFl/a9xe6i6+5rvpFVkf5eh1lted4wuznROQ Kw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3861a1412k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 15:16:28 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QJ74jl011037;
 Mon, 26 Apr 2021 19:16:28 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by ppma04dal.us.ibm.com with ESMTP id 384ay9cf3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 19:16:27 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13QJFCfp34472310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Apr 2021 19:15:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17E716E050;
 Mon, 26 Apr 2021 19:15:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B54B66E04E;
 Mon, 26 Apr 2021 19:15:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Apr 2021 19:15:10 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH 2/3]  nvme: Add set-feature(0xb) in persistent event log
Date: Mon, 26 Apr 2021 12:52:17 -0500
Message-Id: <1619459538-3998-3-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f5Oz1eaJx945pG7iKXDZfCIH48C36WsQ
X-Proofpoint-ORIG-GUID: f5Oz1eaJx945pG7iKXDZfCIH48C36WsQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-26_09:2021-04-26,
 2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_121631_136453_92CBB022 
X-CRM114-Status: GOOD (  18.68  )
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

Add "set-feature(0xb) support in pel and tested with two NVME devices.

./nmve persistent-event-log -a 0x0 -t 0xb /dev/nvme0

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 linux/nvme.h |  1 +
 nvme-print.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 4ad09ee..fed06bf 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -877,6 +877,7 @@ enum nvme_persistent_event_types {
     NVME_FORMAT_COMPLETION_EVENT    = 0x08,
     NVME_SANITIZE_START_EVENT       = 0x09,
     NVME_SANITIZE_COMPLETION_EVENT  = 0x0a,
+    NVME_SET_FEATURE_EVENT          = 0x0b,
     NVME_THERMAL_EXCURSION_EVENT    = 0x0d
 };
 
diff --git a/nvme-print.c b/nvme-print.c
index d05ed3e..389c321 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1334,6 +1334,8 @@ void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 si
 				le16_to_cpu(sanitize_cmpln_event->cmpln_info));
 			break;
 		case NVME_THERMAL_EXCURSION_EVENT:
+			printf("No Jason format for set-feature events in PEL\n");
+		case NVME_SET_FEATURE_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
 			json_object_add_value_uint(valid_attrs, "over_temp",
 				thermal_exc_event->over_temp);
@@ -1358,6 +1360,8 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 {
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
+	int fid, cdw11, dword_cnt;
+	unsigned char *mem_buf = NULL;
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
 	struct nvme_time_stamp_change_event *ts_change_event;
@@ -1368,6 +1372,7 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	struct nvme_format_nvm_compln_event *format_cmpln_event;
 	struct nvme_sanitize_start_event *sanitize_start_event;
 	struct nvme_sanitize_compln_event *sanitize_cmpln_event;
+	struct nvme_set_feature_event *set_feat_event;
 	struct nvme_thermal_exc_event *thermal_exc_event;
 	struct nvme_persistent_event_log_head *pevent_log_head;
 	struct nvme_persistent_event_entry_head *pevent_entry_head;
@@ -1578,6 +1583,20 @@ void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
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
