Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED2BC05027
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6cLImqBNhFBFlLKNdHhWTCVGOvggrnKTF/qZcJLa2Bs=; b=i2fZ/+KN5EbdjC49ZXIyiOKxbI
	a7M566aZT3Ws3sUzJS6p6LI9Y8bfe3jnDPe8XacXGHV7tGt5H46d2DWPGuEwPjCSDrn5mjGX5Ynu8
	gGt2BCpGD2h8HOD4jkO2qpPydsrKTzauySxnfgdBhwphXTC+Cr4ihcb0aMwSeOzMYj3cD5shVqBBx
	EkyI6tyHT6O3YZ4VlcAwBysPV7t8mzLc93/iyxigNPsEynICdYBXhuipvgrzJhCY3KNuRn7g0dSx/
	YHP5icxDfhY30tqh1X/OjOh0taBCHRnuZbRBR06AIrXX2tbtji0l0I/lMRMLIVYyCzqkoHY7oH3qK
	HbYRn1Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ1nS-000UIR-Dg; Thu, 09 Feb 2023 07:56:46 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ1nK-000UHe-I5
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 07:56:41 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230209075630euoutp01dead2a7e444a69a633bf81fc43c4691c~CGObARaCL1128511285euoutp013
	for <linux-nvme@lists.infradead.org>; Thu,  9 Feb 2023 07:56:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230209075630euoutp01dead2a7e444a69a633bf81fc43c4691c~CGObARaCL1128511285euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675929390;
	bh=6cLImqBNhFBFlLKNdHhWTCVGOvggrnKTF/qZcJLa2Bs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G4m633+U5HhOsdbChBHZErzKSZQHClHglap5kejMIhucW6LaTHl/+1l6zKmX6QXP8
	 V8Eow4u0kf0fOmCSM4oHiSsZjNwif2Mleuvkn9as3mx8aQMIBZX4G3VGuXyTAU+kuk
	 IxmaYP+oZ3GZEq7iCIFI3Snc2+3kFncE6K0Mzz/k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230209075630eucas1p2f4a63a53ecf36b1cb5e452d91282f588~CGOarpWEk1540615406eucas1p2m;
	Thu,  9 Feb 2023 07:56:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 84.F9.01471.E27A4E36; Thu,  9
	Feb 2023 07:56:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230209075629eucas1p1454c7716c86345ddaea04fd43a65503d~CGOaWEh2Z3143731437eucas1p1n;
	Thu,  9 Feb 2023 07:56:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230209075629eusmtrp220f04e244c33740d7914f2165a39d7c3~CGOaVZaJK2040420404eusmtrp2D;
	Thu,  9 Feb 2023 07:56:29 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-f7-63e4a72e8c6a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id FB.F2.02722.D27A4E36; Thu,  9
	Feb 2023 07:56:29 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230209075629eusmtip195f86d63d1e4fb86f8bdb66823742e7b~CGOaL_cdR0416404164eusmtip15;
	Thu,  9 Feb 2023 07:56:29 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 9 Feb 2023 07:56:28 +0000
Date: Thu, 9 Feb 2023 08:55:12 +0100
From: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
CC: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
	Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Lewis,
 Nathaniel" <Nathaniel.Lewis@sony.com>, Kanchan Joshi <joshi.k@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230209075512.qan5yr4vmrgkyibv@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2486D58DB73FCE8D13A947EC81D89@BYAPR13MB2486.namprd13.prod.outlook.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7p6y58kG5xvELJYufook8X+g99Y
	LSYdusZoMX/ZU3aLJ0eOslscvtbPbrHu9XsWB3aP8/c2snic23Ge3WPTqk42j81L6j1232xg
	82ifsJM5gC2KyyYlNSezLLVI3y6BK2P582dMBasUKpY8ms7awNgq3cXIySEhYCJx79AJ9i5G
	Lg4hgRWMEj/P/WaCcL4wSsy5eBzK+cwosbp/PjtMy45dl6FaljNKfJy+jBWuauvye1DOZkaJ
	p29vsoK0sAioSEw42QtmswlYSmx838sGYosImEp8am5nAWlgFrjAJLFy1mUWkISwgI3E7G8X
	wWxeAVuJ7YvPs0LYghInZz4BizMLWEl0fmgCinMA2dISy/9xgJicArESSw9zQ1yqJPH4xVtG
	CLtW4tSWW2DvSAh84JCYtuccM0TCRWL9n5dsELawxKvjW6DelJH4v3M+E4SdLXHxTDdUfYnE
	4vfHmEF2SQhYS/SdyYEIO0oc7/nMDhHmk7jxVhDiSD6JSdumQ1XzSnS0CUFUq0nsaNrKOIFR
	eRaSt2YheWsWwlsLGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCad0/+Of9rBOPfV
	R71DjEwcjIcYJTiYlUR4v098nCzEm5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2
	ampBahFMlomDU6qByX/BFduzS+yabQMOcHqeXZfV/r3gpvERbi12868dW1XNrc/JM6xecOiu
	bNap04+05CZ8NX2z6220T+dv1ZNzjmosUc59e7Br351jGoV8x0+VX15YlNSw9cQ1mzmZOuvj
	TXZsivHc8PfplOawVff2cop56629evLQM/3/df8aKh68N+bby8DzXrO2TiyaWUvoeXG7p8uh
	rz+SC+U4bk3MnpHetO5v5LuQcsXFcW3Grlb/OxfvnXnk5/ppoksqxCes5GEIW95v4lHUkRvu
	0xY8uag3msM65e3kRzuKGAu87CWCVsu8WlzwdMHSPIZlGYZrl0Ra6W6W3q62wdJDdr2cKZ+v
	SWeS6BQ5j56m2N98SizFGYmGWsxFxYkAUnPmYakDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7q6y58kGxzcYGGxcvVRJov9B7+x
	Wkw6dI3RYv6yp+wWT44cZbc4fK2f3WLd6/csDuwe5+9tZPE4t+M8u8emVZ1sHpuX1HvsvtnA
	5tE+YSdzAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
	vl2CXsby58+YClYpVCx5NJ21gbFVuouRk0NCwERix67L7F2MXBxCAksZJfYc/coMkZCR+HTl
	IzuELSzx51oXG4gtJPCRUaJ1XwJEw2ZGifftKxhBEiwCKhITTvaygthsApYSG9/3gjWICJhK
	fGpuZwFpYBa4wCSxctZlFpCEsICNxOxvF8FsXgFbie2Lz7NCTJ3GKrF72yJmiISgxMmZT8CK
	mAUsJGbOPw+0jQPIlpZY/o8DxOQUiJVYepgb4lAliccv3jJC2LUSn/8+Y5zAKDwLyaBZSAbN
	Qhi0gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmD0bTv2c/MOxnmvPuodYmTiYDzEKMHB
	rCTC+33i42Qh3pTEyqrUovz4otKc1OJDjKbAoJjILCWanA+M/7ySeEMzA1NDEzNLA1NLM2Ml
	cV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBialc/xc5XsCzzkdbagNKFdOnnfi2/U49vflhbwy
	Ef8t4662XbQWLjiyPfLq5uc76o4yTao9tGWynrZRFO/8U/GBogen1znq28fMZ522VvjI1wV+
	QXvMn5yoEhVe2csisH35cY3TD/Y6NGyeauhS8Plt5LyU24+56ir9vl8xnB3Ff+So9xvB/1s/
	7vt+Ql910/t5XrEXFkXJhBjmPZw5/2zO76bgj89fSV46kr9PiVfgO+uZ70lcQmb/ek7/Sjz0
	pcnwid8DhRu8E+9ZhX9cdF92q4G9dWPTXauQBvXVH3eVzjJyZDxyd9/f+mVtSr9mi91W+H4t
	hOeJ7ULlCydMdfcZNH/m/s/kMXuq/T7uAM2ZSizFGYmGWsxFxYkAthu3NkcDAAA=
X-CMS-MailID: 20230209075629eucas1p1454c7716c86345ddaea04fd43a65503d
X-Msg-Generator: CA
X-RootMTR: 20230208223905eucas1p1e449e737047744e3bc4bdc0c62aa4890
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230208223905eucas1p1e449e737047744e3bc4bdc0c62aa4890
References: <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
	<BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
	<20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
	<Y+IpsEd8kMoljOAa@cormorant.local>
	<BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y+NEe3OWshJeHsNB@cormorant.local>
	<BYAPR13MB248670C9FD77D33422E4368681D89@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y+PeRAFwUkig00cR@kbusch-mbp.dhcp.thefacebook.com>
	<CGME20230208223905eucas1p1e449e737047744e3bc4bdc0c62aa4890@eucas1p1.samsung.com>
	<BYAPR13MB2486D58DB73FCE8D13A947EC81D89@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_235639_193639_282E2439 
X-CRM114-Status: GOOD (  16.77  )
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

On 08.02.2023 22:38, Grochowski, Maciej wrote:
>> Are you observing DPC events during the error injection recovery? I didn't see any in the previous logs.
>
>Correct there was no DPC triggered with error recovery.
>I initially run into issue with NVMe device not being able to recover when DPC event got triggered, and by trying to narrow down what happened I figured that same effect can be caused by injecting fatal aer error via aer-inject.
>
>> If you have DPC enabled, it really doesn't make sense to aer_inject on anything downstream capable ports. Those types of errors would be contained by the DPC hardware; the kernel will get a DPC event instead of an AER.
>
>Understand these two scenarios should be investigated separately. I will remove DPC from the picture then.
>I disabled DPC on my setup and removed kernel option. I run same experiment and I got same results, however by playing with connection to NVMe drive I was able to reproduce same result on KIOXIA.
>
>That lead me to the conclusion that this error may be dependent not on NVMe drive but on connection.
>To prove that I got Samsung PM9A3 in M2 factor (previously my experiments were done on U2 devices connected via SlimSAS or Oculink), interestingly M2 factor PM9A3 is able to recover from such scenario, proof below:
>
>```
>pcieport 0000:80:03.3: aer_inject: Injecting errors 00000000/00040000 into device 0000:84:00.0
>pcieport 0000:80:03.3: AER: Uncorrected (Fatal) error received: 0000:84:00.0
>nvme 0000:84:00.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
>pcieport 0000:80:03.3: AER: broadcast error_detected message
>nvme nvme0: frozen state error detected, reset controller
>pcieport 0000:80:03.3: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 0
>#d0_delay = 100ms
>pcieport 0000:80:03.3: pciehp: pciehp_reset_slot: SLOTCTRL 70 write cmd 1008
>pcieport 0000:80:03.3: AER: Root Port link has been reset (0)
>pcieport 0000:80:03.3: AER: broadcast slot_reset message
>nvme nvme0: restart after slot reset
>nvme 0000:84:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xbc200000)
>nvme 0000:84:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xbc210004)
>nvme 0000:84:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100406)
>pcieport 0000:80:03.3: AER: broadcast resume message
>nvme 0000:84:00.0: saving config space at offset 0x0 (reading 0xa80a144d)
>nvme 0000:84:00.0: saving config space at offset 0x4 (reading 0x100406)
>nvme 0000:84:00.0: saving config space at offset 0x8 (reading 0x1080200)
>nvme 0000:84:00.0: saving config space at offset 0xc (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x10 (reading 0xbc210004)
>nvme 0000:84:00.0: saving config space at offset 0x14 (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x18 (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x1c (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x20 (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x24 (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x28 (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x2c (reading 0xa812144d)
>nvme 0000:84:00.0: saving config space at offset 0x30 (reading 0xbc200000)
>nvme 0000:84:00.0: saving config space at offset 0x34 (reading 0x40)
>nvme 0000:84:00.0: saving config space at offset 0x38 (reading 0x0)
>nvme 0000:84:00.0: saving config space at offset 0x3c (reading 0x1ff)
>nvme nvme0: Shutdown timeout set to 8 seconds
>nvme nvme0: 64/0/0 default/read/poll queues
>pcieport 0000:80:03.3: AER: device recovery successful
>```
>
>So my current conclusion is that this is very likely Hardware related issue not Driver/Software.
>I will dig deeper into it but for this particular thread I think there is not much more we can do.

Thanks for sharing this Maciej.

Our firmware team is investigating the issue and have not been able to
reproduce either. I will ask them to pause this until we have more data.

Seems we do not need a quirk then either.

