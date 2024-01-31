Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D9EC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIQivkM47txOTPWMmuF2P9LlXky03Vag92xicuyqh9o=; b=0TVDkmXuLkXywHx+uEifGNsWyH
	aiMK1E6q5vZu2CElXj02Shyko7yhfzSfdp3q7uCUY10pQl0xtHfpw1PbGO3Dz5vCNLqq/HyTxWs5l
	DfxlWmRQ0fX7bQ7pAWB2z0hf/LNHPeL/+Z8kfb3gv74fqg4nw/ECJndo+nd55MSXXmuYHNxYjeq8Q
	mV5HMGUe5QcWeVVuusMxHekvlcB9Y/v9+9DLlxCcY98pSvXO8nqMDcgD5QPe/viXwb4RLTWuvkDyX
	PuzNWctFgjUacOeuENTSFjGmu6CqNIAk/yErC3KOTcoRqqtPIAgj/RYHS5Ct9gDQYu8Z83Ikwe3hh
	RGJcYhrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVChc-00000004GxS-3dCJ;
	Wed, 31 Jan 2024 15:40:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVChY-00000004GvQ-3HlN
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 15:40:39 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240131154032epoutp02572f684c9db60cbc6ffa4133ad9180fe~veNM451ae1019410194epoutp02b
	for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 15:40:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240131154032epoutp02572f684c9db60cbc6ffa4133ad9180fe~veNM451ae1019410194epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706715632;
	bh=RIQivkM47txOTPWMmuF2P9LlXky03Vag92xicuyqh9o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BEnD3SwHH2KVZQfe+/AePJXDFoz3rukKCwd0tsrZVCv/q+sps+f761aVAVsyuIId3
	 Zmv2U8rdUCToJo9Eka1urkEAemRQCDASfjzI7SzusBGy+oWGh6V/X/Tr67LnO5lYLD
	 OLk1YI7ZHnifaMRH4tmaOhadjWffy7OQ6s97X/Sg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240131154031epcas5p37d3e81b92e7c7f907de07ce90d14d3d5~veNME-vO03214432144epcas5p3O;
	Wed, 31 Jan 2024 15:40:31 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TQ5pQ2qGMz4x9Pr; Wed, 31 Jan
	2024 15:40:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	61.07.09634.EE96AB56; Thu,  1 Feb 2024 00:40:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240131154029epcas5p1605cb302fd0ea987bdfed7783a0f7488~veNKPaXG73271532715epcas5p1i;
	Wed, 31 Jan 2024 15:40:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240131154029epsmtrp22311e0af283de034a7adf2f1a9bfb902~veNKO4jL31043510435epsmtrp2e;
	Wed, 31 Jan 2024 15:40:29 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-74-65ba69eed87d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.84.08755.DE96AB56; Thu,  1 Feb 2024 00:40:29 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240131154028epsmtip24e814b879a9932ed7611f939a76be4a4~veNJoYLAl2989429894epsmtip2U;
	Wed, 31 Jan 2024 15:40:28 +0000 (GMT)
Message-ID: <01374b3d-7526-2a0f-c4f9-b2f585ec7bc0@samsung.com>
Date: Wed, 31 Jan 2024 21:10:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmpu67zF2pBvc7BCwOP57EbjF/2VN2
	i32zPB2YPTYvqffYfLrao/1AN1MAc1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
	hbmSQl5ibqqtkotPgK5bZg7QGiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmB
	XnFibnFpXrpeXmqJlaGBgZEpUGFCdsbaJcfZCu4xVfw+3svewDiHqYuRk0NCwERi0ZEHbF2M
	XBxCArsZJTbdXswE4XxilOibdpUZpEpI4BujxKQJiTAdfa0/oIr2Mkr8fNgK5bxllPj8+yxr
	FyMHB6+AncTSudwgDSwCqhJzT/0EW8crIChxcuYTFhBbVCBJ4tfVOYwgtrBAisSJvpNsIDaz
	gLjErSfzwepFBCIkTi6dARVXlrjQ9pIZZDybgKbEhcmlICangLPEwtmVEBXyEtvfzmEGuUZC
	4Bq7xOM7/xlBaiQEXCROveaEOF9Y4tXxLewQtpTE53d72SDsZIlLM89BA6VE4vGeg1C2vUTr
	qX6wrcxAW9fv0odYxSfR+/sJE8R0XomONiGIakWJe5OeskLY4hIPZyyBsj0kli7fwAIJp2mM
	EtvuzmeewKgwCylMZiH5fRaSb2YhbF7AyLKKUTK1oDg3PbXYtMAwL7UcHtnJ+bmbGMEpUMtz
	B+PdBx/0DjEycTAeYpTgYFYS4V0ptzNViDclsbIqtSg/vqg0J7X4EKMpMHImMkuJJucDk3Be
	SbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MYk7sy9+lX5E+mRDE
	l30hsKd8VdTkjz8CBQ+/+yujsOxN10Tb8seuh58Y1sa0FfcrsfzNdl6m/zbEa+/ND5Ou/+/+
	N/tZwO0NOyffZHe4vGdVx6O7Rm1iS34Um2y4bcvbFdn64cwqL/+oZEW28vWxct6rbufFXK5c
	7dT8VcVtoX1UxyyT9hMtKtN+XVl37rhCxftE2QqfNT9Ozkk2mvibdwfntK+drA5fZwc7aSuJ
	L3K4Ztp+9c8nvxenp7oL3om3KQyS26FZtUzZOWFZyaPS1k0L8pXad1owH//97kFQ9oOAyIxu
	vmcThbhXS82vkY5OmtPzyXOFYsi+7lNcGxoTF0hJ8OnHfHd+dPSjJROvEktxRqKhFnNRcSIA
	nmhp1goEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO7bzF2pBjcnylocfjyJ3WL+sqfs
	FvtmeTowe2xeUu+x+XS1R/uBbqYA5igum5TUnMyy1CJ9uwSujLVLjrMV3GOq+H28l72BcQ5T
	FyMnh4SAiURf6w8gm4tDSGA3o8Sad/OgEuISzdd+sEPYwhIr/z1nhyh6zSjxePkaoCIODl4B
	O4mlc7lBalgEVCXmnvoJ1ssrIChxcuYTFhBbVCBJYs/9RrC4sECKxMez38FmMgPNv/VkPlhc
	RCBC4ufyi0wQcWWJC20vmUFsIYFpjBKf2iVAVrEJaEpcmFwKYnIKOEssnF0JUW0m0bW1ixHC
	lpfY/nYO8wRGoVlIjpiFZNksJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yf
	u4kRHPBamjsYt6/6oHeIkYmD8RCjBAezkgjvSrmdqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	xV/0pggJpCeWpGanphakFsFkmTg4pRqYLnTzFrOeXrrR164h4ot8w41OD6Nu9+SPlnuLrk3b
	k9EkweV0W2aBo+eXg190V/94fGhCcOgbZcn+PV3JGVItBcYRhw9zlltcNxI/uWGf1IW5fVJL
	usXu7Fj6qEUp6fL+oL3K10Rn/I1cr+/x+1zMnd7sVzFGG9NNfRTPFzhKLfK90nWhuU3n5F3X
	hrSb2mGMouuqryT/S2zzUe58MFt2cvJ5BaMpE+eXXl96050tIcwg69nm51VVPDmplhsU5zBe
	v/rRSrzhDodqdW+c7Yczrg3Czl+zOmZvL04+8W3mgfuT5qz4sFRrRaNYcVd/X+/uyqpdM+82
	fU3dl7zsY8PFWTcnbX/op3/anWXj26BFSizFGYmGWsxFxYkAFRcIVucCAAA=
X-CMS-MailID: 20240131154029epcas5p1605cb302fd0ea987bdfed7783a0f7488
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240126061043epcas5p49d141355741ca4f1487d772cffe0d0b7
References: <CGME20240126061043epcas5p49d141355741ca4f1487d772cffe0d0b7@epcas5p4.samsung.com>
	<20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_074037_478967_DA85E530 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
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

On 1/26/2024 11:40 AM, Shin'ichiro Kawasaki wrote:
> A recent commit in nvme-cli v2.6 changed the single letter of the
> --opcode option from -o to -O. This caused the failure of nvme/046. To
> make the test case work regardless of the nvme-cli version, replace -o
> with --opcode.

Thanks.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

