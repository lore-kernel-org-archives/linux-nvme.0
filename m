Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F2C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E91610A0
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E91610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwCSpz6TKNhZ1p8cm4ZQ/PfNwr7+5tLtmHc/HVOCo/8=; b=YTGEZPjd+ZV96fHLD0KyxJgBr8
	4p9dE1vZvhOzzxdWpT7+/vOapUMoFyv7XU+Bq0IhjMFDscLQ5SECOO4dER6Au6UcqgaFtizJrJD+o
	I6c/E2kQJcU1PVEZ9LSkkyqTg8MDmiJ3QefUr3MTEfQJOk4hV+/PwUhbzDwgO7HVPw9R2OgYPkkw3
	eUgIi7Aj5I8vIIv+OBLNZn/zAe+QDUhTevbjDmei+Ins+E8FP41nOh9haiK6ODp9k1UnuEQ1acpHH
	QzDpGTbQmuIsiPfLX79f63MaM5Go2gvzNZHZgiJzZAnpea7aXELQbgCH867rMRaZ2sh1jQN2MYs6T
	qh8rSQxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldwU8-00GOst-QP; Tue, 04 May 2021 14:57:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTw-00GOrM-Os
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 14:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dqnYPtmHmPlkZLKDKVjMdR05127CHUIJnutIGvjDtbg=; b=QLw7Rz+jswlwGEM2YDpOePiRPC
 GUPVKJQHy4Z82+2979iH6EwO+Y4GNW9IxktFBTiG7eV9+1PMzaVkLvPZYE32OOk0YwAkQDBBuWc9R
 XlQ7lvmvASfqGFT0tqlbvA/OSqbeK8zVvo0GNRjELrPnf2bs0CDwdDsN+Lm7tcuwNF5dAxtY43Rac
 +CDHAjkHUdbd6eAKxikURBOQwyy77F0M+7SyFyC0QLmiaw6axUqv7UfF8BIjx+2bSPS678kDLPKiF
 taw0u2Lr0hU7pZ7sxwSFOmYlVKRmV+m9IvK/Kcpqj7zKr5ZhjD5B3rq14V6c8C5mSIR3y0lUU3doB
 AzO5k6dA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwTt-0043Gb-4M
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 14:57:03 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 144EXZwV126835; Tue, 4 May 2021 10:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=dqnYPtmHmPlkZLKDKVjMdR05127CHUIJnutIGvjDtbg=;
 b=Mq+turNERfzSjWx60f2kLxm5Jmp67g6yiH91pYkNumH0fC8XdlYB9/Foflq6vVAvh6qj
 Jik/Q9o4lQmHeLobBTSJzNZX55cX5FeTEcvzkXuIVR5t3Ellon7iS7nHRF1dKKJR/ylz
 ylhVazQjlEXqfYeVfARcD4TJQC/pMUWQR9zI4q5vBl+4FhlIKVWNRMakZG3tcyc636s2
 qkHDRDf8POap/LndZe3rNGGltGh/s5DDlCkHD2mUxALUVZNOMcMGpNjuDZMr8yRL512v
 gcF5Zz3JsnjANvxeSsnhPvnXFmlCXuAGuEuw4BTOwy3hJT5075bISqeJXgb7K7HLgpK4 SQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38b7m7hxde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 10:56:57 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144Erb1w007191;
 Tue, 4 May 2021 14:56:56 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04wdc.us.ibm.com with ESMTP id 388xm8x2we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 14:56:56 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 144EutiK49349284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 May 2021 14:56:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18F80BE053;
 Tue,  4 May 2021 14:56:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7EAABE054;
 Tue,  4 May 2021 14:56:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  4 May 2021 14:56:54 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH V2 1/3] nvme-cli: Add event type as filter in persistent event
Date: Tue,  4 May 2021 08:33:45 -0500
Message-Id: <1620135227-21783-2-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1620135227-21783-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eZQHYCPGdplyk-VDDRmaGjnoQQrewDDR
X-Proofpoint-GUID: eZQHYCPGdplyk-VDDRmaGjnoQQrewDDR
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
X-CRM114-CacheID: sfid-20210504_075701_206146_0186A825 
X-CRM114-Status: GOOD (  23.37  )
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

Add -t option in persistent event log command. The customers can use
 -t to filter specific events in pel.

For example, only list hardware error(0x5).

./nvme persistent-event-log -a 0x0 -t 0x5 /dev/nvme0

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 nvme-print.c | 21 ++++++++++++++++++---
 nvme-print.h |  4 ++--
 nvme.c       |  6 +++++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index b01a842..7b43fff 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1031,7 +1031,7 @@ static const char *nvme_show_nss_hw_error(__u16 error_code)
 	}
 }
 
-void json_persistent_event_log(void *pevent_log_info, __u32 size)
+void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 size)
 {
 	struct json_object *root;
 	struct json_object *valid_attrs;
@@ -1115,6 +1115,14 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 		if ((offset + pevent_entry_head->ehl + 3 +
 			le16_to_cpu(pevent_entry_head->el)) >= size)
 			break;
+
+		if ((event_type != 0) &
+				(pevent_entry_head->etype != event_type)) {
+			offset += pevent_entry_head->ehl + 3;
+			offset += le16_to_cpu(pevent_entry_head->el);
+			continue;
+		}
+
 		valid_attrs = json_create_object();
 
 		json_object_add_value_uint(valid_attrs, "event_type",
@@ -1343,7 +1351,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 	json_free_object(root);
 }
 
-void nvme_show_persistent_event_log(void *pevent_log_info,
+void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	__u8 action, __u32 size, const char *devname,
 	enum nvme_print_flags flags)
 {
@@ -1366,7 +1374,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 	if (flags & BINARY)
 		return d_raw((unsigned char *)pevent_log_info, size);
 	if (flags & JSON)
-		return json_persistent_event_log(pevent_log_info, size);
+		return json_persistent_event_log(event_type, pevent_log_info, size);
 
 	offset = sizeof(*pevent_log_head);
 
@@ -1423,6 +1431,13 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			le16_to_cpu(pevent_entry_head->el)) >= size)
 			break;
 
+		if ((event_type != 0) &
+				(pevent_entry_head->etype != event_type)) {
+			offset += pevent_entry_head->ehl + 3;
+			offset += le16_to_cpu(pevent_entry_head->el);
+			continue;
+		}
+
 		printf("Event Type: %u\n", pevent_entry_head->etype);
 		printf("Event Type Revision: %u\n", pevent_entry_head->etype_rev);
 		printf("Event Header Length: %u\n", pevent_entry_head->ehl);
diff --git a/nvme-print.h b/nvme-print.h
index 2d8ed4d..ce4f0c9 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -49,8 +49,8 @@ void nvme_show_predictable_latency_event_agg_log(
 	struct nvme_event_agg_log_page *pea_log,
 	__u64 log_entries, __u32 size, const char *devname,
 	enum nvme_print_flags flags);
-void json_persistent_event_log(void *pevent_log_info, __u32 size);
-void nvme_show_persistent_event_log(void *pevent_log_info,
+void json_persistent_event_log(__u32 event_type, void *pevent_log_info, __u32 size);
+void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	__u8 action, __u32 size, const char *devname,
 	enum nvme_print_flags flags);
 void json_endurance_group_event_agg_log(
diff --git a/nvme.c b/nvme.c
index a2075bf..0c8d669 100644
--- a/nvme.c
+++ b/nvme.c
@@ -911,6 +911,7 @@ static int get_persistent_event_log(int argc, char **argv,
 	const char *action = "action the controller shall take during"\
 			" processing this persistent log page command.";
 	const char *log_len = "number of bytes to retrieve";
+	const char *event_type = "event type";
 	const char *raw = "use binary output";
 	void *pevent_log_info;
 	struct nvme_persistent_event_log_head *pevent_log_head;
@@ -921,6 +922,7 @@ static int get_persistent_event_log(int argc, char **argv,
 	struct config {
 		__u8 action;
 		__u32 log_len;
+		__u32 event_type;
 		int raw_binary;
 		char *output_format;
 	};
@@ -928,12 +930,14 @@ static int get_persistent_event_log(int argc, char **argv,
 	struct config cfg = {
 		.action = 0xff,
 		.log_len = 0,
+		.event_type = 0,
 		.output_format = "normal",
 	};
 
 	OPT_ARGS(opts) = {
 		OPT_UINT("action",       'a', &cfg.action,        action),
 		OPT_UINT("log_len", 	 'l', &cfg.log_len,  	  log_len),
+		OPT_UINT("event-type",   't', &cfg.event_type,   event_type),
 		OPT_FMT("output-format", 'o', &cfg.output_format, output_format),
 		OPT_FLAG("raw-binary",   'b', &cfg.raw_binary,    raw),
 		OPT_END()
@@ -998,7 +1002,7 @@ static int get_persistent_event_log(int argc, char **argv,
 	err = nvme_persistent_event_log(fd, cfg.action,
 		cfg.log_len, pevent_log_info);
 	if (!err)
-		nvme_show_persistent_event_log(pevent_log_info, cfg.action,
+		nvme_show_persistent_event_log(cfg.event_type, pevent_log_info, cfg.action,
 			cfg.log_len, devicename, flags);
 	else if (err > 0)
 		nvme_show_status(err);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
