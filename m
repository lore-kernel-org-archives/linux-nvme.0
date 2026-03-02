Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F9EEA4E18
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+2qH/7P6Z+7BaWyXDubCG6jCEVfVddsfPOo8qp7dAw=; b=EqdeftHyXU9j8UjLnqdm6bnUiL
	PW48GK9hGbgnz2N874joVbG5GABSS5HG8a10POdOzpcYEAaxQWkyI9W5g0sZ0vqf3P2PcrXffcduk
	o83V4LduPUqASTgEKOJrfEk8kbXjl4h5/qy7qPtNLQ5YHJbzNXa+n9xrDggM7rNe0wt8QJE04baS8
	MUcwK8aD4XSx3zyYnZUhlHvOSSt6tliRig0DYacNCTe3vFqFUGAykpIKo7Zxrs4ajnzglfgpX8huC
	dXzJIPJ4AXiIQezTjhfy44VjqO6qYCDQvyWisxBcz2H4wtIcaAmh8eqCktFVK6L8c0omsNs8M6X5a
	mfyNoq8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx4rl-0000000DJ2j-0tAW;
	Mon, 02 Mar 2026 15:07:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx4ri-0000000DJ1o-3BR1
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 15:07:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B993443A4D;
	Mon,  2 Mar 2026 15:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB38C2BC87;
	Mon,  2 Mar 2026 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772464041;
	bh=ODDd4lYneiECSGW5Q5K4OMs77T82tglNOAaANRA0IqM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j41caqtI5viNHtXPTMfUPPbw66e6Rs8w2/INUxRxAodH3veOuMkMBrVV1qaEVXRx8
	 WmgzFMA7xEhkhNbRlltivY9MAbURvQPLvLBCcVBhgQjJ7i6BoekJIwpQDxqZ1i2Ivt
	 z8ZGcpNICFq86SkxySjzAgnQBmhYg4hEspLv/5/shOsNihbuYzfQr7q7X9t4kEyYVE
	 Te/ijdZQRGcAZ+VL4LJmcV1vtm0Dqbfk//5NDc97Tp7/GIfWwkBVppqvpA2Kyce6i/
	 MXnB9jXmiYmuaQoipc51xlDZCvkOTI4DZjaJY+p4P2dHqITklsiplJYHhpSXi0h24j
	 O10o5+TaDwmpw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1A6A3F40070;
	Mon,  2 Mar 2026 10:07:20 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 10:07:20 -0500
X-ME-Sender: <xms:qKelaTNuocR7xAIbe7OizZvEuRyiHv-gugrLM7IS-ZEICr8VUZSYZw>
    <xme:qKelaYyRUG7V-unjHiqmnZnDVH6ixuDSia3oMrw-EeIAyeRTlVfk0rMSOfrvIXelc
    8mGvSZEuw2D9FxpxXI57_0oAAYuSA9d4teAwuOPe9EejAh6tCuN2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtph
    htthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopegvsghighhgvghr
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhr
    tghpthhtohepkhgthhesnhhvihguihgrrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuh
    hsvgdruggvpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:qKelaWzplHH2832W_V-iqk1Wkjydqod0wD7l3ZtTi2Byn9V2elWGUw>
    <xmx:qKelaeI9k_SxynOJm3vrBHbZNE5FHfBw3ALNhDiCqdo4jTzFF2m_hg>
    <xmx:qKelaVWAbUT-i66LbGaLeJt-WRN8QtXu9B0BRLFMl_Da9ugXAujp2g>
    <xmx:qKelaRZteUWGEDcRzbyC1UCXrkiZXaD_wsU1Ts9wa4sIBapfqDrhkA>
    <xmx:qKelacxvThnlK-YRD9jWS-TlHhfcz2wP5cjCAYWPAhR3Zf39esABvRod>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5C76700069; Mon,  2 Mar 2026 10:07:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A1Akm2M3he9s
Date: Mon, 02 Mar 2026 16:06:58 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 "Chaitanya Kulkarni" <kch@nvidia.com>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>
Message-Id: <4b07ba4e-c5bf-4a05-8560-9660f40f8e70@app.fastmail.com>
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_070722_858055_57C7CD6F 
X-CRM114-Status: GOOD (  17.37  )
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



On Mon, 2 Mar 2026, at 08:59, Eric Biggers wrote:
> This series converts the implementation of NVMe in-band authentication
> to use the crypto library instead of crypto_shash for HMAC and hashing.
>
> The result is simpler, faster, and more reliable.  Notably, it
> eliminates a lot of dynamic memory allocations, indirect calls, lookups
> in crypto_alg_list, and other API overhead.  It also uses the library's
> support for initializing HMAC contexts directly from a raw key, which is
> an optimization not accessible via crypto_shash.  Finally, a lot of the
> error handling code goes away, since the library functions just always
> succeed and return void.
>
> The last patch removes crypto/hkdf.c, as it's no longer needed.
>
> This series applies to v7.0-rc1 and is targeting the nvme tree.
>
> I've tested the TLS key derivation using the KUnit test suite added in
> this series.  I don't know how to test the other parts, but it all
> should behave the same as before.
>
> Eric Biggers (21):
>   nvme-auth: add NVME_AUTH_MAX_DIGEST_SIZE constant
>   nvme-auth: common: constify static data
>   nvme-auth: use proper argument types
>   nvme-auth: common: add KUnit tests for TLS key derivation
>   nvme-auth: rename nvme_auth_generate_key() to nvme_auth_parse_key()
>   nvme-auth: common: explicitly verify psk_len == hash_len
>   nvme-auth: common: add HMAC helper functions
>   nvme-auth: common: use crypto library in nvme_auth_transform_key()
>   nvme-auth: common: use crypto library in
>     nvme_auth_augmented_challenge()
>   nvme-auth: common: use crypto library in nvme_auth_generate_psk()
>   nvme-auth: common: use crypto library in nvme_auth_generate_digest()
>   nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()
>   nvme-auth: host: use crypto library in
>     nvme_auth_dhchap_setup_host_response()
>   nvme-auth: host: use crypto library in
>     nvme_auth_dhchap_setup_ctrl_response()
>   nvme-auth: host: remove allocation of crypto_shash
>   nvme-auth: target: remove obsolete crypto_has_shash() checks
>   nvme-auth: target: use crypto library in nvmet_auth_host_hash()
>   nvme-auth: target: use crypto library in nvmet_auth_ctrl_hash()
>   nvme-auth: common: remove nvme_auth_digest_name()
>   nvme-auth: common: remove selections of no-longer used crypto modules
>   crypto: remove HKDF library
>

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

