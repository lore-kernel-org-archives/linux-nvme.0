Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB16CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pITYsPsThP17aHlfra33wVD/hsUOZhp43/VFyHn5x/s=; b=CaW874xF90sy9FCJJr0MtZ4KTr
	YNqrcWJyb9L+3nRrw9Vl/BMxfwZaoYBnNZJkBOdirdv2MkM4vr6mriS/276v5pWK7yKvnWeJenk/E
	+vy3wT4/qmDE15HiWO0F6kSAaGYYzDA1rZQECbgfuImRyWSgua3NTf9ChMBdQzKLHoJO8iRh18emT
	GKoo2NwRK14LISLaSIYA5qFaGoSnLtKskTBQqNDNuv5ZzTLS+7g/fWpkzi/QQHcRsv2lr7lwXJLtw
	vHYHT3/w1cEMA1eEoVcMWaPgcWEQf31BMncOVb2pe52APtibuARHAtkMAS2oY8rwP8jrmH7i4wEDH
	cX6qO/Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOXAW-0000000GBry-41pd;
	Thu, 27 Nov 2025 08:16:01 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOXAU-0000000GBrW-2eh2
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 08:16:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CA2533697;
	Thu, 27 Nov 2025 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764231356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pITYsPsThP17aHlfra33wVD/hsUOZhp43/VFyHn5x/s=;
	b=TluerG3uFDtD5vj7Gv/OZX00SWSOfGx7lWBW17V49qOLjWp/NOyXsJO3ujBkogWJbrtAn5
	LEUv/i1DU3r5SK3MemtnHhYy7t3WrjjkXUmuuO7InHIJF2SW/2NtjsTZyJBllXclnzvZDI
	ZhdaoflSHLmwxzK7pnWwSK7Jq6zepzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764231356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pITYsPsThP17aHlfra33wVD/hsUOZhp43/VFyHn5x/s=;
	b=npUSdpCI8r35+Z6lO3WN8+fH/yuRZ56P//Rttw79zLzRr48shiWp3v7AcR4GzBIBNmJMkj
	AcuVnFtucS9xB5Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764231356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pITYsPsThP17aHlfra33wVD/hsUOZhp43/VFyHn5x/s=;
	b=TluerG3uFDtD5vj7Gv/OZX00SWSOfGx7lWBW17V49qOLjWp/NOyXsJO3ujBkogWJbrtAn5
	LEUv/i1DU3r5SK3MemtnHhYy7t3WrjjkXUmuuO7InHIJF2SW/2NtjsTZyJBllXclnzvZDI
	ZhdaoflSHLmwxzK7pnWwSK7Jq6zepzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764231356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pITYsPsThP17aHlfra33wVD/hsUOZhp43/VFyHn5x/s=;
	b=npUSdpCI8r35+Z6lO3WN8+fH/yuRZ56P//Rttw79zLzRr48shiWp3v7AcR4GzBIBNmJMkj
	AcuVnFtucS9xB5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06DC63EA63;
	Thu, 27 Nov 2025 08:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id siwYALwIKGnBHAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 08:15:56 +0000
Message-ID: <a7c115c1-36cb-4521-8d9f-df07ff1554a8@suse.de>
Date: Thu, 27 Nov 2025 09:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-auth: switch to use 'struct key'
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-4-hare@kernel.org>
 <834f1966-5a05-4351-b7de-3a54fb5df9cf@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <834f1966-5a05-4351-b7de-3a54fb5df9cf@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_001558_975181_8966A4E9 
X-CRM114-Status: GOOD (  20.93  )
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

On 11/26/25 08:53, Sagi Grimberg wrote:
> 
> 
> On 28/05/2025 17:05, Hannes Reinecke wrote:
>> Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
>> handling function to use 'struct key'. With that we can drop the now
>> unused 'struct nvme_dhchap_key' definitions.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/common/Kconfig |   1 +
>>   drivers/nvme/common/auth.c  | 170 ++++++++++++------------------------
>>   drivers/nvme/host/Kconfig   |   1 -
>>   drivers/nvme/host/auth.c    |  28 +++---
>>   drivers/nvme/host/nvme.h    |   4 +-
>>   drivers/nvme/host/sysfs.c   |  25 +++---
>>   drivers/nvme/target/Kconfig |   1 -
>>   drivers/nvme/target/auth.c  |  40 +++++----
>>   drivers/nvme/target/nvmet.h |   4 +-
>>   include/linux/nvme-auth.h   |  17 +---
>>   10 files changed, 113 insertions(+), 178 deletions(-)
>>
>> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
>> index da963e4f3f1f..8a5521c038c5 100644
>> --- a/drivers/nvme/common/Kconfig
>> +++ b/drivers/nvme/common/Kconfig
>> @@ -13,3 +13,4 @@ config NVME_AUTH
>>       select CRYPTO_DH
>>       select CRYPTO_DH_RFC7919_GROUPS
>>       select CRYPTO_HKDF
>> +    select NVME_KEYRING
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index 918c92cbd8c5..8c2ccbfb9986 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -14,6 +14,8 @@
>>   #include <crypto/hkdf.h>
>>   #include <linux/nvme.h>
>>   #include <linux/nvme-auth.h>
>> +#include <linux/nvme-keyring.h>
>> +#include <keys/user-type.h>
>>   #define HKDF_MAX_HASHLEN 64
>> @@ -153,98 +155,28 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>> -u32 nvme_auth_key_struct_size(u32 key_len)
>> +struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
>> +                  size_t secret_len)
>>   {
>> -    struct nvme_dhchap_key key;
>> +    struct key *key;
>> -    return struct_size(&key, key, key_len);
>> -}
>> -EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
>> -
>> -struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>> -                          u8 key_hash)
>> -{
>> -    struct nvme_dhchap_key *key;
>> -    unsigned char *p;
>> -    u32 crc;
>> -    int ret, key_len;
>> -    size_t allocated_len = strlen(secret);
>> -
>> -    /* Secret might be affixed with a ':' */
>> -    p = strrchr(secret, ':');
>> -    if (p)
>> -        allocated_len = p - secret;
>> -    key = nvme_auth_alloc_key(allocated_len, 0);
>> -    if (!key)
>> -        return ERR_PTR(-ENOMEM);
>> -
>> -    key_len = base64_decode(secret, allocated_len, key->key);
>> -    if (key_len < 0) {
>> -        pr_debug("base64 key decoding error %d\n",
>> -             key_len);
>> -        ret = key_len;
>> -        goto out_free_secret;
>> -    }
>> -
>> -    if (key_len != 36 && key_len != 52 &&
>> -        key_len != 68) {
>> -        pr_err("Invalid key len %d\n", key_len);
>> -        ret = -EINVAL;
>> -        goto out_free_secret;
>> -    }
>> -
>> -    /* The last four bytes is the CRC in little-endian format */
>> -    key_len -= 4;
>> -    /*
>> -     * The linux implementation doesn't do pre- and post-increments,
>> -     * so we have to do it manually.
>> -     */
>> -    crc = ~crc32(~0, key->key, key_len);
>> -
>> -    if (get_unaligned_le32(key->key + key_len) != crc) {
>> -        pr_err("key crc mismatch (key %08x, crc %08x)\n",
>> -               get_unaligned_le32(key->key + key_len), crc);
>> -        ret = -EKEYREJECTED;
>> -        goto out_free_secret;
>> -    }
>> -    key->len = key_len;
>> -    key->hash = key_hash;
>> +    key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
>> +    if (!IS_ERR(key))
>> +        pr_debug("generated dhchap key %08x\n",
>> +             key_serial(key));
>>       return key;
>> -out_free_secret:
>> -    nvme_auth_free_key(key);
>> -    return ERR_PTR(ret);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
>> -struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
>> -{
>> -    u32 num_bytes = nvme_auth_key_struct_size(len);
>> -    struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
>> -
>> -    if (key) {
>> -        key->len = len;
>> -        key->hash = hash;
>> -    }
>> -    return key;
>> -}
>> -EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
>> -
>> -void nvme_auth_free_key(struct nvme_dhchap_key *key)
>> -{
>> -    if (!key)
>> -        return;
>> -    kfree_sensitive(key);
>> -}
>> -EXPORT_SYMBOL_GPL(nvme_auth_free_key);
>> -
>> -int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
>> +int nvme_auth_transform_key(struct key *key, char *nqn,
>>                   u8 **transformed_secret)
>>   {
>>       const char *hmac_name;
>>       struct crypto_shash *key_tfm;
>>       SHASH_DESC_ON_STACK(shash, key_tfm);
>> +    long key_len = 0;
>>       u8 *transformed_data;
>> -    u8 *key_data;
>> +    u8 *key_data, key_hash;
>>       size_t transformed_len;
>>       int ret;
>> @@ -252,17 +184,47 @@ int nvme_auth_transform_key(struct 
>> nvme_dhchap_key *key, char *nqn,
>>           pr_warn("No key specified\n");
>>           return -ENOKEY;
>>       }
>> -    key_data = kzalloc(key->len, GFP_KERNEL);
>> -    if (!key_data)
>> +    down_read(&key->sem);
>> +    ret = key_validate(key);
>> +    if (ret) {
>> +        pr_warn("%s: key %08x invalidated\n",
>> +            __func__, key_serial(key));
>> +        up_read(&key->sem);
>> +        return ret;
>> +    }
>> +    key_len = user_read(key, NULL, 0);
>> +    if (key_len <= 0) {
>> +        pr_warn("failed to get length from key %08x: error %ld\n",
>> +            key_serial(key), key_len);
>> +        up_read(&key->sem);
>> +        return key_len;
>> +    }
>> +    key_data = kzalloc(key_len, GFP_KERNEL);
>> +    if (!key_data) {
>> +        up_read(&key->sem);
>>           return -ENOMEM;
>> -    memcpy(key_data, key->key, key->len);
>> -    if (key->hash == 0) {
>> +    }
>> +
>> +    ret = user_read(key, key_data, key_len);
>> +    key_hash = nvme_dhchap_psk_hash(key);
>> +    up_read(&key->sem);
>> +    if (ret != key_len) {
>> +        if (ret < 0) {
>> +            pr_warn("failed to read data from key %08x: error %d\n",
>> +                key_serial(key), ret);
>> +        } else {
>> +            pr_warn("only read %d of %ld bytes from key %08x\n",
>> +                ret, key_len, key_serial(key));
>> +        }
>> +        goto out_free_data;
>> +    }
>> +    if (key_hash == 0) {
>>           *transformed_secret = key_data;
>> -        return key->len;
>> +        return key_len;
>>       }
>> -    hmac_name = nvme_auth_hmac_name(key->hash);
>> +    hmac_name = nvme_auth_hmac_name(key_hash);
>>       if (!hmac_name) {
>> -        pr_warn("Invalid key hash id %d\n", key->hash);
>> +        pr_warn("Invalid key hash id %d\n", key_hash);
>>           ret = -EINVAL;
>>           goto out_free_data;
>>       }
>> @@ -274,9 +236,9 @@ int nvme_auth_transform_key(struct nvme_dhchap_key 
>> *key, char *nqn,
>>       }
>>       transformed_len = crypto_shash_digestsize(key_tfm);
>> -    if (transformed_len != key->len) {
>> +    if (transformed_len != key_len) {
>>           pr_warn("incompatible digest size %ld for key (hash %s, len 
>> %ld)\n",
>> -            transformed_len, hmac_name, key->len);
>> +            transformed_len, hmac_name, key_len);
>>           ret = -EINVAL;
>>           goto out_free_tfm;
>>       }
>> @@ -288,7 +250,7 @@ int nvme_auth_transform_key(struct nvme_dhchap_key 
>> *key, char *nqn,
>>       }
>>       shash->tfm = key_tfm;
>> -    ret = crypto_shash_setkey(key_tfm, key->key, key->len);
>> +    ret = crypto_shash_setkey(key_tfm, key_data, key_len);
>>       if (ret < 0)
>>           goto out_free_transformed_data;
>>       ret = crypto_shash_init(shash);
>> @@ -304,8 +266,9 @@ int nvme_auth_transform_key(struct nvme_dhchap_key 
>> *key, char *nqn,
>>       if (ret < 0)
>>           goto out_free_transformed_data;
>> -    crypto_free_shash(key_tfm);
>>       *transformed_secret = transformed_data;
>> +    crypto_free_shash(key_tfm);
>> +    kfree(key_data);
>>       return transformed_len;
>> @@ -454,31 +417,6 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp 
>> *dh_tfm,
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
>> -int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
>> -{
>> -    struct nvme_dhchap_key *key;
>> -    u8 key_hash;
>> -
>> -    if (!secret) {
>> -        *ret_key = NULL;
>> -        return 0;
>> -    }
>> -
>> -    if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
>> -        return -EINVAL;
>> -
>> -    /* Pass in the secret without the 'DHHC-1:XX:' prefix */
>> -    key = nvme_auth_extract_key(secret + 10, key_hash);
>> -    if (IS_ERR(key)) {
>> -        *ret_key = NULL;
>> -        return PTR_ERR(key);
>> -    }
>> -
>> -    *ret_key = key;
>> -    return 0;
>> -}
>> -EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
>> -
>>   /**
>>    * nvme_auth_generate_psk - Generate a PSK for TLS
>>    * @hmac_id: Hash function identifier
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index 4d64b6935bb9..65a5a5fd82f9 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -115,7 +115,6 @@ config NVME_HOST_AUTH
>>       bool "NVMe over Fabrics In-Band Authentication in host side"
>>       depends on NVME_CORE
>>       select NVME_AUTH
>> -    select NVME_KEYRING
>>       help
>>         This provides support for NVMe over Fabrics In-Band 
>> Authentication in
>>         host side.
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 9e7c2e889ee0..c5be0c13e85b 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -1068,14 +1068,22 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>       INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>>       if (!ctrl->opts)
>>           return 0;
>> -    ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
>> -            &ctrl->host_key);
>> -    if (ret)
>> +    ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
>> +                           ctrl->opts->dhchap_secret,
>> +                           strlen(ctrl->opts->dhchap_secret));
> 
> It is a bit confusing that you replace a generate_key with an 
> extract_key function.
> Can you explain a bit on this?
> 

It was probably a misnomer to start with.
'nvme_auth_generate_key()' constructs a 'struct nvme_dhchap_key'
from the input parameters on the commandline.
(And so in a sense 'generates' it, without having anything to do
with the 'generated' key in the NVMe sense).
And internally 'nvme_auth_generate_key()' is a wrapper around 
'nvme_auth_extract_key()' anyway.

>> +    if (IS_ERR(ctrl->host_key)) {
>> +        ret = PTR_ERR(ctrl->host_key);
>> +        ctrl->host_key = NULL;
>>           return ret;
>> -    ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
>> -            &ctrl->ctrl_key);
>> -    if (ret)
>> +    }
>> +    ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
>> +                           ctrl->opts->dhchap_ctrl_secret,
>> +                           strlen(ctrl->opts->dhchap_ctrl_secret));
>> +    if (IS_ERR(ctrl->ctrl_key)) {
>> +        ret = PTR_ERR(ctrl->ctrl_key);
>> +        ctrl->ctrl_key = NULL;
>>           goto err_free_dhchap_secret;
>> +    }
>>       if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
>>           return 0;
>> @@ -1097,10 +1105,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>       return 0;
>>   err_free_dhchap_ctrl_secret:
>> -    nvme_auth_free_key(ctrl->ctrl_key);
>> +    key_put(ctrl->ctrl_key);
>>       ctrl->ctrl_key = NULL;
>>   err_free_dhchap_secret:
>> -    nvme_auth_free_key(ctrl->host_key);
>> +    key_put(ctrl->host_key);
>>       ctrl->host_key = NULL;
>>       return ret;
>>   }
>> @@ -1122,11 +1130,11 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
>>           kfree(ctrl->dhchap_ctxs);
>>       }
>>       if (ctrl->host_key) {
>> -        nvme_auth_free_key(ctrl->host_key);
>> +        key_put(ctrl->host_key);
>>           ctrl->host_key = NULL;
>>       }
>>       if (ctrl->ctrl_key) {
>> -        nvme_auth_free_key(ctrl->ctrl_key);
>> +        key_put(ctrl->ctrl_key);
>>           ctrl->ctrl_key = NULL;
>>       }
>>   }
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 1de1b843afa5..3dd83a48532a 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -378,8 +378,8 @@ struct nvme_ctrl {
>>       struct work_struct dhchap_auth_work;
>>       struct mutex dhchap_auth_mutex;
>>       struct nvme_dhchap_queue_context *dhchap_ctxs;
>> -    struct nvme_dhchap_key *host_key;
>> -    struct nvme_dhchap_key *ctrl_key;
>> +    struct key *host_key;
>> +    struct key *ctrl_key;
>>       u16 transaction;
>>   #endif
>>       key_serial_t tls_pskid;
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index a48d30c31d51..b3b63453df1c 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -596,8 +596,6 @@ static ssize_t 
>> nvme_ctrl_dhchap_secret_store(struct device *dev,
>>           return -EINVAL;
>>       if (count < 7)
>>           return -EINVAL;
>> -    if (memcmp(buf, "DHHC-1:", 7))
>> -        return -EINVAL;
>>       dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
>>       if (!dhchap_secret)
>> @@ -605,13 +603,12 @@ static ssize_t 
>> nvme_ctrl_dhchap_secret_store(struct device *dev,
>>       memcpy(dhchap_secret, buf, count);
>>       nvme_auth_stop(ctrl);
>>       if (strcmp(dhchap_secret, opts->dhchap_secret)) {
>> -        struct nvme_dhchap_key *key, *host_key;
>> -        int ret;
>> +        struct key *key, *host_key;
>> -        ret = nvme_auth_generate_key(dhchap_secret, &key);
>> -        if (ret) {
>> +        key = nvme_auth_extract_key(opts->keyring, dhchap_secret, 
>> count);
>> +        if (IS_ERR(key)) {
>>               kfree(dhchap_secret);
>> -            return ret;
>> +            return PTR_ERR(key);
>>           }
>>           kfree(opts->dhchap_secret);
>>           opts->dhchap_secret = dhchap_secret;
>> @@ -619,7 +616,7 @@ static ssize_t 
>> nvme_ctrl_dhchap_secret_store(struct device *dev,
>>           mutex_lock(&ctrl->dhchap_auth_mutex);
>>           ctrl->host_key = key;
>>           mutex_unlock(&ctrl->dhchap_auth_mutex);
>> -        nvme_auth_free_key(host_key);
>> +        key_put(host_key);
>>       } else
>>           kfree(dhchap_secret);
>>       /* Start re-authentication */
>> @@ -663,13 +660,13 @@ static ssize_t 
>> nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>>       memcpy(dhchap_secret, buf, count);
>>       nvme_auth_stop(ctrl);
>>       if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
>> -        struct nvme_dhchap_key *key, *ctrl_key;
>> -        int ret;
>> +        struct key *key, *ctrl_key;
>> -        ret = nvme_auth_generate_key(dhchap_secret, &key);
>> -        if (ret) {
>> +        key = nvme_auth_extract_key(opts->keyring,
>> +                        dhchap_secret, count);
>> +        if (IS_ERR(key)) {
>>               kfree(dhchap_secret);
>> -            return ret;
>> +            return PTR_ERR(key);
>>           }
>>           kfree(opts->dhchap_ctrl_secret);
>>           opts->dhchap_ctrl_secret = dhchap_secret;
>> @@ -677,7 +674,7 @@ static ssize_t 
>> nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
>>           mutex_lock(&ctrl->dhchap_auth_mutex);
>>           ctrl->ctrl_key = key;
>>           mutex_unlock(&ctrl->dhchap_auth_mutex);
>> -        nvme_auth_free_key(ctrl_key);
>> +        key_put(ctrl_key);
>>       } else
>>           kfree(dhchap_secret);
>>       /* Start re-authentication */
>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>> index 4c253b433bf7..5761bb52c46c 100644
>> --- a/drivers/nvme/target/Kconfig
>> +++ b/drivers/nvme/target/Kconfig
>> @@ -5,7 +5,6 @@ config NVME_TARGET
>>       depends on BLOCK
>>       depends on CONFIGFS_FS
>>       select NVME_KEYRING if NVME_TARGET_TCP_TLS
>> -    select KEYS if NVME_TARGET_TCP_TLS
>>       select SGL_ALLOC
>>       help
>>         This enabled target side support for the NVMe protocol, that is
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index c70d9d259a7f..7f87dc39a2de 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -145,6 +145,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, 
>> struct nvmet_sq *sq)
>>       int ret = 0;
>>       struct nvmet_host_link *p;
>>       struct nvmet_host *host = NULL;
>> +    u8 host_hash, ctrl_hash;
>>       down_read(&nvmet_config_sem);
>>       if (nvmet_is_disc_subsys(ctrl->subsys))
>> @@ -190,42 +191,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, 
>> struct nvmet_sq *sq)
>>           ctrl->shash_id = host->dhchap_hash_id;
>>       }
>> -    /* Skip the 'DHHC-1:XX:' prefix */
>> -    nvme_auth_free_key(ctrl->host_key);
>> -    ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
>> -                           host->dhchap_key_hash);
>> +    key_put(ctrl->host_key);
>> +    ctrl->host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
>> +                           strlen(host->dhchap_secret));
> 
> Does extract_key have multiple usages? generation and extraction?
As I said, the 'nvme_auth_generate_key()' is a misnomwer now that we 
havesecure concatenation implemented.
It does not 'generate' a key, it's just a fancy wrapper around 
nvme_auth_extract_key(). I could rename it, but as the function is going
away anyway it feels kinda pointless.
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

