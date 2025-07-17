Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA5DC83F1A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/jXZprNAiZwbFkjDKErohzqcX9b0ATB2AmBo9GP25RA=; b=A8w7QN0/nqIWAezHrxQZhbV9EW
	85SPo2WT3u/IKtlvB6mQTqJaytbsMbVux9GyT7MUdQ2aPxfM3a6PReKp2Xy6E7ZAw20h+cRS8EhBK
	257LnMKAKrV7P+Pg27IDQkuRCMVaZrBw0LksRtPg3a4zKW9IFpHoyePB48GZY4+Bx10optIdXCvM7
	Tl105wFI8IeItMRLhltGCaH2AZrJQN3IalM1BlyrJSv4DyyY++3J9ZqJGuPFuaGUm5WSyB/COtqNN
	IQC3j2mM5s+dX1/icwA0FB/FuqEs66I2cKK1L3pLAHQNflJIGwv6QkLIBelqDSiPIXgEMzuc6CLfK
	RwOXV9lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucOAq-0000000ABHz-3Ujk;
	Thu, 17 Jul 2025 12:57:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucMnN-00000009yvy-0wXZ
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 11:29:04 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250717112854epoutp03b0be32adf7b4b21c5413719958e602f3~TBmqfflvS0881508815epoutp03v
	for <linux-nvme@lists.infradead.org>; Thu, 17 Jul 2025 11:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250717112854epoutp03b0be32adf7b4b21c5413719958e602f3~TBmqfflvS0881508815epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752751735;
	bh=/jXZprNAiZwbFkjDKErohzqcX9b0ATB2AmBo9GP25RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xj5mWGF35LzrKfkYbKA/xDgW4K4QszbbbIman5AufKUQwnCq/WBrCqXCagAT/4ei+
	 Q8HBLOApvZSMPS+8qw0JgcU520/5VITjbVBXHLHn5NPEumtxft8DF3XnmBBtlZWTvr
	 7n6RBMQGUx6MX6dN3wKZXPYyEa3qjEahwqQQOiSA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250717112854epcas5p293ca95960526612ccac45756a2d86611~TBmqLt-Nh2576625766epcas5p2R;
	Thu, 17 Jul 2025 11:28:54 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bjW0554Xnz6B9mG; Thu, 17 Jul
	2025 11:28:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250717083851epcas5p4e16203f1673841f8dbf2da2a671cde66~S-SL69nPF2382023820epcas5p48;
	Thu, 17 Jul 2025 08:38:51 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250717083850epsmtip1cf2830059d74adcec255c78de7346487~S-SLN9v4d2002620026epsmtip1Z;
	Thu, 17 Jul 2025 08:38:50 +0000 (GMT)
Date: Thu, 17 Jul 2025 14:08:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch
	<kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: nvme-pci: try function level reset on init failure
Message-ID: <20250717083834.2pp4lugbl4u46ngd@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20250715191627.3690017-1-kbusch@meta.com>
X-CMS-MailID: 20250717083851epcas5p4e16203f1673841f8dbf2da2a671cde66
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_1ce28_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250717083851epcas5p4e16203f1673841f8dbf2da2a671cde66
References: <20250715191627.3690017-1-kbusch@meta.com>
	<CGME20250717083851epcas5p4e16203f1673841f8dbf2da2a671cde66@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_042902_720986_8F1E6A1F 
X-CRM114-Status: GOOD (  12.94  )
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

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_1ce28_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/07/25 12:16PM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>NVMe devices from multiple vendors appear to get stuck in a reset state
>that we can't get out of with an NVMe level Controller Reset. The kernel
>would report these with messages that look like:
>
>  Device not ready; aborting reset, CSTS=0x1
>
>These have historically required a power cycle to make them usable
>again, but in many cases, a PCIe FLR is sufficient to restart operation
>without a power cycle. Try it if the initial controller reset fails
>during any nvme reset attempt.
>
>Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
>v1->v2:
>
>  Added code comment explaining whe escalation
>
>  Add an informational kernel message that this event occured
>
>  Use the "pcie_reset_flr()" API instead of "pcie_flr()" since that one
>  checks for quirks and capabilities before writing FLR config bits.
>  Note, NVMe PCI Trasnsport Spec mandates FLR capability, so the latter
>  should not apply to any compliant device, but you never know...
>
> drivers/nvme/host/pci.c | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_1ce28_
Content-Type: text/plain; charset="utf-8"


------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_1ce28_--

