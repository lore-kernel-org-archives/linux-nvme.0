Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DADCD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xc5wwIA+wuX+FrvvNwBxRAL6BCym8h/2s85B6+mqOng=; b=Gmj+zP7CE7CE+iGy2Eki2Z6KKs
	4QU6dk2Vh+vPuVh8jnEdEg6IDn5/OHE7aHUhzOn3DABZUmeLY4n0Ej5O4MBOufEDlxk1bxebpVZ9f
	xk9Z3h+ba4eIudZTAvHn0YeZtiYGrU2YB4a4oE4gTux6mjqqqQjnagJrSEeXTFRF17Y/GQUcUqpzb
	jfznmWcZ2tNvcLnAMmrsrcbyi+1nWSAdH5PKMW79RiHj3VcXA0yOP6ULjttut3b6voSTXIZad1E8o
	Dqxl2V7+itRCu7clbbgzEMT4+Ax9rqYUg/JFzX4urroMvkKPV/9iVEiWrSVKye6kryfAxKb2K6RmY
	b2d7rx5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZec-0000000DVcL-01t6;
	Sun, 07 Apr 2024 21:02:18 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZeZ-0000000DVbZ-0zAS
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:02:16 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516ced2f94cso1164393e87.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712523729; x=1713128529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc5wwIA+wuX+FrvvNwBxRAL6BCym8h/2s85B6+mqOng=;
        b=FDyYRq+1/R+F1iIEliBp1g7IC2Ux24WwL+6OdSuNBm8OnLwKjCASf1c45VcRYd/aJz
         RF5jQ72GibGJJzGoFliO93DtVzkfo/Pg5t5GYHMecCRGGVcWxYI9VFtKStFLTGOVlE5/
         ezRqGgcS/2UT31IhlDk3rfOSiXiPIfMQLTFzx7IXlMLn4vSmS28mvIw/bf0vlhvZ4Rip
         F6BgKR9TIlj6IbgDq3Vg1KnXclkBaCtcizwCMfzSrbyzQSSJdtiLbPRcscUD1NJC3oFz
         DReDdNiJb2KHOqyQ0k5CM6kqGNVnv68PgXNqTA8h6afAkrRVUpfo/rSRawmjCe7ZU5Be
         4ctA==
X-Forwarded-Encrypted: i=1; AJvYcCVK+lpN0SkZB+wrjymj6yHIv342KeFcNnCQhzfpDessZ5tjIQeqEp4ZWbrZscIothBYLTEa8zs2caw4NLITjf9GWLYs5PtJAVhrma4P4CE=
X-Gm-Message-State: AOJu0Yzj0n82q+TRnAn9yzkuuBTifC222QzOkPyM+yqB0sbVv/MEoaLX
	IEgFmSUhtg3Cqwq4F5uZvTu9iwKiz+DqT3/vGT65K1OKeeac4pZWNrn33vZG
X-Google-Smtp-Source: AGHT+IHniq1szqyFWmYvEzUHKYh/AoefwwgsxjA6Z55XpelbfiliR31NV50P6dUwK+LQaEKyoW+EVQ==
X-Received: by 2002:a2e:86d0:0:b0:2d8:1b2a:6526 with SMTP id n16-20020a2e86d0000000b002d81b2a6526mr4414118ljj.4.1712523729334;
        Sun, 07 Apr 2024 14:02:09 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b004148d7b889asm14722329wmq.8.2024.04.07.14.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:02:09 -0700 (PDT)
Message-ID: <dcfee7a6-a7d3-4e1e-8b12-e19939ada427@grimberg.me>
Date: Mon, 8 Apr 2024 00:02:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] nvme: add nvme_auth_generate_digest()
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-6-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-6-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_140215_312324_0F827AA5 
X-CRM114-Status: GOOD (  16.82  )
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



On 18/03/2024 17:03, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Add a function to calculate the PSK digest as specified in TP8018.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/common/auth.c | 105 +++++++++++++++++++++++++++++++++++++
>   include/linux/nvme-auth.h  |   2 +
>   2 files changed, 107 insertions(+)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 7a4b6589351d..f56f08a4461e 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -547,5 +547,110 @@ u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
>   
> +u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
> +			      char *subsysnqn, char *hostnqn)

Same comment here.

> +{
> +	struct crypto_shash *tfm;
> +	struct shash_desc *shash;
> +	u8 *digest, *hmac;
> +	const char *hmac_name;
> +	size_t digest_len, hmac_len;
> +	int ret;
> +
> +	if (WARN_ON(!subsysnqn || !hostnqn))
> +		return ERR_PTR(-EINVAL);
> +
> +	hmac_name = nvme_auth_hmac_name(hmac_id);
> +	if (!hmac_name) {
> +		pr_warn("%s: invalid hash algoritm %d\n",
> +			__func__, hmac_id);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	switch (nvme_auth_hmac_hash_len(hmac_id)) {
> +	case 32:
> +		hmac_len = 44;
> +		break;
> +	case 48:
> +		hmac_len = 64;
> +		break;
> +	default:
> +		pr_warn("%s: invalid hash algorithm '%s'\n",
> +			__func__, hmac_name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	hmac = kzalloc(hmac_len + 1, GFP_KERNEL);
> +	if (!hmac)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tfm = crypto_alloc_shash(hmac_name, 0, 0);
> +	if (IS_ERR(tfm))
> +		goto out_free_hmac;
> +
> +	digest_len = crypto_shash_digestsize(tfm);
> +	digest = kzalloc(digest_len, GFP_KERNEL);
> +	if (!digest) {
> +		ret = -ENOMEM;
> +		goto out_free_tfm;
> +	}
> +
> +	shash = kmalloc(sizeof(struct shash_desc) +
> +			crypto_shash_descsize(tfm),
> +			GFP_KERNEL);
> +	if (!shash) {
> +		ret = -ENOMEM;
> +		goto out_free_digest;
> +	}
> +
> +	shash->tfm = tfm;
> +	ret = crypto_shash_setkey(tfm, psk, psk_len);
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = crypto_shash_init(shash);
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = crypto_shash_update(shash, hostnqn, strlen(hostnqn));
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = crypto_shash_update(shash, " ", 1);
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = crypto_shash_update(shash, subsysnqn, strlen(subsysnqn));
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = crypto_shash_update(shash, " NVMe-over-Fabrics", 18);
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = crypto_shash_final(shash, digest);
> +	if (ret)
> +		goto out_free_shash;
> +
> +	ret = base64_encode(digest, digest_len, hmac);
> +	if (ret < hmac_len)
> +		ret = -ENOKEY;
> +	ret = 0;
> +
> +out_free_shash:
> +	kfree_sensitive(shash);
> +out_free_digest:
> +	kfree_sensitive(digest);
> +out_free_tfm:
> +	crypto_free_shash(tfm);
> +out_free_hmac:
> +	if (ret) {
> +		kfree_sensitive(hmac);
> +		hmac = NULL;
> +	}
> +	return ret ? ERR_PTR(ret) : hmac;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
> +
>   MODULE_DESCRIPTION("NVMe Authentication framework");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
> index 31dc1db2d4d6..2cbb9249a8b3 100644
> --- a/include/linux/nvme-auth.h
> +++ b/include/linux/nvme-auth.h
> @@ -42,5 +42,7 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
>   				u8 *sess_key, size_t sess_key_len);
>   u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
>   			   u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len);
> +u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
> +			      char *subsysnqn, char *hostnqn);
>   
>   #endif /* _NVME_AUTH_H */


