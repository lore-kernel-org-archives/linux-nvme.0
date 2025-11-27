Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7199BCFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UgpXAVjFVpY+UIXQUyWqJZ9sJHKfuJOG2bHrh3HYzN8=; b=fbERzZ8tP7tBWcCrBigoJBCEuo
	doKgk9R5HVQ5cFjqfbFD+UqlsKK+ZtxSAcCqZ/cWp6fA6bbdWNjO7VGMOGCYrvnKpl+XVaaqdhl2/
	M92pitu98z5G/kSMlYDng4Qmm91erDDmD5jyrr0LHYi7SbWZsiSbUxn3O6KQx2ZjS/jMKRPRoW8IV
	XQw3M1OyioXNY+sxETcNc/OJI2HRgvry6sFfkLSlJ/NH+b/JanEdyO3GJIzgYgdPvT0Px6DMBCVSC
	IrvAX0HMzDGzMjAR9ZVRl3iKmVs/8DfKaoy4wo+9jAQTiiTHAXGeuTcJcAqpAjFemmgXPzvOc4BSN
	0ImAdULw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOX1J-0000000GBLa-1mJ4;
	Thu, 27 Nov 2025 08:06:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOX1G-0000000GBLF-1jfp
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 08:06:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4421921BB5;
	Thu, 27 Nov 2025 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgpXAVjFVpY+UIXQUyWqJZ9sJHKfuJOG2bHrh3HYzN8=;
	b=AYsb6Knh8mYYgYqR9QWZtrlVLr98lI42zHnezYrwnZM2X5nuzP3nWVqX0jWTXAmMF0A2hq
	AWKOJCIJNYFpmWKvwUMu1QDkO0X0FJAj/28ZdMvKVCxbkd8DJ09z90YP1EL4tyIHIRG4aG
	hF7NOaiESBOixkOoPq9FiYvzzpQ/w8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgpXAVjFVpY+UIXQUyWqJZ9sJHKfuJOG2bHrh3HYzN8=;
	b=6K/WlZULFvlrKpp9uWTpBiNjJM4JF8q1WiNrAvzz7/dMlPpvqTVcxb4txUpnF00CBPxGo3
	5OLPp1+eN+3UK7Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgpXAVjFVpY+UIXQUyWqJZ9sJHKfuJOG2bHrh3HYzN8=;
	b=AYsb6Knh8mYYgYqR9QWZtrlVLr98lI42zHnezYrwnZM2X5nuzP3nWVqX0jWTXAmMF0A2hq
	AWKOJCIJNYFpmWKvwUMu1QDkO0X0FJAj/28ZdMvKVCxbkd8DJ09z90YP1EL4tyIHIRG4aG
	hF7NOaiESBOixkOoPq9FiYvzzpQ/w8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgpXAVjFVpY+UIXQUyWqJZ9sJHKfuJOG2bHrh3HYzN8=;
	b=6K/WlZULFvlrKpp9uWTpBiNjJM4JF8q1WiNrAvzz7/dMlPpvqTVcxb4txUpnF00CBPxGo3
	5OLPp1+eN+3UK7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F5AD3EA63;
	Thu, 27 Nov 2025 08:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GQ+iAYAGKGkdEwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 08:06:24 +0000
Message-ID: <5eb61eb0-9883-4f7b-ae49-9c8d4852af9d@suse.de>
Date: Thu, 27 Nov 2025 09:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] nvme-keyring: add 'dhchap' key type
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-3-hare@kernel.org>
 <18bf1285-f6b4-4ac1-a9f0-1760adab3f11@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <18bf1285-f6b4-4ac1-a9f0-1760adab3f11@grimberg.me>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_000626_952566_B7A09D9A 
X-CRM114-Status: GOOD (  33.25  )
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

On 11/26/25 08:46, Sagi Grimberg wrote:
> 
> 
> On 28/05/2025 17:05, Hannes Reinecke wrote:
>> Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
>> Keys are stored with a 'user-type' compatible payload, such
>> that one can use 'user_read()' to access the raw contents
>> and the 'read()' callback to get the base64-encoded key
>> data in the DH-HMAC-CHAP secret representation.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/common/keyring.c | 266 ++++++++++++++++++++++++++++++++++
>>   include/linux/nvme-keyring.h  |  22 ++-
>>   2 files changed, 287 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/ 
>> keyring.c
>> index 32d16c53133b..a58c93c6d495 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -4,6 +4,9 @@
>>    */
>>   #include <linux/module.h>
>> +#include <linux/crc32.h>
>> +#include <linux/base64.h>
>> +#include <linux/unaligned.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/key-type.h>
>>   #include <keys/user-type.h>
>> @@ -252,6 +255,262 @@ key_serial_t nvme_tls_psk_default(struct key 
>> *keyring,
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
>> +static void nvme_dhchap_psk_describe(const struct key *key, struct 
>> seq_file *m)
>> +{
>> +    seq_puts(m, key->description);
>> +    seq_printf(m, ": %u", key->datalen);
>> +}
>> +
>> +static bool nvme_dhchap_psk_match(const struct key *key,
>> +                  const struct key_match_data *match_data)
>> +{
>> +    const char *match_id;
>> +    size_t match_len;
>> +
>> +    if (!key->description) {
>> +        pr_debug("%s: no key description\n", __func__);
>> +        return false;
>> +    }
>> +    if (!match_data->raw_data) {
>> +        pr_debug("%s: no match data\n", __func__);
>> +        return false;
>> +    }
>> +    match_id = match_data->raw_data;
>> +    match_len = strlen(match_id);
>> +    pr_debug("%s: match '%s' '%s' len %zd\n",
>> +         __func__, match_id, key->description, match_len);
>> +
>> +    return !memcmp(key->description, match_id, match_len);
>> +}
>> +
>> +static int nvme_dhchap_psk_match_preparse(struct key_match_data 
>> *match_data)
>> +{
>> +    match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
>> +    match_data->cmp = nvme_dhchap_psk_match;
>> +    return 0;
>> +}
>> +
>> +/**
>> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
>> + * @prep: preparsed payload of the key data
>> + *
>> + * Decode the DH-HMAC-CHAP key data passed in in @prep and
>> + * store the resulting binary data. The binary data includes
>> + * space for the CRC, the version, and the hmac identifier,
>> + * but the data length is just the key data without the CRC.
>> + * This allows the user to read the key data via the
>> + * 'user_read()' function, but also to export the full
>> + * key data including CRC via the 'read' callback from the key type.
>> + */
>> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
>> +{
>> +    struct user_key_payload *upayload;
>> +    size_t datalen = prep->datalen, keylen;
>> +    int ret;
>> +    u32 crc;
>> +    u8 version, hmac;
>> +
>> +    if (!prep->data) {
>> +        pr_debug("%s: Empty data", __func__);
>> +        prep->payload.data[0] = NULL;
>> +        prep->quotalen = 0;
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s", &version, 
>> &hmac) != 2) {
>> +        pr_debug("%s: invalid key data '%s'\n", __func__,
>> +             (char *)prep->data);
>> +        prep->payload.data[0] = NULL;
>> +        prep->quotalen = 0;
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* skip header and final ':' character */
>> +    datalen -= 11;
>> +
>> +    /* keylen is the key length, 4 bytes CRC, 1 byte version, and 1 
>> byte HMAC identifier */
>> +    switch (datalen) {
>> +    case 48:
>> +        keylen = 38;
>> +        break;
>> +    case 72:
>> +        keylen = 54;
>> +        break;
>> +    case 92:
>> +        keylen = 70;
>> +        break;
>> +    default:
> 
> This feels like random arithmetic Hannes. Really really really hard to 
> review this code
> and understand if it is correct without trying to decipher the bits/ 
> bytes of the payload.
> 
> Can we introduce well documented macros/helpers to make this code more 
> explainable?
> 
Sure, will do.

>> +        pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
>> +        prep->payload.data[0] = NULL;
>> +        prep->quotalen = 0;
>> +        return -EINVAL;
>> +    }
>> +
>> +    upayload = kzalloc(sizeof(*upayload) + keylen, GFP_KERNEL);
>> +    if (!upayload) {
>> +        prep->payload.data[0] = NULL;
>> +        prep->quotalen = 0;
>> +        return -ENOMEM;
>> +    }
>> +
>> +    /* decode the data */
>> +    prep->quotalen = keylen;
>> +    prep->payload.data[0] = upayload;
>> +    ret = base64_decode(prep->data + 10, datalen, upayload->data);
>> +    if (ret < 0) {
>> +        pr_debug("%s: Failed to decode key %s\n",
>> +             __func__, (char *)prep->data + 10);
>> +        return ret;
>> +    }
>> +    ret -= 4;
>> +    crc = ~crc32(~0, upayload->data, ret);
>> +    if (get_unaligned_le32(upayload->data + ret) != crc) {
>> +        pr_debug("%s: CRC mismatch for key\n", __func__);
>> +        /* CRC mismatch */
>> +        return -EKEYREJECTED;
>> +    }
>> +    upayload->data[ret + 4] = version;
>> +    upayload->data[ret + 5] = hmac;
> 
> Again some more inline random arithmetic.
> 
I described it briefly in the function description, but will
be updating it to give a detailed layout of the keys.

>> +    upayload->datalen = ret;
>> +    return 0;
>> +}
>> +
>> +static long nvme_dhchap_psk_read(const struct key *key, char *buffer, 
>> size_t buflen)
>> +{
>> +    const struct user_key_payload *upayload;
>> +    size_t datalen, keylen;
>> +    u8 version, hmac;
>> +    long ret;
>> +
>> +    upayload = user_key_payload_locked(key);
>> +    switch (upayload->datalen) {
>> +        case 32:
>> +        keylen = 59;
> 
> Some more random arithmetic...
> 
See above, will be moved into a helper function.

>> +        break;
>> +        case 48:
>> +        keylen = 83;
>> +        break;
>> +        case 64:
>> +        keylen = 103;
>> +        break;
>> +        default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!buffer || buflen == 0)
>> +        return keylen;
>> +
>> +    if (buflen < keylen)
>> +        return -EINVAL;
>> +
>> +    memset(buffer, 0, buflen);
>> +    version = upayload->data[upayload->datalen + 4];
>> +    hmac = upayload->data[upayload->datalen + 5];
>> +    ret = sprintf(buffer, "DHHC-%01hhu:%02hhu:", version, hmac);
>> +    if (ret < 0)
>> +        return -ENOKEY;
>> +    /* Include the trailing CRC */
>> +    datalen = upayload->datalen + 4;
>> +    ret += base64_encode(upayload->data, datalen, buffer + ret);
>> +    buffer[ret] = ':';
>> +    ret++;
>> +    return ret;
>> +}
>> +
>> +static struct key_type nvme_dhchap_psk_key_type = {
>> +    .name           = "dhchap",
>> +    .flags          = KEY_TYPE_NET_DOMAIN,
>> +    .preparse       = nvme_dhchap_psk_preparse,
>> +    .free_preparse  = user_free_preparse,
>> +    .match_preparse = nvme_dhchap_psk_match_preparse,
>> +    .instantiate    = generic_key_instantiate,
>> +    .revoke         = user_revoke,
>> +    .destroy        = user_destroy,
>> +    .describe       = nvme_dhchap_psk_describe,
>> +    .read           = nvme_dhchap_psk_read,
>> +};
>> +
>> +struct key *nvme_dhchap_psk_refresh(struct key *keyring,
>> +        const u8 *data, size_t data_len)
> 
> Is there a call-site to this? I don't see one...
> 
Hmm. I thought there was, but I'll check.
Will be moving it into the patch requiring it.

>> +{
>> +    key_perm_t keyperm =
>> +        KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
>> +        KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
>> +        KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
>> +    char *identity;
>> +    key_ref_t keyref;
>> +    key_serial_t keyring_id;
>> +    struct key *key;
>> +    uuid_t key_uuid;
>> +
>> +    if (data == NULL || !data_len)
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    generate_random_uuid(key_uuid.b);
>> +    identity = kasprintf(GFP_KERNEL, "%pU", &key_uuid);
>> +    if (!identity)
>> +        return ERR_PTR(-ENOMEM);
>> +    if (!keyring)
>> +        keyring = nvme_keyring;
>> +    keyring_id = key_serial(keyring);
>> +
>> +    pr_debug("keyring %x generate dhchap psk '%s'\n",
>> +         keyring_id, identity);
>> +    keyref = key_create(make_key_ref(keyring, true),
>> +                "dhchap", identity, data, data_len,
>> +                keyperm, KEY_ALLOC_NOT_IN_QUOTA |
>> +                KEY_ALLOC_BUILT_IN |
>> +                KEY_ALLOC_BYPASS_RESTRICTION);
>> +    if (IS_ERR(keyref)) {
>> +        pr_warn("refresh dhchap psk '%s' failed, error %ld\n",
>> +            identity, PTR_ERR(keyref));
>> +        kfree(identity);
>> +        return ERR_PTR(-ENOKEY);
>> +    }
>> +    key = key_ref_to_ptr(keyref);
>> +    pr_debug("generated dhchap psk %08x\n", key_serial(key));
>> +    kfree(identity);
>> +    return key;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_dhchap_psk_refresh);
>> +
>> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char 
>> *identity)
> 
> Same...
> 
See above. Will be moving it into the patch requiring it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

