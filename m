Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B107C76196
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inqKjYpOQxw0sjlXgN14rMfLP72HbvMwYIz7Fx069HA=; b=MpWPkQ3/WWj+Hqkx4MXoWZe/uu
	ztyzB2MgiYEt11DpaoC99HBB26cAjLqNXKjnXzcD1mGN11wLZ/ywLkQy8UPrYw+E9qdKn0CIiW8Jl
	KB80huevyJrpihgosWPt41a64q4HSEh4UpYb++sjebFw0ksouDHIDLGjW3MftelDcPrv7m1sdYNvX
	vmQr+EmB7iqCq2TlweQRlbIV8aud1KHZCAnYzlwMoKB3+zSL/nN3mBDPpbR33x/hxOsiU/zASWY17
	B0WuoXz8tCXKdk2g5zulLNhIcQiqO0k4zYMcOqbi27tfBNM+1zhdzCPWhCUeOyjkL2RjeP0o4VdJb
	uV/0rsyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piDZs-007Dnh-1E;
	Fri, 31 Mar 2023 12:09:56 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piDZl-007DlS-2A
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 12:09:53 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230331120940euoutp0172b162f380dfdca5bd1474d5f83feea6~Rf7vQK2jg2377023770euoutp01G
	for <linux-nvme@lists.infradead.org>; Fri, 31 Mar 2023 12:09:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230331120940euoutp0172b162f380dfdca5bd1474d5f83feea6~Rf7vQK2jg2377023770euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680264580;
	bh=inqKjYpOQxw0sjlXgN14rMfLP72HbvMwYIz7Fx069HA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UuPM0+lO1twhe51qr0enPcvDopI8ysC4Utrjy6JZNgUyE8P9PlEZyLBf01YarQYdx
	 zMT16zXHF0yLc9wroqZSsrfFQf4UKcbQiBn1L6ZQiS6Z5E1Ws9P5JFkUPTmtMxOO1P
	 D01+pF6zBUK1jrSZE8JhhzDisphjcqUkikyqeHGQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230331120940eucas1p2ee79ba98a8264df82f702fe3788fc75a~Rf7vHAE0M0055200552eucas1p2X;
	Fri, 31 Mar 2023 12:09:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 9D.8C.10014.48DC6246; Fri, 31
	Mar 2023 13:09:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230331120939eucas1p1e6fd3e1ed0dbcc32e847d43d316cd704~Rf7uhpV800541005410eucas1p1V;
	Fri, 31 Mar 2023 12:09:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230331120939eusmtrp1eb99567c8ca3553e7ee7689e11e75d68~Rf7uhJJZ11640016400eusmtrp1C;
	Fri, 31 Mar 2023 12:09:39 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-e5-6426cd8473a7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.BC.09583.38DC6246; Fri, 31
	Mar 2023 13:09:39 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230331120939eusmtip2f1c0709325d377f935d996c918b810f4~Rf7uV99v02402824028eusmtip26;
	Fri, 31 Mar 2023 12:09:39 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 31 Mar 2023 13:09:38 +0100
Date: Fri, 31 Mar 2023 14:01:22 +0200
From: Pankaj Raghav <p.raghav@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: Olav Gjerde <olav@backupbay.com>, <linux-nvme@lists.infradead.org>
Subject: Re: Intel P4608 (Oracle f640) doesn't show both NVMe devices.
 globally duplicate IDs for nsid
Message-ID: <20230331120100.4tcmcnzgwmsalau4@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCRbC8I3R7aZK9g4@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87otZ9VSDK4/ELKYdOgao8X8ZU/Z
	LVZciXRg9jiy7Qq7x6ZVnWwem5fUBzBHcdmkpOZklqUW6dslcGUcWjyJvaCRp+LDjGlMDYyH
	ObsYOTkkBEwkGuffZO5i5OIQEljBKNH27hwbhPOFUWLCt1Z2COczo8TxI/NZYFoeX2uCSiwH
	atl1kwWuauLb91DOFkaJPY1trCAtLAKqEv0vvzN2MXJwsAloSTR2soOERQSUJe7OnwlWwizg
	JjF/1ms2EFtYIEOiZdIuRhCbF2jbpyun2CBsQYmTM5+wQNTrSCzY/YkNZCSzgLTE8n8cIGFO
	AXuJLfN6WCEOVZJo2HwG6uhaiVNbbjGBnCYhsINDov/+P0aIhIvEttf32CBsYYlXx7ewQ9gy
	Eqcn90A1V0s8vfGbGaK5hVGif+d6sMUSAtYSfWdyIGocJdY0nmCGCPNJ3HgrCHEmn8SkbdOh
	wrwSHW1CENVqEjuatjJOYFSeheSxWUgem4Xw2AJG5lWM4qmlxbnpqcXGeanlesWJucWleel6
	yfm5mxiByeL0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd5CY9UUId6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUzilu2vGVXuGipvPt+cIJ1VrFr7zGCv87MD
	nB81jzOEMiSfD5Jb8a2t6uCrFQ+LpeRPcfXdW/ZA3ef0z/OXMjvK9oRGPZPhzNE+n6T/1Mqa
	zTDo/UZfn9p7v7bM6pq0pWqp4YGIiUfe/J/MzFFjkT75ZJSHbHGalMz1f7vbf2tK9bpoHOvu
	S3YXKUwwXbFi0dGObcJ/k8TrumfdP8TNLRU4RW+vROPBmVP/FPUlKW9b//gxs/ru5rf3yuZl
	aDT81Y0M0eP39Z2/Pjznw1ahoN5/Wxp61O0XWVQnLOAySks+23jn1+qo1Zubd7nIfjoQ4P5r
	8iYmiZxGoW8PTnGYN08WPMTCNGHyUr0rIk827VJiKc5INNRiLipOBAB0noC5hQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Pd3ms2opBr8u6lpMOnSN0WL+sqfs
	FiuuRDowexzZdoXdY9OqTjaPzUvqA5ij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3N
	Y62MTJX07WxSUnMyy1KL9O0S9DIOLZ7EXtDIU/FhxjSmBsbDnF2MnBwSAiYSj681sXcxcnEI
	CSxllPjVd5EJIiEj8enKR3YIW1jiz7UuNoiij4wStx90soIkhAS2MEqc2+kFYrMIqEr0v/zO
	2MXIwcEmoCXR2AnWKyKgLHF3/kywcmYBN4n5s16zgdjCAhkSLZN2MYLYvEBHfLpyCmp+K6PE
	8ul72SESghInZz5hgWjWkViw+xMbyHxmAWmJ5f84QMKcAvYSW+b1sELcqSTRsPkMC4RdK/H5
	7zPGCYzCs5BMmoVk0iyESQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExsy2Yz+37GBc
	+eqj3iFGJg7GQ4wSHMxKIryFxqopQrwpiZVVqUX58UWlOanFhxhNgSExkVlKNDkfGLV5JfGG
	ZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MertsC42tdewfX9vzJ3aT
	94fmnhgec4PmvRrmrGu2vN/bPo/niRRb838Jh2LpZV8+r8x3KzzbXFkZXnZ+Fp+Hj6zxxOdR
	/2LfHfl2eaFp+drLqt5z90z9KtUoY2GwRuNxdrPSswVspw1fKUwVvVJXpSwb+HXzLOciwzZ3
	lvhjOZKGrPWsOxmLms9NlVbS5j3Dr8Rze2JhqtHVI59U3P4/ONU25aIzS+O+dIWAXSaCX5fa
	5RxcnXy3/ldvYtYJFq69nBc2hCq4TX2gee9T5q/3pSbT/Zs2Hu+XieS1yMjVOCR0RVQ3ICay
	qPJ1yl0RbuXDXb/m3tok+dvdf4GuVJr1GpMTFQnnmjUFS13CZyqxFGckGmoxFxUnAgB9BsIT
	IgMAAA==
X-CMS-MailID: 20230331120939eucas1p1e6fd3e1ed0dbcc32e847d43d316cd704
X-Msg-Generator: CA
X-RootMTR: 20230331120939eucas1p1e6fd3e1ed0dbcc32e847d43d316cd704
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230331120939eucas1p1e6fd3e1ed0dbcc32e847d43d316cd704
References: <CAJ7kQyGTc_+ajkTGKKsyvazWRFud3P71Nv2U_bcqAnhL9yS=ZA@mail.gmail.com>
	<ZCRbC8I3R7aZK9g4@kbusch-mbp.dhcp.thefacebook.com>
	<CGME20230331120939eucas1p1e6fd3e1ed0dbcc32e847d43d316cd704@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_050950_321886_3C220F14 
X-CRM114-Status: GOOD (  20.70  )
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

On Wed, Mar 29, 2023 at 09:36:43AM -0600, Keith Busch wrote:
> On Wed, Mar 29, 2023 at 12:36:23PM +0200, Olav Gjerde wrote:
> > Hi,
> > 
> > I just upgraded to debian-testing which runs Linux 6.1 on a machine
> > here and I have trouble with my NVME card which has two NVMe drives. I
> > find the following error message in
> > dmesg: nvme nvme2: globally duplicate IDs for nsid 1
> > 
> > I googled this error message and came over the explanation here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216049
> > 
> > lspci returns this,
> > 
> > 87:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> > Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> > 88:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> > Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> > 
> > I have checked the master source code, and I see no changes recently,
> > so my guess is that the fix is adding NVME_QUIRK_BOGUS_NID
> > to the following section:
> > { PCI_VDEVICE(INTEL, 0x0a54), /* Intel P4500/P4600 */
> >      .driver_data = NVME_QUIRK_STRIPE_SIZE |
> >      NVME_QUIRK_DEALLOCATE_ZEROES |
> >       NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> > 
> > in drivers/nvme/host/pci.c
> 
> Yeah, NVME_QUIRK_BOGUS_NID is needed. The only problem is this particular model
> shares the same VID:DID as the 4500/4600 that do not have this problem. I guess
> none of them get to use those features...
Can this be then moved to core_quirks in core.c then with its specific mn?
> 

