Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA28C02188
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yjk97imBnKIfiyfiWXwvHSWjkC0UabJBaiHXXMbZsqE=; b=npkrpFHWuzlvmm3fn5/Yzi4okE
	D9iIzD9AUc7h02D0liXdOhqeM83/kTBAdzmoBqkCOKIZjvZZ+71XJK1CMdEQJEYEuwV9mrrmWhUIW
	KMDVsENpjSLZrW46DiUhQL4A2exOZsM9ytPtEMVcLKnf5M2CSRD1SWcsGTMsKNgZz4w7GtLd43PqV
	j5Ig3XMMv/6YS+Nd97nIvUEX/5uZ/GdobBg4NvP4VlkriqxFSeFO09x5aZ4aCPKKEq5u766jPIc+7
	Id5kz8LiOg6HRtmsIf44CLiy7XvRzBQiIu5q8yKza1LnQeLI6E+ZJXKfjG89vRYQjziaZzkjN6DmH
	BxDKgIkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWyo-0000000G5wN-1MhB;
	Thu, 16 Jan 2025 21:00:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYWym-0000000G5uw-1Uee
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 21:00:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F54D5C5FCE;
	Thu, 16 Jan 2025 20:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C985C4CED6;
	Thu, 16 Jan 2025 21:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737061238;
	bh=ei48WzDzQXjwdLn3xeNuV6Y9soa7jumN+VhYVf6oIbQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=krLzUDGJpvLy/t9Kt5pMwTh4Uez1IeaoqrxvB8XYpPZgBiTnhXx4WRFQUowinmlzn
	 mRd7JZZtv/4faOqBd3sx4rT9ZKwaCYL17MWmvA3cPeiZ4C/X3JDh5iIhEbfp2u6hEE
	 tMcHiOKCOMg0c+f9JGDQQeZMo2Hy0tiwzByswP6RQJZ2BrF7RRLWOnhFVxFdXbWaR1
	 4YHKEEvilbrEG2rQafVavGW3VRP7kyVKE4Mw287KtrZwmyrHbWfMS4c5J3qeE9EMZ5
	 NEqrqzzZ/4AzOrS8iZWTVjTXJxC+6RLJ+os16QqA8uukEZGLCxL9bltC9YfSkGdtKl
	 Gy0sHHYDs+8bg==
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DAAFD1200083;
	Thu, 16 Jan 2025 16:00:36 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 16:00:36 -0500
X-ME-Sender: <xms:dHOJZ_8hnrsy-ECJdAOQhqbieHNitsZTUyWxpffUhYWXpC0s_BRHQQ>
    <xme:dHOJZ7uv6bWKUdrSLNYRkQNUnErbS8jLliX3TjOn9CZwxad3Qot1cG_Imf2F-tjUu
    I2mXftxq5MS6uIf3J0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrh
    hnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeejvefflefgledvgfevvdetleehhfdv
    ffehgeffkeevleeiveefjeetieelueeuvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonheppehkvghrnh
    gvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoh
    eprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtoheplhhoghgrnhhg
    seguvghlthgrthgvvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthht
    ohepshhhrghmvggvrhgrlhhirdhkohhlohhthhhumhdrthhhohguiheshhhurgifvghird
    gtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopegrgi
    gsohgvsehkvghrnhgvlhdrughk
X-ME-Proxy: <xmx:dHOJZ9AsJorCdvsMQoxKmdUUyLaDrarWg_hDv0lIk4UGGYNSNWOc2A>
    <xmx:dHOJZ7dgJxPeoxCqJDK6dxgG9pUYIr_52ACmcuhRIw1Qh9GaunCLwA>
    <xmx:dHOJZ0NcoJ96f9Cm3V1tQ5aoiCzNw33kuCzYomD4dLo444b1fpQ0Xw>
    <xmx:dHOJZ9kW1rLTlUibKKzm5XjNDGE7mt0S8k2egAdwWJej7fRDieXAPQ>
    <xmx:dHOJZ-tBWC5CFeUXfiLbOKYQdG4K_dodDJWtuk1DQC1UPn6t-RWZL1C7>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A17001C20067; Thu, 16 Jan 2025 16:00:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 23:00:14 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: "Robin Murphy" <robin.murphy@arm.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Keith Busch" <kbusch@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Logan Gunthorpe" <logang@deltatee.com>,
 "Yishai Hadas" <yishaih@nvidia.com>,
 "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
 "Kevin Tian" <kevin.tian@intel.com>,
 "Alex Williamson" <alex.williamson@redhat.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 =?UTF-8?Q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 "Randy Dunlap" <rdunlap@infradead.org>
Message-Id: <45eee716-83fd-4b15-ae11-2414aa119db3@app.fastmail.com>
In-Reply-To: <20250116201853.GE674319@ziepe.ca>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
 <20250115083340.GL3146852@unreal> <20250116201853.GE674319@ziepe.ca>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_130040_483690_DEC64437 
X-CRM114-Status: GOOD (  12.67  )
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



On Thu, Jan 16, 2025, at 22:18, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2025 at 10:33:40AM +0200, Leon Romanovsky wrote:
>> > > +	do {
>> > > +		phys_addr_t phys;
>> > > +		size_t len;
>> > > +
>> > > +		phys = iommu_iova_to_phys(domain, addr);
>> > > +		if (WARN_ON(!phys))
>> > > +			continue;
>> > 
>> > Infinite WARN_ON loop, nice.
>> 
>> No problem, will change it to WARN_ON_ONCE.
>
> I think the other point is that the addr doesn't increase, so this
> loop will lock up.

Yes, this is what I planned to do.

>
> Possibly just do return? I suppose something is hopelessly corrupted
> if we ever hit this..
>
> Jason

