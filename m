Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6238C00A98
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4oJ07Mgqq+Mcanfxie4hDstIPCALLDkrdwRm+uDaiA=; b=ZS3neBG4QGP+I/dtRD1Ffbi0K7
	jJSWANyKnDb63PoKnXVnjmoSybPGDy2mbAr7AJ+M+xHgEj9QgkBtbi00YDPdUH3xwfTzS6yhUOd3x
	Yu76hKjv1Q2uBag2Z6jV2u/0bjmFBFSfD571PlqXu9iT3BMYcybaEgKecawwYg5gA4Gn8hgaHE4Dt
	Holou9DN6Pud/D91gq6CRdh8Cz6Bb2sk8S+fGCV6aT1f4YpUW/OmkZ1WZK90c/uzWWc6qpfeaKqoR
	X3bjthEpBO0bE5ytbqyFaqJvxA2lcXTKD+ohaREWDD41enn3mUPVfvZS8H5uRWlETvyHlj9UbJjiN
	7EzNXxZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpeo-002Nkv-2U;
	Fri, 20 Oct 2023 13:35:18 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpej-002Nim-21
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:35:16 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231020133509epoutp03f0c513d0b3c5197ce8b668de710c86b3~P1DVNc9mY2071220712epoutp03g
	for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 13:35:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231020133509epoutp03f0c513d0b3c5197ce8b668de710c86b3~P1DVNc9mY2071220712epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697808909;
	bh=M4oJ07Mgqq+Mcanfxie4hDstIPCALLDkrdwRm+uDaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzopDL+YjKcGC/kq/RBdZD9mcAQD6LVKPvNJwLlIrjCvJ73A9ILv/Jxtx/YJ7DgAx
	 zT9NNTaROS3RuTyZPQ5KCarHfUu5xcaofDb3iCBbEvWg8Cb1jYH52fFIhwn6ePMjNs
	 MunERNJFU7nblsPUkTLXiYGO8cuzt4/I589Fs+W0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231020133509epcas5p18d6b358f8bc60382b125ec0175d49ca1~P1DVAmfmx2783827838epcas5p1n;
	Fri, 20 Oct 2023 13:35:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SBlvJ1005z4x9Pv; Fri, 20 Oct
	2023 13:35:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.27.09634.C0282356; Fri, 20 Oct 2023 22:35:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231020133507epcas5p35dcf9c86d04aaace28907625e7f12b92~P1DS-Wc1t2860128601epcas5p3N;
	Fri, 20 Oct 2023 13:35:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231020133507epsmtrp1c324bcd66fe8f940c9180b93e20e5bec~P1DS_r8k21528915289epsmtrp1M;
	Fri, 20 Oct 2023 13:35:07 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-01-6532820c551c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.40.07368.B0282356; Fri, 20 Oct 2023 22:35:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231020133506epsmtip13c3f48b9c55744b980d02e57faa34394~P1DRw-nPn1237612376epsmtip10;
	Fri, 20 Oct 2023 13:35:06 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 3/3] nvme: restrict non-root passthrough to SGL
Date: Fri, 20 Oct 2023 18:58:37 +0530
Message-Id: <20231020132837.151037-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020132837.151037-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTXZenySjVYOVHZovVd/vZLG4e2Mlk
	sXL1USaLo//fslmcf3uYyWLSoWuMFvOXPWW3WPf6PYsDh8fOWXfZPc7f28jicflsqcemVZ1s
	HpuX1HvsvtnA5tG3ZRVjAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
	Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi
	0rx0vbzUEitDAwMjU6DChOyMxfdPMhac4Kr4N/clewPjTY4uRk4OCQETiXf/HjN2MXJxCAns
	ZpT4s2ktlPOJUWL77TVQzjdGiQUdd9hhWp4t6GCFSOxllLjxdTUzhPOZUeLSo/VsXYwcHGwC
	mhIXJpeCNIgIuEg0/HvDCGIzC5RIHJg1kRXEFhZwkri/bgLYUBYBVYkbP/4wg9i8ApYSx99v
	ZYFYJi8x89J3dpCRnAJWEsvflUKUCEqcnPmEBWKkvETz1tnMEOV/2SVWNlpA2C4SR1svQI0R
	lnh1fAvU/VISL/vboOxkiUszzzFB2CUSj/cchLLtJVpP9TODrGUG+mT9Ln2IVXwSvb+fMIGE
	JQR4JTrahCCqFSXuTXrKCmGLSzycsYQVosRDYnqbASRsehklXv/ayzKBUX4WkgdmIXlgFsKy
	BYzMqxglUwuKc9NTi00LDPNSy+Gxmpyfu4kRnDC1PHcw3n3wQe8QIxMH4yFGCQ5mJRFeVQ+D
	VCHelMTKqtSi/Pii0pzU4kOMpsAAnsgsJZqcD0zZeSXxhiaWBiZmZmYmlsZmhkrivK9b56YI
	CaQnlqRmp6YWpBbB9DFxcEo1MOXyT/dPcWtY+ONlYP27l9NVCnY8t2AQ2u9besjI+kV/54zT
	l9b0HE08kzL5bKfTHz3RL5sTdl2+ncVxrXj10VaO1tUhNgzGch+3is9qsl4sb2Kq/Ltxa/6+
	R5udQ3k9D777NunDok+ubav5gt5xdfOd3VzPvodl+6yiBw9P3+QNEy3jvmu/PajStkK56q+X
	fsqfEDOl/OCTy2827TI+7p0uHPJdNyVIZP6BTIsFPTbtJbd6YqNvSuVXNZa0+pQYb+/g8Dy9
	zUUxzPygUNy2pyY7urduXLbp932zbV8SY979C3gn9G3u4pwvCu0GAj/s+O9dyjsvFn6YMfvE
	W+7Y+x0z2f6evBmv+NrpmXhuvhJLcUaioRZzUXEiAGn4bPwhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnC53k1Gqwf8DUhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPYoLpuU1JzMstQifbsErozF908yFpzgqvg39yV7A+NNji5GTg4J
	AROJZws6WLsYuTiEBHYzSsx+v4cZIiEu0XztBzuELSyx8t9zdoiij4wSb0/uYOli5OBgE9CU
	uDC5FKRGRMBLYt7sBSwgNrNAhcT/1y8ZQWxhASeJ++smgM1hEVCVuPHjD9h8XgFLiePvt7JA
	zJeXmHnpOzvISE4BK4nl78BGCgGVNN6fywZRLihxcuYTqPHyEs1bZzNPYBSYhSQ1C0lqASPT
	KkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4HDX0tjBeG/+P71DjEwcjIcYJTiYlUR4
	VT0MUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgkigM
	+aR2/tdpud9sNvdyNAPd69mktQ887zlzfUPz6pvLjk9Lkeb/KHk632JT3eN0TY9PCWb2eza8
	mLaM/dBl46fmF88vfet6qo7R1vP5gqYlwTYKWx7sET3FOXPL/UtdxdZNx5Jbzly5FxucNYXt
	wE5JET4pHc8oLel/Jk84Njr803r0TnP6y0S/KL/mJOZqv9muhqZlJeqvtqaXyN/xsXvHXi+4
	jUXNlP2W9dLA/0uTendOaq7JOdpvkSPZ53P3yc7IyhqDZTuOZy/f6Bx7L/FPyN1PevPYlsh+
	cfZ/e1Nkd0+yH9ussvT7ekdWtkqZerF5JhjU6SdGK7Ap37hlyyBRPbkohUPq3NKG5OlKLMUZ
	iYZazEXFiQDWxb+J5gIAAA==
X-CMS-MailID: 20231020133507epcas5p35dcf9c86d04aaace28907625e7f12b92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231020133507epcas5p35dcf9c86d04aaace28907625e7f12b92
References: <20231020132837.151037-1-joshi.k@samsung.com>
	<CGME20231020133507epcas5p35dcf9c86d04aaace28907625e7f12b92@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_063514_034346_AFA61F70 
X-CRM114-Status: GOOD (  15.91  )
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

Passthrough has a hole that can be exploited to make the device do
larger DMA into kernel/user memory.

SGL transfers go with explicit buffer length information that device
checks and fails the I/O rather than doing extra transfer.

Set the NVME_REQ_FORCE_SGL for non-root passthrough I/O commands that
involve data/meta transfer.

Fixes: 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..1656c19d0c56 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -203,6 +203,17 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		*metap = meta;
 	}
 
+	/* Data/Meta transfer for unprivileged passthrough is only via SGL */
+	if (bdev && !capable(CAP_SYS_ADMIN)) {
+		if (!nvme_ctrl_sgl_supported(ns->ctrl) ||
+		    (meta && !nvme_ctrl_meta_sgl_supported(ns->ctrl))) {
+			dev_warn(ns->ctrl->device,
+				"Controller does not support data or meta SGL");
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+		nvme_req(req)->flags |= NVME_REQ_FORCE_SGL;
+	}
 	return ret;
 
 out_unmap:
-- 
2.25.1


