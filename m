Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94E3CDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=HwKnOY9OUp2zL9+FTTO8Nb11hWBp4g7Sk8Rym6Pe0mA=; b=nOv/zMxBfd2fByZFdE3ofJJeDl
	SjJIgHWFXQqbmTLyqUVeeB6/UDARvVAN6bMe4qybuqsBAdIFX5KVjZoXqeWng6ZhD1YLOVhhbenpU
	3yLxQs0Ufw/QcfjJQW1PGXEvDANEWCHtyMJec8ZFGc9mHnaSXJuG0OGuPC2ILtjLUjHER2zZcDQ+J
	Kr1pGhX9e5KON58Q7Bq9cohsnF4wGoWNf7a/MzUqy8mfuyuQ1vdITBUHaetNDa5H5kjAQa2EKopTo
	+ZsPOGO4IczBfzechOwdzzsTJTwGvOo1V040iIxDxNrHLPFp5Q7p8glzadDtCOI+KwSqky1stBeNs
	opuI7a2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBPL-00FTC9-0x;
	Wed, 18 Oct 2023 18:36:39 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBPF-00FT8k-33
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 18:36:38 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231018183623epoutp025ad093b77c5363b7b7ed56a1b8027910~PR3wsE9VZ1401814018epoutp02Q
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 18:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231018183623epoutp025ad093b77c5363b7b7ed56a1b8027910~PR3wsE9VZ1401814018epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697654183;
	bh=HwKnOY9OUp2zL9+FTTO8Nb11hWBp4g7Sk8Rym6Pe0mA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PcM8+hGeKW9o0WywC6BCwj2/5mom9k2Go5xnkG9gRvRW7+XjarcoIOAohdsEk0FBG
	 rBVo841h8gQ5eJImtSMIs23XONLSmxc4NTDULPZ+q+Yuk1zureMnOoTUyu9uZg/Ffc
	 Q6N2Rhjkl3nNXN4hElwiLdG+/1eluwHy04h9P/3Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231018183622epcas5p3d453bdfe5e3a0da9bf0241c5ce84423f~PR3vtKUqe1772517725epcas5p3b;
	Wed, 18 Oct 2023 18:36:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4S9fgn0B4Mz4x9Pr; Wed, 18 Oct
	2023 18:36:21 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.EE.10009.4A520356; Thu, 19 Oct 2023 03:36:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4~PR3uadPuO1436714367epcas5p26;
	Wed, 18 Oct 2023 18:36:20 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231018183620epsmtrp13ccea44e412d4ba437a5f081db581a69~PR3uZ01pA1688416884epsmtrp11;
	Wed, 18 Oct 2023 18:36:20 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-ed-653025a43cc8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.C9.07368.4A520356; Thu, 19 Oct 2023 03:36:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231018183619epsmtip1fee37cdc815858150c2e5f01ba99ca0d~PR3tLN1951268612686epsmtip1I;
	Wed, 18 Oct 2023 18:36:19 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] Unprivileged sgl-only passthrough
Date: Thu, 19 Oct 2023 00:00:01 +0530
Message-Id: <20231018183003.41174-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTS3eJqkGqwceb1har7/azWdw8sJPJ
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
	xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnF
	pXnpenmpJVaGBgZGpkCFCdkZ89ceZC5YzFax97BjA+Mk1i5GTg4JAROJJc03gGwuDiGB3YwS
	7xYthnI+MUpsOPuGBcL5xijxpH8bM0zL3imz2CESexklWs/cg6r6zCix7xtIPwcHm4CmxIXJ
	pSANIgIuEg3/3jCC2MwCJRIHZk0E2y0sYCaxZ1kPWJxFQFVi0cFnYDavgIXE2nNzWSCWyUvM
	vPSdHSIuKHFy5hMWiDnyEs1bZzOD7JUQuMcusa31L9RDLhKv9t5igrCFJV4d38IOYUtJvOxv
	g7KTJS7NPAdVUyLxeM9BKNteovVUPzPI/cxA96/fpQ+xi0+i9/cTJpCwhACvREebEES1osS9
	SU+htopLPJyxBMr2kFj58SrYRCGBWIkzP3awTWCUm4Xkg1lIPpiFsGwBI/MqRsnUguLc9NRi
	0wKjvNRyeFQm5+duYgSnRi2vHYwPH3zQO8TIxMF4iFGCg1lJhDc9WCdViDclsbIqtSg/vqg0
	J7X4EKMpMFgnMkuJJucDk3NeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9
	TBycUg1MQRcL70mrhrEc+2mlOvXPO/M7VU80Gntm69/do8NpneOvPZW7RiV4rny3+OSmguoP
	P0SrF5QfdpFjlz5SvzppUyGXvh73MmGmIke3dT1PpC//MV8442WkqJnVj47cYO537LKnrj1z
	q7J/vOnE2teXnGr2+yT+LHHmXyC1IWD1s5W8pwOehdYdFZ/Qmc2V5hbDYqhq+sx7/RHNb1Gr
	3S4k/LR5lLnJ7aBgxPIb1mq7hDne5Z/J+XNG5sRWCXn5XUqKDcd5fmm1/W5O+rvq9ryH0lfv
	uYvPqKu4wSqpMW+N8/xZ13uu2jZX+XVac2vveFXpVaGyUYl/yvmzD9++qWb5uuP9CbVTShuf
	M08p2r1ciaU4I9FQi7moOBEAp6m6bBYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO4SVYNUg/kvVSxW3+1ns7h5YCeT
	xcrVR5ksjv5/y2Zx/u1hJotJh64xWsxf9pTdYt3r9ywOHB47Z91l9zh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0ffllWMAexRXDYpqTmZZalF+nYJXBnz1x5kLljMVrH3sGMD4yTWLkZODgkB
	E4m9U2axdzFycQgJ7GaU2HTsERtEQlyi+doPdghbWGLlv+dQRR8ZJV7ta2HuYuTgYBPQlLgw
	uRSkRkTAS2Le7AUsIDazQIXE/9cvGUFsYQEziT3LesBsFgFViUUHn4HZvAIWEmvPzWWBmC8v
	MfPSd3aIuKDEyZlPoObISzRvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nzkw0LDPNSy/WKE3OL
	S/PS9ZLzczcxgsNXS2MH4735//QOMTJxMB5ilOBgVhLhTQ/WSRXiTUmsrEotyo8vKs1JLT7E
	KM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qB6VaIbH5Ll2PGntupSxg2bi9Vzn2jqu4j
	bXv4eNmrqDTrttUlt+xDo9tPr9AyLduSI8VttCNy9vEurrl/xWqLnyuFP5v6dq7l5qpPIWcs
	TSyFospWHPRZueqrgIXn/gfvm5/eTBLt8Nim5CSqEdWw4cbXWatNp1rP6/m03s9IrlRM/cM1
	ybzs91Ob77Owbus97D5dv1xz7VIJRqnGYmXtXy8+fI2eFV7MYtnP/yrh1vMbZ3c6rAxdFW7t
	u7Rnpe7GrdmR8z6VKuj5aFVqn5ymsrniXd7KSRFqcqvUjJef2f9qt/qBj5YT/j50XNSmvbNF
	42XCnaYPKay5WX9CXxVyWfrN2nAnZWNCZu7FnZ/6lViKMxINtZiLihMBc3C4Dc4CAAA=
X-CMS-MailID: 20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_113634_663431_B922E89F 
X-CRM114-Status: GOOD (  10.97  )
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

Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
Patch 2: Enables fine-granular passthrough with the change that i/o
commands can transfer the data only via SGL.

Requirement:
- Prepared against block 6.6 tree.
- The patch in uring-passthrough failure handling is required to see the
  submission failure (if any)
  https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@samsung.com/

Kanchan Joshi (2):
  nvme-pci: meta-transfer via sgl
  nvme: fine-granular CAP_SYS_ADMIN for nvme io/admin commands

 drivers/nvme/host/ioctl.c | 162 ++++++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h  |   6 ++
 drivers/nvme/host/pci.c   |  63 +++++++++++++--
 include/linux/nvme.h      |   2 +
 4 files changed, 194 insertions(+), 39 deletions(-)

-- 
2.25.1


