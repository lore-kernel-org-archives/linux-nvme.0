Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAB7D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 21:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MW6qjGvcZshpRDFZJvq3qh6yqNJCrMZoao7qW5FVyqI=; b=jUBYtl8pdTAK2tduShW615evwK
	M5fDC9tk40ZgtVzVXaaHJ+AmttSrZQceUt4i/FMGgfNTr6RUPUWlLlr/XZBskbG+916O6/+msIv2t
	JPv31GGGlMfYtNOZ9adN9T0//oFTmnk62Ize8IAinTBlzb+i2C0KQIGHbqiOsMmVGQE2xHSeyfJtB
	X8KJkUSnHAFmFIKDGMDyaJrT8N/Gpq2muDSaDhS4VMIXpxAcsvxKyFRoN1jiHwqK0RPryqvm2em3T
	HQ8VH8Xyf3wjCXZLt5N016x1xZa+i5lZYggDJnEccXw79cvQdeXCL6O7IgRmdq4dchVrv/8C7ls8b
	F2j8hReQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpDX-00000002anK-0NYQ;
	Sun, 30 Nov 2025 21:44:27 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpDT-00000002amw-1LbM
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 21:44:24 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779d47be12so28235415e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 13:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764539061; x=1765143861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MW6qjGvcZshpRDFZJvq3qh6yqNJCrMZoao7qW5FVyqI=;
        b=qn8i50frmmExfC1Frr+xogmGlwaV8DtbFfSrlBCmYDtymLmhkJxEheT++ZT8PXXtL6
         AnCAF+zug+mnGFGph+nxeutDNCqFYkcMZrWRL27ABNht3B5hRYiNrbqf4JCSAKe+3TpH
         vYeZzXSOe8OzL9AvnZeM9K/Yk/cdnVt2M5iYMtuAoSNISbjjicXlbHASBt/Y7PrXR74p
         ZFCWiuTDoWsapdQ87Srb2xwhCrnzkN2tJbfzv3B7s7J+Ld1KXVu4DhfmrJES/BfYVtWt
         yTHLp+fJVNi56Y/sik3KPz2VxTEvUikuVlQzZe3O00QWig1yWAjeV2jYBcRqqhvD/HzN
         drWg==
X-Forwarded-Encrypted: i=1; AJvYcCUtWQE12Ao491aiGdZ26iava5+oDHIPHWsrBh/tmguJo3vWhI6eMa9q6vOF6HJ5OczgBjYQJme4M4TC@lists.infradead.org
X-Gm-Message-State: AOJu0YySDnv68HuGie4et97T25wiFyQO9ex3Zy9PSHyAzmB9Bh13tRlY
	1Fzr/fWerYQ6n/orUZXweyPLN6AjqEJkyzvNiDEnXPYPkqxzrc3KnlgU
X-Gm-Gg: ASbGncvZkpqRJj09mXA0F5Y5u51fEq9SnZd2Brtt7zM7SBHi3secLbucgUlLvpHxW8r
	2vjiyHdgB0o/cSeg9xeV2F+Tr+KR68A1egh/agq5wwTq4dm/yUkfLNAnhsirrd7NidtSbLRMqG2
	QDW1EAT+xbywL8dwrJaJ1Opa5cuDmLoRFu1eCpU7Y9FlEMFqx8DRF9t7vvk/QCpXCBH5OZ8Sp7t
	pY935OEVce7ir8MhAz/IOXdTZ2reB93pn7GrkYmsrH13sc1tXRxv+Oi/7HAX6jvYoCQEEOAusj/
	r6fuAGUiaGAgm/tvjOGvQpShbsqtqzBXbIdl2nI63KOkI9+pQfeIIGBiHGv1KbOPYvOP7tCuiAZ
	Ygd45GoR+3Lw5WX+dJHs+oIS2OEh0n4USrQAcF+v/OJY1a2WTN6mc3qQv8zdwgW1iN3/mvzyBS6
	T5KYcpe9e4B8pxQQ+DvM7ALbr5JLr2ILPqPcvfega4
X-Google-Smtp-Source: AGHT+IHpda2zDUWv18x0ugpRYsL4mXq/4wnIF0kMi+15NKGLlSUIZ9pg2MsshypNhIQhooNd91z1eQ==
X-Received: by 2002:a05:600c:314d:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-477c0175164mr356046695e9.3.1764539061223;
        Sun, 30 Nov 2025 13:44:21 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47911143bb6sm223551585e9.3.2025.11.30.13.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 13:44:20 -0800 (PST)
Message-ID: <d9188ff0-7467-403f-8cf2-e9a27a25f2e7@grimberg.me>
Date: Sun, 30 Nov 2025 23:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-auth: switch to use 'struct key'
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-4-hare@kernel.org>
 <834f1966-5a05-4351-b7de-3a54fb5df9cf@grimberg.me>
 <a7c115c1-36cb-4521-8d9f-df07ff1554a8@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a7c115c1-36cb-4521-8d9f-df07ff1554a8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_134423_429284_2082EF69 
X-CRM114-Status: GOOD (  24.26  )
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



On 27/11/2025 10:15, Hannes Reinecke wrote:
> On 11/26/25 08:53, Sagi Grimberg wrote:
>>
>>
>> On 28/05/2025 17:05, Hannes Reinecke wrote:
>>> Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
>>> handling function to use 'struct key'. With that we can drop the now
>>> unused 'struct nvme_dhchap_key' definitions.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/common/Kconfig |   1 +
>>>   drivers/nvme/common/auth.c  | 170 
>>> ++++++++++++------------------------
>>>   drivers/nvme/host/Kconfig   |   1 -
>>>   drivers/nvme/host/auth.c    |  28 +++---
>>>   drivers/nvme/host/nvme.h    |   4 +-
>>>   drivers/nvme/host/sysfs.c   |  25 +++---
>>>   drivers/nvme/target/Kconfig |   1 -
>>>   drivers/nvme/target/auth.c  |  40 +++++----
>>>   drivers/nvme/target/nvmet.h |   4 +-
>>>   include/linux/nvme-auth.h   |  17 +---
>>>   10 files changed, 113 insertions(+), 178 deletions(-)
>>>
>>> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
>>> index da963e4f3f1f..8a5521c038c5 100644
>>> --- a/drivers/nvme/common/Kconfig
>>> +++ b/drivers/nvme/common/Kconfig
>>> @@ -13,3 +13,4 @@ config NVME_AUTH
>>>       select CRYPTO_DH
>>>       select CRYPTO_DH_RFC7919_GROUPS
>>>       select CRYPTO_HKDF
>>> +    select NVME_KEYRING
>>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>>> index 918c92cbd8c5..8c2ccbfb9986 100644
>>> --- a/drivers/nvme/common/auth.c
>>> +++ b/drivers/nvme/common/auth.c
>>> @@ -14,6 +14,8 @@
>>>   #include <crypto/hkdf.h>
>>>   #include <linux/nvme.h>
>>>   #include <linux/nvme-auth.h>
>>> +#include <linux/nvme-keyring.h>
>>> +#include <keys/user-type.h>
>>>   #define HKDF_MAX_HASHLEN 64
>>> @@ -153,98 +155,28 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>>> -u32 nvme_auth_key_struct_size(u32 key_len)
>>> +struct key *nvme_auth_extract_key(struct key *keyring, const u8 
>>> *secret,
>>> +                  size_t secret_len)
>>>   {
>>> -    struct nvme_dhchap_key key;
>>> +    struct key *key;
>>> -    return struct_size(&key, key, key_len);
>>> -}
>>> -EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
>>> -
>>> -struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>>> -                          u8 key_hash)
>>> -{
>>> -    struct nvme_dhchap_key *key;
>>> -    unsigned char *p;
>>> -    u32 crc;
>>> -    int ret, key_len;
>>> -    size_t allocated_len = strlen(secret);
>>> -
>>> -    /* Secret might be affixed with a ':' */
>>> -    p = strrchr(secret, ':');
>>> -    if (p)
>>> -        allocated_len = p - secret;
>>> -    key = nvme_auth_alloc_key(allocated_len, 0);
>>> -    if (!key)
>>> -        return ERR_PTR(-ENOMEM);
>>> -
>>> -    key_len = base64_decode(secret, allocated_len, key->key);
>>> -    if (key_len < 0) {
>>> -        pr_debug("base64 key decoding error %d\n",
>>> -             key_len);
>>> -        ret = key_len;
>>> -        goto out_free_secret;
>>> -    }
>>> -
>>> -    if (key_len != 36 && key_len != 52 &&
>>> -        key_len != 68) {
>>> -        pr_err("Invalid key len %d\n", key_len);
>>> -        ret = -EINVAL;
>>> -        goto out_free_secret;
>>> -    }
>>> -
>>> -    /* The last four bytes is the CRC in little-endian format */
>>> -    key_len -= 4;
>>> -    /*
>>> -     * The linux implementation doesn't do pre- and post-increments,
>>> -     * so we have to do it manually.
>>> -     */
>>> -    crc = ~crc32(~0, key->key, key_len);
>>> -
>>> -    if (get_unaligned_le32(key->key + key_len) != crc) {
>>> -        pr_err("key crc mismatch (key %08x, crc %08x)\n",
>>> -               get_unaligned_le32(key->key + key_len), crc);
>>> -        ret = -EKEYREJECTED;
>>> -        goto out_free_secret;
>>> -    }
>>> -    key->len = key_len;
>>> -    key->hash = key_hash;
>>> +    key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
>>> +    if (!IS_ERR(key))
>>> +        pr_debug("generated dhchap key %08x\n",
>>> +             key_serial(key));
>>>       return key;
>>> -out_free_secret:
>>> -    nvme_auth_free_key(key);
>>> -    return ERR_PTR(ret);
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
>>> -struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
>>> -{
>>> -    u32 num_bytes = nvme_auth_key_struct_size(len);
>>> -    struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
>>> -
>>> -    if (key) {
>>> -        key->len = len;
>>> -        key->hash = hash;
>>> -    }
>>> -    return key;
>>> -}
>>> -EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
>>> -
>>> -void nvme_auth_free_key(struct nvme_dhchap_key *key)
>>> -{
>>> -    if (!key)
>>> -        return;
>>> -    kfree_sensitive(key);
>>> -}
>>> -EXPORT_SYMBOL_GPL(nvme_auth_free_key);
>>> -
>>> -int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
>>> +int nvme_auth_transform_key(struct key *key, char *nqn,
>>>                   u8 **transformed_secret)
>>>   {
>>>       const char *hmac_name;
>>>       struct crypto_shash *key_tfm;
>>>       SHASH_DESC_ON_STACK(shash, key_tfm);
>>> +    long key_len = 0;
>>>       u8 *transformed_data;
>>> -    u8 *key_data;
>>> +    u8 *key_data, key_hash;
>>>       size_t transformed_len;
>>>       int ret;
>>> @@ -252,17 +184,47 @@ int nvme_auth_transform_key(struct 
>>> nvme_dhchap_key *key, char *nqn,
>>>           pr_warn("No key specified\n");
>>>           return -ENOKEY;
>>>       }
>>> -    key_data = kzalloc(key->len, GFP_KERNEL);
>>> -    if (!key_data)
>>> +    down_read(&key->sem);
>>> +    ret = key_validate(key);
>>> +    if (ret) {
>>> +        pr_warn("%s: key %08x invalidated\n",
>>> +            __func__, key_serial(key));
>>> +        up_read(&key->sem);
>>> +        return ret;
>>> +    }
>>> +    key_len = user_read(key, NULL, 0);
>>> +    if (key_len <= 0) {
>>> +        pr_warn("failed to get length from key %08x: error %ld\n",
>>> +            key_serial(key), key_len);
>>> +        up_read(&key->sem);
>>> +        return key_len;
>>> +    }
>>> +    key_data = kzalloc(key_len, GFP_KERNEL);
>>> +    if (!key_data) {
>>> +        up_read(&key->sem);
>>>           return -ENOMEM;
>>> -    memcpy(key_data, key->key, key->len);
>>> -    if (key->hash == 0) {
>>> +    }
>>> +
>>> +    ret = user_read(key, key_data, key_len);
>>> +    key_hash = nvme_dhchap_psk_hash(key);
>>> +    up_read(&key->sem);
>>> +    if (ret != key_len) {
>>> +        if (ret < 0) {
>>> +            pr_warn("failed to read data from key %08x: error %d\n",
>>> +                key_serial(key), ret);
>>> +        } else {
>>> +            pr_warn("only read %d of %ld bytes from key %08x\n",
>>> +                ret, key_len, key_serial(key));
>>> +        }
>>> +        goto out_free_data;
>>> +    }
>>> +    if (key_hash == 0) {
>>>           *transformed_secret = key_data;
>>> -        return key->len;
>>> +        return key_len;
>>>       }
>>> -    hmac_name = nvme_auth_hmac_name(key->hash);
>>> +    hmac_name = nvme_auth_hmac_name(key_hash);
>>>       if (!hmac_name) {
>>> -        pr_warn("Invalid key hash id %d\n", key->hash);
>>> +        pr_warn("Invalid key hash id %d\n", key_hash);
>>>           ret = -EINVAL;
>>>           goto out_free_data;
>>>       }
>>> @@ -274,9 +236,9 @@ int nvme_auth_transform_key(struct 
>>> nvme_dhchap_key *key, char *nqn,
>>>       }
>>>       transformed_len = crypto_shash_digestsize(key_tfm);
>>> -    if (transformed_len != key->len) {
>>> +    if (transformed_len != key_len) {
>>>           pr_warn("incompatible digest size %ld for key (hash %s, 
>>> len %ld)\n",
>>> -            transformed_len, hmac_name, key->len);
>>> +            transformed_len, hmac_name, key_len);
>>>           ret = -EINVAL;
>>>           goto out_free_tfm;
>>>       }
>>> @@ -288,7 +250,7 @@ int nvme_auth_transform_key(struct 
>>> nvme_dhchap_key *key, char *nqn,
>>>       }
>>>       shash->tfm = key_tfm;
>>> -    ret = crypto_shash_setkey(key_tfm, key->key, key->len);
>>> +    ret = crypto_shash_setkey(key_tfm, key_data, key_len);
>>>       if (ret < 0)
>>>           goto out_free_transformed_data;
>>>       ret = crypto_shash_init(shash);
>>> @@ -304,8 +266,9 @@ int nvme_auth_transform_key(struct 
>>> nvme_dhchap_key *key, char *nqn,
>>>       if (ret < 0)
>>>           goto out_free_transformed_data;
>>> -    crypto_free_shash(key_tfm);
>>>       *transformed_secret = transformed_data;
>>> +    crypto_free_shash(key_tfm);
>>> +    kfree(key_data);
>>>       return transformed_len;
>>> @@ -454,31 +417,6 @@ int nvme_auth_gen_shared_secret(struct 
>>> crypto_kpp *dh_tfm,
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
>>> -int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key 
>>> **ret_key)
>>> -{
>>> -    struct nvme_dhchap_key *key;
>>> -    u8 key_hash;
>>> -
>>> -    if (!secret) {
>>> -        *ret_key = NULL;
>>> -        return 0;
>>> -    }
>>> -
>>> -    if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
>>> -        return -EINVAL;
>>> -
>>> -    /* Pass in the secret without the 'DHHC-1:XX:' prefix */
>>> -    key = nvme_auth_extract_key(secret + 10, key_hash);
>>> -    if (IS_ERR(key)) {
>>> -        *ret_key = NULL;
>>> -        return PTR_ERR(key);
>>> -    }
>>> -
>>> -    *ret_key = key;
>>> -    return 0;
>>> -}
>>> -EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
>>> -
>>>   /**
>>>    * nvme_auth_generate_psk - Generate a PSK for TLS
>>>    * @hmac_id: Hash function identifier
>>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>>> index 4d64b6935bb9..65a5a5fd82f9 100644
>>> --- a/drivers/nvme/host/Kconfig
>>> +++ b/drivers/nvme/host/Kconfig
>>> @@ -115,7 +115,6 @@ config NVME_HOST_AUTH
>>>       bool "NVMe over Fabrics In-Band Authentication in host side"
>>>       depends on NVME_CORE
>>>       select NVME_AUTH
>>> -    select NVME_KEYRING
>>>       help
>>>         This provides support for NVMe over Fabrics In-Band 
>>> Authentication in
>>>         host side.
>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>> index 9e7c2e889ee0..c5be0c13e85b 100644
>>> --- a/drivers/nvme/host/auth.c
>>> +++ b/drivers/nvme/host/auth.c
>>> @@ -1068,14 +1068,22 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>>       INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>>>       if (!ctrl->opts)
>>>           return 0;
>>> -    ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
>>> -            &ctrl->host_key);
>>> -    if (ret)
>>> +    ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
>>> +                           ctrl->opts->dhchap_secret,
>>> + strlen(ctrl->opts->dhchap_secret));
>>
>> It is a bit confusing that you replace a generate_key with an 
>> extract_key function.
>> Can you explain a bit on this?
>>
>
> It was probably a misnomer to start with.
> 'nvme_auth_generate_key()' constructs a 'struct nvme_dhchap_key'
> from the input parameters on the commandline.
> (And so in a sense 'generates' it, without having anything to do
> with the 'generated' key in the NVMe sense).
> And internally 'nvme_auth_generate_key()' is a wrapper around 
> 'nvme_auth_extract_key()' anyway.

This makes sense. Can you please put this in the patch description?

