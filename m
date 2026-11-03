Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE2606A332
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=11RHfbK+;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfyW7SjQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jCFfZJGemn1JU+wzUlcxr5wK/hc7cIdFHCwQVVaYBDo=; b=11RHfbK+lFb3IBd/saji6BZ0sT
	DSsQcshyHvLLwpP/XfTJCa8hKl5xBa3qDpGbfzXd9GncMnDzYvQjh4vuP6B0S98+AmJKJqeN39QLh
	W2PyS6dbpTv968YOLaYZeKy8YrW/FEuIsbb78yE2NgiIigL2ZOcxzwb/wPk3UfMmpWAVrz2rRemb1
	O9IXF4pibeZrowAwYyClElB2z1KNRwerhSCKlB1joFNwGhfdVtiJP3LnO9Ztvv/dfYAWVsNa20gui
	yQjuWswwxfsECHjgSqWj75kVmrcxpib5gbsnCHpvLx4j0F/ktf2mU3dvS2ssPsMTBcRLyrF53Fi0g
	L0nEYI/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGUu-00000002ykg-0pxc;
	Tue, 03 Nov 2026 15:32:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGUt-00000002ykW-0fSP
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:32:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C5496022B;
	Tue,  3 Nov 2026 15:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C809C1F000C1;
	Tue,  3 Nov 2026 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719946;
	bh=jCFfZJGemn1JU+wzUlcxr5wK/hc7cIdFHCwQVVaYBDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MfyW7SjQ9UhGhzbG+F9lKV34NRvyqtTBHIFrsgdFPEyk08fiH2S1lQ+IUg8PzcdHO
	 Vjas8MqMO/RpjYcJQ5vCSh33FgLZrLj2jgxvEJx31tVKn6Eg+KCQNvSN8IJqF6qr/G
	 QZZyQXxARKP1t53dyIF83UM2LOiSffmRT3sGO1qwoh6+XcvZR8l4SJq6dCA0mncQaw
	 fDbBHA7HPXVTe9gzLUIXS1xEk7PSV5SSWVP7GywX7gGiqLqMexfPg9mjmlphhsTdBV
	 0Smcn/QHmO3XYmPvGbn86sgWs58E6sBNccHK4VQrxpcrIrqYuH8FHlmeOyDKRLk2st
	 vmpXekcZiUqyw==
Date: Tue, 3 Nov 2026 08:32:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hugo Deco <hugodeco@sufficit.com.br>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: add NO_FUA quirk for ADATA XPG GAMMIX S70 BLADE
Message-ID: <aun-iBepyYhdGsZ5@kbusch-mbp>
References: <CAGFVba_mDRomduXFV5HugBvb9sKhNzdhgDvkCvUvcdOhy4ri4Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGFVba_mDRomduXFV5HugBvb9sKhNzdhgDvkCvUvcdOhy4ri4Q@mail.gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 08:21:25AM -0700, Hugo Deco wrote:
>  static const struct nvme_core_quirk_entry core_quirks[] = {
> +	{
> +		/*
> +		 * ADATA XPG GAMMIX S70 BLADE (fw 03020P5E) takes 200-600 ms
> +		 * to complete FUA writes while Flush takes ~1.3 ms.
> +		 */
> +		.vid = 0x1cc1,
> +		.mn = "XPG GAMMIX S70 BLADE",
> +		.quirks = NVME_QUIRK_NO_FUA,
> +	},

Can you add this to the nvme_id_table in the pci.c file instead? That
seems safer than matching a specific model string. There are several
other ADATA devices in that table, too.

