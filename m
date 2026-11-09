Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D86606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yj6P2XA/;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A3RJSr6l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lc+6qx2UG38WIrtd6egXFwbBuMncdBzZZ4ciazNwnms=; b=Yj6P2XA/monogZ
	qmSjqITNP9LZOk9rHwP2tbW1+C1N/U/vE2jhQA8Vt5uFrWUZ2wBggDUOf6Dpm1jgdu8UvYSGVzrbo
	Z4veikzEE8hfClvPD26AJrz7Y+YfGQZn5mivhRKyXbW6Q4FmoDEuik2vdfF1Aol+fuerzRNJA/oFM
	FXu9YuKyJmSTyZxJHFn9pLKoAFwlmACPmcQn+7RM1JBmhVbc1Bq35rk6IroyidMEc2qCZHyAxLYn/
	qWSgjgYYgwo4HulWikbMJ06dcF1Osw8M/M/GfVq/CG7HpodVwUKm3Rx+SW1oaLR2hoI0YD1SjEbSU
	mS4yaqNQRGEpYBUBUaLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8i-0000000HEDl-1IBJ;
	Mon, 09 Nov 2026 03:33:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8f-0000000HE9T-01lS
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iNaw1957571;
	Mon, 9 Nov 2026 03:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lc+6qx2UG38WIrtd6
	egXFwbBuMncdBzZZ4ciazNwnms=; b=A3RJSr6lA9ogU5FiulMSxQgZeTNeMM3uC
	Z1cRT75qNVYFLZlV6AB1vM9ttRCzOggvEAVtyhHTwyiU0FajP5ZcOejzz0Ce5HXb
	K19SWEyw6o9ytFX+Ch7DiBEbU+LSiD1TuA8NMrVUYk/Oc3Pv8zr0wcw8qqjRRfH4
	q2TXR/LxIKGD/R9wQp6uHUgJYtuf1YNYzxDwIBlW489xBB/bUJlnAkO4g6xIdtL5
	uWddCvXoC0S45e3kiTI5GKUlkXDo1EHNyh4tI9A1COcLRKH/JsGSm9Kqq9RViM8v
	OhkrJ38i+t8az7yrzNcxIcIWH7Faa/kS8Kzr3QV9ynNbw2VYNZ3iA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuj33e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90YwFe3423126;
	Mon, 9 Nov 2026 03:33:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvnmk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93XXJo31326674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3D9420043;
	Mon,  9 Nov 2026 03:33:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C42920040;
	Mon,  9 Nov 2026 03:33:28 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 20/23] nvmet: fix PCI P2P parameters access using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:25 +0530
Message-ID: <20261109033102.982191-45-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX1l1h0cIm7xQV
 1TYodMyVHqd9aLfWGqqsdOTQxDY5f+bjDUbf85xHmpi5HwWYZMtAh6NkmLUyuvSsDpjOYkvPkbt
 CbuRET9e2iLSMYFQTo/lUFjvOqEV/yA=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af13f12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=mgqsmbDQb_rkrO5PrMAA:9
X-Proofpoint-GUID: 53DDMe21Uk0JEGeCKtPGGA4s_h75FSPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX+m5npmV78Na6
 kC9ikc1ZVlZvjY6uIVh15tqXYTwmclT9K6qNAhyq3MjLulnFA/Vx3696gEJojqNXdZ3TncrWqZe
 q8uiMG+tFLm0H5jzH1+xS7uH/j5/2ccrkHG6MW30kPQRDhAQ947hth+QZE9ilv9WCuyg1BwQugG
 6e4n9NIMRcIpIpxGqP8CeiCv7WrOy8Zxe7fh8fn7qjC5F5IW5IM2K/a5Bp9j0PTEOY+/lGj2+gE
 ftZJOy1kYTd5Bc1r7bRvg+luabmDqpln3FzQCTdGiSN21hOGnwpF6Ll2CJfvrBdeYki0iGBkKvO
 rIRN4H6fNT4dIItcBBlIZeE6Q0mx4ADStBCG95iRd3TtVUks6oE+OAQdmaaiInY8lNEz2t/v9v0
 7V5w9oTnWXvnf2jvTWNnwFgeqImqoFb9C8xSBI4kWc7kkKckNHnX9plS72O7SIl3nBtVA2nXI2Z
 SGLLH+4qh2L14PmZagg==
X-Proofpoint-ORIG-GUID: XbXvmgoTxaYM4lCaGSX2Si25j76RxUn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193345_168665_7AAAE473 
X-CRM114-Status: GOOD (  13.40  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet_ns::p2p_dev and nvmet_ns::use_p2pmem fields are protected by
nvmet_subsys::lock. However, nvmet_ns_p2pmem_show() accesses these
fields without holding the corresponding lock, triggering Clang context
analyzer errors:

drivers/nvme/target/configfs.c:587:42: error: reading variable 'p2p_dev' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  587 |         return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
      |                                                 ^
drivers/nvme/target/configfs.c:587:55: error: reading variable 'use_p2pmem' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  587 |         return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
      |                                                              ^

Fix the above errors by acquiring ns->subsys->lock before accessing
PCI P2P parameters in nvmet_ns_p2pmem_show().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a87917381093..7245db64b8dc 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -582,8 +582,13 @@ CONFIGFS_ATTR(nvmet_ns_, device_path);
 static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
 
-	return pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
+	mutex_lock(&ns->subsys->lock);
+	ret = pci_p2pdma_enable_show(page, ns->p2p_dev, ns->use_p2pmem);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_p2pmem_store(struct config_item *item,
-- 
2.53.0


