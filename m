Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF6CCCD195
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZmuJhutMfvig7ABoeqG5Gz+8QdZtaHNzjH8dqMQNPD0=; b=SjNeIh92WwN3X3qfpswHiQALpo
	0CEwrYhwyscm4xigEpFRF9Ik5kBUmm6M+V+urdzsnDdBLWJQ3xR2n+sOju35yIo//TYd69WSftSY6
	j4LvC8ko2E8EJbPuc+Q6N7nYKxi1BpqW+Lh+4A8k8bjLOQjOj1RC+O4/6ga05rJjFbtWGtf3sTLVn
	B31prpzDvf8HbevvVbfbYi/apl3BKob35n85vowfriSs2jH27lSyPX5yTWt1RzxGp9j388V/lfSND
	ctG4Gyo1acLCq7TZdhfEN+29nWLBe5mBBmivLVivF0CZTT2KHUys4AB2DqRbozYOrWqWdQdxHvRHI
	EF4jni8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWAH-00000002VV9-0tdu;
	Wed, 22 Oct 2025 10:33:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWAE-00000002VTX-40ej
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 10:33:56 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M1XqhS003010;
	Wed, 22 Oct 2025 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZmuJhu
	tMfvig7ABoeqG5Gz+8QdZtaHNzjH8dqMQNPD0=; b=omoYXkgkknYxrXvyJTnEbJ
	133tE7t4VqMuSJkYijxW+4ICrDN9FIdA9150RdyDHYqCCNVzB1a6ufw721OQCsqe
	EITUjnBSSRkkOzjwS8dmlN3vuVIs8t1pVFSAVQSv7sVoglwGxSDdi7iCkzEWHWC+
	0WEQqqqIR0QH5Sd/lPSVJl/s98mc2qpuXeXSJTYxUXAzz7cQqWtgG2f1PPQLDk+x
	OayHKmJejP5u8f/qKs9V6cV6WpyOpk+oRg6YHqkYJf6L0iqpY7Rdg1WgqQLmX9LO
	R2IcdjxuFEQDTRYyxOe7PpNaU54NE+cTl1EXMG4moov6CIO+pHb3njiZcrbUYSLg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vtqgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6wmuf024987;
	Wed, 22 Oct 2025 10:33:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjypj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MAXjUx42729730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 10:33:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B86A200A4;
	Wed, 22 Oct 2025 10:33:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18DE3200A7;
	Wed, 22 Oct 2025 10:33:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 10:33:45 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 22 Oct 2025 12:33:17 +0200
Subject: [PATCH v2 2/2] nvme-pci: Add debug message on fail to read CSTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
In-Reply-To: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kchk@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, Chaitanya Kulkarni <kch@nvidia.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jKMHZT-R5zsH3hTJ1pDsaNwvxmf9B69a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+exPNhm5fnSI
 dFc0WCO0nxFwJznurdG/Ya+bhmNJl1k0eq4X2hxopaKwhxWiS/v8c8iW5LA2J+gntV8cbwphANk
 cKOErFZGKHYrCtxQEQ0erahH3lhY1ohFZAHCC+nCmKw2DQ9AMddI064Y8f63azkotJNbNo30Onv
 XQ9GCP6StKZrm12k3ihuThRnxKfCWxOLua8uLKukOojxM74oUArwHmjbl3VS8RGmVOGjY01Bmhl
 VXYaqqLrayX27W1HdA46JEWcG2BTiHkh3XWsKKi/AC5PV6qqAyOtne6evBd3uj3SbT1c+sjVKOw
 2fFlv+DBU9cBJkwmzspwR8DKF4q8tyCkFazcNa7MB7jUzQ3TTxpdO2Dci2w72+BE3ZiNdh6SK0O
 JRCR78PTi3XYNajYhMEu3lwKFG15nw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f8b30d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JF9118EUAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=Gwek0BahB5A2Lshf9EwA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: jKMHZT-R5zsH3hTJ1pDsaNwvxmf9B69a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_033355_124722_C5673FDE 
X-CRM114-Status: GOOD (  15.64  )
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

Add a debug log spelling out that reading the CSTS register failed - to
distinguish this from other reasons for ENODEV.

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8c624960c9f67e0cc8409023de5e532d6ed9b3ac..ce563e93d29443a25e9236d0b6d8152ee85796d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	pci_set_master(pdev);
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+		dev_dbg(dev->ctrl.device, "reading CSTS register failed");
 		result = -ENODEV;
 		goto disable;
 	}

-- 
2.48.1


