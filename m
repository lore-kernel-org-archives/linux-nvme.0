Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C1CCDB482
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 06:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vm35Z2nXf+oPVr2umNHbmMG57DF5rQor8aRwdfXsRjI=; b=vi8s4o83+t7pyWTlogvlgnPujf
	33Ivokf5OgnwlGa0ChO6+4hvTE9oTU6+na0QePt5KU00YTHZ6OBn+wd9ezB8YTugCtqmmxM+Li8NT
	fBOfC1oqFGk0lVtIlu1855cd0S4J1X2olc4DuzI6DxgPenNL4Vf59dmGRJugBRp9D8XLgSCjjOxbS
	8hAV83fJI5eoYVkZbf9ZOeqi1eko95HQSe7Jb0zyjvA+znrLag64hbZN7OpoaWwIAovUIEyamwnXx
	gL9ubW4tZJ3un9F0hc+I0qQDUCo60yClERwnjQ9BjxLPHAn1MNpJObYTzFP8vTSrnM2P2vTK07a+B
	Sgf5dtVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdJX-00BNLS-1i;
	Tue, 17 Oct 2023 06:12:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdJU-00BNKN-2N
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 06:12:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6C2A468BFE; Tue, 17 Oct 2023 08:12:15 +0200 (CEST)
Date: Tue, 17 Oct 2023 08:12:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de, Akash Appaiah <Akash.Appaiah@dell.com>
Subject: Re: [PATCH v3 2/3] nvme-auth: use transformed key size to create
 resp
Message-ID: <20231017061215.GB8454@lst.de>
References: <20231016225857.3085234-1-shiftee@posteo.net> <20231016225857.3085234-3-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016225857.3085234-3-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_231220_918063_39EFC58E 
X-CRM114-Status: GOOD (  12.75  )
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

> +struct nvme_dhchap_key *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)

Please avoid the overly long line.

> +		key_len = sizeof(*key) + key->len;

struct_size again.  And maybe add a helper to calculate the size for
a key instea dof duplicating it.

> +		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
>  		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);

Nit, but I find the ? : syntax very confusing when not used in things
like macros or argument lines.  A 

		if (!transformed_key)
			return ERR_PTR(-ENOMEM);
 		return transformed_key;

is a bit longer, but much easier to read.

>  	}
>  	hmac_name = nvme_auth_hmac_name(key->hash);
> @@ -257,7 +258,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
>  
>  	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
>  	if (IS_ERR(key_tfm))
> -		return (u8 *)key_tfm;
> +		return (void *)key_tfm;

This should (already in the original code) use ERR_CAST instead.

> +	transformed_key = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn);

Please avoid the overly long line here as well.

> +struct nvme_dhchap_key *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);

... and here.


