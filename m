Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7309CD10386
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnJRpP2qonDJzuYdD19JpDSHLL0kUhhye4VrzUEMock=; b=vVqDxWR7jv5C2Mp/Z3rrp7KRNU
	mJDWQBJQ7/FTsSfmGyjBnHNnOnOtINoJQpdchxZLnesrS5BE37v37GBlYlNPi9kCgvRK8kZ1XLQju
	zHVILSdBaBcSnuI2Q2y0bd1G5OHVB+R7U0gbCaBC50hJuCthEpZ5C4pO4sFAzACkulFxlI4l8hVai
	VYQQKCMqld+g5mH1MnsJd85gDN+sBRRgX8wvF8qFz4sN5QpX9tygffnGJeiTC3XLwV2UyN9NjWTdA
	WFMQPcXi6RCIh3Zb6QCsvJ9v4PGyp/lnVfcpzFNeU8NUBKXn5qhOK2ppk6LrbZ7dLUTFL7D0/QENG
	jiHNe2Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOALT-0000000EYgn-2uMd;
	Wed, 26 Nov 2025 07:53:47 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOALQ-0000000EYgO-3Uqt
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 07:53:46 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so52348735e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 23:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764143623; x=1764748423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnJRpP2qonDJzuYdD19JpDSHLL0kUhhye4VrzUEMock=;
        b=F3rvRv+3EiqFrk1Fg08J+ojyDD8RtXDTF0lw0NAJl9ecHxyvq1tZ+HTPRTxyw5+uBa
         1e3A0LQm9Ib7nDK/PHylppai43KyrxG/KRf/LeevuBLdgIc7cK8XvNiP/287us5EobWV
         6LEUYN1QvDCjqZbPEUKqtB5QyDT3wS0SyHKF71g+NGAbLdADQn5Opwtj5aW5N+qRyctE
         YFI52AjDT+mijDtRBj4MT2xvMzFBBk6Qu/0v3TB0GIRgqPGv4jkBfhDbBhr08BbAb7++
         JZh1epLLv9liWyC9/Ox8OebWhapgLMTsmj4KhzIHFc24tKcDGuFjxZx8qBn0nTfvd77C
         31XA==
X-Forwarded-Encrypted: i=1; AJvYcCWvb/ahLFyj+tD1aQDtGXXINgMEn3Z4sUbzRfOUJcSD/dacTWVQwXSD3Z+BGpMW793gYf5r5NfUOsJQ@lists.infradead.org
X-Gm-Message-State: AOJu0YyXW5hN2vsnph2tj4KoH5ZuRGXdCCRZ+0+u8av6I47F72oLI5yy
	xH66X+VlLD/rh0WHF/XBdGwLP50nDqt6gJgSQ62ZDSPjJlyg3DrqjvdcxnQudA==
X-Gm-Gg: ASbGncuvmPaliFQmwgpZKBR1sZcaGY9dHiCqXHhbfuZkqgppkYxw6xKAJbGJ7OjKcvv
	FYO5k2gNHd/krAx4CovZy1VsitPBcIadRKLBCe2wLndA5gfz/KxD4mnIQR0hJToMYfDrBSwY2ee
	JBRUMHQvco97N/i1UyHsjgmFV7wNuALagRIHisoL/xMkE6XAcRxfT4z0Sb6mpvPRfY242FJ76HS
	+bodS8nlISdNiIoH4/UiQ7rNTsK2w+ZLUkmcYnIzXxyoEjf8rsvxsmLZRQvy3owVP+gb7GEJO4F
	9/Le1m0E45vfx4D1EQ6REix5l8Wskv9QVNpkAwn/h87vQbJBPm4jBect05IZfDnJ2o2lKW7mqAK
	chG+gRi4O4hkAWYVHbIoN1KNNP1+sCnqrfKuoNmMB13jpFnpxkHuhK65R6Pmx13qesxmkE9jreC
	VrBVRcjY53vcFJLJmM+XbiWpk+m60htzeY6S2UPpQlm6MJLsc8mAvW
X-Google-Smtp-Source: AGHT+IGMoBUWHZUuwe76ccRbjKwVyxA1tlztywzbMHVIT77ak77tH7CIQx2eH6hd64d8U2OXKnBDRw==
X-Received: by 2002:a05:600c:46d2:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47904b1afcemr52296285e9.21.1764143622478;
        Tue, 25 Nov 2025 23:53:42 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm41177386f8f.29.2025.11.25.23.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 23:53:42 -0800 (PST)
Message-ID: <834f1966-5a05-4351-b7de-3a54fb5df9cf@grimberg.me>
Date: Wed, 26 Nov 2025 09:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-auth: switch to use 'struct key'
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_235344_943188_634DC432 
X-CRM114-Status: GOOD (  30.11  )
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



On 28/05/2025 17:05, Hannes Reinecke wrote:
> Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
> handling function to use 'struct key'. With that we can drop the now
> unused 'struct nvme_dhchap_key' definitions.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/common/Kconfig |   1 +
>   drivers/nvme/common/auth.c  | 170 ++++++++++++------------------------
>   drivers/nvme/host/Kconfig   |   1 -
>   drivers/nvme/host/auth.c    |  28 +++---
>   drivers/nvme/host/nvme.h    |   4 +-
>   drivers/nvme/host/sysfs.c   |  25 +++---
>   drivers/nvme/target/Kconfig |   1 -
>   drivers/nvme/target/auth.c  |  40 +++++----
>   drivers/nvme/target/nvmet.h |   4 +-
>   include/linux/nvme-auth.h   |  17 +---
>   10 files changed, 113 insertions(+), 178 deletions(-)
>
> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
> index da963e4f3f1f..8a5521c038c5 100644
> --- a/drivers/nvme/common/Kconfig
> +++ b/drivers/nvme/common/Kconfig
> @@ -13,3 +13,4 @@ config NVME_AUTH
>   	select CRYPTO_DH
>   	select CRYPTO_DH_RFC7919_GROUPS
>   	select CRYPTO_HKDF
> +	select NVME_KEYRING
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 918c92cbd8c5..8c2ccbfb9986 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -14,6 +14,8 @@
>   #include <crypto/hkdf.h>
>   #include <linux/nvme.h>
>   #include <linux/nvme-auth.h>
> +#include <linux/nvme-keyring.h>
> +#include <keys/user-type.h>
>   
>   #define HKDF_MAX_HASHLEN 64
>   
> @@ -153,98 +155,28 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>   
> -u32 nvme_auth_key_struct_size(u32 key_len)
> +struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
> +				  size_t secret_len)
>   {
> -	struct nvme_dhchap_key key;
> +	struct key *key;
>   
> -	return struct_size(&key, key, key_len);
> -}
> -EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
> -
> -struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
> -					      u8 key_hash)
> -{
> -	struct nvme_dhchap_key *key;
> -	unsigned char *p;
> -	u32 crc;
> -	int ret, key_len;
> -	size_t allocated_len = strlen(secret);
> -
> -	/* Secret might be affixed with a ':' */
> -	p = strrchr(secret, ':');
> -	if (p)
> -		allocated_len = p - secret;
> -	key = nvme_auth_alloc_key(allocated_len, 0);
> -	if (!key)
> -		return ERR_PTR(-ENOMEM);
> -
> -	key_len = base64_decode(secret, allocated_len, key->key);
> -	if (key_len < 0) {
> -		pr_debug("base64 key decoding error %d\n",
> -			 key_len);
> -		ret = key_len;
> -		goto out_free_secret;
> -	}
> -
> -	if (key_len != 36 && key_len != 52 &&
> -	    key_len != 68) {
> -		pr_err("Invalid key len %d\n", key_len);
> -		ret = -EINVAL;
> -		goto out_free_secret;
> -	}
> -
> -	/* The last four bytes is the CRC in little-endian format */
> -	key_len -= 4;
> -	/*
> -	 * The linux implementation doesn't do pre- and post-increments,
> -	 * so we have to do it manually.
> -	 */
> -	crc = ~crc32(~0, key->key, key_len);
> -
> -	if (get_unaligned_le32(key->key + key_len) != crc) {
> -		pr_err("key crc mismatch (key %08x, crc %08x)\n",
> -		       get_unaligned_le32(key->key + key_len), crc);
> -		ret = -EKEYREJECTED;
> -		goto out_free_secret;
> -	}
> -	key->len = key_len;
> -	key->hash = key_hash;
> +	key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
> +	if (!IS_ERR(key))
> +		pr_debug("generated dhchap key %08x\n",
> +			 key_serial(key));
>   	return key;
> -out_free_secret:
> -	nvme_auth_free_key(key);
> -	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
>   
> -struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
> -{
> -	u32 num_bytes = nvme_auth_key_struct_size(len);
> -	struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
> -
> -	if (key) {
> -		key->len = len;
> -		key->hash = hash;
> -	}
> -	return key;
> -}
> -EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
> -
> -void nvme_auth_free_key(struct nvme_dhchap_key *key)
> -{
> -	if (!key)
> -		return;
> -	kfree_sensitive(key);
> -}
> -EXPORT_SYMBOL_GPL(nvme_auth_free_key);
> -
> -int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
> +int nvme_auth_transform_key(struct key *key, char *nqn,
>   			    u8 **transformed_secret)
>   {
>   	const char *hmac_name;
>   	struct crypto_shash *key_tfm;
>   	SHASH_DESC_ON_STACK(shash, key_tfm);
> +	long key_len = 0;
>   	u8 *transformed_data;
> -	u8 *key_data;
> +	u8 *key_data, key_hash;
>   	size_t transformed_len;
>   	int ret;
>   
> @@ -252,17 +184,47 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
>   		pr_warn("No key specified\n");
>   		return -ENOKEY;
>   	}
> -	key_data = kzalloc(key->len, GFP_KERNEL);
> -	if (!key_data)
> +	down_read(&key->sem);
> +	ret = key_validate(key);
> +	if (ret) {
> +		pr_warn("%s: key %08x invalidated\n",
> +			__func__, key_serial(key));
> +		up_read(&key->sem);
> +		return ret;
> +	}
> +	key_len = user_read(key, NULL, 0);
> +	if (key_len <= 0) {
> +		pr_warn("failed to get length from key %08x: error %ld\n",
> +			key_serial(key), key_len);
> +		up_read(&key->sem);
> +		return key_len;
> +	}
> +	key_data = kzalloc(key_len, GFP_KERNEL);
> +	if (!key_data) {
> +		up_read(&key->sem);
>   		return -ENOMEM;
> -	memcpy(key_data, key->key, key->len);
> -	if (key->hash == 0) {
> +	}
> +
> +	ret = user_read(key, key_data, key_len);
> +	key_hash = nvme_dhchap_psk_hash(key);
> +	up_read(&key->sem);
> +	if (ret != key_len) {
> +		if (ret < 0) {
> +			pr_warn("failed to read data from key %08x: error %d\n",
> +				key_serial(key), ret);
> +		} else {
> +			pr_warn("only read %d of %ld bytes from key %08x\n",
> +				ret, key_len, key_serial(key));
> +		}
> +		goto out_free_data;
> +	}
> +	if (key_hash == 0) {
>   		*transformed_secret = key_data;
> -		return key->len;
> +		return key_len;
>   	}
> -	hmac_name = nvme_auth_hmac_name(key->hash);
> +	hmac_name = nvme_auth_hmac_name(key_hash);
>   	if (!hmac_name) {
> -		pr_warn("Invalid key hash id %d\n", key->hash);
> +		pr_warn("Invalid key hash id %d\n", key_hash);
>   		ret = -EINVAL;
>   		goto out_free_data;
>   	}
> @@ -274,9 +236,9 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
>   	}
>   
>   	transformed_len = crypto_shash_digestsize(key_tfm);
> -	if (transformed_len != key->len) {
> +	if (transformed_len != key_len) {
>   		pr_warn("incompatible digest size %ld for key (hash %s, len %ld)\n",
> -			transformed_len, hmac_name, key->len);
> +			transformed_len, hmac_name, key_len);
>   		ret = -EINVAL;
>   		goto out_free_tfm;
>   	}
> @@ -288,7 +250,7 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
>   	}
>   
>   	shash->tfm = key_tfm;
> -	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
> +	ret = crypto_shash_setkey(key_tfm, key_data, key_len);
>   	if (ret < 0)
>   		goto out_free_transformed_data;
>   	ret = crypto_shash_init(shash);
> @@ -304,8 +266,9 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
>   	if (ret < 0)
>   		goto out_free_transformed_data;
>   
> -	crypto_free_shash(key_tfm);
>   	*transformed_secret = transformed_data;
> +	crypto_free_shash(key_tfm);
> +	kfree(key_data);
>   
>   	return transformed_len;
>   
> @@ -454,31 +417,6 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
>   
> -int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
> -{
> -	struct nvme_dhchap_key *key;
> -	u8 key_hash;
> -
> -	if (!secret) {
> -		*ret_key = NULL;
> -		return 0;
> -	}
> -
> -	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> -		return -EINVAL;
> -
> -	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> -	key = nvme_auth_extract_key(secret + 10, key_hash);
> -	if (IS_ERR(key)) {
> -		*ret_key = NULL;
> -		return PTR_ERR(key);
> -	}
> -
> -	*ret_key = key;
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
> -
>   /**
>    * nvme_auth_generate_psk - Generate a PSK for TLS
>    * @hmac_id: Hash function identifier
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 4d64b6935bb9..65a5a5fd82f9 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -115,7 +115,6 @@ config NVME_HOST_AUTH
>   	bool "NVMe over Fabrics In-Band Authentication in host side"
>   	depends on NVME_CORE
>   	select NVME_AUTH
> -	select NVME_KEYRING
>   	help
>   	  This provides support for NVMe over Fabrics In-Band Authentication in
>   	  host side.
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 9e7c2e889ee0..c5be0c13e85b 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -1068,14 +1068,22 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>   	if (!ctrl->opts)
>   		return 0;
> -	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
> -			&ctrl->host_key);
> -	if (ret)
> +	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
> +					       ctrl->opts->dhchap_secret,
> +					       strlen(ctrl->opts->dhchap_secret));

It is a bit confusing that you replace a generate_key with an 
extract_key function.
Can you explain a bit on this?

> +	if (IS_ERR(ctrl->host_key)) {
> +		ret = PTR_ERR(ctrl->host_key);
> +		ctrl->host_key = NULL;
>   		return ret;
> -	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
> -			&ctrl->ctrl_key);
> -	if (ret)
> +	}
> +	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
> +					       ctrl->opts->dhchap_ctrl_secret,
> +					       strlen(ctrl->opts->dhchap_ctrl_secret));
> +	if (IS_ERR(ctrl->ctrl_key)) {
> +		ret = PTR_ERR(ctrl->ctrl_key);
> +		ctrl->ctrl_key = NULL;
>   		goto err_free_dhchap_secret;
> +	}
>   
>   	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
>   		return 0;
> @@ -1097,10 +1105,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   
>   	return 0;
>   err_free_dhchap_ctrl_secret:
> -	nvme_auth_free_key(ctrl->ctrl_key);
> +	key_put(ctrl->ctrl_key);
>   	ctrl->ctrl_key = NULL;
>   err_free_dhchap_secret:
> -	nvme_auth_free_key(ctrl->host_key);
> +	key_put(ctrl->host_key);
>   	ctrl->host_key = NULL;
>   	return ret;
>   }
> @@ -1122,11 +1130,11 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
>   		kfree(ctrl->dhchap_ctxs);
>   	}
>   	if (ctrl->host_key) {
> -		nvme_auth_free_key(ctrl->host_key);
> +		key_put(ctrl->host_key);
>   		ctrl->host_key = NULL;
>   	}
>   	if (ctrl->ctrl_key) {
> -		nvme_auth_free_key(ctrl->ctrl_key);
> +		key_put(ctrl->ctrl_key);
>   		ctrl->ctrl_key = NULL;
>   	}
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1de1b843afa5..3dd83a48532a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -378,8 +378,8 @@ struct nvme_ctrl {
>   	struct work_struct dhchap_auth_work;
>   	struct mutex dhchap_auth_mutex;
>   	struct nvme_dhchap_queue_context *dhchap_ctxs;
> -	struct nvme_dhchap_key *host_key;
> -	struct nvme_dhchap_key *ctrl_key;
> +	struct key *host_key;
> +	struct key *ctrl_key;
>   	u16 transaction;
>   #endif
>   	key_serial_t tls_pskid;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index a48d30c31d51..b3b63453df1c 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -596,8 +596,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   		return -EINVAL;
>   	if (count < 7)
>   		return -EINVAL;
> -	if (memcmp(buf, "DHHC-1:", 7))
> -		return -EINVAL;
>   
>   	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
>   	if (!dhchap_secret)
> @@ -605,13 +603,12 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   	memcpy(dhchap_secret, buf, count);
>   	nvme_auth_stop(ctrl);
>   	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
> -		struct nvme_dhchap_key *key, *host_key;
> -		int ret;
> +		struct key *key, *host_key;
>   
> -		ret = nvme_auth_generate_key(dhchap_secret, &key);
> -		if (ret) {
> +		key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
> +		if (IS_ERR(key)) {
>   			kfree(dhchap_secret);
> -			return ret;
> +			return PTR_ERR(key);
>   		}
>   		kfree(opts->dhchap_secret);
>   		opts->dhchap_secret = dhchap_secret;
> @@ -619,7 +616,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
>   		mutex_lock(&ctrl->dhchap_auth_mutex);
>   		ctrl->host_key = key;
>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
> -		nvme_auth_free_key(host_key);
> +		key_put(host_key);
>   	} else
>   		kfree(dhchap_secret);
>   	/* Start re-authentication */
> @@ -663,13 +660,13 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>   	memcpy(dhchap_secret, buf, count);
>   	nvme_auth_stop(ctrl);
>   	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
> -		struct nvme_dhchap_key *key, *ctrl_key;
> -		int ret;
> +		struct key *key, *ctrl_key;
>   
> -		ret = nvme_auth_generate_key(dhchap_secret, &key);
> -		if (ret) {
> +		key = nvme_auth_extract_key(opts->keyring,
> +					    dhchap_secret, count);
> +		if (IS_ERR(key)) {
>   			kfree(dhchap_secret);
> -			return ret;
> +			return PTR_ERR(key);
>   		}
>   		kfree(opts->dhchap_ctrl_secret);
>   		opts->dhchap_ctrl_secret = dhchap_secret;
> @@ -677,7 +674,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>   		mutex_lock(&ctrl->dhchap_auth_mutex);
>   		ctrl->ctrl_key = key;
>   		mutex_unlock(&ctrl->dhchap_auth_mutex);
> -		nvme_auth_free_key(ctrl_key);
> +		key_put(ctrl_key);
>   	} else
>   		kfree(dhchap_secret);
>   	/* Start re-authentication */
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 4c253b433bf7..5761bb52c46c 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -5,7 +5,6 @@ config NVME_TARGET
>   	depends on BLOCK
>   	depends on CONFIGFS_FS
>   	select NVME_KEYRING if NVME_TARGET_TCP_TLS
> -	select KEYS if NVME_TARGET_TCP_TLS
>   	select SGL_ALLOC
>   	help
>   	  This enabled target side support for the NVMe protocol, that is
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index c70d9d259a7f..7f87dc39a2de 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -145,6 +145,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>   	int ret = 0;
>   	struct nvmet_host_link *p;
>   	struct nvmet_host *host = NULL;
> +	u8 host_hash, ctrl_hash;
>   
>   	down_read(&nvmet_config_sem);
>   	if (nvmet_is_disc_subsys(ctrl->subsys))
> @@ -190,42 +191,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>   		ctrl->shash_id = host->dhchap_hash_id;
>   	}
>   
> -	/* Skip the 'DHHC-1:XX:' prefix */
> -	nvme_auth_free_key(ctrl->host_key);
> -	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
> -					       host->dhchap_key_hash);
> +	key_put(ctrl->host_key);
> +	ctrl->host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
> +					       strlen(host->dhchap_secret));

Does extract_key have multiple usages? generation and extraction?

