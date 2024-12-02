Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA66E69E81
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHwrI71S4SfGCbdaA/PTqWwRLZNgaMfV1z5PVSFJx1M=; b=3IDEVgWM8VsTh7nabk31k4QgfQ
	XjVuxptp5Kw10Whi6zXA0Dpf2/skjKYMJOMOgTHaDmuCMcaEp82k4kvQaMizXvo9lLRIVcMzd+c/p
	hDfsbp2dcdydRtFsZW5pPPKn0vkN6mIaQrVOv4mz6dOnaK1o7m5UfBkwfZ9FEIedf9iMYeu3Ctl83
	CG6O4/EdUJOqDtPz8Sd0d33YBbgJvSpmYDJ/MRToVGLptAB3HD1o8m87bmn0j81oE7ShSTi/+/CVK
	yZVOBhfQoWesRY+1p9duEMTcfYmCoLsyF5eU8TET3qrY4ePK6PN4CFQdO+Dnf08Vo63s4tSVCdXO9
	HSCZlKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIB8r-00000007A5U-2i9B;
	Mon, 02 Dec 2024 18:27:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIB8W-00000007A1u-13RM
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 18:27:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C192B5C61C4;
	Mon,  2 Dec 2024 18:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5BC4CED1;
	Mon,  2 Dec 2024 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733164027;
	bh=wdKK+PkyJH3h5ZrI5lebesLfAgsK4mHhtintSvua9v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQm+DOhDwjUknLItBzTtpBjXsSgVwGpaTijCxo/G8ymdaXOZalcv3FSOeVI+R4nCT
	 IHWLnwz6Y37a4Iq2KcVEhxaFTc95iMzMwjFw4Sk/w6MKk1JGyswpuTl2zC7we4A5p/
	 QVAZGjQ41J8ydnfg0BX3ZCVlzml17b/CFwGDzLGPZ7bQUksO27zdAcCBlCoRo/EQH+
	 ZYufhbpVihvSQddYETfHptLYm4TMvP5esjLC/kkQSBdd7c0Pz122uU4R9qlL63QFpX
	 MWfrg1m99qVDFTZSJ4gZ9q4RTc0DH8++Mlp4Mdr35O1EBnf+7Jg/Worzzc98EZQAXp
	 yAdDgGQBhl3FQ==
Date: Mon, 2 Dec 2024 10:27:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 01/10] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20241202182705.GA2037@sol.localdomain>
References: <20241202142959.81321-1-hare@kernel.org>
 <20241202142959.81321-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202142959.81321-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_102708_327280_E8FE2093 
X-CRM114-Status: GOOD (  11.93  )
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

On Mon, Dec 02, 2024 at 03:29:50PM +0100, Hannes Reinecke wrote:
> Separate out the HKDF functions into a separate module to
> to make them available to other callers.
> And add a testsuite to the module with test vectors
> from RFC 5869 (and additional vectors for SHA384 and SHA512)
> to ensure the integrity of the algorithm.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: linux-crypto@vger.kernel.org

Acked-by: Eric Biggers <ebiggers@kernel.org>

> +int hkdf_expand(struct crypto_shash *hmac_tfm,
> +		const u8 *info, unsigned int infolen,
> +		u8 *okm, unsigned int okmlen)
> +{
> +	SHASH_DESC_ON_STACK(desc, hmac_tfm);
> +	unsigned int i, hashlen = crypto_shash_digestsize(hmac_tfm);
> +	int err;
> +	const u8 *prev = NULL;
> +	u8 counter = 1;
> +	u8 tmp[HASH_MAX_DIGESTSIZE] = {};

Zero-initializing tmp is not necessary.

- Eric

