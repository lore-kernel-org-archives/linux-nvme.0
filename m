Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E83C6FD19
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SQn1KG2Bb0nzCHzZpnGe5rulziHDgOOqAlTWRrNBWQk=; b=h88wHxZDYBBTCXUS/8/uTTjZKX
	GRcDCQdwp/9JScd2m1IoFKkFmfXfuQftD16QrVBv7DTb6+i5ek5emK41oMrTsP7CqGKVCw+K7CdKF
	u9vLqgo1SOMT/Gum0dPmzBW7w1bX0HefqCk+PJiClYwXgU8vjUgmQz+jj6D+KVoniHT8nLny4ZWFX
	dmTXvH5FPKriOLlH1gUpVXWODUCJvgK89S13oHFMMjcnkXQJYNfekU4BoV2AEWlbUqE0zUMuPFmXH
	gvHzn/ejpQE5K6R4oVSRLnkpS+arsNEBcQ6uBZ3KQWKUaVa4wjBEHTrBAFbhJKHsDwrN4NAMmUNkR
	HHNUEKfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbewa-00558F-34; Mon, 13 Mar 2023 09:58:16 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbewS-00556e-UZ
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 09:58:14 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230313095803euoutp02477d120beb5cd5d33d14980bb8b5340f~L8hr2UwH33158631586euoutp02l
	for <linux-nvme@lists.infradead.org>; Mon, 13 Mar 2023 09:58:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230313095803euoutp02477d120beb5cd5d33d14980bb8b5340f~L8hr2UwH33158631586euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1678701483;
	bh=SQn1KG2Bb0nzCHzZpnGe5rulziHDgOOqAlTWRrNBWQk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FflIfbwH4etYsM9kMrC6DrG9z0vA9/C5fDckKSOBDH3rCaPZoJmxQ8Fuw7GXgwBiS
	 B56BqYZoOEtqs9aznex4a2NSfE/aZt8ds4xTKhaUbzlJ3bDNosbSucG0P1wNqZP3u/
	 KuzNGnGuiQGG9YIkfQLAS3wvDeQE7xGqkokUI0Eg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230313095803eucas1p263215b66fa7b54cfcf76693266ecd680~L8hrl23r00160201602eucas1p2q;
	Mon, 13 Mar 2023 09:58:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AD.63.09966.BA3FE046; Mon, 13
	Mar 2023 09:58:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230313095802eucas1p2ed9a708d3fb0fb1fac05015a6fb06b7f~L8hrG42tE1263312633eucas1p2n;
	Mon, 13 Mar 2023 09:58:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230313095802eusmtrp14aace66621c33afe6df168082d3ce98f~L8hrGDOrA1915419154eusmtrp1z;
	Mon, 13 Mar 2023 09:58:02 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-02-640ef3ab0fef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.3D.08862.AA3FE046; Mon, 13
	Mar 2023 09:58:02 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230313095802eusmtip1010f049769ce23441ab8c39fdb91ed7a~L8hq6WFZd0509805098eusmtip1x;
	Mon, 13 Mar 2023 09:58:02 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 13 Mar 2023 09:58:02 +0000
Date: Mon, 13 Mar 2023 10:49:44 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	<axboe@fb.com>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	"Khandelwal, Rajat" <rajat.khandelwal@intel.com>, <p.raghav@samsung.com>,
	<javier.gonz@samsung.com>, <monish.kumar.r@intel.com>
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Message-ID: <20230313094944.nsonmbtpmgh4rtng@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdc9d3d6-ad2e-7866-c74c-2a0f8db8eab2@linux.intel.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87qrP/OlGPRME7H4v+cYm8XK1UeZ
	LCYdusZoMX/ZU3aL1luhFr/aVSy6VrtZrHv9nsWBw2Ni8zt2j/P3NrJ4LN7zkslj06pONo95
	JwM9Ni+p99h9s4EtgD2KyyYlNSezLLVI3y6BK2Phc5OC6/wVzU8PMDUw3uTuYuTkkBAwkdjX
	cY0RxBYSWMEo8W8ubxcjF5D9hVGia94+FgjnM6PE/e8dLDAdJ542sEIklgNVndrBDlfV9ewH
	G4SzhVFi/o8NTCAtLAKqEvP2LwNawsHBJqAl0djJDhIWETCXuHOiC2wFs8AEJolvJ6aDHSIs
	YCmxavYesF5eoHXPJx9ihrAFJU7OfAJ2BrOAjsSC3Z/YQGYyC0hLLP/HARLmFHCW+NI+ix3i
	UiWJhs1noK6ulTi15RYTyC4JgS8cEjs/rGaCSLhIzJ8M0yAs8er4FihbRuL05B6o5mqJpzd+
	M0M0tzBK9O9cD7ZYQsBaou9MDkSNo8SJ+ZtYIcJ8EjfeCkKcyScxadt0Zogwr0RHmxBEtZrE
	jqatjBMYlWcheWwWksdmITy2gJF5FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmD6Of3v
	+JcdjMtffdQ7xMjEwXiIUYKDWUmEdws/T4oQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lC
	AumJJanZqakFqUUwWSYOTqkGJgm/CJ3JW2dH5R5vq/p96Mu53d+2zlzqaD0p5nCJ3V5Du/Vz
	BEUD2mJslxswNjzgulD9IS+Je4fKxXyBxMPz275KSu3alDD9xPuMpiJrBp3FJzJ/Ho2b3Pw/
	1SIuyHprM3/xRZtaV5Evwj8idq9jm/rBMaJLrGFCe7H167drSi2apEp9nVfrs4Wa8TNWd3RE
	CqcL7TpW6BU70WDbxdZeR/m7bxa1chnkCjrIGcz4NO3It6Qlnwq15szR4/M1klaLtii6ucpd
	NS2DY6F+G6+Dwe4uHYvN12S4Qhz3Oh3nWtXUGzBpVq8G274vZv+ipF/OZa92vF2w03/yrDNf
	Z0vbvnBfkxgYvDt5pYtE9HklluKMREMt5qLiRADYD71orgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7qrPvOlGLxYZ2Lxf88xNouVq48y
	WUw6dI3RYv6yp+wWrbdCLX61q1h0rXazWPf6PYsDh8fE5nfsHufvbWTxWLznJZPHplWdbB7z
	TgZ6bF5S77H7ZgNbAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
	ak5mWWqRvl2CXsbC5yYF1/krmp8eYGpgvMndxcjJISFgInHiaQNrFyMXh5DAUkaJIxtOMkEk
	ZCQ+XfnIDmELS/y51sUGUfSRUeLilC52CGcLo8Srl3fZQKpYBFQl5u1fxtjFyMHBJqAl0dgJ
	1iwiYC5x50QXC0g9s8AEJolvJ6YzgiSEBSwlVs3eA7aNF+iM55MPMUMMPcAkseHBJaiEoMTJ
	mU9YQGxmAR2JBbs/sYEsYBaQllj+jwMkzCngLPGlfRbUpUoSDZvPsEDYtRKf/z5jnMAoPAvJ
	pFlIJs1CmLSAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYCRuO/Zz8w7Gea8+6h1iZOJg
	PMQowcGsJMK7hZ8nRYg3JbGyKrUoP76oNCe1+BCjKTAoJjJLiSbnA1NBXkm8oZmBqaGJmaWB
	qaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk43Mgxm7Fqc6OiyRfKFq+aAtMmbV77lK
	C/k6BHlqmZqPMH4+lfbWZnoJw8urKndWcpwXs3LXO/8oXub/orPZenWmDxNSKrd/Uz/Jstt9
	2ffc1oNVq1MMl0g53Nux3vvcWw+pe9eVN1vH3lV7zf79ikPAQa9LGa/ntrkZz745cxVPTeHe
	X9VzXzf8437i8mNSKVPwHZUExkW/apkXL9F+r/7EsyXMte6jToXvnHN1ZYppd3LPHnx4xkc5
	1jhaoFRx5YncpEXeIjGlcQHfNcznn2A6pe696aaXAeuyD3HGFYyHfj7z2bz6ypPSekbX32Ec
	898mbpTWipd831jo/E56/53LAm67ZjJPvMF2xSrrvBJLcUaioRZzUXEiALae3DVNAwAA
X-CMS-MailID: 20230313095802eucas1p2ed9a708d3fb0fb1fac05015a6fb06b7f
X-Msg-Generator: CA
X-RootMTR: 20230313095802eucas1p2ed9a708d3fb0fb1fac05015a6fb06b7f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230313095802eucas1p2ed9a708d3fb0fb1fac05015a6fb06b7f
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
	<20230309151218.GA17235@lst.de>
	<ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
	<1573badb-6741-73f8-17a5-8e9cd31d90e7@linux.intel.com>
	<ZAoWZFykm4F5wr+o@kbusch-mbp.dhcp.thefacebook.com>
	<bdc9d3d6-ad2e-7866-c74c-2a0f8db8eab2@linux.intel.com>
	<CGME20230313095802eucas1p2ed9a708d3fb0fb1fac05015a6fb06b7f@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_025810_414364_74031783 
X-CRM114-Status: GOOD (  31.02  )
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

jn Thu, Mar 09, 2023 at 11:43:33PM +0530, Rajat Khandelwal wrote:
> > > > > > I have tried 5.10 and 6.1.15 kernels.
> > > > > So we have a quirk for a device called Samsung X5 in core.c, which is a
> > > > > bit of an unusual match.  Can you check that it gets applied for the
> > > > > device that you are testing?
> > > > > 
> > > > > Also if it gets applied, can you test this patch?
> > > > That won't help here. The driver should be bailing on the device
> > > > nvme_pci_enable() before we do the ready check:
> > > > 
> > > > static int nvme_pci_enable(struct nvme_dev *dev)
> > > > {
> > > > ...
> > > >           if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> > > >                   result = -ENODEV;
> > > >                   goto disable;
> > > >           }
> > > > 
> > > > It sounds like the bridge has a valid memory window, and the kernel assigned it
> > > > to the device, but for some reason the device didn't apply it to its BAR. Maybe
> > > > the device just doesn't support hotplug?
> > > The issue is sporadic in nature, witnessed even during reboots with the device
> > > attached.
> > > Is such a scenario even possible (BAR not getting written by the hardware)?
> > It's not supposed to be possible, but your analysis checking the BAR register
> > with setpci seems pretty convincing that that is happening.

A bit more context on this issue FWIW:

Monish contacted me a while ago regarding this issue happening in
Samsung X5. I failed to reproduce this issue in an Intel 6th gen
(skylake) laptop. I tried hotplugging the device multiple times but the
device came up without any issue. That laptop used a JHL6540 Thunderbolt 3
Bridge. I get from your email that you started seeing this issue from Alderlake. 

To isolate if this is an issue with the device, I repeated the same
steps on an Apple Mac M1 but couldn't reproduce this error. 

Unfortunately this device is already EOL, so our Firmware team is unable
to help here.

--
Pankaj

