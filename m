Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F58CCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZcWhPdzR9E0rNvps/txYO3Mv8PSf0/Qn7HBMAtZcqE=; b=DpmPGRTTCDt5jaBuUG+SWe/JSP
	a4etKCwXHU4LDeNMHxV6CNF+iUpHwcaX9DmcvsB/NJwXPt3UA+aqvuWU3DTqcpUV83Ke1GGH7tXgi
	HPTtWEoDj1fsyBjEDGeODv0LIhRp3AGwF2nyJuEPwmW/2Fsx9vi8FrB1W4lnlOOWImfLs++Zj1ESJ
	rm7aqYtxImDE9rENNxJ5OZ9SP8jR5BmJiykj+8HZjTEXWeICACTGFA6asPIerYShvx3UabSvmIwO0
	NAa75j7tl3YvRE5G4aAKV2gABJ4YN9srRqD9ZnHW2Q5sXxKTVA2sTrLcmfvyn4KB2th2C+NEkl+Id
	rrpdH4og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAu4M-0000000EYEk-3LVe;
	Mon, 20 Oct 2025 17:53:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAu4K-0000000EYEI-3zuL
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 17:53:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4949045639
	for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 17:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1628C4CEFE;
	Mon, 20 Oct 2025 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982796;
	bh=6F/GYnqOJXRHnvCY6WO+LvG1KxSGSq0QkHQM/hUhnsI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lIVlv5HeK6aECGu3waBm3xkFhdJCCZMh803JZzqokdbVOo/lJteMXaQFWjMf1yNuR
	 O84EUMqWuXIb6/9QGz7NeKg9WAC8kE+dzof8nWq0+OtmihIr8QZoI3nC+nsji9Pd0o
	 CrJq/J6YH8pUPhvNZeKTxtv2+Ngwp+ptp2/h55ZWnkw8Cy3L22XlYX69eznw6mXipg
	 ZDVT3vZY3/K1VHtgeKM7TG72T0O2DkG/gzwFa6THINiHCbz9UNnI8QfSPVGOOdhHBz
	 6cH234bGShi7wR93nZxkRuV7ADDu+H8Fjlmml0pBH4OJwPhbdePBSZzq5A5XmY6iLx
	 kc2042nINGG+g==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2AE8F40066;
	Mon, 20 Oct 2025 13:53:14 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 20 Oct 2025 13:53:14 -0400
X-ME-Sender: <xms:Cnf2aE3IzDbfYWO21VHMa9NeXunh7GxobwI5xV2p90TEJ2ulCg_qsQ>
    <xme:Cnf2aJ5KsZkgAbiSauqyxJXNlRTkr0sHPTSV-YRQivPjHZpTqKgDoxoTQ7rCYwccY
    5B6yque48zE2jyjX0PSv8GanWq2bjlm6zWRJYe2InUFReg85QPPnBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdr
    uggv
X-ME-Proxy: <xmx:Cnf2aHy-lZEXOinfubNaiYUhpGbiyXe6Z3DZP5nN5hX2jWM-TK2Ufw>
    <xmx:Cnf2aHAGAJHxcbvnYKih7BSZTnSC5rpMPTGTDNkZKuVH5x_44-3ZRA>
    <xmx:Cnf2aEbZbDzGRU-pW6CvJEfWfYjNgh4TV_MV5D_bAPLOah9vmAEwOw>
    <xmx:Cnf2aPjnppBICK4VvaX06y5qYvFSo9r3VFouhvfvsC3xle6ohD75Vg>
    <xmx:Cnf2aG6e7OFOMnrLhfJIINyKZx9N5x3ifC06maD86CJv0lyaHF57romN>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2B472CE0067; Mon, 20 Oct 2025 13:53:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AVzMaWY76SJg
Date: Mon, 20 Oct 2025 20:51:25 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, linux-nvme@lists.infradead.org
Message-Id: <e9d4d0c3-21ec-40bb-a577-8a54ef5830d1@app.fastmail.com>
In-Reply-To: <aPZrka9vQKugd-o8@kbusch-mbp>
References: <73609a88-b98f-474a-8872-673cf5ca0581@app.fastmail.com>
 <aPZrka9vQKugd-o8@kbusch-mbp>
Subject: Re: Metadata integrity, single segment and peer-to-peer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_105317_031285_4A76074C 
X-CRM114-Status: UNSURE (   8.92  )
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



On Mon, Oct 20, 2025, at 20:04, Keith Busch wrote:
> On Mon, Oct 20, 2025 at 02:50:04PM +0300, Leon Romanovsky wrote:
>> Hi Keith,
>> 
>> I'm looking on the nvme_pci_setup_meta_mptr() implementation [1] and
>> don't see is_pci_p2pdma_page() which exists in
>> nvme_pci_setup_data_simple() [2]. Is it intentionally? Can single
>> segment be p2p transfer?
>
> We may be calling unnecessarily dma_unmap_page in that case for mptr,
> but I think that still works anyway.

How? dma_map_bvec() is actually dma_map_page_attrs() and that function doesn't handle PCI_P2PDMA_MAP_BUS_ADDR and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE states.

Thanks

