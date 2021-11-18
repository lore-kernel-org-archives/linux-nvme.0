Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B1C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2C161B2B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD2C161B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lv+kPqRRfJjEFdC+t89LKcIhHnj4O6maBtETv629tCo=; b=mkJuB+ZjmLLtI449EHcvPloM6V
	LDVDt4B/R5+y+9QQAD6RCNIBHp8j8KjYSyFRfoFOysJPB8pmxgjvWpLhqudW+gghRU9MeoaBbb4qm
	/K8PXdMVWEBx9tANuBrzLH3/WFM0BhYR/rcZXOskS01sRMa0ClMPDwSlqDuml2LlcbZgeO2T7AjWU
	iwK1H4xakHvn/MM/IMyVmWwx+PGVKrdUFW6RE8HLHizPDCaA01B+/VJhxBMstRJq4oYE+ctaMHvIp
	+id6tmMgUT7it3OicYC0jQxA98RNs/Et3R0Dc7DpOjBRIRnFOzrmGd0Ev5TZAAlOfI0eQeFuqGHMO
	hg+Iuoiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm80-008YGn-AW; Thu, 18 Nov 2021 18:27:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7o-008YDi-0k
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:09 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIGn0jB004558; 
 Thu, 18 Nov 2021 18:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=lv+kPqRRfJjEFdC+t89LKcIhHnj4O6maBtETv629tCo=;
 b=F+qaKalRwU4/Hd0aWwJ9nyopGKfe1rLovEKPsnX5P+SyKe8YlINWfV+vqOK96eeE4sBR
 ZaUPHDqWM4CQIuKcAlWz8mlXCzYv8ltmT4Zo4WMBRpdE48TBe05ZqNXd6vey6ct34cDc
 FJbfGSP8jHrFmsMc+inCBnNkN0N3dmONGzwm/50V5lvmTkL9DJ9V0pCluNy4wToyreg7
 UVvigDCYCaY+VLaUdo5VXBmIlAnmlDx2PPpWjxjFKb8mJpNAefxi8wix6s7tPuNJtHTT
 YDnHk0zwo3FV88EIVQfLtxsiWgXAkHPSyxbxgJveF5FR2/mHb8Go4pu+6LYfbbNer1OC aw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cdtp5jd8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:05 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIJ27c030684;
 Thu, 18 Nov 2021 18:27:04 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 3ca50dmdf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:04 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIQx1L11469388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:00 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9E47AC068;
 Thu, 18 Nov 2021 18:26:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6188EAC059;
 Thu, 18 Nov 2021 18:26:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:26:59 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 1/1] libnvme: Add new events support in PEL
Date: Thu, 18 Nov 2021 10:57:19 -0600
Message-Id: <1637254639-19479-2-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637254639-19479-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637254639-19479-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cz6sXozf3pyHwXAIV2539oNe0BGnjoAe
X-Proofpoint-ORIG-GUID: Cz6sXozf3pyHwXAIV2539oNe0BGnjoAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102708_088754_E6659949 
X-CRM114-Status: GOOD (  15.98  )
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

Add two new events support in header file.

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 src/nvme/types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/nvme/types.h b/src/nvme/types.h
index a82ed3f..71e4c55 100644
--- a/src/nvme/types.h
+++ b/src/nvme/types.h
@@ -3044,6 +3044,8 @@ enum nvme_persistent_event_types {
     NVME_PEL_FORMAT_COMPLETION_EVENT	= 0x08,
     NVME_PEL_SANITIZE_START_EVENT	= 0x09,
     NVME_PEL_SANITIZE_COMPLETION_EVENT	= 0x0a,
+    NVME_PEL_SET_FEATURE_EVENT		= 0x0b,
+    NVME_PEL_TELEMETRY_CRT		= 0x0c,
     NVME_PEL_THERMAL_EXCURSION_EVENT	= 0x0d,
 };
 
@@ -3122,6 +3124,12 @@ struct nvme_sanitize_compln_event {
 	__u8	rsvd6[2];
 };
 
+/* persistent event type 0Bh */
+struct nvme_set_feature_event {
+	__le32	layout;
+	__le32	cdw_mem[0];
+};
+
 struct nvme_thermal_exc_event {
     __u8 	over_temp;
     __u8 	threshold;
-- 
2.27.0


