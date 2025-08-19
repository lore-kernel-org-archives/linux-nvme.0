Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C7CA0EE6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V0a8rCSgjkAz7gnhnXOKuD7c9T1R+bK+iGUt9hpQUxA=; b=HVtNIxQGg2xxLXfO925KplnjTO
	YPnt0YD2Q87XMDRtXf+ZYJ9rEcTmvnbgqfxaXFzmdpW3SmZZJgKJGUrD/yl9UFu7fadMV7lYISamS
	YM4rCSZsziB+N0HCLRhW5BoSoUysXeaAc8SFTn/5LJovdEjBBj5Ny4HEPq/Cvf0OrPaxeHJWQkfvS
	olWL7QuVbQXoD8CyGAOV387U3RR4re/+yPfNwB4qyCU931v7GoWPHxkbm3Dk4hLUXb0S5ksZ6xRu2
	391vQD9QPJObaXW64zmrgUM6W4HMQeTwcYVw7RPkAwetVeikpAF05jk7du8TuS2f12xAEtBZQjkmz
	kVrWdytg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowE6-0000000Fhd7-1HD8;
	Thu, 21 Aug 2025 03:44:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoROl-0000000BL1r-4Bow
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 18:49:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A68B6434E0;
	Tue, 19 Aug 2025 18:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F31C4AF09;
	Tue, 19 Aug 2025 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755629369;
	bh=7PY2nvBiFg+PmH3kasIozmSCqMsV1czCdVRZ4HT8eEo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Xmpr6nUlxhT4ML+rFt1gIMnPEVpYqIqWjpUkgUQR5tX3Ea3qBYnKk1IyWsYC7sBet
	 QBsMrRk3r7iMu12daYBH1ylIKK33Dgbw2Y1MuCT43OUlbupun65NOdzuJa9IY8ytGJ
	 F2KoEBiwNJLZb2M/WkquLSxMBkG+zUTjWlAYLvA7NXHrkQmzA8GdxTTiqKCPXXi78g
	 mN0g5G7szNsgyUdSlZmbkMIIrt7pMw7M4uyf1LOzcmC10UoLlqg1CBOGjbTIEq00Ec
	 HfGNVq0UJwNkN4j62cFWRW+/HtCdXt1of9/eic9VtPkqlZST1PzxASg8IfYr3RIGmP
	 SUG+MxNe67pLw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 31D3DF40066;
	Tue, 19 Aug 2025 14:49:27 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 14:49:27 -0400
X-ME-Sender: <xms:NsekaGLkpYYn_tL5rT3yO_BkXqxiddfgdxidgKxcHaH-MXl652p3cQ>
    <xme:NsekaOJlIC7TCSjCwYmRCpvzsFljgqYaxuYOZolEbVOqnFcN0Yb2GZzTgHG2uybzM
    aWMSS4nJkDgbbBx7tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeivdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhi
    esrghrmhdrtghomhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdp
    rhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehr
    ohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepghhlihguvghrsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkrghsrghnqdguvghvsehgohhoghhlvghgrhho
    uhhpshdrtghomhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvg
X-ME-Proxy: <xmx:N8ekaMdwa-bjfjKiy_bnjKe5pj-w5KnECjXqAsQ2QeQdV4SQA7pQwg>
    <xmx:N8ekaPdCW9gH5-vPa6JOMA4aaqp_1mwWnXjSovauczKDDBtpYQ57dA>
    <xmx:N8ekaKnKy6VKuw8SWj7LEaUJFkqm2rbcIMv54YWlw8KOdD3OfERqqw>
    <xmx:N8ekaE8iyeSnMuDLLObkGrzOSgmAQEbj_4QdVJQzRyQ8881Jp0dwDQ>
    <xmx:N8ekaGEni2UyRaNp_TjZoxjj4fIEinDxeQ57M5QUT8SDp3Eg6UepfRUM>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E45512CE0071; Tue, 19 Aug 2025 14:49:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A0xmfm2pPGfg
Date: Tue, 19 Aug 2025 20:49:08 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Leon Romanovsky" <leonro@nvidia.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christoph Hellwig" <hch@lst.de>, "Danilo Krummrich" <dakr@kernel.org>,
 iommu@lists.linux.dev, "Jason Wang" <jasowang@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Joerg Roedel" <joro@8bytes.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Juergen Gross" <jgross@suse.com>,
 kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nvme@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 "Sagi Grimberg" <sagi@grimberg.me>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, virtualization@lists.linux.dev,
 "Will Deacon" <will@kernel.org>, xen-devel@lists.xenproject.org
Message-Id: <82f3cf3c-960b-41bc-82a8-ce84353706ed@app.fastmail.com>
In-Reply-To: <aKTAVOBp0u6ZSC4w@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
 <aKTAVOBp0u6ZSC4w@kbusch-mbp>
Subject: Re: [PATCH v4 14/16] block-dma: migrate to dma_map_phys instead of map_page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_114932_084889_2CE16FDC 
X-CRM114-Status: GOOD (  11.21  )
X-Mailman-Approved-At: Wed, 20 Aug 2025 20:44:16 -0700
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



On Tue, Aug 19, 2025, at 20:20, Keith Busch wrote:
> On Tue, Aug 19, 2025 at 08:36:58PM +0300, Leon Romanovsky wrote:
>>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>>  {
>> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
>> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
>> +	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
>> +			rq_dma_dir(req), 0);
>
> Looks good.
>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>
> Just a random thought when I had to double back to check what the "0"
> means: many dma_ api's have a default macro without an "attrs" argument,
> then an _attrs() version for when you need it. Not sure if you want to
> strictly follow that pattern, but merely a suggestion.

At some point,  I had both functions with and without attrs, but Christoph said that it is an artefact and I should introduce one function which accepts attrs but without _attrs in the name.

Thanks 

