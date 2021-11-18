Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DC261B2B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 18:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05DC261B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XunOcU5phN25P7LwoSwL7wXNW85TMza0A5CbZUtDmjE=; b=yhr9WcXdA39UJV3ADukiDdH6iU
	RC/LmJj7h2KYtrOHhKajV9AO6id+kQrIDcGqjEKLGpVmoYBc9iXMttx2EUxC5w0hq9h0BjF6fQhTY
	LosMIV52finAmB6RnQnKTZw88qlG83ojquE07/+JpFHojd7h0mrwXP5VM8DVt4uT7+KcK6g/Wq3wQ
	AzqJhvzf+iMjF2UFVrnlXnZuidPv/0bHv7DvHqDJvqWzGL576C6OiLKSUcg4w+sZotcvyp3C2l8qB
	YvAkyMl3ME+78UXGKSbGSHil7fkjCgZOyFC2OpyFkrbqBWY9nETt4W0v+d8rwad6TuCXE5L7b0XXO
	GQPknLpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnm8Z-008YOL-G5; Thu, 18 Nov 2021 18:27:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnm7v-008YFF-Sy
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 18:27:17 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIGhar1027812; 
 Thu, 18 Nov 2021 18:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=XunOcU5phN25P7LwoSwL7wXNW85TMza0A5CbZUtDmjE=;
 b=RqV2jQopn4/GCW1yeGWTrqgf+ovawRzU9lNKGUpZwOkB5fphtrU9tnG38PR2TN75INC8
 EinSSBn89F8OwrlpW0JrdNxU+WYMSZ+5iWPlKs0iSYGV70wSYeCm966D2SG69TvXz7Vx
 iPElEtTljOTMujgAV5n1F2BGvKrPthZoGYZ8bpADd+OO1SyLQVKt1kOMddWZKeVFc9aT
 9pqixRkuXrZm/ix2mUYCPYb0vutSumX6ucCOx43vEojTAhTy5/ajYy+kNP2/NyPBm0ZO
 EBAE+m2LuEX54Yv7l2UehrrEunD5S9iaDc6UP0g/wdN+/vmeqqi6dFtGHsDid+9Du6w2 mA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3cdtkutn2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:14 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIJAwF006545;
 Thu, 18 Nov 2021 18:27:14 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma05wdc.us.ibm.com with ESMTP id 3ca50ctu6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Nov 2021 18:27:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1AIIRBfv57606450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Nov 2021 18:27:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4723EB2076;
 Thu, 18 Nov 2021 18:27:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D434AB2064;
 Thu, 18 Nov 2021 18:27:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Nov 2021 18:27:10 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: chaitanyak@nvidia.com
Cc: keith.busch@wdc.com, linux-nvme@lists.infradead.org, hare@suse.de,
 wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2 5/5] nvme-cli: Add support Telemetry CRT in PEL
Date: Thu, 18 Nov 2021 10:57:28 -0600
Message-Id: <1637254648-19500-6-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
References: <1637254648-19500-1-git-send-email-wenxiong@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MObXjU5HUBLf5Qavt3OEkw__rneutQcT
X-Proofpoint-ORIG-GUID: MObXjU5HUBLf5Qavt3OEkw__rneutQcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_102716_096604_91B323E3 
X-CRM114-Status: GOOD (  15.84  )
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
index 8d7ecee..0de5a8b 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1712,6 +1712,9 @@ void nvme_show_persistent_event_log(void *pevent_log_info,
 
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


