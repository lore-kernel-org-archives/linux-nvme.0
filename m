Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D302CC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=CBF3fiPChkqmeKpu1gd1PW+nbHuze8c8+pcqo4NTyaU=; b=fz39sTdJ4p/TBa
	Gp3Q6BzCeZAus6n0P5ABXXvwbIN7KG67PKOwUVZcrezUfqlICyyNfwWlkyv3m9oGv5sQc36cQ1dSP
	rcS3iU9Xl1qIhKTfgL8BuR7V1CeTTbEiSn9s04yL7+VcINgWRjnDLgFakbMLVlYZRTV7ZiwPdUCmr
	bjZ1KeHp/hRTY2GYtAONHeNorruDI+1W8SkuPak8oeAV+LQe2GwyrKkqHHbf50XmAVCmEzet6AKji
	RUEzhBJoBXFDzE+Cp45H09AnxCStO8t8RRo+Q+OA9dQjS5vDcRXWzzNJ+nEv4C6A3lnASlXfp0EbM
	0q4zxeeL0XORTF8ow75w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXfT3-0000000AOgE-3w8T;
	Wed, 07 Feb 2024 10:47:49 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXfSz-0000000AOe5-0XuF
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 10:47:48 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240207104737epoutp04fcaa32d50f99f90874f07dfcd704abce~xjudFyfwg2868828688epoutp04G
	for <linux-nvme@lists.infradead.org>; Wed,  7 Feb 2024 10:47:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240207104737epoutp04fcaa32d50f99f90874f07dfcd704abce~xjudFyfwg2868828688epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707302857;
	bh=CBF3fiPChkqmeKpu1gd1PW+nbHuze8c8+pcqo4NTyaU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=VexJema/phsRC4ELO1qteXRGCuD/kG+iBhw6MnzSQElqi0aPAEMQE/J8NsYM5zd+j
	 eTjbKUQVNEY98DWMyOdHhisXcO1wiFNBYWkNsQyUGliUc7n7tBUN/mxSwulzpPd81f
	 USa9Oj9hEXa8s2ZIj4h4DX1RwvA2inBcOsWp27sk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240207104736epcas5p4f7c93d0b86f6ef0e44d9a2b3dc5a2f6b~xjucIU27A1966319663epcas5p4H;
	Wed,  7 Feb 2024 10:47:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TVGzC00Zwz4x9Q2; Wed,  7 Feb
	2024 10:47:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.06.09672.6CF53C56; Wed,  7 Feb 2024 19:47:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96~xjf-ZdrYS0165001650epcas5p1V;
	Wed,  7 Feb 2024 10:31:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240207103103epsmtrp26bcc3c4349d7fd425535d0fe0474a386~xjf-Y4P4v1048110481epsmtrp2V;
	Wed,  7 Feb 2024 10:31:03 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-e9-65c35fc6ca55
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.86.18939.7EB53C56; Wed,  7 Feb 2024 19:31:03 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
	[107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240207103102epsmtip1abe644abc78da9d6ed34183f337c1ea2~xjf_FOYsm1597315973epsmtip1K;
	Wed,  7 Feb 2024 10:31:02 +0000 (GMT)
From: sathya.m@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, d.palani@samsung.com,
	prakash.bv@samsung.com, anshul@samsung.com, Sathyavathi M
	<sathya.m@samsung.com>
Subject: [PATCH 1/1] nvme-pci: Verify the CMB's Controller Base Address.
Date: Wed,  7 Feb 2024 10:31:38 +0530
Message-Id: <1707282098-28131-1-git-send-email-sathya.m@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmhu6x+MOpBsc3WFj8nj6F1eL/nmNs
	Fm+/PmCzWLn6KJPFpEPXGC3mL3vKbnFvRhe7xbrX71kstl5ewO7A6TGx+R27x/l7G1k8Nq3q
	ZPPYvKTeY/fNBjaPvi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
	8hJzU22VXHwCdN0yc4CuUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfm
	FpfmpevlpZZYGRoYGJkCFSZkZzxaepWlYAN3xe832xkbGGdzdjFyckgImEhMOvyEEcQWEtjN
	KHHlk0UXIxeQ/YlR4vqLPqgEkLOq3wimof/UZUaIop2MEncvz2aGcNqYJKac2sEGUsUmICXx
	tHkyC4gtIuAo8WrFczaQImaBPkaJU+8/gY0VFvCQ+Hl6I5jNIqAqMeNRNzuIzSvgItH76xcz
	xDoFiSkP34NtkBA4xC6x/cRCVoiEi8Sbfc+gioQlXh3fwg5hS0l8freXDcLOlzgz6QgjhF0i
	MW9nM1SNvcTFPX+Zuhg5gC7SlFi/Sx8iLCsx9dQ6JhCbWYBPovf3EyaIOK/EjnkwtpLEic9v
	oWwJiTX797KCjJEA+mVhoxMktGIlmnq/sExglJ2FsGABI+MqRsnUguLc9NRi0wLjvNRyeDwl
	5+duYgSnNS3vHYyPHnzQO8TIxMF4iFGCg1lJhNdsx4FUId6UxMqq1KL8+KLSnNTiQ4ymwCCb
	yCwlmpwPTKx5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwrUw+
	NnVl5J8e58UPheaYnrj29xCvCfvVmbluyz+/tm3dUzrFUnqisu7SG99Xf2bi/JNqnaMVWJZX
	0yG5dOay5T9ZVtz3mRl6Zf/CDX48rSqHbndczVitkbVWsCmzyWfSI95mj0uHT35WYG3d6LdT
	MScpJHxdWMn2FWx5TV/qpq9PvDI5gfcvV+Sd9ev+34q93Oo22/y04PO2frZg/yPvPyuFi/5d
	c2jbDtU/C780z9h8maWsZu6G+Mbrvc+PqR/QlWju013lGfcpJFZJ5eLV6SITd+cL2J5VDlf+
	8e5cgn76h7yZPL7TBBcEb+OpSDnltcUscZNIyBTho6and/88ft/lvaDxcq+bu7OjJSS5Xiux
	FGckGmoxFxUnAgDCFsGF9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJTvd59OFUg2Ndmha/p09htfi/5xib
	xduvD9gsVq4+ymQx6dA1Rov5y56yW9yb0cVuse71exaLrZcXsDtwekxsfsfucf7eRhaPTas6
	2Tw2L6n32H2zgc2jb8sqxgC2KC6blNSczLLUIn27BK6MR0uvshRs4K74/WY7YwPjbM4uRk4O
	CQETif5Tlxm7GLk4hAS2M0qsPb6KGSIhIbF79XsWCFtYYuW/5+wQRS1MEn0H5zCBJNgEpCSe
	Nk8GKxIRcJc4+rKBCaSIWWASo8TEO5vYQRLCAh4SP09vZASxWQRUJWY86gaL8wq4SPT++gW1
	TUFiysP3zBMYeRYwMqxiFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECA4vraAdjMvW/9U7xMjE
	wXiIUYKDWUmE12zHgVQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUw
	WSYOTqkGJq4W1+ouI0fxVQd4xZ8vMW0J2bbz4B1ZzbfvjDdZ6oi+uVK+SajqItea73JH9/P2
	sMmlRNftiknd0Bg7uWoZk/5KHhlHeyONpfOjDraUH59xPz96SegXqb1xS6ZZnz4e0fVw7jKR
	T1dvaltWvlcM4P9nGL/M6ttuAc6S0sKz6/5KWuhrb1F2mhNV7fc8OoWt+Z7Z7Yenk36kO3EY
	6b16qPe06Mndw+f3ZFzmW/Bo3tqrPgu+szbnXmTN/jVbYs6vkOmTxX6ys+TIfVt6q6y7pWNv
	a+5uqUUu00ulkpynNr+U2fvy6oqrf0z4z8lP8Xp1uUi+dGHhhs7zi09+/tRZNbVxts+Zzak1
	NcvO9/3drKLEUpyRaKjFXFScCAAu+kP6ngIAAA==
X-CMS-MailID: 20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96
References: <CGME20240207103103epcas5p1b4f57f29cac1387546301ba279ea0f96@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_024746_653515_0769FC5B 
X-CRM114-Status: GOOD (  17.18  )
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

From: Sathyavathi M <sathya.m@samsung.com>

As per the NVMe Base Specification, CMB should not be enabled if
the CMB's Controller Base Address(CMBMSC.CBA) is invalid. This patch
detects if the CMB's Controller Base Address is valid or not.

Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
---
 drivers/nvme/host/pci.c | 3 +++
 include/linux/nvme.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6..6edc442 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1856,6 +1856,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 		hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
 			     (pci_bus_address(pdev, bar) + offset),
 			     dev->bar + NVME_REG_CMBMSC);
+		/* Check the status of Controller Memory Buffer */
+		if (readl(dev->bar + NVME_REG_CMBSTS) & 0x1)
+			return;
 	}
 
 	/*
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bc605ec..0ff925b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -145,6 +145,7 @@ enum {
 	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
 					 * Space Control
 					 */
+	NVME_REG_CMBSTS	= 0x0058,	/* Controller Memory Buffer Status */
 	NVME_REG_CRTO	= 0x0068,	/* Controller Ready Timeouts */
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
-- 
1.8.3.1


