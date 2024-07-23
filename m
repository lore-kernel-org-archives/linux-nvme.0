Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233B9C3DA70
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+U+kg33vRzHia7VD3/GuMlL72dbo0wXuK0vKKUgz6gU=; b=ZFD9EwNQnugxcLZPX527s4qwjG
	HdsQAgrPZBuilKuaczZ4nTfSOblGxFRpTNBIVYSh3JmYlSmOi70kHkwifcryl6K/PT9r5g4MrjPkE
	cfiKCpfSZr03ze4BkZG/UXPLhiOf3LCCH7g51EGkZNv+fr2Gj75Md6pTYLiiwZOEmj0lBmYDRvM+s
	GiYqPBBPplQlvT3CbasRpdczA7XYvq/IaDdZf9TWOlJGkNzgRw6K4wPX+qdg/v43c9sEeh3pBf/k7
	yljQ7QQ4pzbyFhed+gimCg2CayIiO6wK688ZWqWrps437I9j7zcKyZflQs9oHFfwCzNatFz9V08Be
	AX/5B22w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4jX-0000000B5Qe-3xp0;
	Tue, 23 Jul 2024 01:54:31 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW4jV-0000000B5QF-2LLB
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 01:54:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8C60ACE0AFD;
	Tue, 23 Jul 2024 01:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96DEC116B1;
	Tue, 23 Jul 2024 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721699666;
	bh=8WCj+BKX/80lHp9Jl4kBYqEi8PSbtOt7Odt2bf8LT9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcN5DCR8DP8/CeHaBpeKF/AFovl/76AxKdVt+vfBZcx/dzT/Zhm0oaJE/EAcVkuDg
	 zR1WV7tIhhzQ7aAbaKjiO7vuqijDzVaMUJTXnAQnhpyAlaTbXefD1smEmoRK9yys51
	 m0AHdAWnW5zP1/QRTAt3w2x3QsZATp5Wi6khKrbPxMZRxa3CrwauvnNX1g1YEUxwQG
	 N+D9FHwTMzbSHEnf8SqsWBIyTVaAjCIsq1izn0dFmVdfrK/ySaNgZInoLB7aBrA9zt
	 wyFnT3Y3jbMOq/AUKBw928blVo4G/w902Ad4//sTqfBBjALjGvlBeRxcb+6pPz7USC
	 sQnJ2tKTilQPw==
Date: Tue, 23 Jul 2024 01:54:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-keyring: add nvme_tls_psk_refresh()
Message-ID: <20240723015425.GD2319848@google.com>
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-6-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722142122.128258-6-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_185429_793258_9729C342 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jul 22, 2024 at 04:21:18PM +0200, Hannes Reinecke wrote:
> +struct key *nvme_tls_psk_refresh(struct key *keyring, char *hostnqn, char *subnqn,
> +		u8 hmac_id, bool generated, u8 *data, size_t data_len, char *digest)

For inputs use pointer to const, e.g. 'const char *hostnqn'.
This applies to the whole patchset.

> +	identity = kzalloc(identity_len, GFP_KERNEL);
> +	if (!identity)
> +		return ERR_PTR(-ENOMEM);
> +
> +	snprintf(identity, identity_len, "NVMe1%c%02d %s %s %s",
> +		 generated ? 'G' : 'R', hmac_id, hostnqn, subnqn, digest);

This is reinventing kasprintf().

- Eric

