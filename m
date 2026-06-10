Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC8BCD98CC
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4oV0YATnMk8wx4/zuEPoGA2HSbUDyKzWn69tU1MuZM4=; b=opQCQqP2QkPE/odmxjXh6K4bwy
	jVt44e7LKckWATejBCXD4PMc3joOwk6ekqp3rzcfWbXU0PIb/oNYHL2LH2HGoM2aSLH9Q3BFZuF2d
	U1j6kRgHC4WdL6bJNH68V3fjU2U0YpI7m5g+UeEvuTxv14sNaCbY3Yw9KPGdUQobfisRLrtSASOTy
	Z46Sxt2tdpoGYYWl8PUwyy14WxzFSOdBzT1vOvgxuYup5BX1ZZzHIiJ9Olxd9Ez5oaiumnfkYwsLO
	AR55s5h38U4G2EAsj1E9NTT8DxxgZJK3PzHPF/1NOBchqg07XwPiHd4t9z5YV3gi8DILnqWj1nOEN
	8YvXItQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv5-00000007sdD-0f3g;
	Wed, 10 Jun 2026 14:28:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv2-00000007saz-2Thj
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:37 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1e6wm3078674;
	Wed, 10 Jun 2026 14:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4oV0YATnMk8wx4/zu
	EPoGA2HSbUDyKzWn69tU1MuZM4=; b=FxuvjJSXVd/wXAJT9gaY+BcAbQAvDISHS
	OGDl5Ay84H3eYl9Ai5cofyS+KD1HB8TQdS8bH26LqhFhvtgqu//iYd13ohA5Tste
	cOn2HFRpeEbBBz0hCXunQfKknp20ia4J1CpOp4//jLli1Ri2qy2jJlt8qUfIj62z
	luzhPqB8Qvu0eViCATKRtBLtYi1OfBe3qzyV5m9HtmrhksyZ1mEe4jSEO7igLZmS
	YZj3LokDxKw76r1hEajSB2cc6x9RVaNntI9949iEeycZ7VZlmm8mrhMBkakHNwZR
	jhJKrnfln3Sx92GmutDRvyruF7oJrXEVVxARpedu8wpbMwSxt3ojQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb241kpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEK3vn011481;
	Wed, 10 Jun 2026 14:28:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyerw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESN9R59572626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C58A20040;
	Wed, 10 Jun 2026 14:28:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCDF20049;
	Wed, 10 Jun 2026 14:28:21 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 06/15] nvme: add Clang context annotations for nvme_dev::shutdown_lock
Date: Wed, 10 Jun 2026 19:57:26 +0530
Message-ID: <20260610142743.115898-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a29748c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=lhRNW2dt6MhivXYX8oYA:9
X-Proofpoint-ORIG-GUID: BJPSG3ycLT0GxbrP3ePOzc61riEjQron
X-Proofpoint-GUID: rZBwRqFnvqViv2hJ03H630VCcFenykfi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX5FPIhv7X7O7z
 w7+5ekJWXK4bdBbRXkalrZlIzK3LxqZ9uH7qRMfqWHArkMNBO9e2nBbWwcrhCRwHtPd05J6VejP
 rYsgKAHoGIAjRVW2fHsrdBD8WtNOZHu8WzeK2qrN9RqCEqaRVfK87XdWwblzECs2FuieaRO4doV
 5/I/UPO+sy3QkhbxdCmJIUOrPzLb/cPbf88ZTxLc2hpc30RJzq9FkU0lhSP7eUFgJfyZZ5EnOPA
 SI+LlXm5tFGCVpu58FbC4TCOLv8wxTgskVcfaGegPSaFHvCAa2ZiggPmtEcbutxLc+LM8brRiCm
 UMGwmyTvnRX3xGaJXh3ro+goCwYWF9lYnS7drSNw8Q97Xc2mCRJaxnkVbj5SfLPl+k2LpgoBWPs
 c9XXLZFgznggIgHghxqQAx+QQBmWZarMtfaWzBM/rJzKl0UunKt+wTyYlE1Usgps4hg+WwutYGI
 HwahDDw3GtPFsFa5oZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072836_635414_936A49F3 
X-CRM114-Status: GOOD (  14.00  )
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

nvme_setup_io_queues_trylock() conditionally acquires dev->shutdown_lock
using mutex_trylock(). The function returns 0 when the lock is
successfully acquired and a negative error code otherwise.

Annotate the function with __cond_acquires(0, &dev->shutdown_lock) so
that Clang's lock context analysis can track the lock state based on
the return value and verify correct lock usage at call sites.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b5f846200678..894da63127a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2194,6 +2194,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
  * Try getting shutdown_lock while setting up IO queues.
  */
 static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
+	__cond_acquires(0, &dev->shutdown_lock)
 {
 	/*
 	 * Give up if the lock is being held by nvme_dev_disable.
-- 
2.53.0


