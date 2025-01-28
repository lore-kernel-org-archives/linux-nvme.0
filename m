Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93424C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2S+xSD7rScry8Ihuta1Xwhf/8z1KU36UsxeLzHY70Q=; b=cPN6QiR4yUOsk4m/U6O31Vghil
	QzhkUhW80injwsrczaCMGPpmxdfzwUgRBEAtpcg7Y8Gc0RJ0nPyQQ4T8ndS7Up/o9HYlZInbI3Nmu
	6//UUfatiXM+ChMXFBvO1BwRekUe1+MRWxL4lRcMatT85YlozebUH1o9AfmEBrBkz5re4/Lsi0EzN
	zG5lomM4XRXPyyN9IftXjVa804738Z9/ypGFLnMSlStxHIsw2ujXdlI/kihHm/j24qMXQPADqJwuq
	56romGLyQird8yig7ynwdI0qR1k5uZ/wKru/svqYIGRROfHl44qqbzaRmcle8xJTmR1wa1nMhRJtI
	jn3q3s3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchOf-00000004RG3-0CG3;
	Tue, 28 Jan 2025 08:56:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchOc-00000004RFj-2nEM
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:56:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3374968D05; Tue, 28 Jan 2025 09:56:29 +0100 (CET)
Date: Tue, 28 Jan 2025 09:56:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 03/10] nvme: add nvme_auth_generate_digest()
Message-ID: <20250128085628.GB25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-4-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_005634_846428_A716DB67 
X-CRM114-Status: GOOD (  15.13  )
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

> + * @psk_len: Lenght of @psk

Spelling: Lenght -> Length.

> + * specified in item 4 above (ie the hash function of the cipher suite associated
> + * with the PSK identity) with the PSK as HMAC key to the concatenation of:
> + * - the NQN of the host (i.e., NQNh) not including the null terminator;
> + * - a space character;
> + * - the NQN of the NVM subsystem (i.e., NQNc) not including the null terminator;

Same issue with overly long comment lines as in the last patch.
(I won't bring this up another time if it shows up in the next patches)

> +	shash = kmalloc(sizeof(struct shash_desc) +
> +			crypto_shash_descsize(tfm),
> +			GFP_KERNEL);

SHASH_DESC_ON_STACK?

> +	ret = base64_encode(digest, digest_len, enc);
> +	if (ret < hmac_len)
> +		ret = -ENOKEY;
> +	else {
> +	    *ret_digest = enc;
> +	    ret = 0;
> +	}

Messed up formatting here.  But this would normally be a:

	if (ret < hmac_len) {
		ret = -ENOKEY;
		goto out_free_shash;
	}

	*ret_digest = enc;
	ret = 0;



