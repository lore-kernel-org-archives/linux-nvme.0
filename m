Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9937CC54E71
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQRf8sa+9WldPEN6mF1FnwCn42mPXzl/+1j3nPC5tpg=; b=Zy0ZK1oS5nqK9jW3vDPWFEJtFk
	wHENDK113cM9nVqLVNFeTHdFvMl7BYV0zkbPd/s1SDSBaR3oZ1oZajMyihM7nnecmDMdpsK98Waxe
	YCLwMrgc7s9ey8TTCFX/8sT7ucthDG7L7Eb7CHTxDpJbYJYb11IiBwdUKljlydIynmSQsM8ZyPCAH
	BSJuLaYq9gFrlHfixVPoyxjvEdlbjenJ2AxC5xYbrxKFDX8SwbmXEU1CbFjAs9WoMe8EDNbyaKPJI
	73bdM9AhCet4IXs0EQkS83/4RuKlXJaN/8Z8iRTOnq4duNZ6z9YXkVHGyXHnGRNBaXin8MX1Oyrhe
	SmU56Tmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjGUl-0000000F3iN-3r8N;
	Wed, 28 Aug 2024 11:05:47 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjGRs-0000000F33y-0kne
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 11:03:00 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240828110242euoutp02df2d53679f87472bc20185dcc4b62d49~v34kbVf4E2959029590euoutp02J
	for <linux-nvme@lists.infradead.org>; Wed, 28 Aug 2024 11:02:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240828110242euoutp02df2d53679f87472bc20185dcc4b62d49~v34kbVf4E2959029590euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724842962;
	bh=DQRf8sa+9WldPEN6mF1FnwCn42mPXzl/+1j3nPC5tpg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EhVSfTRQ0lEQNPaDGhK8zSNPMLquPkEpecpUlfUoKvgRBsJPtxIyscs4sHvTEErJA
	 B9YHPIhrYH/CelcttTvZKIkxnwI/aN1wS24IVGJtLv/1kESfGKZ6oUIg1qsKJ6AoEU
	 6zNKNjUQSNy9LujLJnLwzpZFiXACMPrLo7hCMJ9c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240828110242eucas1p1e97f35a9323d2353f4ef0665970acfcf~v34kOmYNa1193511935eucas1p1K;
	Wed, 28 Aug 2024 11:02:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.E7.09875.1D30FC66; Wed, 28
	Aug 2024 12:02:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240828110241eucas1p2f237730e7ac898a732309978a4b1d10c~v34jtf40O1271212712eucas1p22;
	Wed, 28 Aug 2024 11:02:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828110241eusmtrp1b8c7af4cad45e402bbd0bf963005b2e5~v34jsOgXY0653006530eusmtrp1w;
	Wed, 28 Aug 2024 11:02:41 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-7e-66cf03d1d2f0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E4.6E.08810.1D30FC66; Wed, 28
	Aug 2024 12:02:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828110241eusmtip1def6386c765cdbee79315dd7ff10b9de~v34japGLD0491604916eusmtip1q;
	Wed, 28 Aug 2024 11:02:41 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 28 Aug 2024 12:02:41 +0100
Date: Wed, 28 Aug 2024 13:02:39 +0200
From: "javier.gonz@samsung.com" <javier.gonz@samsung.com>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
CC: Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Message-ID: <20240828110239.hnljbiow2zbaduhu@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87oXmc+nGbT1WFj833OMzWLl6qNM
	FpMOXWO0uLxrDpvF/GVP2S2WLj/GbLHu9XsWiwUbHzE6cHhMbH7H7nH+3kYWj02rOtk8Ni+p
	99h9s4HN4+PTWywenzfJBbBHcdmkpOZklqUW6dslcGWs+neIuWAVZ8Xm3XOZGxi3sHcxcnJI
	CJhIrHxxl7GLkYtDSGAFo8TNzlPsEM4XRol73WtYIZzPjBKr/u1kgWk5s/4lVNVyRol33ReY
	4arOToPp3wLUcnIXWAuLgKrEzH/fWUFsNgFLiR+3LjKD2CICVhLPT9xnA2lgFnjKJHFxwxWw
	hLBAgMSMW3fBbF4BW4m+V6vZIWxBiZMzn4ANZQZq7vzQBDSUA8iWllj+jwMiLC/RvHU2WCun
	gJ1Ex50PzBBnK0k8fvGWEcKulTi15RYTyF4JgXZOic49F1ghEi4SW7a/hbKFJV4dhwWTjMTp
	yT1Q/1dLNJw8AdXcwijR2rEV7AgJAWuJvjM5EKajxOmPPhAmn8SNt4IQp/FJTNo2nRkizCvR
	0SY0gVFlFpK/ZiH5axbCX7OQ/LWAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYII6
	/e/4lx2My1991DvEyMTBeIhRgoNZSYT3xPGzaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5VVPk
	U4UE0hNLUrNTUwtSi2CyTBycUg1Mk5Y0nm2ZMvGsqdaEj8kyxzmXs0qXWqSobPa0Nm7ZtOdm
	jtQ+iViztaKPzvhPles99bT7VIAaMxeTueCcvDmFh4VmCRcmBr22l3m8/dmpH4vuM1yq25z0
	PeLAfrNr95cG/9hmHiTnkaZhctQl/UPwwtlXNOvLBV94Jutn7ZAosOv/YBBbIXb3jv4b2wiO
	vbPdcur46zrEuZnDpxfNWeZm/vpQU19mQuojpbSpZXqHzzA7WOepWGw/IMf9KKpuj5/kJZ3L
	89kCby2Y1a3MILVnnaUYB7dn/a+/01L0g16ZJWrsu/PlrN9h/ldHQ1iVL+3n2/Nlwr8HdyeY
	fco13yPU8GLWBd4Plzx+fVAQePVUiaU4I9FQi7moOBEAEZ1zI78DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7oXmc+nGTR/E7X4v+cYm8XK1UeZ
	LCYdusZocXnXHDaL+cueslssXX6M2WLd6/csFgs2PmJ04PCY2PyO3eP8vY0sHptWdbJ5bF5S
	77H7ZgObx8ent1g8Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
	t7NJSc3JLEst0rdL0MtY9e8Qc8EqzorNu+cyNzBuYe9i5OSQEDCROLP+JZDNxSEksJRRYuXN
	p8wQCRmJjV+uskLYwhJ/rnWxQRR9ZJTY/auDFcLZwihx5ukqNpAqFgFViZn/voN1sAlYSvy4
	dRFskoiAlcTzE/fBupkFnjJJXNxwBSwhLOAn0dLTzAhi8wrYSvS9Wg11xwEmiSvPjzBBJAQl
	Ts58wgJiMwtYSMycfx6ogQPIlpZY/o8DIiwv0bx1NthMTgE7iY47H6BeUJJ4/OItI4RdK/H5
	7zPGCYwis5BMnYVk6iyEqbOQTF3AyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMIa3Hfu5
	eQfjvFcf9Q4xMnEwHmKU4GBWEuE9cfxsmhBvSmJlVWpRfnxRaU5q8SFGU2AYTWSWEk3OByaR
	vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpuKVwiIzpDVUp617
	bR0QtLq+/PuXtos8q7mK1y9usvr0Sy3pv7ZViUv63I1bmZuOT1n9+e7EJ2/PKkxdfzmYWXTS
	pLs/fm1n+bA2ct3U1pt6fSveR+6eliGSz3zEOvvKMu+GC9bMvPmJzVbLPinkH7+/4PttN521
	l7f7uj6ddMUwWqRvyjSpsxP/n89W0lmk6lsY3SfFqVB5v67W2upA8iXLSZtWPTrj0dcnOCl8
	u2z+dKbInE6X/Unbzn6bfKfykeH1qGUMX6dysXSaSk3mESnsK99yKoyn7JXad8vIg3yKtxw7
	gvlMqjPyFz++uKBrumKW6EkhP0fhpPgXE81FD5r6zlVSna/n8vzJhJ0P+ZRYijMSDbWYi4oT
	AcBR011qAwAA
X-CMS-MailID: 20240828110241eucas1p2f237730e7ac898a732309978a4b1d10c
X-Msg-Generator: CA
X-RootMTR: 20230427074641eucas1p185bb564521b6c01366293d20970fdfe2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230427074641eucas1p185bb564521b6c01366293d20970fdfe2
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
	<20230321132604.GA14120@lst.de> <20230414051259.GA11464@lst.de>
	<CGME20230427074641eucas1p185bb564521b6c01366293d20970fdfe2@eucas1p1.samsung.com>
	<20230427073752.3e3spo2vgfxdfcv2@localhost>
	<53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_040248_847536_8EEAF20E 
X-CRM114-Status: GOOD (  18.72  )
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

On 27.08.2024 19:08, Saeed Mirzamohammadi wrote:
>Hi Pankaj/Samsung team,
>
>Sorry for pulling up an old thread. Has this been fixed in the
>firmware? If not, we could fix this issue with quirk for now until it’s
>resolved on the firmware side.

Saeed,

I believe we had concluded that this was a _requested_ feature by
specific customers. Therefore, we would not work on an upstream quirk.

Did I misunderstand?

Thanks,
Javier

>
>Thanks,
>Saeed
>
>
>> On Apr 27, 2023, at 12:37 AM, Pankaj Raghav <p.raghav@samsung.com> wrote:
>>
>> Hi Christoph,
>> On Fri, Apr 14, 2023 at 07:12:59AM +0200, Christoph Hellwig wrote:
>>> On Tue, Mar 21, 2023 at 02:26:04PM +0100, Christoph Hellwig wrote:
>>>> Can you send a patch with a new quirk that just disables the EUI64,
>>>> but keeps the NGUID?
>>>
>>> Did this go anywhere?
>> We had a discussion about this internally with our firmware team, and it
>> looks like these firmware were given to specific customers based on
>> mutual agreement. They are already in discussion with our firmware team
>> regarding this.
>>
>> I don't think this should go into as a generic quirk in Linux for these
>> models.
>

