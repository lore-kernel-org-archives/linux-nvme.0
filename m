Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B808DC04FFE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 06:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTPo97fFW7JFow6wuakzbZJLG7DuLVeGi4uFZTtSNOE=; b=UcyK4f0fWNnbPOQqBm+zZtXC6/
	pM4W9Vv2Ed3RIZV3n0WOcnHIUK7q6+S8E9r99OKKMEcPLmeZ4h1UgfFOeKwNV1teAn0pzAFPKcQze
	XeOmjiZ9/yuLPfLl0n0AwTk/q61a2AKboBH0Ed4OUlTrfEG76WmrKlrTQuQgGahwMw1YBJ5Yn57Rj
	+Ujcp7zRdOA7cW0gTonAA94PxyfpUqOuVNgd7y+4Gkwt65JjcTADVtrAos1MOgZhM49oNnnjUHm3r
	NJgTcQTdp6jV7TqjfYXfZEPa4feWNDfG9KfU6hVgf+bI//9HkjXOCrFaXlfPshBlsC/zJqO9FaSr8
	+6IqEq4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q99-0000000BgHm-0Bzg;
	Thu, 02 May 2024 06:42:23 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Q93-0000000BgEf-0atn
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 06:42:19 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240502064154epoutp039906b63f8c66e707f6189b46f018a216~LmNLxHbAo1666416664epoutp03W
	for <linux-nvme@lists.infradead.org>; Thu,  2 May 2024 06:41:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240502064154epoutp039906b63f8c66e707f6189b46f018a216~LmNLxHbAo1666416664epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714632114;
	bh=XTPo97fFW7JFow6wuakzbZJLG7DuLVeGi4uFZTtSNOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhfR2t2WqKRMCO/bnJDTdlR5WvuMcH/Sr5txiwxTnyoyQJTtO3SaxkyQTuGMgBKwH
	 sQFI3/Vzhpowi7O6Yws7OcJ7zsP4TFWG00nbw0vS+84hCbVo/WB39eTJ3UKh3k9HlY
	 Mn1KCemolGLd5THvSR4qt8BdSAsCnY4a4bNMaWbQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240502064154epcas5p19ecc2944ec1e741fa3a90d120d8c4fa3~LmNLNSt9Q0374603746epcas5p1r;
	Thu,  2 May 2024 06:41:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VVPVT1Gh2z4x9Q2; Thu,  2 May
	2024 06:41:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.C5.09688.EA533366; Thu,  2 May 2024 15:41:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240502064150epcas5p3b6461ca0466650cd0296089d257ff861~LmNHZQTxc0237202372epcas5p38;
	Thu,  2 May 2024 06:41:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240502064150epsmtrp1200fc6d78aa1defc8862fad6524ea7aa~LmNHYidIa1132611326epsmtrp1X;
	Thu,  2 May 2024 06:41:50 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-5c-663335aebc79
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.06.08924.EA533366; Thu,  2 May 2024 15:41:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240502064149epsmtip145b14511259d8e152084515c10d8654f~LmNGkr5BS2071120711epsmtip1b;
	Thu,  2 May 2024 06:41:49 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/2] nvme: remove sgs and sws
Date: Thu,  2 May 2024 12:04:37 +0530
Message-Id: <20240502063438.422046-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502063438.422046-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmlu46U+M0g4UPZSxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjcq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIznizZg57wUaW
	iiuvp7E0MB5i7mLk5JAQMJHYcewPUxcjF4eQwG5GiQc7d7FAOJ8YJTYdPsgK4XxjlHi+/SQr
	TMvcCaegqvYySpy4/BSq/zOjxL8rf4EyHBxsApoSFyaXgjSICBhLdK5sYAGxmQXcJW4/6WEC
	sYUFdCVmX30AdgeLgKrEuokdYDW8ApYSR1asgrpPXmLmpe/sIDangJXE8jt/mCBqBCVOznwC
	NVNeonnrbGaQGyQEbrFLnPp5hQ3kBgkBF4mZPywg5ghLvDq+hR3ClpJ42d8GZSdLXJp5jgnC
	LpF4vOcglG0v0XqqnxlkDDPQK+t36UOs4pPo/f2ECWI6r0RHmxBEtaLEvUlPocEjLvFwxhJW
	iBIPiY1vAiGB08so0bNpLuMERvlZSB6YheSBWQjLFjAyr2KUTC0ozk1PLTYtMMpLLYdHa3J+
	7iZGcArU8trB+PDBB71DjEwcjIcYJTiYlUR4pyzUTxPiTUmsrEotyo8vKs1JLT7EaAoM4YnM
	UqLJ+cAknFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA5P+ng8f
	bzcJKT1hb5hkuZB/lpbVwhvhhjPj/tX5PZr56vpFS8ETAZEnvb3+v3pUae12U0RswXTdLfqM
	lx5x/DFxC8/RZvWUdIraznvvRtq/aV+u81luevzMdP7H0L1JhlEh/c8OX7HbbCWvxnVriVRm
	jS5bW8a5ZRoiPt/DRRtP9j/79iHi/l2jvYpOv11nHL1td3XO4llRvV3La6YyRFz7Zl1YdVou
	m/t4//vqcIdXrj79XPJHFyyskpv8ZdakW/xvlh9LXqX3e24E141SuXle3Y/fbJacOV+x7Omi
	v+luKjKCu9i0IzMfLn1V9PnHKuXjMnLSO5a1XTNZlRy0bWvR9Axr9pXGLSyl049Un5qnxFKc
	kWioxVxUnAgApOyM0woEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnO46U+M0gxN3OSxWrj7KZHH0/1s2
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8+rasYgxgjeKySUnNySxL
	LdK3S+DKeLNmDnvBRpaKK6+nsTQwHmLuYuTkkBAwkZg74RRLFyMXh5DAbkaJaf23mSAS4hLN
	136wQ9jCEiv/PQezhQQ+Mko8WmHexcjBwSagKXFhcilIWETAXGLfheesIGFmAU+J9RPlQcLC
	AroSs68+AFvFIqAqsW5iBwuIzStgKXFkxSqoE+QlZl76DjadU8BKYvmdP0wQmywlXvQvZYWo
	F5Q4OfMJWC8zUH3z1tnMExgFZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
	P3cTIzh4tTR3MG5f9UHvECMTB+MhRgkOZiUR3ikL9dOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
	84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MF0WOPnVKXurwbqc87+vzj7E0PVD88GkhxMXnWNl
	u5beXre6sUt87oTCMkOV1C++N8T064SWbAlvv9ir8WF7zsvSM9YXHj19d7ZDUc1+/coVZzNN
	5zh9WNFy1tHtctfECkaTXkNfw42/UmyVulSnX1/8wP3Y3JmWpVp5EvyrX/ew7L/TPv32S42W
	NfP5W16/ed94qO3Y32syDyftXPx428wni3f8rFwQEGwcuKPIaP2KpVobpy3jTbE2VdRpusCp
	fXv2jTy3jxwp3jeMNj8sj+NcH8Pm9X7pmpr/r+Uftp24z+Fq7WzLuFJF/EsYb8X+7U8d5ra9
	fs51YlJKS2y+/sbuhm9FFhXi0SYsaxN0uU4rsRRnJBpqMRcVJwIAZzygX80CAAA=
X-CMS-MailID: 20240502064150epcas5p3b6461ca0466650cd0296089d257ff861
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240502064150epcas5p3b6461ca0466650cd0296089d257ff861
References: <20240502063438.422046-1-joshi.k@samsung.com>
	<CGME20240502064150epcas5p3b6461ca0466650cd0296089d257ff861@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_234218_092106_850CC0B2 
X-CRM114-Status: GOOD (  12.57  )
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

sgs/sws are unused, so remove these from nvme_ns_head structure.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/nvme.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0ed64dc7380..22a9992a4525 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -466,8 +466,6 @@ struct nvme_ns_head {
 	u8			pi_type;
 	u8			pi_offset;
 	u8			guard_type;
-	u16			sgs;
-	u32			sws;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
-- 
2.25.1


