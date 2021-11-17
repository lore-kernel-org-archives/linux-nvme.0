Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F94C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:31:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A5861B9F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8A5861B9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ysgzo8S6Ur1/wCf5Rk3pUleERC6Zb6xn3+OcQZI09FA=; b=WNuYsDjWsEvP3hQnZY7F4LRiq6
	H1hU0zC4jdhlydk4U29LJsSE8JTAQ7Bn2kZYTPogz7jV7fvpEsom2QOyNr7tbehifh/8K0MjKBwL8
	UWBmazRzcAYlkitOwmQZze3OXJQ5kBXw6OSthK/cfZqYNvZkvEskhqyW9yCJ0dG44z7lMLcZUq7Ae
	5OXUiolyr6VLt/baZ3oqGq6WH5esqJU3IUdnQjKG8BYO44NdkvuNn2zZ+A4lJyxF+YVb6SSZqvlcs
	gatXO3SbNEcxQoeE3uS4+3bZJ7iyb1EKdcAyzAwolqoNr0KQsJw+HDQIQU24RhNzOllNY0E1S70rF
	VSujdIVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnOmN-005qx6-L2; Wed, 17 Nov 2021 17:31:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOmK-005qw6-F1
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 17:31:26 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGmCk0020035; 
 Wed, 17 Nov 2021 17:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=ysgzo8S6Ur1/wCf5Rk3pUleERC6Zb6xn3+OcQZI09FA=;
 b=geU+N1iEcN7K8BKxAa3rIO5bot4wZI3vn/Z9EKD+zUcMZFFo0F//9qOtE9wsHSFbqUDe
 oio/Dv+Q1UWWBBRTcQ0hio6q5diW6aogdlEIZ933jRNtvtsYqUcvW6Lc27pwZyPmlBNK
 GX7twagh5LUpp963694dpZvRyzJde7nzEMwBKou8E7KLlnCH7FEcTySwwrwPnMcTzLPF
 Zu3v5hAUuMhq5xlc/Cfm3IHLUjyMk/Bxy5iRSkm5S6u/M/6KxwJi+vJdq5i5WClR7Mm2
 brd8NvJlDPzs7nrC/Rdp9flqtCFgAcPKUymW32XhABgu6ewe6NqLAyHZF6xq2W1qbOsc Rw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cd5k28wu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:31:20 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHCr9H011857;
 Wed, 17 Nov 2021 17:31:19 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 3ca50cm9pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:31:19 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AHHVH3v23527900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Nov 2021 17:31:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24F657805E;
 Wed, 17 Nov 2021 17:31:17 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD1C97806B;
 Wed, 17 Nov 2021 17:31:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Nov 2021 17:31:16 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: anaidu.gollu@samsung.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 1/1] libnvme: Add new events support in PEL
Date: Wed, 17 Nov 2021 10:01:39 -0600
Message-Id: <1637164899-16984-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 80TaM13bLcVKCrwajA4dLs_gAc3bscXx
X-Proofpoint-ORIG-GUID: 80TaM13bLcVKCrwajA4dLs_gAc3bscXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_093124_787692_F07CDE9C 
X-CRM114-Status: GOOD (  16.35  )
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
index b7f3fcc..9e2e809 100644
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


