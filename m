Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF81CCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZjdwl7FnEi2lU6bCDHKVt6bQ30THwLTs+JaHvcqT0s=; b=D4E8i2bMQF7l1CPKE56F3aG6K6
	9kn0OO62FjOUi4OrFmnoEqnKRDmOQJBGzFiA8jl5FlI0RA2Oo1nXRGnZBg09zkp9fz/QdvlIZtGKt
	yHIhsqAsUzQYdNIK7BSl14xw6r1igSXJCk1x9ufUPoCJOQ41TiZICY/1Z4+JB75aKrAYwOnhHmuDF
	npLWqDhoJoreXXi9fJphRdVOSzOR5X3yugzD/fzEc9hCCToaSPywFF5oeAUK/yNHDtxh19xkrod/x
	Rkwa3rFTQARqmyuqL1cDBJQRMPB3YJi4vU27nScJ4St1ZXSaQguwsVnVd2VSP8axUBJ5jwu0YOYwR
	E+3IAAQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArpO-0000000E8EK-3bTs;
	Mon, 20 Oct 2025 15:29:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArpM-0000000E8DD-2V2I
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 15:29:41 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCRb1V023459;
	Mon, 20 Oct 2025 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kZjdwl
	7FnEi2lU6bCDHKVt6bQ30THwLTs+JaHvcqT0s=; b=Zqmj8ArvkCMFSl10VgFpBZ
	PrXDfYx3gKblkJHqCdMOYPXClpXegB0ma6xZ8ZGqJvkQEIhHppw2DGCajhXMupjP
	7vsf0RnRbdbdFAMprjzCpfn6TMBY9FEVTsFMPv/C+LLJluEna30NoHBY5uSl06Xs
	l0yOur4dHCbJQa7tzpiKgnrALOBbSW3Bq1IVYViG7L3yA6hKzO0VXUjGV8XJM9eY
	WsrsJSwFmuoU9B2gzW4qfdiA0JIeWW1Ml4ykqijy3Hj+GPbpC19IiE9J1s9Odr2o
	DiPCRnn8gmqTjEd2hzk09Y1wBxWkm3vVaLXpdqg0r/8yKNkd7KZs+TJn4BXVuHlg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rt925-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEJJWI017066;
	Mon, 20 Oct 2025 15:29:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxpemb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KFTOFZ51577090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:29:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83F0620040;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 602F420043;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 20 Oct 2025 17:29:08 +0200
Subject: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
In-Reply-To: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CKnkR60__oQPb3_NoV8ArCyH0KmX-7tT
X-Proofpoint-GUID: CKnkR60__oQPb3_NoV8ArCyH0KmX-7tT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX68Eo7iBx4JUL
 mNLBpM1iRy0P9SFa/kbvpWFTPQ+TA66WwTcGg8Enfu0NxUCv1tHlM3zNnGiRAT8eagT+oWIHA0j
 nnRI0HH+R2ucqBt8jWGxny6J8pm/BrGrXUL3WWCGus5mRpi3UPdfq6u5bvnmZfyH4jh6OJ7QkaC
 29NrIYpUMY2eWUZj7oFFO8T4FEsoLigyeaxa8+cXCakWKwSVw5ecWoa+J/KTmbV1f2BKIJWmdDW
 F7z9aMh2fYMMztXGRlimjypdsp91UZdXfVNsvgTpES0AyCZufg4N757WFQMYuX8vF/bRG7zVzTM
 BL7IoFhc6V8+lfYFNM+o1/uBqRL/uw7yB9Hx3E8KhHQRfl5V5JHgQgpu4MYrtUy4lwl3U2Z2Bcj
 kCQZCrk6aAtesR9Z8ZfTXnOVXVAc8g==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f65559 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Gwek0BahB5A2Lshf9EwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_082940_640098_63C66919 
X-CRM114-Status: GOOD (  14.39  )
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

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce0890becd6425eb80ebad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	pci_set_master(pdev);
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+		dev_dbg(dev->ctrl.device, "Read CSTS register failed");
 		result = -ENODEV;
 		goto disable;
 	}

-- 
2.48.1


