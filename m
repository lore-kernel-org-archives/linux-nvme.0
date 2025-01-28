Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86931C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqt/l1fY0yY1ltAPPsJGzJcqm1E/Tt/jz6A63buZzKY=; b=WzxQOqSuV6lHeWQEMD4OnweLK/
	uALi6uFYfQtWVTh5qLH4NXvvjNY24HoRGZywa1DbM7+PDIvmim7g6dU3tn5EHDLwVp1HvDI88bQ3f
	FmXukUTyYndHdCHlYSib3gzjssjUIVIqC6bz7UqCONXkaghdtLqjusKbvSqgCqAtkT4xHpNm4ftGC
	qGZzT0tP+/VMC0H0UYGHLk+M/fs6HTHkokZvV81sEcEv/y5j6zDSiLNsR0MbSVttskjaxMQelOdcr
	/t4/hlo5KxQxE4zfILC4Mwh4SbScm39U//wgVfJxik8/pL6uPFVpjv59WDKGFXLIXYFA8Hj7py22h
	NtjT5kmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchMK-00000004R0m-18Eh;
	Tue, 28 Jan 2025 08:54:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchLt-00000004Qzs-13R9
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:53:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6B0068C4E; Tue, 28 Jan 2025 09:53:37 +0100 (CET)
Date: Tue, 28 Jan 2025 09:53:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/10] nvme: add nvme_auth_generate_psk()
Message-ID: <20250128085336.GA25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_005345_438155_D4A2227F 
X-CRM114-Status: GOOD (  16.29  )
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

> + * Generate a PSK for TLS as specified in NVMe base specification, section 8.13.5.9:

Please fix your comment to stay in 80 characters.  The line wrapping
here makes the text almost unreadable.

> +int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
> +		u8 *c1, u8 *c2, size_t hash_len, u8 **ret_psk,size_t *ret_len)

Missing whitespace before the last size_t.

> +{
> +	struct crypto_shash *tfm;
> +	struct shash_desc *shash;
> +	u8 *psk;
> +	const char *hmac_name;
> +	int ret, psk_len;
> +
> +	if (!c1 || !c2) {
> +		pr_warn("%s: invalid parameter\n", __func__);
> +		return -EINVAL;
> +	}

No a very useful error message.  Given that this is a violation of
the API contract either a WARN_ON_ONCE or just letting the crypto
algorithm fail should be fine.

> +	tfm = crypto_alloc_shash(hmac_name, 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	psk_len = crypto_shash_digestsize(tfm);
> +	psk = kzalloc(psk_len, GFP_KERNEL);
> +	if (!psk) {
> +		ret = -ENOMEM;
> +		goto out_free_tfm;
> +	}
> +
> +	shash = kmalloc(sizeof(struct shash_desc) +
> +			crypto_shash_descsize(tfm),
> +			GFP_KERNEL);
> +	if (!shash) {
> +		ret = -ENOMEM;
> +		goto out_free_psk;
> +	}

Is there a good reason this can't use SHASH_DESC_ON_STACK()?


