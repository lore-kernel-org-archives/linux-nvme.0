Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF91D10386
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eUe/anRHQJluj2fFftB2zJAs9bU5g58yljl1CwTUyfU=; b=c3G7TYAoPlcPRZUHT+sLQhE2bg
	f4YBSznT/wIXBNmqBUla+pgy18dvhDr4iTaJGsmyNnPtBXjPT7+Njpnsf1lN4W9hFI+zU8+AF1d91
	3tQXYOQf98F50wkHuFjiXK6VMgAHvgtSP9C9cOknSTQF8FoOzucNcNYP6DNqErTVEmHkA8tGnO5zp
	uodxsyiVvxwakf/TKGEXrmEnHEg5+3F8XypSKVOD2a30CYAIUTqDYfNNPb+G7/7z3mIMVIb3KvvXr
	ZBQ24wk/scyuvwpNkBvvfEhc0tnz6UtOv9I00vuTTs6zfFjxzSNYDit5NPFQq94uxMiF3wYzfCzBN
	E5klWgAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOAEw-0000000EYMW-236d;
	Wed, 26 Nov 2025 07:47:02 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOAEu-0000000EYLZ-0I7b
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 07:47:01 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so37622875e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 23:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764143218; x=1764748018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUe/anRHQJluj2fFftB2zJAs9bU5g58yljl1CwTUyfU=;
        b=Vj/5U9tZB0OsPSfvpIQNYAw8gpL/unGj9fklJjkEjx96NT/Tcwotj3/jKNgT1jtlC/
         QUOK/f49JMEDDQOvENnielrUdQkAkU9nDE7gpfyUvh+c89bxJp6AIZQlRLo2qto//hIE
         ZmUoVHlVECYNQbQ5m2LIeeyVVsSXZXBN1T3DD9XB1PMGmIPNiAZFpCPfbqur50+IpqT9
         br5z1GsC30yckkdgez2EKjIWnfIVE14FaMWXPY6tgVaVDvWobe0DQ86c4lHmiRAuzqQu
         0MlDDgi6TpUPIGJIKdvCCiS+PPUrTkf2ykLm05GrlSLpV7WGNyY8UCGOKesukImN+2lF
         3Yeg==
X-Forwarded-Encrypted: i=1; AJvYcCVYOm6/kNasrtdysl+3RaoCsuQatAV8plYpyLvPUGKnXp8NMV4usjnCEKcr0h5dlwWxeWM+drssJ7no@lists.infradead.org
X-Gm-Message-State: AOJu0YwG0r/WMoof9GxqTotIqqVSzR0ZS9v0uWnKfJkD4XpXOJJCWKtY
	FuKoBpfh5Kqff5dUIT8dRJFPizQ9qC3hna/grX5Pe9tJQOJl7TV9PAxZQ33hGQ==
X-Gm-Gg: ASbGnctiszn9+Gt5vsQN5Aa93O9Pgh28NiJDB+nY912jO52cpLKuIqdRrjP2/7BWZBp
	pp+zMbYMIXJxREMDH1LK+K2tqPej1+7QA5r8u1UVGymxjB6HVwxPoddImVpiqPreKydpeeOkE9P
	JbjutrTVm44cEq+PSWAII+NempjYWNmnKCa8EPjI37yUJU5vLSbEpBu22D1UDdelC1g+Q1Z+H/+
	cmIStRUEn6KEd5zC+dhjrpcrQS/equtRaSdf9IPxyCqmXMc2rUMHQFN4Vs7v6ET4oBdcz25r8Cq
	Pb5Me6y8OAYo4XWkucQ/OEPZsdWe81VaD+YU5DP8J0MiEtzJ46gPK0pkD6ALmswfZz6C0FMgfkx
	rE8cVbt818YFRQ+butWWQ8NkCHU88qCPk+L2+Vk1stHH46onwsz9Uzq3wHp8jw5ElzZqZV3jGif
	j9NCEETqK6LXYbd70SSjZxY4VdfnQjQ2Po+oN/oSzZK0PIjJcNuRkK
X-Google-Smtp-Source: AGHT+IG8SZxNySD9jsJZgkUP4ZQOAT6LRb/V7KBZYf+xX5GSG3OTcgrV/9eifQpfIr6PIRcCLgf2mQ==
X-Received: by 2002:a05:600c:4f53:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47904b12f35mr62125715e9.16.1764143218075;
        Tue, 25 Nov 2025 23:46:58 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790addddf6sm28225105e9.8.2025.11.25.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 23:46:57 -0800 (PST)
Message-ID: <18bf1285-f6b4-4ac1-a9f0-1760adab3f11@grimberg.me>
Date: Wed, 26 Nov 2025 09:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] nvme-keyring: add 'dhchap' key type
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_234700_412093_3074B408 
X-CRM114-Status: GOOD (  34.52  )
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
> Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
> Keys are stored with a 'user-type' compatible payload, such
> that one can use 'user_read()' to access the raw contents
> and the 'read()' callback to get the base64-encoded key
> data in the DH-HMAC-CHAP secret representation.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/common/keyring.c | 266 ++++++++++++++++++++++++++++++++++
>   include/linux/nvme-keyring.h  |  22 ++-
>   2 files changed, 287 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 32d16c53133b..a58c93c6d495 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -4,6 +4,9 @@
>    */
>   
>   #include <linux/module.h>
> +#include <linux/crc32.h>
> +#include <linux/base64.h>
> +#include <linux/unaligned.h>
>   #include <linux/seq_file.h>
>   #include <linux/key-type.h>
>   #include <keys/user-type.h>
> @@ -252,6 +255,262 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
>   }
>   EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
>   
> +static void nvme_dhchap_psk_describe(const struct key *key, struct seq_file *m)
> +{
> +	seq_puts(m, key->description);
> +	seq_printf(m, ": %u", key->datalen);
> +}
> +
> +static bool nvme_dhchap_psk_match(const struct key *key,
> +				  const struct key_match_data *match_data)
> +{
> +	const char *match_id;
> +	size_t match_len;
> +
> +	if (!key->description) {
> +		pr_debug("%s: no key description\n", __func__);
> +		return false;
> +	}
> +	if (!match_data->raw_data) {
> +		pr_debug("%s: no match data\n", __func__);
> +		return false;
> +	}
> +	match_id = match_data->raw_data;
> +	match_len = strlen(match_id);
> +	pr_debug("%s: match '%s' '%s' len %zd\n",
> +		 __func__, match_id, key->description, match_len);
> +
> +	return !memcmp(key->description, match_id, match_len);
> +}
> +
> +static int nvme_dhchap_psk_match_preparse(struct key_match_data *match_data)
> +{
> +	match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
> +	match_data->cmp = nvme_dhchap_psk_match;
> +	return 0;
> +}
> +
> +/**
> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
> + * @prep: preparsed payload of the key data
> + *
> + * Decode the DH-HMAC-CHAP key data passed in in @prep and
> + * store the resulting binary data. The binary data includes
> + * space for the CRC, the version, and the hmac identifier,
> + * but the data length is just the key data without the CRC.
> + * This allows the user to read the key data via the
> + * 'user_read()' function, but also to export the full
> + * key data including CRC via the 'read' callback from the key type.
> + */
> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct user_key_payload *upayload;
> +	size_t datalen = prep->datalen, keylen;
> +	int ret;
> +	u32 crc;
> +	u8 version, hmac;
> +
> +	if (!prep->data) {
> +		pr_debug("%s: Empty data", __func__);
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -EINVAL;
> +	}
> +
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s", &version, &hmac) != 2) {
> +		pr_debug("%s: invalid key data '%s'\n", __func__,
> +			 (char *)prep->data);
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -EINVAL;
> +	}
> +
> +	/* skip header and final ':' character */
> +	datalen -= 11;
> +
> +	/* keylen is the key length, 4 bytes CRC, 1 byte version, and 1 byte HMAC identifier */
> +	switch (datalen) {
> +	case 48:
> +		keylen = 38;
> +		break;
> +	case 72:
> +		keylen = 54;
> +		break;
> +	case 92:
> +		keylen = 70;
> +		break;
> +	default:

This feels like random arithmetic Hannes. Really really really hard to 
review this code
and understand if it is correct without trying to decipher the 
bits/bytes of the payload.

Can we introduce well documented macros/helpers to make this code more 
explainable?

> +		pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -EINVAL;
> +	}
> +
> +	upayload = kzalloc(sizeof(*upayload) + keylen, GFP_KERNEL);
> +	if (!upayload) {
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -ENOMEM;
> +	}
> +
> +	/* decode the data */
> +	prep->quotalen = keylen;
> +	prep->payload.data[0] = upayload;
> +	ret = base64_decode(prep->data + 10, datalen, upayload->data);
> +	if (ret < 0) {
> +		pr_debug("%s: Failed to decode key %s\n",
> +			 __func__, (char *)prep->data + 10);
> +		return ret;
> +	}
> +	ret -= 4;
> +	crc = ~crc32(~0, upayload->data, ret);
> +	if (get_unaligned_le32(upayload->data + ret) != crc) {
> +		pr_debug("%s: CRC mismatch for key\n", __func__);
> +		/* CRC mismatch */
> +		return -EKEYREJECTED;
> +	}
> +	upayload->data[ret + 4] = version;
> +	upayload->data[ret + 5] = hmac;

Again some more inline random arithmetic.

> +	upayload->datalen = ret;
> +	return 0;
> +}
> +
> +static long nvme_dhchap_psk_read(const struct key *key, char *buffer, size_t buflen)
> +{
> +	const struct user_key_payload *upayload;
> +	size_t datalen, keylen;
> +	u8 version, hmac;
> +	long ret;
> +
> +	upayload = user_key_payload_locked(key);
> +	switch (upayload->datalen) {
> +	    case 32:
> +		keylen = 59;

Some more random arithmetic...

> +		break;
> +	    case 48:
> +		keylen = 83;
> +		break;
> +	    case 64:
> +		keylen = 103;
> +		break;
> +	    default:
> +		return -EINVAL;
> +	}
> +
> +	if (!buffer || buflen == 0)
> +		return keylen;
> +
> +	if (buflen < keylen)
> +		return -EINVAL;
> +
> +	memset(buffer, 0, buflen);
> +	version = upayload->data[upayload->datalen + 4];
> +	hmac = upayload->data[upayload->datalen + 5];
> +	ret = sprintf(buffer, "DHHC-%01hhu:%02hhu:", version, hmac);
> +	if (ret < 0)
> +		return -ENOKEY;
> +	/* Include the trailing CRC */
> +	datalen = upayload->datalen + 4;
> +	ret += base64_encode(upayload->data, datalen, buffer + ret);
> +	buffer[ret] = ':';
> +	ret++;
> +	return ret;
> +}
> +
> +static struct key_type nvme_dhchap_psk_key_type = {
> +	.name           = "dhchap",
> +	.flags          = KEY_TYPE_NET_DOMAIN,
> +	.preparse       = nvme_dhchap_psk_preparse,
> +	.free_preparse  = user_free_preparse,
> +	.match_preparse = nvme_dhchap_psk_match_preparse,
> +	.instantiate    = generic_key_instantiate,
> +	.revoke         = user_revoke,
> +	.destroy        = user_destroy,
> +	.describe       = nvme_dhchap_psk_describe,
> +	.read           = nvme_dhchap_psk_read,
> +};
> +
> +struct key *nvme_dhchap_psk_refresh(struct key *keyring,
> +		const u8 *data, size_t data_len)

Is there a call-site to this? I don't see one...

> +{
> +	key_perm_t keyperm =
> +		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
> +		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
> +		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
> +	char *identity;
> +	key_ref_t keyref;
> +	key_serial_t keyring_id;
> +	struct key *key;
> +	uuid_t key_uuid;
> +
> +	if (data == NULL || !data_len)
> +		return ERR_PTR(-EINVAL);
> +
> +	generate_random_uuid(key_uuid.b);
> +	identity = kasprintf(GFP_KERNEL, "%pU", &key_uuid);
> +	if (!identity)
> +		return ERR_PTR(-ENOMEM);
> +	if (!keyring)
> +		keyring = nvme_keyring;
> +	keyring_id = key_serial(keyring);
> +
> +	pr_debug("keyring %x generate dhchap psk '%s'\n",
> +		 keyring_id, identity);
> +	keyref = key_create(make_key_ref(keyring, true),
> +			    "dhchap", identity, data, data_len,
> +			    keyperm, KEY_ALLOC_NOT_IN_QUOTA |
> +			    KEY_ALLOC_BUILT_IN |
> +			    KEY_ALLOC_BYPASS_RESTRICTION);
> +	if (IS_ERR(keyref)) {
> +		pr_warn("refresh dhchap psk '%s' failed, error %ld\n",
> +			identity, PTR_ERR(keyref));
> +		kfree(identity);
> +		return ERR_PTR(-ENOKEY);
> +	}
> +	key = key_ref_to_ptr(keyref);
> +	pr_debug("generated dhchap psk %08x\n", key_serial(key));
> +	kfree(identity);
> +	return key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_dhchap_psk_refresh);
> +
> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity)

Same...

> +{
> +	key_ref_t keyref;
> +	key_serial_t keyring_id;
> +
> +	if (!keyring)
> +		keyring = nvme_keyring;
> +	keyring_id = key_serial(keyring);
> +	pr_debug("keyring %x lookup dhchap psk '%s'\n",
> +		 keyring_id, identity);
> +
> +	keyref = keyring_search(make_key_ref(keyring, true),
> +				&nvme_dhchap_psk_key_type,
> +				identity, false);
> +	if (IS_ERR(keyref)) {
> +		pr_debug("lookup dhchap psk '%s' failed, error %ld\n",
> +			 identity, PTR_ERR(keyref));
> +		return ERR_PTR(-ENOKEY);
> +	}
> +
> +	return key_ref_to_ptr(keyref);
> +}
> +EXPORT_SYMBOL_GPL(nvme_dhchap_psk_lookup);
> +
> +u8 nvme_dhchap_psk_hash(struct key *key)
> +{
> +	const struct user_key_payload *upayload;
> +	u8 hmac;
> +
> +	if (!key)
> +		return 0;
> +	upayload = user_key_payload_locked(key);
> +	hmac = upayload->data[upayload->datalen + 5];
> +	return hmac;
> +}
> +EXPORT_SYMBOL_GPL(nvme_dhchap_psk_hash);
> +
>   static int __init nvme_keyring_init(void)
>   {
>   	int err;
> @@ -270,11 +529,18 @@ static int __init nvme_keyring_init(void)
>   		key_put(nvme_keyring);
>   		return err;
>   	}
> +	err = register_key_type(&nvme_dhchap_psk_key_type);
> +	if (err) {
> +		unregister_key_type(&nvme_tls_psk_key_type);
> +		key_put(nvme_keyring);
> +		return err;
> +	}
>   	return 0;
>   }
>   
>   static void __exit nvme_keyring_exit(void)
>   {
> +	unregister_key_type(&nvme_dhchap_psk_key_type);
>   	unregister_key_type(&nvme_tls_psk_key_type);
>   	key_revoke(nvme_keyring);
>   	key_put(nvme_keyring);
> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> index ab8971afa973..d8baa71f061d 100644
> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -18,9 +18,14 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
>   
>   key_serial_t nvme_keyring_id(void);
>   struct key *nvme_tls_key_lookup(key_serial_t key_id);
> +
> +struct key *nvme_dhchap_psk_refresh(struct key *keyring,
> +		const u8 *data, size_t data_len);
> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity);
> +u8 nvme_dhchap_psk_hash(struct key *key);
> +
>   #else
>   static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> -		const char *hostnqn, char *subnqn, u8 hmac_id,
>   		u8 *data, size_t data_len, const char *digest)
>   {
>   	return ERR_PTR(-ENOTSUPP);
> @@ -38,5 +43,20 @@ static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
>   {
>   	return ERR_PTR(-ENOTSUPP);
>   }
> +static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
> +		const char *hostnqn, const char *subnqn,
> +		u8 *data, size_t data_len)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
> +		const char *hostnqn, const char *subnqn, u8 hmac);
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +u8 nvme_dhchap_psk_hash(struct key *key)
> +{
> +	return 0;
> +}
>   #endif /* !CONFIG_NVME_KEYRING */
>   #endif /* _NVME_KEYRING_H */


