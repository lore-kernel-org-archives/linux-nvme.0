Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8633C05027
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yABXWTe15cfWW6BHd3dxTmuzIwbo+wH5UwtQHf6qb8w=; b=SmVPhUPAalbnCyHucceMNOLEHa
	Ttsk8DN3E1nhikCnwjwfz5d+njZR+3G1I1bbbGRti7VqWqVjCL29LArtWtKVLfTFvf3oLLic6W5VT
	kD3ejmBFCl2XgipI+RwpCfr1C0lMCI/aDpWIH/QizEquaEK6uJeDQrayubh0T3uwSktp780+mgW+Q
	ixJrZfnmV9O++S1Uw4Pr6NyUv0A5nGc0MJX/FvDixaSa6LfEyLNWMIdqM500AMUESsRrZKsOR+bfP
	RV/QSvj0AcpGS83eiUBGanVSNKidkYwbzML5cJldaDDFSeuuIqnKEQH6o9g8WGi1H2T+yztbSmqVA
	ASg3GYBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP5eq-009Yi9-LM; Mon, 06 Feb 2023 17:52:00 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP5ek-009Ygp-AW
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 17:51:58 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230206175144euoutp0107826f07e1ff537415c23a9567c9845a~BTaRfEXDJ0345703457euoutp01O
	for <linux-nvme@lists.infradead.org>; Mon,  6 Feb 2023 17:51:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230206175144euoutp0107826f07e1ff537415c23a9567c9845a~BTaRfEXDJ0345703457euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675705904;
	bh=yABXWTe15cfWW6BHd3dxTmuzIwbo+wH5UwtQHf6qb8w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sYGBLjwWC8hUj83Y46dsq2q7Bm0xpMDnDOr3B/vf7onjrc23RsLA2zVvRx2tEkfCg
	 h5UVsvvC7VvgpGiaqMpWiLYa7I2gljnD5w0QflhxtMHY8m3QPnKrqXuWAYufHEpoMZ
	 dOkMx54IrO+FmI/jTer8wwJL1ZimhZaxRKmaJHe4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230206175144eucas1p126a3eebb4ab62c4c6a95265cf9c27958~BTaQ9DIxJ2470024700eucas1p1T;
	Mon,  6 Feb 2023 17:51:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.97.61197.F2E31E36; Mon,  6
	Feb 2023 17:51:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230206175143eucas1p2526f4b91925c9dcadb519bf505767ff9~BTaQlaZZ-1964619646eucas1p2Z;
	Mon,  6 Feb 2023 17:51:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230206175143eusmtrp1dcfe01e506bea431ce064c0c2454bda3~BTaQk1oT30593305933eusmtrp1I;
	Mon,  6 Feb 2023 17:51:43 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-e4-63e13e2f708c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 1A.E7.02722.F2E31E36; Mon,  6
	Feb 2023 17:51:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230206175143eusmtip10d940d9521085856a7b56d7030e73e06~BTaQbEBgx3003030030eusmtip1R;
	Mon,  6 Feb 2023 17:51:43 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 6 Feb 2023 17:51:42 +0000
Date: Mon, 6 Feb 2023 18:51:42 +0100
From: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "Grochowski, Maciej"
	<Maciej.Grochowski@sony.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Lewis,
 Nathaniel" <Nathaniel.Lewis@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzneV0Du4fJBrP3M1qsXH2UyWLSoWuM
	FvOXPWW3eHLkKLvF4Wv97BbrXr9ncWDzOH9vI4vHplWdbB6bl9R77L7ZwObRPmEncwBrFJdN
	SmpOZllqkb5dAlfG08MLmAvWC1TcmLmLpYGxm7eLkZNDQsBE4mPTI8YuRi4OIYEVjBL/1vyF
	cr4wSlz4MZkFwvnMKHF6+UNGmJa5e9uZIRLLGSWady5hhqvafXcvO0iVkMAWRomp9yS7GDk4
	WARUJE6uVAEJswlYSmx838sGYosIKEvcnT+TFaSXGWRd75bDzCAJYQEbidnfLrKA2LwCthIL
	771gh7AFJU7OfAIWZxawkuj80MQKMp9ZQFpi+T8OkDCngJbEjb+r2EHCEkDzl0/3hbi5VuLU
	lltMIKskBJ5wSDROu8cGUeMi8XQbNCiEJV4d38IOYctInJ7cwwJhZ0tcPNPNDGGXSCx+f4wZ
	otVaou9MDkTYUeLEtyuMEGE+iRtvBSFu5JOYtG06VDWvREebEES1msSOpq2MExiVZyH5ahaS
	r2YhfLWAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYGo5/e/41x2MK1591DvEyMTB
	eIhRgoNZSYTX9MCDZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2Cy
	TBycUg1MpV3m5/NePH8ZcatnqzSTjsXsT8uqSh/LHEn+nPMnqChE8OOmx1c+Tdss6Nc+8Yxg
	dNVym0uc6wMy48NMvh8u6KhiYMo69XA527PqVq5yg2IWPqnAFS2//zOZLHeZ2jjnyou7XBp1
	j+/9qIl+GLn44ZbqS5esdv3Nr93xn/Hy9rqlx1aa/b56TMYtcC/PyrJHX7LkvvC1HNOoedVw
	5eX39M2eCUll5Wc2t5fNnnKrqu74Z32myNN1gt/OcJkc/7VPuosrNuJfn//tU4Iyh27Ft1yS
	8FBcs+/F8kM/Qp0vcl+5N+O4wf/aWzwiucryhwt6uZ8Wa+/enRY3wXPTWcsdHhcqmFlivqY4
	tJ9oi6ksUGIpzkg01GIuKk4EAFY29fqcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7r6dg+TDTZ81rJYufook8WkQ9cY
	LeYve8pu8eTIUXaLw9f62S3WvX7P4sDmcf7eRhaPTas62Tw2L6n32H2zgc2jfcJO5gDWKD2b
	ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mp4cXMBes
	F6i4MXMXSwNjN28XIyeHhICJxNy97cwgtpDAUkaJ/Tc0IeIyEp+ufGSHsIUl/lzrYuti5AKq
	+cgo0bZ2HRNEwxZGiU33gGwODhYBFYmTK1VAwmwClhIb3/eygdgiAsoSd+fPZAXpZRb4wijR
	u+Uw2DJhARuJ2d8usoDYvAK2EgvvvWCHWHCDReLLkRVMEAlBiZMzn4AVMQtYSMycf54RZBmz
	gLTE8n8cIGFOAS2JG39XsYOEJYCWLZ/uC3FzrcTnv88YJzAKz0IyaBaSQbMQBi1gZF7FKJJa
	WpybnltsqFecmFtcmpeul5yfu4kRGGXbjv3cvINx3quPeocYmTgYDzFKcDArifCaHniQLMSb
	klhZlVqUH19UmpNafIjRFBgSE5mlRJPzgXGeVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5Y
	kpqdmlqQWgTTx8TBKdXAVHf1aYlK90qR2ULXEg88n9LKH3hrt7RtSPu7WQvOTVRfwiu09/zV
	o9ftZSddfX3AeY25VDxj0/Yf0WnX7zjZZD9t77lwIkw9zuXHuu3+nGv9sw9cNXK5V9vVNpe1
	wyn8Avtdq6icqLvy2/ca5dTMWNP1hNOofHHinLfGG1T3qDvsDs5eUNFvdVayyvX9DO6JRkYv
	s0+v8NgceXEHwyOGBwdulD9269zdKfjd+cOGnwVbLx4KdVjV+vPYgSNuvSGHf4Y+v5fUuK09
	98nfe0+2nbzEs1zo+8QzV94x7plnkaP27cHUqS1pK24w8kae95Mtfrtv9q/4rR0znqp0PGTw
	7/HtPbRTeIvU81cv97VJJH1WYinOSDTUYi4qTgQA4QkDYDsDAAA=
X-CMS-MailID: 20230206175143eucas1p2526f4b91925c9dcadb519bf505767ff9
X-Msg-Generator: CA
X-RootMTR: 20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a
References: <20230202101818.GB14931@lst.de>
	<BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
	<BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
	<CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
	<BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<20230206140220.6af2b6k7belue2nh@ArmHalley.local>
	<20230206154218.GA12556@lst.de> <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_095155_764446_0C64A819 
X-CRM114-Status: GOOD (  20.30  )
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

On 06.02.2023 09:22, Keith Busch wrote:
>On Mon, Feb 06, 2023 at 04:42:18PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 06, 2023 at 03:02:20PM +0100, Javier.gonz@samsung.com wrote:
>> > Is there a chance we can get a quirk for this for this FW. Seems like an
>> > issue on our side that is creating problems.
>>
>> So waht would the quirk look like?  This would have to be something in
>> the core PCIe code, not NVMe as far as I can tell.

Yes. I was wondering if you had a reason for this not being a good idea.

>
>Yeah, I'm assuming it's a PCI level quirk because the remove-rescan was
>successful at reinitializing. The remove-rescan should do a very similiar
>config space setup and nvme startup as an AER recovery, so I'm guessing this is
>a matter of timing. If so, the below is how I'd imagine the quirk may look.

Thanks Keith. Let me try this out. I need to reproduce this first.

Maciej: It would be helpful if you can try this at your end.

>But if this idea isn't successful, it'd be bit a more work to figure out what
>sequence this device wants to happen in order to complete recovery.

Ok. Thanks!

>
>---
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index fba95486caaf2..f642e7029e0e9 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -5054,7 +5054,10 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> 	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
> 	 * this to 2ms to ensure that we meet the minimum requirement.
> 	 */
>-	msleep(2);
>+	if (dev->quirks & <NEW_SB_DELAY_QUIRK_BIT>)
>+		msleep(100);
>+	else
>+		msleep(2);
>
> 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>@@ -5066,7 +5069,10 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> 	 * be re-initialized.  PCIe has some ways to shorten this,
> 	 * but we don't make use of them yet.
> 	 */
>-	ssleep(1);
>+	if (dev->quirks & <NEW_SB_DELAY_QUIRK_BIT>)
>+		ssleep(5);
>+	else
>+		ssleep(1);
> }
>
> void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>--

