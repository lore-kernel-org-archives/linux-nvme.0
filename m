Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83599C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+iQsm3hfosqQmSkkVmr8crzsyxw2qkaqPu3if0KTuPs=; b=H3T+OUaKB8VCIukvA/sWzH4lMh
	Kqb60SjvdSEA3t5jZsGfFYtgHZcrYy5U4MwJqp+iA8he4oK6RWOLhtK3FrNF8mN/tEEXwemS/UH+3
	jzVbaVVMi0h7XTh4Evd/aZFD5gU7gWN/OXedNsko91SahJ9Z6wwj1OIbrk/JBno6Yz9roSnwGIban
	p9QEOs9pbqRANLedzzN3VgqPxnb9I8w45dNFOMoR9G+IIaQKL6VToi13Bz9eCQGanDQEvofEDEKSl
	pvgQQXp0gdo64aXMeoTNCbew/3yI+afzsw+s1aoOm5+lC1oDruQeSV4dvXkDeJWpPZCAPU9xVhDc8
	MLijaKUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVRKJ-00GIQK-0X;
	Mon, 14 Aug 2023 06:45:19 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVRKD-00GIOc-2l
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 06:45:17 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230814064455epoutp020ed6b9dcd9b74a7bb12e8c1c43e211fe~7LPBknme82608026080epoutp02g
	for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 06:44:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230814064455epoutp020ed6b9dcd9b74a7bb12e8c1c43e211fe~7LPBknme82608026080epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691995496;
	bh=+iQsm3hfosqQmSkkVmr8crzsyxw2qkaqPu3if0KTuPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Khs7o0HNeyMJqVm/1mz4p0/1sWAUK1Gee87OQZ4MoxB8swZCh7zNaVg5vcN5vqQWg
	 OltzAn0pQuZHTHXaK4IiAM1ZIPLcaFDTRx/SQfgcj30aSGLrrvN6hKrF5ydiNwM5Xq
	 dQ6aofVMdIviSh96WehEewx1lAv8UCFjJ7sJx6s4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230814064455epcas5p2a013c18a7c6d8fae918c9f73ae09215b~7LPBImR6v2656526565epcas5p20;
	Mon, 14 Aug 2023 06:44:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4RPPys5pCkz4x9Q9; Mon, 14 Aug
	2023 06:44:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0A.6D.55522.56DC9D46; Mon, 14 Aug 2023 15:44:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230814064453epcas5p216e308e567a0657e7a519c71c604031c~7LO-EcToY2429724297epcas5p2-;
	Mon, 14 Aug 2023 06:44:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230814064453epsmtrp116f50861ab0be9ab0e924c5a6f70a49e~7LO-Drfcl2107721077epsmtrp1F;
	Mon, 14 Aug 2023 06:44:53 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-70-64d9cd65ead4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.30.34491.56DC9D46; Mon, 14 Aug 2023 15:44:53 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230814064451epsmtip20e0d856471a8a7cdbc5c08f3623ecc0b~7LO87bWky1020810208epsmtip2-;
	Mon, 14 Aug 2023 06:44:50 +0000 (GMT)
Date: Mon, 14 Aug 2023 12:11:30 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <20230814064130.GA6702@green245>
MIME-Version: 1.0
In-Reply-To: <ZNZogPZtHsxi1S10@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmum7q2ZspBi9W61msufKb3WL13X42
	i5sHdjJZrFx9lMni/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM95MvsFcsJmrYtG0t+wNjLs5
	uhg5OSQETCRerTzB0sXIxSEksJtRomvnRHYI5xOjxITVXawQzjdGiZWvT7LAtFzY/wWqZS+j
	xNIju5ggnGeMErtbu5hAqlgEVCV+blvE3MXIwcEmoClxYXIpSFhEQFni7vyZYFOZBd4C1b9/
	xQySEBbwl7i8uhXM5hXQkWj6+5cVwhaUODnzCdhmTgF7idnH14LFRYEGHdh2nAnioi0cEk2b
	tUB2SQi4SOzsY4QIC0u8Or6FHcKWknjZ3wZlJ0tcmnkOqrVE4vGeg1C2vUTrqX6wE5gFMiQW
	7HnGBmHzSfT+fsIEMZ5XoqNNCKJcUeLepKesELa4xMMZS6BsD4kVZ/dCw+cDo0Tn62NMExjl
	ZiH5ZhaSFRC2lUTnhybWWUArmAWkJZb/44AwNSXW79JfwMi6ilEytaA4Nz212LTAMC+1HB7H
	yfm5mxjBCVfLcwfj3Qcf9A4xMnEwHmKU4GBWEuG95X4tRYg3JbGyKrUoP76oNCe1+BCjKTB2
	JjJLiSbnA1N+Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTAL/
	vxQxlSTd/W2wsUaR4caFEtUg2zKHY4e9mLbE5PIJ33vFrJ1Zqyr5PellX8XJMN+Sh99tzr1/
	LfLl6FK794//rtYonR1QcTuQXU3kpeZP8/8rY+q26DLdV71i9L+xwWgjm3/O5R2lM2U6ZP8I
	8V+q/7m5a5aZlKnQpNmMiTvK95xfYPDyuuLeFcVeZ3d4HXqnMfFZl6m2svYTydtvdorO9Vqh
	tL0nLmmC04QXs5YLOsssjHwQs27JwfxzzytOl/rnccY+fztNOF7uRnaH4hTBZ7mT3aYuvfGi
	X8yDOabhQvhmMYf6y2rdrHxLj5k/MtsoV9Cr0LNN91p07iH1030Od87O/TkpwGpZ440NHEos
	xRmJhlrMRcWJADmQnuNBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvG7q2ZspBr/m8VisufKb3WL13X42
	i5sHdjJZrFx9lMni/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
	Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZLSv7
	2Aqeslec/TaPvYGxna2LkZNDQsBE4sL+LyxdjFwcQgK7GSVuzXjFCJEQl2i+9oMdwhaWWPnv
	OTtE0RNGia83rrKCJFgEVCV+blvE3MXIwcEmoClxYXIpSFhEQFni7vyZrCD1zAJvGSV2v3/F
	DJIQFvCVeL38GwuIzSugI9H09y8rxNAPjBJvNj5mgkgISpyc+QSsiFnATGLe5odgC5gFpCWW
	/+MACXMK2EvMPr4W7AZRoGUHth1nmsAoOAtJ9ywk3bMQuhcwMq9ilEwtKM5Nzy02LDDMSy3X
	K07MLS7NS9dLzs/dxAiOIi3NHYzbV33QO8TIxMF4iFGCg1lJhPeW+7UUId6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUxHv/SyG5w5nNg1Vzp75dN2mf/z
	vz94ID/hsPIx8cO2DwsEtNyXfNQL5fvEWvqjL/ijkvHOeXFs0Uvs3+74skj/1J91u/X5hdo3
	fD3ctuSqetO5EHbRHatX1r+8ZyjywOZi77P+H6eS08uuhamt7alb4NJS+UvpdGjr0ba+63kb
	mK3u7z6efuhY25Q7K6YJZ5lHHy/lm/GyXtaxbrt7dPrDraLPNhTM3yc6yaW5/P6pn5NDe5K7
	i+f++WLc/OeAwMXcV+xS2dtq9yzuuM/ia/ftVHffm5ae2q0Tfi+/Llbl265yrJXTWevDOTkr
	701OAU57dy68mchhw3krlsFoQ4qU+YtJJnO2KZpsWCLdcIBLiaU4I9FQi7moOBEAjcWFsBED
	AAA=
X-CMS-MailID: 20230814064453epcas5p216e308e567a0657e7a519c71c604031c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811160454epcas5p2635d208557749a2431b99c27b30a727f
References: <20230811155906.15883-1-joshi.k@samsung.com>
	<CGME20230811160454epcas5p2635d208557749a2431b99c27b30a727f@epcas5p2.samsung.com>
	<20230811155906.15883-2-joshi.k@samsung.com>
	<ZNZogPZtHsxi1S10@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_234516_158903_8D6EC373 
X-CRM114-Status: GOOD (  14.47  )
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

------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Aug 11, 2023 at 10:57:36AM -0600, Keith Busch wrote:
>On Fri, Aug 11, 2023 at 09:29:05PM +0530, Kanchan Joshi wrote:
>> +static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
>> +					struct nvme_ns *ns,
>> +					struct nvme_command *c,
>> +					__u64 meta, __u32 meta_len)
>> +{
>> +	/*
>> +	 * User may specify smaller meta-buffer with a larger data-buffer.
>> +	 * Driver allocated meta buffer will also be small.
>> +	 * Device can do larger dma into that, overwriting unrelated kernel
>> +	 * memory.
>> +	 */
>> +	if (ns && (meta_len || meta)) {
>> +		u16 nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
>> +
>> +		if (meta_len != (nlb + 1) * ns->ms) {
>> +			dev_err(ctrl->device,
>> +			"%s: metadata length does not match!\n", current->comm);
>> +			return false;
>> +		}
>
>Don't you need to check the command PRINFO PRACT bit to know if metadata
>length is striped/generated on the controller side?

Good point. Will add that check in v2.

------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_
Content-Type: text/plain; charset="utf-8"


------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_--

