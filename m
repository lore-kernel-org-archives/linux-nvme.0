Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCAFC4321E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=dUWarxBgIIGvMT0WcZqTP1J4oIKzS7HhegeJjIwkJT8=; b=SHnCit4I5kXFTWbXgbHpmU0kNR
	XwLLekQ/r6ZW1+KJlITUSHKPyuzMMrkrSYu47D03ev6AUcneSQbzoPsxDnThEc5ora0DZ/QYkSK4h
	y/96q6QeT8yI6/rO8FuSrznDPGj4QRt91BIQrbCwmn9lgndO9L7iGzjKZP69Tiyxi6POGn6rUrnUh
	iEBf2T7wyLDMTFFgXQVjNDcTxdEdCLO6TSvmXqexybpdKOulewoVpnwzANIJxfHWu4ceEXDDmlCGe
	Zj+YbrVglqu+ENolmfyNnq3pGxb6n2uvsT6DH9r5sI2FqGYJaZGj2TZ9nJBwbdC9lWaaRx3awock6
	sKcitwFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2CVf-0045lN-J8; Mon, 05 Dec 2022 14:31:55 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2CVX-0045ju-KD
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 14:31:50 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221205143144euoutp02a9929d2224c2b131c60f8e73b75a610f~t7CqCrwO91438814388euoutp02L
	for <linux-nvme@lists.infradead.org>; Mon,  5 Dec 2022 14:31:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221205143144euoutp02a9929d2224c2b131c60f8e73b75a610f~t7CqCrwO91438814388euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670250704;
	bh=dUWarxBgIIGvMT0WcZqTP1J4oIKzS7HhegeJjIwkJT8=;
	h=From:To:CC:Subject:Date:References:From;
	b=X1TO+XKLhek8awzkgOHap4xCul1UY2jKSlrGunegCCiYGrIiqA/oe18Q+G+BDByQ7
	 cj/eAeSQMfsK5oT/vfZdP8GjLNQ5+KoDHagZlCd3pK7rE1t7yqIRZq0FB+MAnRc7KS
	 +XvYE4lgowp6oKZpGdQqWcTpbz909kUhvEwSYPEo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221205143143eucas1p27996e81a2943756d43e0c5f2d4d9ba65~t7Cp5sZqM3246232462eucas1p2p;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.C3.09561.FC00E836; Mon,  5
	Dec 2022 14:31:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221205143143eucas1p2f5dd4e56ff5ab515fca60ecc0a10350c~t7Cpd3wza3245332453eucas1p2G;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221205143143eusmtrp1e4061d2859e6b4eda3a103e08cf40963~t7CpdQl2w1752117521eusmtrp1O;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-9e-638e00cf77bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.99.09026.FC00E836; Mon,  5
	Dec 2022 14:31:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221205143143eusmtip101a20425f642eef85c131f891ab99742~t7CpUgx6M0124201242eusmtip1M;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 5 Dec 2022 14:31:38 +0000
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <chaitanyak@nvidia.com>, <sagi@grimberg.me>,
	<kbusch@kernel.org>
CC: <p.raghav@samsung.com>, <javier.gonz@samsung.com>,
	<joshi.k@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v5 0/1] nvme : Add ctrl id to allowed passthru commands
Date: Mon, 5 Dec 2022 15:27:45 +0100
Message-ID: <20221205142746.1026912-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd3zDH3JBl83WFm8P/iY1WLl6qNM
	FpMOXWO0mL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DK+PdwBUtBK3/FmttvGBsYJ/J0MXJwSAiYSGz5zNXFyMUhJLCCUeJkw2cWCOcLo8TD
	dVPZIJzPjBIf5y5l6mLkBOu4+HIiO0RiOaPEvmMbWeCqbjTcYYZwNjFKdHzdxg7SwiagI3H+
	DUiCk0NEIETix+29YO3MArOANl7qZgFJCAu4Szw8fIMNxGYRUJE41bsSzOYVsJWYfPkqM8Ru
	eYm269MZQS5nFtCUWL9LH6JEUOLkzCdgY5iBSpq3zoYqV5TYMuc7K4RdK3Fqyy0mkL0SAic4
	JF4evMsGkXCR6D2wmQXCFpZ4dXwLO4QtI3F6cg9UPFti55RdUEMLJGadBAUMKPSsJfrO5ECE
	HSUmN69lhgjzSdx4KwhxDp/EpG3TocK8Eh1tQhDVahI7mrYyTmBUnoXwyywkv8xC8ssCRuZV
	jOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgWnl9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe
	Fxt7k4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzrpjSkSwkkJ5YkpqdmlqQWgSTZeLglGpgSuZt
	e5LM0zrtwbtD05uu20kIuMpObltzu46/+637FeXs5A/xx7hb6i0zTZ59/xzeWyM1PcDuQWLC
	2pPCJamz9dcV984wum8q7idzw1TPsuCrZOrmmnmdi92XN284qZ0km7x0cvKHym2Rrul2k/MY
	Yg0LT2QpBJy9vJAtbUaXRCnHs48Jayv/vJYOWCJkey3qVfLX+5GF82c/E5x9ZWc5Qxrvy91/
	mrbbnfwyQ+yZYFdX3q7v63m2cbZ8075hsPOgzjbD28wL2ZemLHSQ0vv/Lfdf1OZJ28vf8qXs
	5911l+fDlbvr36916u7OL2w5dse2/4Hy4eMFtxNmCz7ef+Dqwb3pbKVHVvA2KUyZNnOfuBJL
	cUaioRZzUXEiABgVBXOaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7rnGfqSDX59l7F4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8e/hCpaCVv6KNbff
	MDYwTuTpYuTkkBAwkbj4ciJ7FyMXh5DAUkaJaadeskMkZCQ+XfkIZQtL/LnWxQZiCwl8ZJSY
	czAYomETo8Sr72dYQBJsAjoS59/cYQaxRQRCJH7c3gs2lVlgBqPEqrULWUESwgLuEg8P3wCb
	xCKgInGqdyWYzStgKzH58lVmiG3yEm3XpzN2MXIANWtKrN+lD1EiKHFy5hOwXcxAJc1bZ0OV
	K0psmfOdFcKulfj89xnjBEahWQjds5B0z0LSvYCReRWjSGppcW56brGRXnFibnFpXrpecn7u
	JkZgHG079nPLDsaVrz7qHWJk4mA8xCjBwawkwvtiY2+yEG9KYmVValF+fFFpTmrxIUZToG8m
	MkuJJucDIzmvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJyPmE
	nwbbdElWaynVvsUrb1/g6uP/dy/n13upx+VCR4xaImcUSR/ZoJe+T0HV9c3CR4uyL23nW+R1
	4sKv3sqslnvMay1dd37Ztu0nY1D2Rpdr+va51UWVvtaHLh1QCV9qLZLPtS1Htvmk/gyVa927
	V/yqCo4V4HLdeePzhCb7P3EJD1vOXJls+jeYd4HO3ppTl+rP3jNh+3bWZaL0QWeuqOsRPDuu
	SX7U/M4YvYvVqL88Pj081ofVsqp+3tqwwIdTlxq59TT773x8d7vzc/XojDD2HPmDh50ivq8X
	S6sJ/H7uiPHkv8nfxKt7IltLHbfP+SFc1BfzfMapbWw7ZA9aP/o8edskc3Xxuxt8d1xTYinO
	SDTUYi4qTgQA0O6XAiwDAAA=
X-CMS-MailID: 20221205143143eucas1p2f5dd4e56ff5ab515fca60ecc0a10350c
X-Msg-Generator: CA
X-RootMTR: 20221205143143eucas1p2f5dd4e56ff5ab515fca60ecc0a10350c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221205143143eucas1p2f5dd4e56ff5ab515fca60ecc0a10350c
References: <CGME20221205143143eucas1p2f5dd4e56ff5ab515fca60ecc0a10350c@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_063148_274254_73DBE3AA 
X-CRM114-Status: GOOD (  14.17  )
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

What?
In this patch I add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the nvme
admin commands that are allowed in unprivileged passthru.

Why?
This will allow access to attributes that are needed to effectively write
to the char device in passthru.  Applications with write permissions should
not need to be privileged to write to the device. With Kanchan's latest patch
(https://lore.kernel.org/linux-nvme/20221020070205.57366-1-joshi.k@samsung.com/)
the nvme IO and identify commands in passthru now follow device
permissions; however there are still some controller attributes like
minimal data transfer size (MDTS) which need a privileged user to be
queried.

How?
Add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the allow list in
nvme_cmd_allowed.

V5:
* Drop the ioclt implementation in favor of just adding the controller id
  commands to the allow list in nvme_cmd_allowed. This resulted after a
  comment from Kieth Busch pointing out that adding a struct and an ioctl
  for stuff that is already there, makes no sense.  IMO the ioctl
  patch is mostly done and is there if we need it.

V4:
* Fixed an error where the ioctl number would change if new members were
  added. Now I use _IO instead of _IOWR to avoid leave the ioctl number
  static. This is very similar to the implementation contained in
  https://github.com/torvalds/linux/blob/master/include/uapi/linux/vfio.h

V3:
* Removed unneeded comments in nvme_ioctl.h
* Added a comment to the nvme_sectors_to_mps function
* Moved size checks to nvme_check_size in core.h
* Changed struct initialization to match what we use in nvme driver {} vs
  {0}

V2:
* Changed comment from // to /**/
* Took a call out from an if condition and assigned it to ret var.

Joel Granados (1):
  nvme : Add ctrl id to allowed passthru commands

 drivers/nvme/host/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.30.2


