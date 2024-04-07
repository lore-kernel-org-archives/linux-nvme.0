Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1ECD128A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUrWL9hZ4Mr78vxQuu91CHc+kmPbnGOtM+4nq6POMfo=; b=WCF5qDFCGco/UhhaVQJ5xgfqtO
	eDGAfPiWZzUQenO8uxVfZ8/3Au/UvvHr77DtvCZYchoCtcvquwjIUaqe7nq2zEACCw7b4jtiPjy7q
	1IDx5oQ+VI8ztGRykdnnVemCb4YlvGIk4K4DGvGzqnfPf6Wyi4uPhrN1QfJ90zkt4CfsxCdTN8Lev
	00y+1L/e6MeshlOU3UfXV5571en86u/d9jZi5Sk/ghtUlDYQsA8fwh8ErY6TJZ7b7fVk7Db5rEwH8
	ZDrs0Cr0q3SuwxZ1aMaomvtg35gThDwzOkK3XcQOq84j7KVOvy1mIuFZnHmWGuMQwUm+pd/JtOmhp
	iUFo3NSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZgo-0000000DVtL-3fGA;
	Sun, 07 Apr 2024 21:04:34 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtZgl-0000000DVst-3KS8
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:04:33 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34584c783acso284367f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712523870; x=1713128670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUrWL9hZ4Mr78vxQuu91CHc+kmPbnGOtM+4nq6POMfo=;
        b=GjHLj93V/bby92H8hPSg681MNUe5rM+WUsZq+Bmp3M8D/8ei1fmLkAUUeqeCSseSDk
         7KB+ZDVn09hC6rWc1RzCwYV4APmtjrtC16/xvnwTRPNNNrx37A42Mo/IfvGwNg9hN9fa
         ClikXBgcq5RwM9kyxm4Z127ub42UDbDuqi/zf8WNjxa8xHSsoduGytg9RUYG29N9Xfmr
         xUnZ7gTBGRasSUsIrgWo/GqcbWof8rrGUSQY9mNZoNdypPLBFyGQbC+wDHGv3lGI4LWl
         TcRwC5uvPajJOES8Sq1rnf0m1gpQVxvi3Mo8EzLjuXkWmOH3vdTL4Qqu6jYMrBNzAmvW
         DPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXdYm/Yt3Tuf3wZgOmFz/zDUtRaYl97t+ajlCgczhWzJdtv8B+0E3dDBcQ/UfaSrtYpCEZJSxC3yKjnkXDX+O8tbrOI5Mn4GH99VIftcc=
X-Gm-Message-State: AOJu0YyLorqLjs5jRAO3493CqXO1HFVt9KWm2q+VlPwm7oohBMzdgb1D
	5nkiIaxK1Ckp32ryZWy2GZUZrRnvX5QFcbH/iTDWkypEd3KwV6YCbKvyz5uR
X-Google-Smtp-Source: AGHT+IFYbt8BTuzxY91lCtnPsvnhoJevkWo7JQ3g87iwzJ7pXWe/lrPWVctAQHtuolo3CuvQasejfQ==
X-Received: by 2002:a05:600c:1c94:b0:416:7470:43c4 with SMTP id k20-20020a05600c1c9400b00416747043c4mr427081wms.2.1712523869649;
        Sun, 07 Apr 2024 14:04:29 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0041567ce9f10sm11033351wmq.0.2024.04.07.14.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:04:29 -0700 (PDT)
Message-ID: <c0c4beac-2680-411f-bd1d-45db6d1c3792@grimberg.me>
Date: Mon, 8 Apr 2024 00:04:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] nvme: add nvme_auth_derive_tls_psk()
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-7-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_140431_877720_8EF91299 
X-CRM114-Status: GOOD (  17.30  )
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
> Add a function to derive the TLS PSK as specified TP8018.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/auth.c | 71 ++++++++++++++++++++++++++++++++++++++
>   include/linux/nvme-auth.h  |  1 +
>   2 files changed, 72 insertions(+)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index f56f08a4461e..90d525afc240 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -652,5 +652,76 @@ u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
>   
> +u8 *nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len, u8 *psk_digest)
> +{

Same comment here.
Can you please add a description of the derivation process in a function 
comment?
It is not trivial for me to follow.

> +	struct crypto_shash *hmac_tfm;
> +	const char *hmac_name;
> +	const char *psk_prefix = "tls13 nvme-tls-psk";
> +	size_t info_len, prk_len;
> +	char *info;
> +	unsigned char *prk, *tls_key;
> +	int ret;
> +
> +	hmac_name = nvme_auth_hmac_name(hmac_id);
> +	if (!hmac_name) {
> +		pr_warn("%s: invalid hash algoritm %d\n",
> +			__func__, hmac_id);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (hmac_id == NVME_AUTH_HASH_SHA512) {
> +		pr_warn("%s: unsupported hash algorithm %s\n",
> +			__func__, hmac_name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
> +	if (IS_ERR(hmac_tfm))
> +		return (u8 *)hmac_tfm;
> +
> +	prk_len = crypto_shash_digestsize(hmac_tfm);
> +	prk = kzalloc(prk_len, GFP_KERNEL);

What does prk stand for?

> +	if (!prk) {
> +		ret = -ENOMEM;
> +		goto out_free_shash;
> +	}
> +
> +	ret = hkdf_extract(hmac_tfm, psk, psk_len, prk);
> +	if (ret)
> +		goto out_free_prk;
> +
> +	ret = crypto_shash_setkey(hmac_tfm, prk, prk_len);
> +	if (ret)
> +		goto out_free_prk;
> +
> +	info_len = strlen(psk_digest) + strlen(psk_prefix) + 1;
> +	info = kzalloc(info_len, GFP_KERNEL);
> +	if (!info)
> +		goto out_free_prk;
> +
> +	memcpy(info, psk_prefix, strlen(psk_prefix));
> +	memcpy(info + strlen(psk_prefix), psk_digest, strlen(psk_digest));
> +
> +	tls_key = kzalloc(psk_len, GFP_KERNEL);
> +	if (!tls_key) {
> +		ret = -ENOMEM;
> +		goto out_free_info;
> +	}
> +	ret = hkdf_expand(hmac_tfm, info, strlen(info), tls_key, psk_len);
> +	if (ret)
> +		goto out_free_key;
> +
> +out_free_key:
> +	kfree(tls_key);
> +out_free_info:
> +	kfree(info);
> +out_free_prk:
> +	kfree(prk);
> +out_free_shash:
> +	crypto_free_shash(hmac_tfm);
> +
> +	return ret ? ERR_PTR(ret) : tls_key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_derive_tls_psk);
> +
>   MODULE_DESCRIPTION("NVMe Authentication framework");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
> index 2cbb9249a8b3..335236fb2b73 100644
> --- a/include/linux/nvme-auth.h
> +++ b/include/linux/nvme-auth.h
> @@ -44,5 +44,6 @@ u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
>   			   u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len);
>   u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
>   			      char *subsysnqn, char *hostnqn);
> +u8 *nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len, u8 *psk_digest);
>   
>   #endif /* _NVME_AUTH_H */


