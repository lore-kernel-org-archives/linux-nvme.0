Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D2EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:35:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C7A61221
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 17:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12C7A61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DPDw5FM3TZQUuCnN8Yn+bsYopw5dgMa9tyjrJNdY5y4=; b=qaYvg5HsUygRxOvK/zJ8I78TZf
	YtYiFkvhzmcpFJo0K+MnSoAP2SfxmAnLW4RAlTvQJBdbdmR41erKR994p5yX99liN9K1ca5KM3ho6
	1+kiSFtQOQLl5QIlbFWrXT5+IVSxdV7MUVp5aFTZRX+IHGaHfW7DOvKbYDJFIcWqS+IyidEz+J1cG
	/DxdLJ+XBrXDZt1Q10DPMwgnEpfLxe1rtl38MFKEP7CQxYZ89HAk3I6xwHIg1Os3/c3DMFMnt0POz
	mjpMfOZMXHLr/6BESamlSfluDUETftgYOIKfKOjQByBPutq3HmhlUFdqptHUKM6fJS+6yP8EGEJmU
	zW1/bCJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnOqZ-005s9d-J0; Wed, 17 Nov 2021 17:35:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOpM-005rlT-36
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 17:34:33 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGCAAN023304; 
 Wed, 17 Nov 2021 17:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=DPDw5FM3TZQUuCnN8Yn+bsYopw5dgMa9tyjrJNdY5y4=;
 b=ZlKMbTjf9UszSuU0fMaBkJUFl1c31Z0Ks2bB+lw70NuewK+bGdbN+cdlDBssIMei8YAp
 Sd4XrSKEq/wwyIdF41yBOSkwPF7HOTAVld1WBW9pWo3V37QGXD+Pi2RhEtGvlt1wKE8C
 dYIgjZFEYk6f8mN0bD7h2aF61u2tt70iZ+aZSn8FaSFJpNmcveX59vwi/DJ2miGSqUkJ
 2RslnxXXV5+hrU6nD6MDo7lrD/mmoyW7X5x+LswLce2SW+H0dUuT56oUreb/8AAtEEN+
 dGni4Wx1affRxCMh52WCWE+pNlbGxB3S2Ohb45GGWhHaP3J68pRjOvaOY8L6R1J23WNG kQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3cd51v9usg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:31 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHWrPG003639;
 Wed, 17 Nov 2021 17:34:30 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by ppma01dal.us.ibm.com with ESMTP id 3ca50cmc71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 17:34:30 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AHHYS1b59375962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Nov 2021 17:34:28 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E06EA6E04E;
 Wed, 17 Nov 2021 17:34:27 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8043F6E05E;
 Wed, 17 Nov 2021 17:34:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Nov 2021 17:34:27 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: anaidu.gollu@samsung.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 5/5]  nvme-cli: Add support Telemetry CRT in PEL
Date: Wed, 17 Nov 2021 10:04:48 -0600
Message-Id: <1637165088-17007-5-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 49ZWFmTeuvNdMCDuiLF-85qM5CanyP71
X-Proofpoint-GUID: 49ZWFmTeuvNdMCDuiLF-85qM5CanyP71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_06,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_093432_287233_879DC131 
X-CRM114-Status: GOOD (  16.67  )
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

Add "Telemetry CRT" event in PEL.

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 nvme-print.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 994ef01..2880b81 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1704,6 +1704,9 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 
 			nvme_feature_show_fields(fid, cdw11, mem_buf);
 			break;
+		case NVME_PEL_TELEMETRY_CRT:
+			d(pevent_log_info + offset, 512, 16, 1);
+			break;
 		case NVME_PEL_THERMAL_EXCURSION_EVENT:
 			thermal_exc_event = pevent_log_info + offset;
 			printf("Thermal Excursion Event Entry: \n");
-- 
2.27.0


