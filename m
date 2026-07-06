Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C855C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQ/135VJVeLMIERaYABh/o2+dfGg4dSPAPpzTXu39NQ=; b=SftCDZ1i8f+zgfJPBPl9O64I7q
	xW31vP5oiaEz5aMfD484teju+uqfVowwWiCVtyLDqibGXGDQfANoP1d04rOjcH/QVXzUM2YFKBrir
	ILa+aDJ9LI2SN/WDK0PFRU9x0wSHbW0olEcpJzsa3lDsaoWOzD8b5R52Re2s/8xLSDIyXjPCrKSIY
	hwHHvSDoaEOoRzqqfvdAIZBXWDxH9RY3uzNzD0TghaTJpL0i50VuIGhnnTrOB1mKdVemdLziE0Cbs
	+Xdk2w3Hp9/3sR+lRH/Z6Zg5HOtKkaYCtC9W3TWElVUyGPKdsrSD7BR8k+vxGTJ0XRL9mpaVBV8w5
	DrJfidTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7D-0000000Ci19-34Ap;
	Mon, 06 Jul 2026 14:16:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7B-0000000Chz6-0PNQ
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:06 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIQ4A3465302;
	Mon, 6 Jul 2026 14:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EQ/135VJVeLMIERaY
	ABh/o2+dfGg4dSPAPpzTXu39NQ=; b=eiLlhHK0LSeHsG2TjzC8cH4QMzD1R8o0A
	y3FCjXiHnz+FS9DB0AwhFXUXxVvUkOYUM741i/RGo6X6yrO5UdDzh75eiXlUPoji
	swzO7QIHcqRQtuIlqFsnrjptjEccnj9VU54a0IWHJczUbC4YfY5/8Qo++aKwhbzU
	aCDoFFhq6AH3IkMcs5uTG7l7usgu0FSjR0J3LVj+TS9jHlnfvZCYNiOfMrgiDK1Y
	g+OV7XO2Ck99YvfROJQs139RGMH9MyKiLzuvMEcGqSvTHjDeohsTii0SXjpW15bR
	U+e48jyL1I1uQ8IkpAUoiZ66EMKE6hUG7RV//9AN9RnaqQ02o12Sw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdjexj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4i9W024780;
	Mon, 6 Jul 2026 14:15:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xwk1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFoGd13500878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9B820043;
	Mon,  6 Jul 2026 14:15:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 613D220040;
	Mon,  6 Jul 2026 14:15:48 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 06/18] nvme: add context annotations for nvme_dev::shutdown_lock
Date: Mon,  6 Jul 2026 19:44:08 +0530
Message-ID: <20260706141452.3008233-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4bb89b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lhRNW2dt6MhivXYX8oYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX39034UtxugBW
 p+JgwH0eXdguv9g+nkBpS+kLd4O9uwanUziJcWp2s9Q3ddg3PfR1FefKBsoptmv0OmfrYoz/t4I
 MU5yRzUJY4/i8DSSy/zGgxI51dzJh4usWrnzxn1x+CmQBCRnHcjZb+406PiReZs3a7Hlfikxiqq
 hNEAjPgJvWp7mUqoHcfgfU+ebny8QieImGp8EfumphHzmY+ry0F/zReOKaU9aPSdWogYG8FEijw
 4hJ16LGNWgQmlf2lOK/jvMf7keFqtE4aBplJx/KoHG3KAFfhRR1/8u46tcNKxi4Dqb9qN4rlArH
 5p6xxpAaSirsCpKClI/DEmSIawZteFX5jLKwgzQFD16gtsYgVsgPKIbko8CGd3aNHJQqCN1dySC
 aABOBXXiUnDrYmCSU9qOYEQiZEel3+XXWV1TwUJhFwiBbjgyWI5w2MO8PHieXtmNK85PGS9niCt
 Y64DfnA1afL/rbgWvJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX2uTL7q1lKnb3
 UDnSFuf5CNZTNXWyuzJkHn8I2554X7fRsXgeDSI/y6DxdKfw76K4OkyGUH65R7DDC9c+LZ4PflB
 tVSBnpbr8q3WMlQ8M+uQGEmlc2CslYM=
X-Proofpoint-GUID: f3312v65kP1pvXXiPuuScJ666RNovmk8
X-Proofpoint-ORIG-GUID: 0pH80USSrJ6Kqpw93Kq-D9bBMu9xCAVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071605_256585_26C6A6B0 
X-CRM114-Status: GOOD (  15.90  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..7954417d1252 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2199,6 +2199,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
  * Try getting shutdown_lock while setting up IO queues.
  */
 static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
+	__cond_acquires(0, &dev->shutdown_lock)
 {
 	/*
 	 * Give up if the lock is being held by nvme_dev_disable.
-- 
2.53.0


