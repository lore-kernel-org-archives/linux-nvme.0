Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A264DC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jul 2024 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1/Ogm/lkh0frUBtsz/Pp852yruNXzsZcJjmxzlNRKA=; b=e70Cqnd2gpgxLqd3dIGFP01K6M
	m5I/+cSmzve8LiyvQDnNotQzt6etqItoqDkOV+Zb3Cg5/BcggLfwNl8qoVgHD57cPiscP3FAsyr58
	S81cfiHygqoEJbmgjYDolVu1YnKUIyhZLlNcAUUkl/9e1vJfnrnILhfKQTmM+Yp4siTGEQ/Yk4ko3
	DxFyO41VWNubzGJ32of2+kCETBkpWuTp79HO/90LKG3vRHi3x7WGdqiQudrDBcQ3qJrhaSSXfMWbh
	IkcciQRklmLHEtmDXGW2PirFwOA1wyAbLtxeQh5/PCbxjhOGbVayvcoyw/Anxlsr4OLd1vL4wsqL/
	psFrB4BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRnH-0000000BlEU-07kI;
	Mon, 29 Jul 2024 14:56:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRbQ-0000000Bhsj-0XXB
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jul 2024 14:43:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D2B361A40;
	Mon, 29 Jul 2024 14:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92C0C32786;
	Mon, 29 Jul 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264235;
	bh=7Nl2cl5gxESKjXvisLxFJo7+YZ0KeVWs8mc22mc66YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1XUonpNJnOEM0i9ATCUfP89kMilddaKp+NQF7sB2QmYfLSfiA12bvGXqWn0qesLU
	 tkS9oBm6OfW/bGKDOIXTLcGHBJKNc16BNo/pvSFOzHLSvr2T1j0CE4FkEng8oGi2Sp
	 T79EwFA66y42TDf8/YNFp076ooX1CoEGhdNEQ7MMyvJypxZIj9nd1V0cb8l0aM6M9N
	 IEI2sRbw0R/aHmHDZMBGdQ6u/nl+aFB3iUGk6vsF739Gam4fzZzbqaeIGIIHngcmlD
	 7WQQjiq+SaXW4zVcFk8zGEVQDR5M7tBB4oBLR/Pibbp6sGfFBKRHEU5GPJ3iLrMkvm
	 S5t5O/NY3ttJw==
Date: Mon, 29 Jul 2024 08:43:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-tcp: check for invalidated or revoked key
Message-ID: <ZqeqqK3XBk_eoyZb@kbusch-mbp>
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722120226.88737-4-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_074356_239309_DB729D9C 
X-CRM114-Status: GOOD (  15.78  )
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

On Mon, Jul 22, 2024 at 02:02:20PM +0200, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 05e89307c8aa..ed5167f942d8 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -20,6 +20,28 @@ key_serial_t nvme_keyring_id(void)
>  }
>  EXPORT_SYMBOL_GPL(nvme_keyring_id);
>  
> +static bool nvme_tls_psk_revoked(struct key *psk)
> +{
> +	return test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
> +		test_bit(KEY_FLAG_INVALIDATED, &psk->flags);
> +}
> +
> +struct key *nvme_tls_key_lookup(key_serial_t key_id)
> +{
> +	struct key *key = key_lookup(key_id);
> +
> +	if (IS_ERR(key)) {
> +		pr_err("key id %08x not found\n", key_id);
> +		return key;
> +	}
> +	if (nvme_tls_psk_revoked(key)) {
> +		pr_err("key id %08x revoked\n", key_id);
> +		return ERR_PTR(-EKEYREVOKED);
> +	}
> +	return key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_tls_key_lookup);
> +
>  static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
>  {
>  	seq_puts(m, key->description);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index f5f545fa0103..432efcbf9e2f 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -665,7 +665,7 @@ static struct key *nvmf_parse_key(int key_id)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	key = key_lookup(key_id);
> +	key = nvme_tls_key_lookup(key_id);

We've had some fallout before with nvme modules vs built-in, so I test
for this now. Here's the relevant parts of my config:

CONFIG_NVME_KEYRING=m
...
CONFIG_NVME_FABRICS=y
...
CONFIG_NVME_TCP=m

And that gets this error:

vmlinux.o: in function `nvmf_parse_key':
/home/kbusch/src/linux/drivers/nvme/host/fabrics.c:668: undefined reference to `nvme_tls_key_lookup'

