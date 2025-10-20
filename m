Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5121FCCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSEjYysYWWk1LsD3k2FDaPqGqJOySS8AEodVfCUxJ9M=; b=yHTwdtzbOc/diAAP3EwARblCPP
	8qRjGawfDLUZ8Ok8Z9s/bcOvldJRNMmKNrqBtyQxf+i14LJtVDD+MXX2shQesI2VyOdR1Bx3MVgq/
	r2OT+ZZZzer6UX7HS399EaSEpdtDxMkHuFPXYgRhISDftGCGnoarTnCde55TE9Njx+0vUZiKlb7VC
	aZSiL5wQBhVXC8EJyMhE1VPM1gB7akgmUyiiUKh/nDDOrfN5qLDQ3l/6gvX6BzZ7KzzGWfrG55rrZ
	mWB0/UM0q4U7szzwU/NGMO77imRBVeEx5NRfFKI6YE/GCxmE24SlW/1e0sioUobwl/Adpif2ejRl/
	jktk0jSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArpO-0000000E8ED-2CBq;
	Mon, 20 Oct 2025 15:29:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArpL-0000000E8CV-23VL
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 15:29:41 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFIggr022111;
	Mon, 20 Oct 2025 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pSEjYy
	sYWWk1LsD3k2FDaPqGqJOySS8AEodVfCUxJ9M=; b=L9xIGcs3aaTGHax3ymNMai
	ac5cR4j5QO12jDhXGgZtaPaAtLOaZv5FdA9eTT3poIbdYb6kJPY21zkKt/ySNLPW
	xjlW2ZWG8Z1D19qa1AG7j1H2mFQkzVhAtABm+Q2PIlWxPNG3LrTqB0OYUPGIVFvC
	KhZtkoB9hdE47vOCwpro4nsC6ZigsFVqI1xBlkExsJApPKRa/dqvadLF8m5FcyiA
	rGflTylusntwWMgT47k5JN/GAmT6+nXux7Sy6pu18oKsgdK/xZLQE6qCm4mKTJWA
	PyES6Mnab2We1G24QpEBqeZ/JavvRuDpXK0hA94c14HDSxO4BH4SIaFqdhXe4UQg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vh57t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDe8U2014658;
	Mon, 20 Oct 2025 15:29:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7rxjby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KFTO3N41550174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:29:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B2A620040;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368772004B;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 20 Oct 2025 17:29:07 +0200
Subject: [PATCH 1/2] nvme-pci: Print error message on failure in nvme_probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
In-Reply-To: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QV0Lo_aqbuu3TJx3KLkVJAFe_NN75plv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX85EqlEsug4/c
 pSv9LOWErJV1G7aHSVurEVI4olnGULoP7T+UpKl0S9pbaTBvN2TYIIcLP6QeYMYfxudQ1i5fqlV
 dufQVHjMzxxT2r1E+sgKTHWTfRy/o1/lQ8WI2ZZQBCa6MHQg5eQB7ThcgFDBPZthV6cgWWwQzmE
 iOLMNgVsCcxP6/WvB3o0OGAnU3xM9fR4HHQJonsg3u6h6X4rXQSPO7izXIdp6yoI4TpfcwjPNLV
 GIGS3PylGXaz+SI87XawqxlMzf1/9apRt+ziYlW8l5MnXOEk/Wv/r5wGB+O+V3HqJnccZNi1wTg
 ruT4pkxwmiG8r0GA9uUsx435cSLhHAg97kl4QmCFyMPdB5qFoJjY+lFbUIWz5ihjEExMj2PbsGI
 hTU4yT7opxEo9OH2TtfZEKXnG9tJaQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f65558 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=53zO2tGsVP_itq-8s-4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QV0Lo_aqbuu3TJx3KLkVJAFe_NN75plv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_082940_010739_4849F87A 
X-CRM114-Status: GOOD (  14.50  )
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

Add a new error message like
nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
that makes failures to probe visible in the kernel log.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f058b49e6e6768675711df52b15765..7544c4bac2c4a230d32cf729abb9e94bf93a921f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3519,6 +3519,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
+	dev_err(dev->ctrl.device, "probe failed on %s (result: %d)\n",
+		dev_name(&pdev->dev), result);
 	nvme_uninit_ctrl(&dev->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&dev->ctrl);

-- 
2.48.1


