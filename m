Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD95C05027
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gf2biH6p+ntq6+hOEzKJBPe2WZky+Gy7HkVuBeMd2cc=; b=nP0uvxGGk2eRlZhDM07VjReGtk
	dnsY3pMneGMZjIX5E+EOcq2LZVdKdlKPClmY+epyQmg24j87tAhuZo6Df1P7BhA7xuZS9P2BHc7fc
	D/DOPX/NO7erMtzKOvU8x7/PeEhaU5J9fqG54JH87JX9byJujmddhnZITbHoZY7VEP039H1hAcojt
	h8mgqtJ1I42DXEWptBdMvFhCpMdF0Nm3LUMtvhwigZ5O96BYmsfY6W/31qoA0soTTfJIRTQqS3Yar
	+kn3ceNy9C30JZtIGuyDFYa1sgDNY/RLQ8QNNPafxtL7UwXdQ3nzGm/bBdM9JD7f4v4yeQAK26bxw
	BrbaQlGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP24n-008hkB-EX; Mon, 06 Feb 2023 14:02:33 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP24j-008hj2-AU
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 14:02:31 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230206140222euoutp01f614e9aa1177358cf710bb2a108ad3a7~BQSAX8AT-2440924409euoutp01e
	for <linux-nvme@lists.infradead.org>; Mon,  6 Feb 2023 14:02:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230206140222euoutp01f614e9aa1177358cf710bb2a108ad3a7~BQSAX8AT-2440924409euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675692142;
	bh=gf2biH6p+ntq6+hOEzKJBPe2WZky+Gy7HkVuBeMd2cc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Wve8Li8fV0fMXq2fYaGzLwbG/Di9MK70yzxtkHfk6zimwo1365d6pO0cpVfyk0/0f
	 5uXPYuAl15ifk3UScsnbXdwB1WI0fMVZQMK0A+XH3rfG4TDtkLvYq08QmFiONFNAG0
	 JyMbgZKJsqby2Yv5y0Yj6aBbg9J1M3WfGmiwMq2I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230206140222eucas1p1533c7896a016fe707f9c7b5007e2421e~BQR-9CJ3H1568315683eucas1p19;
	Mon,  6 Feb 2023 14:02:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id AF.08.01471.D6801E36; Mon,  6
	Feb 2023 14:02:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230206140221eucas1p1bff11da016d90a450b0f5dfd7359e7cb~BQR-rklgA0921509215eucas1p1t;
	Mon,  6 Feb 2023 14:02:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230206140221eusmtrp1381abc14f27c837e288a190f8998d7fd~BQR-q3Rg82568325683eusmtrp1v;
	Mon,  6 Feb 2023 14:02:21 +0000 (GMT)
X-AuditID: cbfec7f2-29bff700000105bf-39-63e1086dda3f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.49.02722.D6801E36; Mon,  6
	Feb 2023 14:02:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230206140221eusmtip2b310724fd6f200233193253c6b23af9e~BQR-g6VQB0951409514eusmtip2R;
	Mon,  6 Feb 2023 14:02:21 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 6 Feb 2023 14:02:20 +0000
Date: Mon, 6 Feb 2023 15:02:20 +0100
From: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "Lewis, Nathaniel"
	<Nathaniel.Lewis@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd1cjofJBu87rCxWrj7KZDHp0DVG
	i/nLnrJbPDlylN3i8LV+dot1r9+zOLB5nL+3kcVj06pONo/NS+o9dt9sYPNon7CTOYA1issm
	JTUnsyy1SN8ugSvj5bnvTAXTRCuevFzO2MB4VrCLkZNDQsBEYs3ndaxdjFwcQgIrGCW2tN1h
	g3C+MEo0zzvLDuF8ZpS4uvI6C0zLgWULmCESyxkltjV/QahqaJoINWwzo8SXHzOYQVpYBFQk
	3gE9AGKzCVhKbHzfywZiiwiYSnxqbmcBaWAWeMQosbNzD1iRsICNxOxvF8H28QrYSty+/oUV
	whaUODnzCVicWcBKovNDE1CcA8iWllj+jwMkzCkQK7H6/CFmiFOVJB6/eMsIYddKnNpyiwlk
	l4TAAw6J83PmQCVcJP613WCDsIUlXh3fwg5hy0icntwD9XO2xMUz3VBDSyQWvz/GDLJXQsBa
	ou9MDkTYUeLEtyuMEGE+iRtvBSGu5JOYtG06VDWvREebEES1msSOpq2MExiVZyH5axaSv2Yh
	/LWAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYIo5/e/4px2Mc1991DvEyMTBeIhR
	goNZSYTX9MCDZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTByc
	Ug1MU6e9ypy99Xds+VaBUoXUrz+uKJrf4S0zduIJ7eETuWW6zCX5e0R90VIXrmk8E66YNYa9
	ZZp7rdEjW93vqWRL1PIvntP9DrdH6AduOHOlrZ/5jJ1DmcWyeGvD6MaVTjU75jWfjLzmvORt
	WS7nIff9Sq12v563P8i5knldomOe4ZOH5Yf0zyr7Pc66bcS1MXrNzAXKezZtnCqz5H+K6YlT
	wRvyG9YqPioL3/Q8lbk+sieUubLI9L7a8baPU6bkH1TmWPAyz9824+QDvraQ4I+3HP4KXT/5
	6qaju9CTlWtV2a+HPFV691L3yzGFBoEffUbbrrEzvLR7sWvnZe6zx9L/fpuZk2F8t0Fh4YuW
	Kj1DJZbijERDLeai4kQAn9ipyaADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xe7q5HA+TDa51qVusXH2UyWLSoWuM
	FvOXPWW3eHLkKLvF4Wv97BbrXr9ncWDzOH9vI4vHplWdbB6bl9R77L7ZwObRPmEncwBrlJ5N
	UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gy3PfmQqm
	iVY8ebmcsYHxrGAXIyeHhICJxIFlC5i7GLk4hASWMkoc/viXHSIhI/HpykcoW1jiz7UuNoii
	j4wS9z+eZYdwNjNKdFy5xAhSxSKgIvEO6BMQm03AUmLj+142EFtEwFTiU3M7C0gDs8AjRomd
	nXvAioQFbCRmf7vIAmLzCthK3L7+hRViajerxOvtn5ggEoISJ2c+AStiFrCQmDn/PFAzB5At
	LbH8HwdImFMgVmL1+UPMEKcqSTx+8ZYRwq6V+Pz3GeMERuFZSCbNQjJpFsKkBYzMqxhFUkuL
	c9Nziw31ihNzi0vz0vWS83M3MQKjbduxn5t3MM579VHvECMTB+MhRgkOZiURXtMDD5KFeFMS
	K6tSi/Lji0pzUosPMZoCw2Iis5Rocj4w3vNK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tS
	s1NTC1KLYPqYODilGph4Z9kqvl5md9mtdfqLS8ndU3V/T3/nYfLrbz4LwzoNPrmlB22aVsW3
	7H25dL41f1iL9tujnRPKMq4euPV9v59mzNG7K1MWsBc5mtV+YDWpmNfmcjF4ybpLx58siY1y
	mjQ74B+n8ZqfQl9Xp7IdMo/dttN47+3wFbJzjv+OVrXbn1+ZetxDvVaux6hpcaf7xR9tk3f0
	3Nx22Ci26bHn8hUKr7daHyyZ8OOhyTovVuf2iM3BokerL55KaHJg8dMr+r2ovoLb8/NuRoYz
	+/i86tzOzficyTan3qTn+63+19ymmq/4Kk8fjFrBFrjduDxoZq/2xrm3T/Cp+ndYhD7sMBQ+
	X/9x6YYrjx9Fqt1583yREktxRqKhFnNRcSIAqiH0KT8DAAA=
X-CMS-MailID: 20230206140221eucas1p1bff11da016d90a450b0f5dfd7359e7cb
X-Msg-Generator: CA
X-RootMTR: 20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a
References: <20230131085828.GB3139@lst.de>
	<Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
	<BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
	<20230202101818.GB14931@lst.de>
	<BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
	<BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
	<CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
	<BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_060229_958704_375CCC28 
X-CRM114-Status: GOOD (  14.58  )
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

On 03.02.2023 18:45, Grochowski, Maciej wrote:
>> > I run remove/rescan for this Samsung PM1733 and it looks like it works
>> > fine on both 5.15 and 6.1.9
>>
>> Sounds like the Samsung wants a longer, non-standard delay between SBR and reinit.
>
>Thanks for the suggestion.
>
>Hi Javier:
>
>We have 2 Samsung NVMe drives: PM9A3 and PM1733
>When we issue fatal AER via aer_inject these driver are not able to recover due to the
>"Unable to change power state from D3cold to D0, device inaccessible"
>
>Repeated log from previous mail (this is consistent behavior on 5.15 and 6.1 kernel)
>```
>[  334.527200] pcieport 0000:00:03.4: aer_inject: Injecting errors 00000000/00004000 into device 0000:0b:00.0
>[  334.537072] pcieport 0000:00:03.4: AER: Uncorrected (Fatal) error received: 0000:0b:00.0
>[  334.545320] nvme 0000:0b:00.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
>[  334.556682] pcieport 0000:00:03.4: AER: broadcast error_detected message
>[  334.563467] nvme nvme5: frozen state error detected, reset controller
>[  334.615434] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 0
>[  335.655445] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 1008
>[  335.663647] pcieport 0000:00:03.4: AER: Root Port link has been reset (0)
>[  335.670523] pcieport 0000:00:03.4: AER: broadcast slot_reset message
>[  335.676954] nvme nvme5: restart after slot reset
>[  335.684371] nvme 0000:0b:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x10a)
>[  336.427724] nvme 0000:0b:00.0: restoring config space at offset 0x8 (was 0xffffffff, writing 0x1080200)
>[  336.437510] nvme 0000:0b:00.0: restoring config space at offset 0x4 (was 0xffffffff, writing 0x100406)
>[  336.447215] nvme 0000:0b:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0xa824144d)
>[  336.457117] pcieport 0000:00:03.4: AER: broadcast resume message
>[  336.479575] nvme 0000:0b:00.0: Unable to change power state from D3cold to D0, device inaccessible
>[  336.494264] nvme nvme5: Removing after probe failure status: -19
>[  336.535861] pcieport 0000:00:03.4: AER: device recovery successful
>[  336.535899] nvme 0000:0b:00.0: vgaarb: pci_notify
>[  336.691465] pci 0000:0b:00.0: vgaarb: pci_notify
>```
>
>Same experiment for other NVMe vendors seems to works fine (I tried on KIOXIA NVME)
>is that something you can take a look at?

Thanks for the note Maciej. I will report this internally.

Keith, Christoph,

Is there a chance we can get a quirk for this for this FW. Seems like an
issue on our side that is creating problems.

Thanks,
Javier

