Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345C3CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Od97J/A15Ke/ThZ/3Q1QlICKHrvcNbuW3doNnpcz9GI=; b=IUWPPyf74oNij9ugkdmd+wtK8g
	K7ddIzTwpmA9JAIDpuewfjNIp4wJhLFjJWRqimBCbu8eIDyKp56BEbUfJwZJFvgE1V6bLdF5BghPL
	1OruaGsPFloVgcRRjoN1O+FXKyrbY0htEYIdDycXstm5lq1SdbWDaIyNWcbHhxPGgehgcX5iEPiy0
	7TxLD5QwZXBLBJqYWOOB/B95CN0aXUz7+2XHT0ECSQzZVyGWOg5lyLUQlOuGzVbcofxMCkEogcF/g
	6q2AfQjLjjQXmOIqwSxu2vAT01C1z21ih9QPoJ9Icgw04V90w8/6nb+Cjxv7xm578OpO4K/M4h3qq
	I94aZtwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWAO-00000002VWh-31a3;
	Wed, 22 Oct 2025 10:34:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWAK-00000002VVx-3TXQ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 10:34:01 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8SFDn017546;
	Wed, 22 Oct 2025 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Od97J/
	A15Ke/ThZ/3Q1QlICKHrvcNbuW3doNnpcz9GI=; b=bpQn1S9vbWPFlpJb1Qgy9y
	J7jQ/VbaxCSNF00EMNGpSYQm/mULhKLzoMttdc+hTCnQ38S0QD2GFKtB7ikTfOzE
	fv0rQA96A7oNAanUUDeArv9wxOYh6ROQPaiWmUwhUh9DmIRd7YuMLfRfHXCGEXJf
	eTlUxloe3qvP17MrNoRWftnoRNnSJIIgTBZeONWWjSNK3owqtxbefPv+NCRxxonh
	QVXsnDGPu8o+feKL2iZ4820jnKs8LeYI7tRD8PnKnxJ7MNiM+PCj+ClNpf2wXE5m
	EWf0XhlHFpxtnEVfou6wgCKJbw5t41QTt8rnPngqU3WSR5X+PBgXvvYZW+TWvLNg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fc5wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7kSRH002324;
	Wed, 22 Oct 2025 10:33:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejfjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MAXjMF42729728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 10:33:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15AD3200A4;
	Wed, 22 Oct 2025 10:33:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E67200A6;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 22 Oct 2025 12:33:16 +0200
Subject: [PATCH v2 1/2] nvme-pci: Print error message on failure in
 nvme_probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
In-Reply-To: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kchk@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f8b30d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=GWyhmD5H9okkrlSlx5YA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ZA--MZ6P12ewBNGmzYdtBs95u6_HQSbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/iRSg8XHU5U5
 V5Y+Q587IR5DLtKB/WoKVQT2ZTkBj1vh0tOwY5WrCc6QU0J935RuxKemRgWrY4c9G22THB7jniN
 4dnvs1Jzy4TvdnSyvm1Ci8gOgadut6mmBmvj6Mie1G9ctxxfatS5wkhxIq5sAc6k/IXupbf09F+
 WJFKih2XvgxD2QJh0B1/CKTd3PvUHUQ/2O2Mp8FkPmfA+xXK+HdHBT0nuYe6DaEyGUYlLGJsbAe
 qBLXpfvqm7fLnUj/aCcq5iyuQNJQtyLN6SsOuk05DoPPazbjjy5WbN1hBGIcICOrYJ6uv1Kh7og
 vYaSLI7ACwdrld9LU0jkcpMqblQYp+6+Ncwy4HbGLUCfw85n4DPXjNOivP72I6XKeGE1NRF1xR/
 dyJLLHhiiukhSv1XFSTlgg5OU3Pf4Q==
X-Proofpoint-ORIG-GUID: ZA--MZ6P12ewBNGmzYdtBs95u6_HQSbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_033400_899039_94CD182C 
X-CRM114-Status: GOOD (  15.09  )
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

Add a new error message that makes failures to probe visible in the
kernel log, like:
nvme 0008:00:00.0: error -ENODEV: probe failed

This highlights issues with a particular device right away instead of
leaving users to search for missing drives.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f058b49e6e6768675711df52b15765..8c624960c9f67e0cc8409023de5e532d6ed9b3ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3522,6 +3522,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_uninit_ctrl(&dev->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&dev->ctrl);
+	dev_err_probe(&pdev->dev, result, "probe failed\n");
 	return result;
 }
 

-- 
2.48.1


