Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4D4CD98DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9S0J4kOPP6rNUpj9hSQNdmH4J074CxuYrIkFj4FhWc=; b=TTyJYHh+XOIqzZ6h9wQBbl8fkp
	Ea0P/Q/iXOr/UI8l+dREuHmfIGQmlT/1tRojUqYrOe3ztYEd7fss8zHIsPlq5aX0r1AK673PkokZD
	wbmnM3nk5RU3a6m7IETq28PUtH9lIzi+eVkjli71eQsIFs/UYrO4DpoVcIOEWT6zx014WwN5QCv7F
	3ICa/7TEy4Iy6kwSuGVH5xI4x8oGUIcnfFBLfVXUVvvUnbzCsJb3HxMEz2D4uM0EY0y46Jg1noTHl
	ZfBpZcGycKlbJqTkQNjiVqpEmTLJ2Rw0wiThg7x2KES+xxLh+vhM3Ne93lMfRRI7As5SHBfXkVGuU
	AejAlbmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJe7X-0000000B5kC-2vDC;
	Thu, 13 Nov 2025 20:40:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJe7W-0000000B5k5-48vI
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:40:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DBE06011F;
	Thu, 13 Nov 2025 20:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E09C4CEFB;
	Thu, 13 Nov 2025 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763066441;
	bh=k9S0J4kOPP6rNUpj9hSQNdmH4J074CxuYrIkFj4FhWc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vDv2zUrwUETRUlIW1qxCkExTUfDNbDLNhgWCd2O2gi/B9fEgNh3w3+bbnn8eRlLSA
	 32U/S0i0baBFDrtqns7Hm6ujWaFHg8JF0k4So3TNVuVAiqQnT0ceHmnHxJzZFjUT1k
	 AxGMcRthB3gXZalQADlxL0fmLKjesTsBdUO75YYmh9hsNJKGrEbVt3aQ4OE3zauMzM
	 U8kPkKQwwh1IwzoYBhW41fPvNl5GeJjK3q7x65EGhw6yrb1kJY2rT1r09rli5dy+Gw
	 j++lT9J/k6jEU8r9/ETn7IXddqwaYHF59ZMHaJSyJmHeBV/4IqWrQB0Mi45gKVDsEV
	 ++Kki53ERiMDw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 745A7F40068;
	Thu, 13 Nov 2025 15:40:40 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 15:40:40 -0500
X-ME-Sender: <xms:SEIWaZHBGuNK4pAd7wS-z9qKhDK2WSIAkAS0uZUqthMvntOGek2-cQ>
    <xme:SEIWaZKEh8eft2TGIofz9EdNBsKw-6bR8TttU5aBerOgo5G8yh-5w1rBvzkPghPZ4
    qDpl8MT-4PbFcmv0PkfZi5iqkLiLns15bruNhVK_pwU5bFdcHSLow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepgeduhfeugeeuueefveejtdefudekkeekhfeuiefhffejgfelleefleeh
    ueetgfefnecuffhomhgrihhnpehpvdhpughmrgdrmhgrphenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonh
    eppehkvghrnhgvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpd
    hrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehksghushgt
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhr
    tghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SEIWaVpkIVp-Q33eeBu5nd4MrleaDwXX1iiI8k6XUvhOzFrGlx8EXg>
    <xmx:SEIWaWuRwX3NjvwomlZLy2JVfmeXtVd56kh8L0rHKf9aecUVRg31AA>
    <xmx:SEIWaYbKQeCtUuwhI8-ILt-gkkmz_lkwqUEQ_DxnMhm59qClZSpg5A>
    <xmx:SEIWada8aPSi91O1Vmq8-QcupFEo1NRj6cB7xShZjcalTqBIYC183g>
    <xmx:SEIWaZk5x_txG9Ph5fre0BN1is-Uk-PUcyWIf_DTYE9pewGZLFmynIi1>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3AB722CE0083; Thu, 13 Nov 2025 15:40:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AaNBfhOYEQos
Date: Thu, 13 Nov 2025 22:40:19 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Message-Id: <ddc17de5-d5fe-4ebf-9d87-0d7bcf4bb7dd@app.fastmail.com>
In-Reply-To: <c745d717-fcd5-48a5-b640-af5697be6049@app.fastmail.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal> <aRY5nCvNnQk4mMCT@kbusch-mbp>
 <c745d717-fcd5-48a5-b640-af5697be6049@app.fastmail.com>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Thu, Nov 13, 2025, at 22:13, Leon Romanovsky wrote:
> On Thu, Nov 13, 2025, at 22:03, Keith Busch wrote:
>> On Thu, Nov 13, 2025 at 09:50:08PM +0200, Leon Romanovsky wrote:
>>> Can you please squash this fixup instead?
>>
>> I think you should change pci_p2pdma_state() to always initialize the
>> map type instead of making the caller do it.
>
> Yes, i just was afraid to add another subsystem into the mix.

Another solution is to call to pci_p2pdma_state() again instead of checking iter.p2pdma.map in nvme.
Which option do you prefer?

Thanks

