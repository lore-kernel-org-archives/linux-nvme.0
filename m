Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5E9FD88FF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 05:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FnV2DfU6ldlRaffTdYqRxLYaw5d0RnAJCdmdUSnBsuQ=; b=ExvYZ9aqQw0byx2SXOUckJtf3B
	LdyJ/6CDjHFgu+8wNybhZe/9ZgGBrEPUXJ7x4d1f2b76ZMmtG69cJAOM9Y2iLOFbnLwwCDsRrWOfT
	XlZdE7NPkEFQSv6pGjYoiNF6GBkyrD8KvV+AL6rlqeYgfU3xnHw1I0NMfDLF5avKJlkCkrmVlNPG+
	i7A5bUzdRjuT2myJLC9nJ13W2hoG5Q8/XwUp7u0QFQbVfB9SxpgaRxhvF5DDTZpj3S9Tiv2VQP9L0
	Y3YiWG2ULkvF3XtOjQbREFzZXHwW+tMBwD7hrVvqSly09w2Ua1+Uc5BvW95Tuz4b4JyR1tFr/brsd
	OSQzImhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Bu7-0000000AlS5-1GjM;
	Wed, 11 Mar 2026 05:14:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Bu5-0000000AlRZ-1BHV
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 05:14:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9556C432E2;
	Wed, 11 Mar 2026 05:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0FBC4CEF7;
	Wed, 11 Mar 2026 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206080;
	bh=veBtBZqsPCDiDvE3BhdzsHoI2Ff31H2EGTdGuA2m8oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieOmcqdaJz05iBarna7fBEjphEohBZnCW3igbgikBAwCWUGPr8jPtbk6NzdTVswWo
	 oj6gGRzILTFkTOULDtS/ku35AWf2hvhMnQu8LX29Vj11CONFuUudeyhTc7Q/y2EO9o
	 +S3nOokoIB3oQ9akgI8E4G3Iaw7MT6RQcKy0WpDBKprV1yq3uzsJro2KpUkfBniAfS
	 7p0HVwDpf5f9yx2kJvdZQx+OHyVS4ltd6IE0iZYTS9ei3TsRlBEfUjK92rb7rw/NvV
	 lMBYjrLl2p//Bw1yIdqe0NLTwX9/uk9VbHBCuSCNb/cZOhFPmCsYw2YwXlFj8NIyE/
	 9ENZZSXAzi90w==
Date: Tue, 10 Mar 2026 22:13:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme-auth: Hash DH shared secret to create session key
Message-ID: <20260311051340.GA2270@sol>
References: <20260311012116.2504291-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311012116.2504291-1-cleech@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_221441_341723_A70403FB 
X-CRM114-Status: GOOD (  14.09  )
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

On Tue, Mar 10, 2026 at 06:21:16PM -0700, Chris Leech wrote:
> +/**
> + * nvme_auth_gen_session_key() - Generate an ephemeral session key
> + * @dh_tfm: Diffie-Hellman transform with local private key already set
> + * @ctrl_key: Peer's public key
> + * @ctrl_key_len: Length of @ctrl_key
> + * @sess_key: Output buffer for the session key
> + * @sess_key_len: Size of @sess_key buffer
> + * @hash_id: Hash algorithm identifier
> + *
> + * NVMe base specification 8.3.5.5.9: The session key Ks shall be computed from
> + * the ephemeral DH key (i.e., g^xy mod p) ... by applying the hash function
> + * H() selected by the HashID parameter ... (i.e., Ks = H(g^xy mod p)).
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int nvme_auth_gen_session_key(struct crypto_kpp *dh_tfm,
>  		const u8 *ctrl_key, size_t ctrl_key_len,

ctrl_key and ctrl_key_len should be public_key and public_key_len.  It
is the public key of the other side, which can be either the host or the
controller.

> +	hash_len = nvme_auth_hmac_hash_len(hash_id);
> +	if (!hash_len) {
> +		pr_warn("%s: invalid hash algorithm %d\n", __func__, hash_id);
> +		return -EINVAL;
> +	}
> +
> +	if (sess_key_len < hash_len) {
> +		pr_warn("%s: sess_key buffer too small (%zu < %zu)\n",
> +			__func__, sess_key_len, hash_len);
> +		return -EINVAL;
> +	}

Probably should be tightened to 'sess_key_len != hash_len', since this
function writes to exactly hash_len bytes and does not report the length
it actually wrote.

- Eric

