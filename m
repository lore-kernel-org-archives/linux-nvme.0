Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56189D132C1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zd5G+KQhPA2oZ11SlLJRE0Pg1nGRfiYB0gxmnoOiCaM=; b=pWyr9E5b0Lyk454oE/5akY/XyG
	likdnImtMBgEHs25DgBeU3AKaGbr3euyhhKtH7/J7BG8E1b04/SJETIRolGQn8K9xdWMfP29fGrfm
	pJz+UsTFhH+QbADdPTeUgimAGIy4vUFoxPLwgTQQW5agSYmDoi1cCGlx7gcHFzW25gC0vLSZIuNCs
	uwRJ8C050UyRe8ShbAQ8/uSyzhqfCCog7iCF+KPgFcR0OSavzv+eoBmWtErR0oEb0K80OrVgdkk5z
	nDg9gShNyhO66wGrCu8vW2nY3yVo7PIiW1IFq0TgbxD2xMvXQ6rwiM8NnZita2NjHh/gTD0po42Kc
	ppzz7zcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7x64-0000000Dqpg-0KpV;
	Mon, 04 Nov 2024 13:26:20 +0000
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7x4M-0000000DqNx-03Vj
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 13:24:35 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C811E25400F7;
	Mon,  4 Nov 2024 08:24:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 08:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730726669;
	 x=1730813069; bh=zd5G+KQhPA2oZ11SlLJRE0Pg1nGRfiYB0gxmnoOiCaM=; b=
	SqN/qSjqxc1ZN4IQaxqZjO4l/U1NciabVFwWNRk07eU3hCGixHa0eoGtEyr74L7t
	wOBvVR1+l3r7JdMbEV+4zbGMbC2S36J3JwKJtqhQf8sYgRTIuyETudj9gZVXoKx6
	oL/8E54bHmG7jxwLC8H5YZARKVxDpBYlUEZDjRQB5jJXsQCtUowW8SV08JXdGAq7
	WllBVtbJ+bwVs4GcVm744D5E9MkePuXjtTF5TQXxvVgC1wDuVVnmOmheQhz8NPWP
	pBskdhZBgANc8gbv+F4BpoB0aL8foYcK1ieiuVWtmNhTkM5er/EWOaZihBW5Ez/C
	RGAjgHWPXNJmOg/dzqHMMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730726669; x=
	1730813069; bh=zd5G+KQhPA2oZ11SlLJRE0Pg1nGRfiYB0gxmnoOiCaM=; b=m
	WzZv09PtmqA1lmDM4XYszse2986K2s860W4bBQpvgyZwnBpwHQa0rp8igkIwbzcu
	ruOZPUdH9fSHacpFH36S03IART525AtUVnf54DdV086FlcjJEDMNwtfbqoYqCzbq
	kEsysIJjcH6vSv8aFRJtxjCkVssMBfIcsj5LZOEF2G7tAUKC2iTv9OcL0o+bGR6v
	TfAv9zFUwdyz5D1MFT5dwXeE9XWUjoYTHsRzKT2RWmCdCY+h6M6u07wD+nZ2PFU6
	J8ZKBO5JaUc4d2JYgsO6izQvRYMSOj6pk8RtakzgzWsoNuJF2I7hGTgGZFpZkW9U
	u0fTd9a6AGtz4Wz2ENT6A==
X-ME-Sender: <xms:DMsoZ9jPPuo1sIJUOmO_9ZGTGG_Mku_4gkqrPf2ozjBejes7e3LDeg>
    <xme:DMsoZyCrkF6DhF00NU0k1Xg_5EgzeY3s--LnxwR7oPjf5PkxSxoQtDWLNMDiPxR-K
    Hz4UCrPvlyifD6jpqE>
X-ME-Received: <xmr:DMsoZ9H0N7ZSOEkxfx0LdWoVkyfEw1wmVG5rb4FjWaRELJsICAfg61lcnqtIS9Jl3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepleehjefftdeijedvveeigffhgfdugeduieevudeh
    jeefueffkeegjeffiefgheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepughlvghmohgr
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfigrnhhghihughhuihesvgduiedqthgvtghhrdgtoh
    hmpdhrtghpthhtohepmhgrrhhtihhnrdhpvghtvghrshgvnhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:DMsoZyRvVg_010fiQLJLkagoM_Owr5KHPK90BaOdHJMUB7V12xZ-bw>
    <xmx:DMsoZ6xuGxlWKWHIjGfDOkRA0Zt6snpxdEf_hs0o1rXeI8ub0s8qOw>
    <xmx:DMsoZ45DkwUsjr5fWCHajdT4tC8yhJcWMiICf3Ni6dnwC4SRNtOMLQ>
    <xmx:DMsoZ_zo6otBncnbUy4TKhKTtYSCKBbTr8ezY0a5NLi7w69GYjxCfQ>
    <xmx:DcsoZ85V2atdf81PZ9IJN_i0Bt4sVaGqlXE_RZNww3c65UdLiD_ZvAO_>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 08:24:26 -0500 (EST)
Message-ID: <f9fd6e53-ecae-4c7d-b35c-be0d27d81173@bjorling.me>
Date: Mon, 4 Nov 2024 14:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangyugui@e16-tech.com, martin.petersen@oracle.com, hare@suse.de,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-2-m@bjorling.me> <20241011081452.GA3337@lst.de>
 <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_052434_633344_203FD570 
X-CRM114-Status: GOOD (  10.28  )
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

>> FYI, I still disagree with this for the same reason as before.
>> Assuming we're not really going to see hard drivers I'd be fine
>> with using it by default for 2.0 (or better even 2.1) by default.
> 
> I've got the rest of the required logs and identifications implemented
> in nvmet to support this. There's one more issue, though, if we do
> restrict the identify to >= 2.0 or 2.1. nvmet reports 1.3, and I suspect
> there's a bit more work than just changing the value of NVMET_DEFAULT_VS
> in order to comply with claiming that version.
> 

Awesome. I'll hold off the implementation. Would you like me to take 
your patches for a spin?

