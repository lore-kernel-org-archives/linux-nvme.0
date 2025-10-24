Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225ADCCD1A5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Oct 2025 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62ZZuMIVEcT23AMveUzBFI4vn/NnpbNP1HCzXrArEq4=; b=OvhCqtoAo7es8/WLVIkLybOo0Q
	q2x6btLX1QANeYm8VrwXTqFUIjtQdoRNjFwLyQa8S1VTYRRL49ioY8YyQ/BHpeI6+ctcd9SDoWiuo
	2ORmarh9MqKu/3ANhjKRzZho+W3MGBJt+XNILzNf956UocrgmUR4/DxBiVq/001n+051UZ/VvcYLq
	fIlqmHkEwOdYSI0Wb6Cy9DAzphuXjlPNLIkFG4vjap3a5q3ECfXa/WKofeb5/4f4+ZL6pnCfWzNHJ
	n9G2hieF1y4rrpwelTnCqvLdvskWVLkvdRY2/1D4MnxdHt1YOHsghYIrK6aqW5o2Yzz5zV4ee5aCh
	2YoMDFJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCFck-000000097Pb-2N58;
	Fri, 24 Oct 2025 11:06:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCFci-000000097NK-0Bgd
	for linux-nvme@lists.infradead.org;
	Fri, 24 Oct 2025 11:06:21 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NKABxU017956;
	Fri, 24 Oct 2025 11:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=62ZZuM
	IVEcT23AMveUzBFI4vn/NnpbNP1HCzXrArEq4=; b=YBqc7QCwpq7mOhPxRvaGqN
	mPn5CLuWLVzL8TTZjYjNOIjfMCvAJWgGMrN6K80vpWGcCn/6AukLISfXqpOMXSMu
	U68Of5RHXxlsmddVWxtBPzMmw8XPSSG5Z+GENujBUkFEtazC69CtuPYhiG4edpXW
	nDNaJ2Gdzh7+RKzudkQSybBd5mJ/KHru8t1+EgCyrAAcwNqUKqo1mCHp3j4HjCOA
	HHP9IX7+upBwhmVqgLpyEP9YxxNUU5fKgbt2C/1272i1mZO2PoNwWg3wCfl03zpR
	eLzO9M44AYfgtRTM40zizG/h0j3HJyOAy0UpCjvocvZpgTP1Gmv8NFkWIRNmvpvg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sex5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9TFIu024303;
	Fri, 24 Oct 2025 11:06:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkand6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OB64j228180838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 11:06:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AE52004B;
	Fri, 24 Oct 2025 11:06:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCE5A2004E;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 24 Oct 2025 13:05:31 +0200
Subject: [PATCH v3 1/2] nvme-pci: Print error message on failure in
 nvme_probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-nvme_probefail-v3-1-5386f905378b@linux.ibm.com>
References: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
In-Reply-To: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tf749bEYkwCIIOD-VHiQeGhjr2Gcb92X
X-Proofpoint-GUID: tf749bEYkwCIIOD-VHiQeGhjr2Gcb92X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9VLfkZ/J8HUz
 hgiaqBByLIPKTFjtEsL3CRSOL8AEF5uEGjDLmKsqsTdwoa4DOxRKlrfjy67xQQkiDKrinWFf9v3
 Lu/EQ7E7rXeKzzxUvgIN4uU6svUh2PdRFRLhlwYx4wgIhiVNatvVLGkZng31EOrOdz0RWySe3ly
 mrUXf81TAbOZHAEJWHDNW/vMjDBGqjXFa1fHGY9LtJC5KSEGXjuLeZ1qZjcyYpPSWeFOpPxrIjh
 haBYpGJjrJKDNk6M2/mEgSB9naEGMD5yCqv1ETo0QjtIFUpxEnh+cn0Io636iKlVP1iOxL8XmiT
 nVAtLs/MtR0WIoZDuoPcT5mgs7V4EdsM9L0fH53iSAZvbsnr45uSbaNNGbDuEX7ukLzBpdn1mqc
 gu/QzWp0wibX1VrSQ1/a8TjCfEEcOQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fb5da1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=GWyhmD5H9okkrlSlx5YA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_040620_087488_F31E2DB2 
X-CRM114-Status: GOOD (  14.06  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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


