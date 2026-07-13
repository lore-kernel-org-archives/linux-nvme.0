Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD24C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EComTKARJb89wPXmLllPWe40ccC9VGBvxmvNUjxIFfM=; b=pxByKEbGWaTAjNhpMVNzXecU8q
	71vQaqDh3n9Um5qCxy7EpMaBPore9I1XlLeV8EIi1E5f8tOfnMnyBBQjxNK9pMTQ3zBxNRt1v2tI/
	58JHhTAwlz57nOTol6kuxWB3MPEgOWzc0uMODLV8bw/d0wAc/hkQknY3Cs62eBz2fW9ZLI5VDqBsD
	mT/A264Tba0WmAXZJGVoIY/MphWzCB7W/HVyXGRuA8PJZaUpv0ug0wWIQIFrHD36WqI1+mum4gatS
	dtEy02LEnaDp9sd+XJyfeYDzW33umSJOkGjjRAxooyPHIp+8ltmRlRw/01MLZLybYmeTX2UcSGIIv
	Uih8YNdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFm-000000094OY-0V3U;
	Mon, 13 Jul 2026 11:55:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFj-000000094MO-2O0s
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:16 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6ftmm1668583;
	Mon, 13 Jul 2026 11:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EComTKARJb89wPXmL
	llPWe40ccC9VGBvxmvNUjxIFfM=; b=VObOpOU9nWnvMp9qCgc7M6Iu699bw0s3M
	6FeqU9Lu2pLJhbgtfi9hyYChIAvNryYyjOnby/KrVYWQ5wAUEBP5giUyuMFjOhVe
	7dlId7FyyqbnjN1t2AGdQln5HQ8yEH0OCeVe65UR7AVYfqiRzQpQlOSj22NzGt3R
	pnxM0ciUs8eL0l428PidkWURq8+TAI6ajQLLr1h7ufuqztzzNGxjU//OGhdaWUXx
	FrmYOaL0spg+T9E4e43lWT7/DOpkQdPZID8jc1H0hSEPudQwgRak8F9gUJjNfo5a
	mwmSiTdjmixB1CQo4Y9kc9XR5enYspCkRjDCua53LQYGfO7HTzh8w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwg1ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBna5S023614;
	Mon, 13 Jul 2026 11:55:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBsx4K52101552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:54:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64EE820043;
	Mon, 13 Jul 2026 11:54:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC4120040;
	Mon, 13 Jul 2026 11:54:57 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:54:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 01/20] list: introduce LIST_HEAD_GUARDED
Date: Mon, 13 Jul 2026 17:24:02 +0530
Message-ID: <20260713115444.465704-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bTKwBTJjdhCUN3eOzq9uFUDeJ3HPzemx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX1p7fjFnYjPXe
 75XQd1C8yqfdE0CyjisUkf+8S/Ndgu6FPCvs7fHVCopY/ehJy7cRHHGA7XCUKx5E5v9RdbSQvuP
 /TUUKQqwQmTwhH7qFLvs1fLnzBoU+k+07EMLgYgv+lOJbkdimhK80NJP7p+r5Qr2SjBDoI5NoU4
 JtlneMFwTM6qtJbQP3llj7mGhX62oLla17ur5anQkJ7/ty2Ci/I4VT98X4FZrvotu8fKvEUtRbW
 sWOUYsPMC1fT49/9ZvNUlpzI+cc1n6IKacMoCAgTXrziZbmK4ApWLlKcyAIBwPJA0lpylxOVDyo
 JqVZ71EtHBLjl7TZWaYsS7JJQMA1PWHMZDW+Z4zc4tSNdY1yJDSmiWSai45XAUcq+0+dnIqaNSX
 rUKcGDDz1vEa9BwjypH0I89Q0fXjdICsoKpxYFyHUyZ3Mc90G8FimqoHS5O9gxP3kkXMgAoB5zs
 3ZrrXNkY2Ukef0hvjmw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54d218 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yEdB1FNURbGifd-vTGUA:9
X-Proofpoint-ORIG-GUID: -hgeGAVeqLIyNtYsh-QJ85jlscnWnySb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXwEnMtMBdEE0j
 EO7laSTHVqvvZfjMmwUNKwx5vM3QFZIzpkTtJOM/OT3HZkvM/4QYbpwF3trkKw5vktS/kvVkHB9
 r4YwF6FOqkmAT9rRO1Bg0TzPHGWh0X4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045515_822750_07D2D9E2 
X-CRM114-Status: GOOD (  13.27  )
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

Introduce LIST_HEAD_GUARDED(name, lock) to define a struct list_head
annotated with __guarded_by(lock). This provides a convenient shorthand
for defining lock-protected list heads and allows compiler context
analysis to validate accesses to the list against the associated lock.

The new helper also reduces boilerplate and improves consistency across
callers that annotate struct list_head objects with __guarded_by().

This is a preparatory change for subsequent patches that annotate
LIST_HEAD() instances with their protecting lock.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/list.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 09d979976b3b..f6f22c8b06f7 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -33,6 +33,14 @@
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
+/**
+ * LIST_HEAD_GUARDED - define a &struct list_head annotated with __guarded_by()
+ * @name: name of the list_head
+ * @lock: lock protecting the list
+ */
+#define LIST_HEAD_GUARDED(name, lock) \
+	__guarded_by(&(lock)) LIST_HEAD(name)
+
 /**
  * INIT_LIST_HEAD - Initialize a list_head structure
  * @list: list_head structure to be initialized.
-- 
2.53.0


