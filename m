Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C2BEB3641
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j50yp53cJpBOwuMlWCAUutHgWir2lmTl/81hIzothnM=; b=E7Tj757ofVS8OxphJxAJbyzDxg
	OwU9FLif6sO+o7HBRaR5CyKuLOrvgZ5IFwI5izQv2ImcmiTd2yiMKQ8kzdh83GcqIuc6gvHjmF9m1
	yiRtfy7hTYIUTDusXSYXe1R5LqZqjStpi5A5j9aowrmOlHXRTG/ibT1HoRbRNO8DxY90lRcQoTWS7
	32j+nC5CYOuO87/el4Ioxpat++uL/QeVTiCwQxDHme5wwrZiUTmu5lT40VSjDsTneginI47POjXHm
	Lj5mc80RjFgB7Pgza1B9omzw2FXq8+nEOfXS8K83bWPAIR3+/OMWy44eYYnwRxitSCnfafTAMAwWm
	KOygIJYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxDbD-0000000EGHT-169p;
	Tue, 03 Mar 2026 00:26:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxDbB-0000000EGH2-2k4K
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 00:26:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BE96360126;
	Tue,  3 Mar 2026 00:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D999AC19423;
	Tue,  3 Mar 2026 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772497612;
	bh=Rc0DxRChtbCtwoaq+0s82dkSSZYybO5p84C4yP4BPJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xts27gHBFzglUcIOSJ9h7fOAYvOeZ3Qi2foAc1cmLi1j42spxy4+pYMOH7h6L2dTx
	 I4jHoxdUQdMVPguCKBsLD1j2Imnls4CYdQB9e3I7C9EuWncKgsw1pbRQPVeGkddVT8
	 FI6RtVw4EVaY34PoTpK7J5Ps1SxR6bm9wJLMxChQ8ggHhy/N3Cu5oXTpNBcSkrH9+I
	 AOFBPaDG8g4hWYu6onEzVPixpuWpBoO694s9j1O/75Tx8my8u18LozLHCBk4FrrM3E
	 macFN80RmmZipM7/sKnkHy5WISxSE+ohcAXswkkEPnvvvDDpCHW+LirAHWp5P2JMJw
	 1rXnnRhORkvXg==
Date: Mon, 2 Mar 2026 16:26:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 04/21] nvme-auth: common: add KUnit tests for TLS key
 derivation
Message-ID: <20260303002649.GE20209@quark>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-5-ebiggers@kernel.org>
 <1de7ef59-4236-4372-81f6-60d5a4f1e253@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de7ef59-4236-4372-81f6-60d5a4f1e253@suse.de>
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

On Mon, Mar 02, 2026 at 11:04:43AM +0100, Hannes Reinecke wrote:
> Which discrepancies do you see between the specified algorithm
> and the implementation?

I'm looking at the latest NVM Express Base Specification, v2.3.

First, there's the following:

    The host computes KS as the hash of the ephemeral DH key resulting
    from the combination of the random value y selected by the host with
    the DH exponential (i.e., gx mod p) received from the controller
    (i.e., KS = H((gx mod p)y mod p) = H(gxy mod p)).

The actual code skips that step when deriving the PSK, and just
considers the DH value directly to be "KS" and uses it directly as an
HMAC key.  That is something that should never be done.  DH values are
not uniformly distributed and must not be used directly as keys.

Second, the only mention of HKDF is in section 8.3.5.6.2.  Assuming that
corresponds to what was attempted to be implemented in
nvme_auth_derive_tls_psk(), it does not match because (at least) the
specified label does not match the one used in the code.

Those are just a couple things I noticed in a very quick glance.

(There's also the key reuse bug I pointed out before.  But it sounds
like that's a bug in the spec, not the code.)

- Eric

