Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D125AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:28:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949AB61B2B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 949AB61B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnF0Dh/Zt2anTstoNoMx/iaOvdnnDy8LuPTyauZ0vIk=; b=RxnCbc+zl6B0epqQBYRuqgQDj+
	iKXBmqqrZnIwruEHleOGLp/5w+8Dv8BJTK0EnH1ePpKfLbbMmK/Xiy98jJsJGBPsMyB5hBffmIrGv
	06ACw4lmBRSxdtRPjSTQ71GebE4YwAQVPTF2/n9s+IuN3grA+/2ctOAiFt50BpS2cKRTyENbhdtmh
	W48npUKboY4ZPn5fOcmYVHPOUc2NrHeDWk/7J9S6FUk9RtETFu5lkvD4Zm/brv3SD8e6Td0in0/Da
	ALkXIuinNeEdKUoKmV8fDfnypnDolIYSK2uK1qCJaBW42RcKLLVXk0iGDZIyJDqWKMN9spPr0UFbP
	6rQ8gz6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm93-008YWr-CG; Thu, 18 Nov 2021 18:28:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7w-008YFG-5G
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:18 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIICYbG029394; 
 Thu, 18 Nov 2021 18:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=NnF0Dh/Zt2anTstoNoMx/iaOvdnnDy8LuPTyauZ0vIk=;
 b=p6KGpwrGwFmgMpSQjpaimM4bA4Is0d7POIFouktrdzmreUFKkeoPmsa33yBGfEQZhTqt
 mn5pPD71IeSQnXg2JYWm4RZ7SMV6aFueOCUZbmohYEkrzjP+COiAyx1K+7AuM9qnc6o9
 mYV0ZvycqtnQCkOHkmNXBfuuSHPa0NlGsPRYJKfScPt6QFAQg7MqoGFyA+eGHqkC/2ek
 b+bWzgW3/meFS3v95oYqKSiRtV/78h3M8iN2HD1zovm9gwuAZnay3Iy6tPK2kRAfLrxK
 nYvsX4Xtm4NSkKKjQSY5qdOxKGy5k8pDKfhB0/YroIucH5Kj8pfrax9VBBkWjxSsp3vq Ug== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cduwer9kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:15 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIJ27w030684;
 Thu, 18 Nov 2021 18:27:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01dal.us.ibm.com with ESMTP id 3ca50dmdky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIRAZS39780816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3ADDB205F;
 Thu, 18 Nov 2021 18:27:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54EFCB2064;
 Thu, 18 Nov 2021 18:27:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:27:10 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 4/5] nvme-cli: Add support set feature event in PEL
Date: Thu, 18 Nov 2021 10:57:27 -0600
Message-Id: <1637254648-19500-5-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dP2COGVHHUDCF8T-JVhOCUtw7CAvIe2U
X-Proofpoint-GUID: dP2COGVHHUDCF8T-JVhOCUtw7CAvIe2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102716_362307_43B81140 
X-CRM114-Status: GOOD (  17.08  )
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

Persistent Event Entries:
Event Number: 0
Event Type: Set Feature Event(0xb)
Event Type Revision: 1
Event Header Length: 21
Controller Identifier: 65
Event Timestamp: 564587204146155
Vendor Specific Information Length: 0
Event Length: 16
Set Feature Event Entry:
Set Feature ID  :0x7 (Number of Queues),  value:0x270027
        Number of IO Completion Queues Allocated (NCQA): 40
        Number of IO Submission Queues Allocated (NSQA): 40

Signed-off-by: Wen Xiong <wenxiong@us.ibm.com>
---
 nvme-print.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index fb7cec3..8d7ecee 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1472,6 +1472,8 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 {
 	__u32 offset, por_info_len, por_info_list;
 	__u64 *fw_rev;
+	int fid, cdw11, dword_cnt;
+	unsigned char *mem_buf = NULL;
 	struct nvme_smart_log *smart_event;
 	struct nvme_fw_commit_event *fw_commit_event;
 	struct nvme_time_stamp_change_event *ts_change_event;
@@ -1482,6 +1484,7 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 	struct nvme_format_nvm_compln_event *format_cmpln_event;
 	struct nvme_sanitize_start_event *sanitize_start_event;
 	struct nvme_sanitize_compln_event *sanitize_cmpln_event;
+	struct nvme_set_feature_event *set_feat_event;
 	struct nvme_thermal_exc_event *thermal_exc_event;
 	struct nvme_persistent_event_log *pevent_log_head;
 	struct nvme_persistent_event_entry *pevent_entry_head;
@@ -1694,6 +1697,21 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 			printf("Completion Information: %u\n",
 				le16_to_cpu(sanitize_cmpln_event->cmpln_info));
 			break;
+		case NVME_PEL_SET_FEATURE_EVENT:
+			set_feat_event = pevent_log_info + offset;
+			printf("Set Feature Event Entry: \n");
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


