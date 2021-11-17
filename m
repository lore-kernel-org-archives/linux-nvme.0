Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5490CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AA561221
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20AA561221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZFrAB8lbX0jfqbd+qkoo94RklRS763kts5hyhjVN3EM=; b=aChn5Eq4pxZqjRcYVbm8Kkexhr
	IbeO9jc9bRwdqep9W9A+vBRkkV1MLgwjQkArQb91gXdnbW3ljTKJFTpfbFS2mQ//8b+m+WGAZHolY
	qbPWedT5n15aIaYzkDJLqeg2VyDcuVfvkgrLU56Nay9CTVfV4gxAA9Wjv2SapFad5dMqZNsUAJ9gd
	7NiEt5HEBESGAsCNxa89c4+Ojlu+gtGUXf4mttubaMEqDIpfAT/Pp6Ok8H9f6s87ebj2M3ALbZ6y+
	vFlYCcUZj+N1Sy3RsxlOM1DoCYoKZ5GZGEl1cwV5E+o/BbEztVkfL50YlVE+Jb7640J6Q4Gd6elRv
	/Bq3eJRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnOqC-005s2L-4f; Wed, 17 Nov 2021 17:35:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOpL-005rkj-1k
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 17:34:33 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGmP0g020313; 
 Wed, 17 Nov 2021 17:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=ZFrAB8lbX0jfqbd+qkoo94RklRS763kts5hyhjVN3EM=;
 b=s6/H4FSrgsmkoBE+lNOY0zfKlUpm0SEYTo+h7cVKmBbSHoiNR662fyL+Ks6v/VhfGZHw
 BhNIHCb6RDyX9IhX+ijRmOUnqGXKt7vFF+xnJIbCkbjtrllm2AFBNT2qBmNCOipvPJj8
 qT/eVOCGKjgb4Get8s0ltiEbOH/C8sB4tSzZEkEZrJ37cn/lDu/fXbUPgNa9+umahttU
 IDrAflHbwQCwXiWE4p5gdZGLQDHx/WeYTJ5i55YXAxzaMRb+OrKJsfFPVH+zpIftGXjX
 00bjWmay4zROkQGYJU2abiI2ypDcbqSSVzzV4RBpFnyqzzPsSFPOd192rRYq0nkKYzcS DQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cd5k28yx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:29 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHWpBq008156;
 Wed, 17 Nov 2021 17:34:29 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma05wdc.us.ibm.com with ESMTP id 3ca50c0myw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AHHYRw320316446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Nov 2021 17:34:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 616546E059;
 Wed, 17 Nov 2021 17:34:27 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BBE56E04E;
 Wed, 17 Nov 2021 17:34:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Nov 2021 17:34:26 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: anaidu.gollu@samsung.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 4/5] nvme-cli: Add support set feature event in PEL
Date: Wed, 17 Nov 2021 10:04:47 -0600
Message-Id: <1637165088-17007-4-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: voAT8FPhgvQhEw1bFk5D8Rd8Ir6_qi5G
X-Proofpoint-ORIG-GUID: voAT8FPhgvQhEw1bFk5D8Rd8Ir6_qi5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_093431_239957_96CC8FEC 
X-CRM114-Status: GOOD (  17.88  )
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

Add "Set Feature" event in PEL.

Signed-off-by: Wen Xiong <wenxiong@us.ibm.com>
---
 nvme-print.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 3f2bb66..994ef01 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1459,6 +1459,8 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 {
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
+	int fid, cdw11, dword_cnt;
+	unsigned char *mem_buf = NULL;
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
 	struct nvme_time_stamp_change_event *ts_change_event;
@@ -1469,6 +1471,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 	struct nvme_format_nvm_compln_event *format_cmpln_event;
 	struct nvme_sanitize_start_event *sanitize_start_event;
 	struct nvme_sanitize_compln_event *sanitize_cmpln_event;
+	struct nvme_set_feature_event *set_feat_event;
 	struct nvme_thermal_exc_event *thermal_exc_event;
 	struct nvme_persistent_event_log *pevent_log_head;
 	struct nvme_persistent_event_entry *pevent_entry_head;
@@ -1686,6 +1689,21 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			printf("Completion Information: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->cmpln_info));
 			break;
+		case NVME_PEL_SET_FEATURE_EVENT:
+			set_feat_event = pevent_log_info + offset;
+			printf("Set Feature Event: \n");
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
 		case NVME_PEL_THERMAL_EXCURSION_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
 			printf("Thermal Excursion Event Entry: \n");
-- 
2.27.0


