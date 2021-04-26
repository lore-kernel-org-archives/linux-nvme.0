Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2094BC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:16:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3CF6101C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 19:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3CF6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOyRHH8Bst2VsAQulsmd1ZrmzLP0xZmlpj0PP5yol44=; b=jEP+TcnWgGkLOjzqicNzhVuJ5T
	gYjfy1PLlV5NF0sl/tmBq9FZiS9Fc358A5j2rh91RE+g/0ntSEBqjooeegTSRrPKjLa8BL9oo6vHA
	lWWOGPHs7ZDjOha5xAfaLaCP74jz04gZZPREPUqZ7NWSbJuuwPsAFe30wnegJMXDBFdrExZOqmZIE
	ynUI4YxhtJUVK3ZIqMVd25WE4+7tdGycPEKeqUT4r2uXMQYepMUIgeNbw/uc33ZNfZ0Jg1yLdNEgU
	cePNC5GTdF45G0a7z0tISCfrtVPKAkWRRaaKJ1Sw7KkQuWniWD1aW7zdKmrnXzGgqzuf8gVktJP0U
	hBF56mPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb6ik-008MXu-6i; Mon, 26 Apr 2021 19:16:38 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6ig-008MXE-Ra
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 19:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nVb8xm9/fGbeP00xdEjRNg6a+VvqTCXcGzbrK9oeADk=; b=1GDZ+Lhv6a8CsxDlfszrBNItLR
 C8w1eiIBFXnzjLXKZlsLvL1VmJVfp3juJGoD6MyxpDbLxSbMtqGMN1ILAkPDGjmk8dttgWyW5McKq
 tshlHZ9KNT2rwZTDWPAhZgchuKKK46of2rjnsF7STIfuaQSSUXnrbv+ZzP+Ixo0IcoWWfOKEMp2zw
 18glTJJy6kKFqMTVDrjSNyEzMuPDkvxBpXn2U8WA9yS5VVTWyEgMofb76oGW/AjEatnPPfrh5Gz3d
 y7N/cdyrU7nwUI/VCjTHzbjJXpxA3Mjwr5+E46Q3hSCUA/ZB1cNhEwohRE0Wkizp0IeHEGsQT+I42
 itf4yxrQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb6ib-00G8O4-IP
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 19:16:33 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13QJ3kcx083714; Mon, 26 Apr 2021 15:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=nVb8xm9/fGbeP00xdEjRNg6a+VvqTCXcGzbrK9oeADk=;
 b=dHVG7XlwpsMm7O0aewCZjUWzmw6D2aEDqYp5QQQA7VMsJ8vnQtEwblqiSFGdnFClUx8X
 K58f2ZAK0TPYU/BoH3zBqBppzXM8BHXGJS9SGsj+XV5NxzWRzy6kCBRz6iqnYrpRyVDk
 heaSLML/8ECNy/P0DX1VZNWFVxt53auDzrc8h0pHZewNhjAG/TT5C9ArwsS3e3Dtlfld
 xWcTsxk0r2eXlv7Cki4G3Cwk+APYgPn+mg0jSKi+20YPW2UGoGDS3c3W6Jt+1+e5A9Re
 KKi+FK71gOlLaYQXBXhyqwBj2iDqagCKUmw9v0kf9h63EOpT7QF88rc08HOm8AToRARl rA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3860yjcdy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 15:16:27 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QJ73Fi011021;
 Mon, 26 Apr 2021 19:16:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 384ay9cf31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Apr 2021 19:16:26 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13QJFAGL36634990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Apr 2021 19:15:10 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2A696E054;
 Mon, 26 Apr 2021 19:15:10 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 354F76E056;
 Mon, 26 Apr 2021 19:15:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Apr 2021 19:15:10 +0000 (GMT)
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, wenxiong@us.ibm.com,
 Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>,
 Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH 1/3] nvme: Add event type as filter in persistent event log
Date: Mon, 26 Apr 2021 12:52:16 -0500
Message-Id: <1619459538-3998-2-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cneiYjnVU-sOy4ZMjkTBSfnTdwbPuHII
X-Proofpoint-ORIG-GUID: cneiYjnVU-sOy4ZMjkTBSfnTdwbPuHII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-26_09:2021-04-26,
 2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_121629_751648_2D990122 
X-CRM114-Status: GOOD (  26.03  )
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

Add -t option in persistent event log command. The customers can use
 -t to filter specific events in pel.

For example, only list hardwere error(0x5).

./nvme persistent-event-log -a 0x0 -t 0x5 /dev/nvme0

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
---
 nvme-print.c | 22 +++++++++++++++++++---
 nvme-print.h |  4 ++--
 nvme.c       |  6 +++++-
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index b01a842..d05ed3e 100755
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
@@ -1106,6 +1106,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 			"log page after context established\n");
 		return;
 	}
+
 	for (int i = 0; i < le32_to_cpu(pevent_log_head->tnev); i++) {
 		if (offset + sizeof(*pevent_entry_head) >= size)
 			break;
@@ -1115,6 +1116,14 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
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
@@ -1343,7 +1352,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 	json_free_object(root);
 }
 
-void nvme_show_persistent_event_log(void *pevent_log_info,
+void nvme_show_persistent_event_log(__u32 event_type, void *pevent_log_info,
 	__u8 action, __u32 size, const char *devname,
 	enum nvme_print_flags flags)
 {
@@ -1366,7 +1375,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 	if (flags & BINARY)
 		return d_raw((unsigned char *)pevent_log_info, size);
 	if (flags & JSON)
-		return json_persistent_event_log(pevent_log_info, size);
+		return json_persistent_event_log(event_type, pevent_log_info, size);
 
 	offset = sizeof(*pevent_log_head);
 
@@ -1423,6 +1432,13 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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
