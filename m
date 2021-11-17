Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:35:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D330561221
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D330561221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XzhQfvcPfWGyXrLvLnl4FPRKSQm4AJZLmC/9XwNNLL8=; b=VVsaVSNxGTSVm53W3IzEv/aG/v
	jYVgB4RC1SPLDxQHnOsQ1tjVPUPqb6aZ508JPPX+j82QITqvJEPsFza6bKxspzBE7y2rB9uHLHBXg
	CvKZM7G7gIHCEewZwIY+3MKWY1NTlbqdkX5zRj1yWHOlXVqRJk/rj8azs7CgEbTboHP/r0xaawE3+
	bPZMGOzlsW81RHmqdzLqVTSU0p4MJ+OzuUimOq1o+WcGVJ+S2QEEHtpLNdOVSCVsYVPNBSEDOy5+5
	RZkDOVC1r/Oyjki2+A2HDSRIGd1UwB/sSwZLD3+ugL5jnDoc1Y8gK9EFyuCAEL+fgP0FodZcHsld+
	asuynDMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnOpr-005rwR-AI; Wed, 17 Nov 2021 17:35:03 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOpK-005rkP-Ly
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 17:34:33 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHQi6M031452; 
 Wed, 17 Nov 2021 17:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=XzhQfvcPfWGyXrLvLnl4FPRKSQm4AJZLmC/9XwNNLL8=;
 b=k9gbM66Mct6qmu1uixIigELnrMbWfBAXVLeu/y4ORXp4WxAC2EZj+9YKcPIfMsZLZtk4
 GGSvcH6Kll0z7H3aISQCGWs/kecF2B9zNCDE4D8idbQ7Go/swUK+quSx4NQbPT5B2SI0
 YgJl9gRGKa7+VnnZpcjs9Y/D/1FHqK/P/gB738CJINOfuWk1O/zKxCUuLIaf5kQXWUGm
 ZmZUl0FOMmkSof5fv11e5zuSY4O1jsdvW/q2ri1NJmIgm1PHGp+Nv52Hwpy3Sz433HmA
 AkbPGd21NiTGpt10FqdV7nAWFT4knGUYofWvdvuB/NIg0YKdpn1HaN5j9wXaaRiVAhyP 0w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cd65484g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:29 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHYG4D009436;
 Wed, 17 Nov 2021 17:34:29 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 3ca50cc8vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AHHYR6328049720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Nov 2021 17:34:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E106A6E052;
 Wed, 17 Nov 2021 17:34:26 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C46A6E066;
 Wed, 17 Nov 2021 17:34:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Nov 2021 17:34:26 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: anaidu.gollu@samsung.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 3/5] nvme-cli: Adds readable firmware level in persistent
Date: Wed, 17 Nov 2021 10:04:46 -0600
Message-Id: <1637165088-17007-3-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5lpmn4OEqGXGLkchvZ4cr-IiLfimozww
X-Proofpoint-GUID: 5lpmn4OEqGXGLkchvZ4cr-IiLfimozww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_093430_894037_E89434E2 
X-CRM114-Status: GOOD (  16.64  )
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

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 nvme-print.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index dcb0e7c..3f2bb66 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1110,6 +1110,7 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
 	__u64 *fw_rev;
 	char key[128];
 	char evt_str[50];
+	char fw_str[50];
 
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
@@ -1292,10 +1293,14 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
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
@@ -1323,8 +1328,10 @@ void json_persistent_event_log(void *pevent_log_info, __u32 size)
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
@@ -1559,10 +1566,12 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
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
@@ -1589,7 +1598,8 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 
 			printf("Power On Reset Event Entry: \n");
 			fw_rev = pevent_log_info + offset;
-			printf("Firmware Revision: %"PRIu64"\n", le64_to_cpu(*fw_rev));
+			printf("Firmware Revision: %"PRIu64" (%s)\n", le64_to_cpu(*fw_rev),
+				fw_to_string((char *)fw_rev));
 			printf("Reset Information List: \n");
 
 			for (int i = 0; i < por_info_list; i++) {
-- 
2.27.0


