Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EFFCA0EE4
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUOWdZP1cezLj5JR2qWET0ULt+yC1LXg9Jc7bXW5jXo=; b=14GDJJC14wyq0Z5X4kn0L2wMrB
	zTnP3YCVq1jvweeGhNP7nafjE3DxOqPkN9XbhPSN1gpC5OtSk9kqcHoopGI2SgtboMQEdt6h2Dptw
	2H5Rf9oUm4wsz14hqiHjmvG9xOECSTMGLnFvYv6t+f70QqCFoy2rkJ5SBiOL8oeRwszUiuTMNJjWv
	IMm8sjHQuzsgjuY03zYrLcML6J9Pljr8vuEvgU2Lvts6DJRsXyx1BzYUn0FRjZldkDRwJSiob4qgJ
	2GE7nYKaxQj5Q63IcKV3OYcrI9eFskOFKxfegr15WYoL6pKq5pIvFAndHSofwTRly2U6tCSnW0s2F
	li01lw0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unbNX-00000005aji-0uxN;
	Sun, 17 Aug 2025 11:16:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummiY-00000001UYL-3fdF
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:11:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4BD8E5C5B0E;
	Fri, 15 Aug 2025 05:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEBCC4AF09;
	Fri, 15 Aug 2025 05:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755234665;
	bh=rjs/V71n+3a48sbczUimLUbQ99An++PfjAuhQIEa13s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qaZHeg2/5a1nlFDrCh+QQq8+2z+k/HIBWZUD4nh0+1i6c37KB42J7MuL6+NCG/t+L
	 Sb4lS+mkZ14VoVX+YlDNVGPRMcWMXRHAGigO6GBs+JD82O/j0LxY54D+zDNDsJYKAo
	 sXevI5VIzQWOLFfl/WV5zUlxyV+wLZ1J0REOzQc8KXCWGG5zo4v1sD8WTb37YmZh26
	 fQvGeRnhGwhiRkaAiLioOMAOHFUuoJ1KDM4vS7BfgMxeW43efHE9YPv+gnweYXLTPM
	 XrWCUBDKKDrqe8banORHuWlWg0uTJGuY3c9EmS4cdtxIgiUKad4TjoW3OXKR2Ys5uU
	 wi4dFrypsvChQ==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id CD58BF40066;
	Fri, 15 Aug 2025 01:11:02 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Fri, 15 Aug 2025 01:11:02 -0400
X-ME-Sender: <xms:ZsGeaEjCAtEWX1UaHLA2gfColtQZO7w89chtZ2uFaG4vMYHweTmDIQ>
    <xme:ZsGeaNCED0uQ78E9d2j9GAg3NYkGAhxwrM8S6giPlAbcy5DsDkd_hrjkIGTNdnggG
    4eL_xWyjdx6jEOR_bI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepffegjefgueegffffjeevheektdekgeevheelvdekieehvdejvdejjefh
    hfelhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonh
    eppehkvghrnhgvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepfeejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpd
    hrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohep
    tghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhope
    hmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopegrsgguihgvlhdrjhgr
    nhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdho
    rhhgpdhrtghpthhtohepghhlihguvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hkrghsrghnqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:ZsGeaPWPNXdI6VvYib3k9QdMC2XlJbr86LA_KN5YspkDL_EEK6BRlA>
    <xmx:ZsGeaI3d1bh3fFRFl4aiXZUts9ejR-WHFcon7KnhJbC_6nOGWjjn2Q>
    <xmx:ZsGeaIdgKvfZyaCQpAF_MAary9Xg8Dva0Q5zSBAie2gJ8xC3nka9fw>
    <xmx:ZsGeaNVlXDFhOQ5jT6MnFggS_FVesjsSUNJLf3EVumbGV5Io7NaXkQ>
    <xmx:ZsGeaG9LccLFJ2EboOYrfkTWU2yRr6gsoUbWRyvB7Ij-X0QWOgy49Rp5>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8094E2CE0071; Fri, 15 Aug 2025 01:11:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AWyaQ402xWe7
Date: Fri, 15 Aug 2025 08:10:43 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christoph Hellwig" <hch@lst.de>, "Danilo Krummrich" <dakr@kernel.org>,
 iommu@lists.linux.dev, "Jason Wang" <jasowang@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Joerg Roedel" <joro@8bytes.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Juergen Gross" <jgross@suse.com>,
 kasan-dev@googlegroups.com, "Keith Busch" <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 "Sagi Grimberg" <sagi@grimberg.me>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, virtualization@lists.linux.dev,
 "Will Deacon" <will@kernel.org>, xen-devel@lists.xenproject.org
Message-Id: <45552b38-5717-4b0c-b0eb-8c463d8cf816@app.fastmail.com>
In-Reply-To: <ccc8eeba-757a-440d-80d3-9158e80c19fe@csgroup.eu>
References: <cover.1755193625.git.leon@kernel.org>
 <ccc8eeba-757a-440d-80d3-9158e80c19fe@csgroup.eu>
Subject: Re: [PATCH v3 00/16] dma-mapping: migrate to physical address-based API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_221107_001265_BD5442F2 
X-CRM114-Status: UNSURE (   8.97  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 17 Aug 2025 04:16:29 -0700
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



On Thu, Aug 14, 2025, at 22:05, Christophe Leroy wrote:
> Le 14/08/2025 =C3=A0 19:53, Leon Romanovsky a =C3=A9crit=C2=A0:
>> Changelog:
>> v3:
>>   * Fixed typo in "cacheable" word
>>   * Simplified kmsan patch a lot to be simple argument refactoring
>
> v2 sent today at 12:13, v3 sent today at 19:53 .... for only that ?
>
> Have you read=20
> https://docs.kernel.org//process/submitting-patches.html#don-t-get-dis=
couraged-or-impatient=20
> ?

Yes, I'm aware of that section. It is not even remotely close to the rea=
lity in different subsystems.

There are some places in the kernel where you never get any responses.

Thanks

