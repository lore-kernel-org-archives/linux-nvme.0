Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54B606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EOKLAdEt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xV2D8mFi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BKoXonjo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WBoYW7Tx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OG3kP68D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=75ACb8MU2pRldjtAiseJjhNyj1Ka9sWUGfzFXhRm3XY=; b=EOKLAdEtv9LBlU
	dAwt6ur0KdpYiobPlp+Yo22u38D8m0V2NSFwMm113SoWVLGSDX3aPgVCaO6nWixR1/rc3LztQqLbH
	24jkm+om8n/wR2OeoZ+Pu5GHpga+WqEw7ezi2BnpyMzuoskMHg8UP5SM88wmAwf7yJ7uoguBZvmI+
	u7CPE0OxMXaNhPwIIkIN1/kaATIKEUxbJfdatFiI87nAHFonzS/OaNf1dphQMDcRIdblm56Y6/Lke
	IlvVq0KoiEupd3/WAinyASIebdhZa+kr5NDiKvw/TX1juSgWIL+XRc7XfSXtcBbejPEiX6RMERkCz
	WpSECFrPgeqYHjegVmSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTw6-00000003XzK-3IDy;
	Mon, 23 Nov 2026 13:18:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTw2-00000003XyY-1hdV
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 13:18:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F34612202C;
	Mon, 23 Nov 2026 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795439896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75ACb8MU2pRldjtAiseJjhNyj1Ka9sWUGfzFXhRm3XY=;
	b=xV2D8mFiWKofZ3JPIV4Z+eOpuzYL110v8I2gneS4x0EIM61uWO5ahbKlUOqwiHR2NBtUTH
	/O2i8FNzTkP9ba/G1K+nVbbggETKxv5VTvVYixP/sM5CCSnzBrAayo+1TPcXasVpTCFrR0
	7JjsFnAdyD/hraxENz1iX3eYPbO43qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795439896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75ACb8MU2pRldjtAiseJjhNyj1Ka9sWUGfzFXhRm3XY=;
	b=BKoXonjovW+MU8QBF90Qeod1CFHTHKzMRuSO5kRwdDp/LuN2TAqt+D4eKyECWKCOGTtXlQ
	QAQ807gc9xOc7oCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WBoYW7Tx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OG3kP68D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795439895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75ACb8MU2pRldjtAiseJjhNyj1Ka9sWUGfzFXhRm3XY=;
	b=WBoYW7TxeA+YeJy9a1xqIqoBEE0w/8rQiDT3tuBsAugM5wtbN//U4TqaKiFQ4bCNa2ZZn8
	+F9ZuGUiAHBax8Z+6U87fgvY1ucUfj4iIacG7USWNFvXE6VT6CejFEQ8nb7yj9HNCNyFe7
	ACijSQdreF/QFFYX9Fw2l0y7PEATSmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795439895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75ACb8MU2pRldjtAiseJjhNyj1Ka9sWUGfzFXhRm3XY=;
	b=OG3kP68DXCnwgenX2QX31T51BV6j4c01famc6q/AkC7ddj7IbZv0ML1wXa6YzYvI7tytqz
	0tcn4V6uxMw43WBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9AE113510;
	Mon, 23 Nov 2026 13:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wCKNIxY9BGtcEQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 13:18:14 +0000
Message-ID: <d84ccc6f-66fe-4154-af73-3f8e4e60857d@suse.de>
Date: Mon, 23 Nov 2026 14:18:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] nvme-keyring: add 'dhchap' key type
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-2-81eefb4c0724@kernel.org>
 <sashiko-outbox-229232@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229232@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: F34612202C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_051818_977017_0FC98AEA 
X-CRM114-Status: GOOD (  41.87  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 1:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issues to consider:
> - [Critical] nvme-keyring: out-of-bounds read on prep->data in
>    nvme_dhchap_psk_preparse()
> - [High] nvme-keyring: uninitialized offset used in
>    nvme_dhchap_psk_preparse()
> - [High] nvme-keyring: header offset mismatch in
>    nvme_dhchap_psk_preparse()
> - [High] nvme-keyring: memory leak of upayload on error in
>    nvme_dhchap_psk_preparse()
> - [Medium] nvme-keyring: broken key length queries in
>    nvme_dhchap_psk_read()
> - [Low] nvme-keyring: inverted naming and comment for
>    nvme_dhchap_decoded_key_size()
> - [Low] nvme-keyring: missing select CRC32 in Kconfig for
>    nvme_dhchap_psk_preparse()
> - [Low] nvme-keyring: redundant nvme_dhchap_psk_match_preparse() forces
>    linear scan
> --
> 
> commit d9b56f363bf407639fb6f4f459820389f42a36f1
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-keyring: add 'dhchap' key type
> 
> This commit registers a 'dhchap' key type in the NVMe keyring module to
> parse, store, and read back base64-encoded DH-HMAC-CHAP secret keys.
> 
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index 87cb51e1f5a7f..d0c36d153afdb 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -4,6 +4,9 @@
>>    */
>>   
>>   #include <linux/module.h>
>> +#include <linux/crc32.h>
>> +#include <linux/base64.h>
>> +#include <linux/unaligned.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/key-type.h>
>>   #include <keys/user-type.h>
> 
> [Severity: Low]
> nvme_dhchap_psk_preparse() calls crc32(), which expands to crc32_le(), but
> config NVME_KEYRING in drivers/nvme/common/Kconfig only selects KEYS and does
> not select CRC32.  Should NVME_KEYRING select CRC32 so builds without
> CONFIG_CRC32 enabled by another option do not fail at link time?
> 

You are right, will be fixed in the next version.

>> @@ -253,6 +256,231 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
> 
> [ ... ]
> 
>> +static bool nvme_dhchap_psk_match(const struct key *key,
>> +				  const struct key_match_data *match_data)
>> +{
>> +	const char *match_id;
>> +	size_t match_len;
>> +
>> +	if (!key->description) {
>> +		pr_debug("%s: no key description\n", __func__);
>> +		return false;
>> +	}
>> +	if (!match_data->raw_data) {
>> +		pr_debug("%s: no match data\n", __func__);
>> +		return false;
>> +	}
>> +	match_id = match_data->raw_data;
>> +	match_len = strlen(match_id);
>> +	if (match_len != strlen(key->description)) {
>> +		pr_debug("%s: match '%s' '%s' different size\n",
>> +			 __func__, match_id, key->description);
>> +		return false;
>> +	}
>> +	pr_debug("%s: match '%s' '%s' len %zd\n",
>> +		 __func__, match_id, key->description, match_len);
>> +
>> +	return !memcmp(key->description, match_id, match_len);
>> +}
>> +
>> +static int nvme_dhchap_psk_match_preparse(struct key_match_data *match_data)
>> +{
>> +	match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
>> +	match_data->cmp = nvme_dhchap_psk_match;
>> +	return 0;
>> +}
> 
> [Severity: Low]
> Is nvme_dhchap_psk_match_preparse() needed here?  nvme_dhchap_psk_match()
> checks for an exact description match identical to key_default_cmp(), so
> overriding lookup_type to KEYRING_SEARCH_LOOKUP_ITERATE forces every dhchap
> key lookup to do a linear scan of the keyring instead of a direct associative
> array lookup.
> 
Possibly not. I'll drop it for the next version.

>> +
>> +/**
>> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
>> + * @prep: preparsed payload of the key data
>> + *
>> + * Decode the DH-HMAC-CHAP key data passed in @prep and
>> + * store the resulting binary data. The binary data includes
>> + * space for the CRC, the version, and the hmac identifier,
>> + * but the data length is just the key data without the CRC.
>> + * This allows the user to read the key data via the
>> + * 'user_read()' function. The additional 'version' ahd 'hmac'
>> + * data is used in the ->read() callback to generate the
>> + * base64 encoded key.
>> + */
>> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
>> +{
>> +	struct user_key_payload *upayload;
>> +	size_t datalen = prep->datalen;
>> +	int ret, offset;
>> +	char *p;
>> +	u32 crc;
>> +	u8 version, hmac;
>> +
>> +	if (!prep->data) {
>> +		pr_debug("%s: Empty data", __func__);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
>> +		   &version, &hmac, &offset) != 2 || !offset) {
>> +		pr_debug("%s: invalid key data '%s'\n", __func__,
>> +			 (char *)prep->data);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
> 
> [Severity: High]
> Can offset be used uninitialized when the second ':' in the header is
> missing?
> 
> In vsscanf(), %n does not increment the conversion count.  An input such as
> "DHHC-1:00" converts version and hmac, fails to match the trailing ':', and
> returns 2 before reaching %n.  Because offset is not initialized to 0,
> !offset reads whatever value is on the stack and later passes
> prep->data + offset to strlen() and strrchr().
> 
Fixed by initializing 'offset'.

>> +
>> +	/* skip header and final ':' character */
>> +	datalen = strlen(prep->data + offset);
>> +	p = strrchr(prep->data + offset, ':');
>> +	if (p)
>> +		datalen--;
> 
> [Severity: Critical]
> Can sscanf(), strlen(), strrchr(), and pr_debug() read past the end of
> prep->data?
> 
> add_key() and keyctl_update_key() allocate an exact plen-byte buffer with
> kvmalloc() and copy the user payload without adding a NUL terminator:
> 
> security/keys/keyctl.c:SYSCALL_DEFINE5(add_key) {
>      ...
> 	if (plen) {
> 		ret = -ENOMEM;
> 		payload = kvmalloc(plen, GFP_KERNEL);
> 		if (!payload)
> 			goto error2;
> 
> 		ret = -EFAULT;
> 		if (copy_from_user(payload, _payload, plen) != 0)
> 			goto error3;
> 	}
>      ...
> }
> 
> nvme_dhchap_psk_preparse() never bounds prep->data by prep->datalen before
> treating it as a NUL-terminated string, so a non-NUL-terminated payload from
> userspace causes out-of-bounds kernel memory reads.
> 
Fixed by checking the data length and using memchr().

>> +
>> +	/*
>> +	 * payload is < key | version | hmac >
>> +	 * base64 decode will always return less data
>> +	 * than the encoded data, so allocating the size
>> +	 * of the encoded data will be large enough.
>> +	 */
>> +	upayload = kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
>> +	if (!upayload) {
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* decode the data */
>> +	prep->payload.data[0] = upayload;
>> +	ret = base64_decode(prep->data + 10, datalen, upayload->data,
>> +			    true, BASE64_STD);
>> +	if (ret < 0) {
>> +		pr_debug("%s: Failed to decode key %s\n",
>> +			 __func__, (char *)prep->data + 10);
>> +		prep->payload.data[0] = NULL;
>> +		return ret;
>> +	}
> 
> [Severity: High]
> Can base64_decode() read 1 byte past the key buffer and decode the wrong
> slice when offset is not 10?
> 
> Because 2 in %02hhu is a maximum field width, a header with a single-digit
> HMAC such as "DHHC-1:1:<base64>" sets offset to 9.  datalen is computed from
> prep->data + offset, but base64_decode() starts at prep->data + 10, skipping
> the first base64 character and reading 1 byte past the end of the string.
> 
Fixed by checking for 'offset == 10' earlier on.

> Also, if a trailing ':' is followed by any other character (such as a
> newline), decrementing datalen by 1 instead of using p - (prep->data + offset)
> leaves trailing characters in datalen.  And when base64_decode() fails it
> returns -1, so returning ret directly returns -EPERM to userspace instead of
> -EINVAL.
> 
Fixed by returning -EINVAL here.

>> +	if (ret != 36 && ret != 52 && ret != 68) {
>> +		pr_debug("%s: invalid decoded key size '%d'\n",
>> +			 __func__, ret);
>> +		prep->payload.data[0] = NULL;
>> +		return -EINVAL;
>> +	}
>> +	ret -= 4;
>> +	crc = ~crc32(~0, upayload->data, ret);
>> +	if (get_unaligned_le32(upayload->data + ret) != crc) {
>> +		pr_debug("%s: CRC mismatch for key\n", __func__);
>> +		/* CRC mismatch */
>> +		prep->payload.data[0] = NULL;
>> +		return -EKEYREJECTED;
>> +	}
> 
> [Severity: High]
> Does clearing prep->payload.data[0] = NULL on the error paths above leak
> upayload?
> 
> When ->preparse() returns an error, the keyring core calls ->free_preparse(),
> which is user_free_preparse() and frees prep->payload.data[0] via
> kfree_sensitive().  Setting prep->payload.data[0] = NULL on base64_decode(),
> key size, and CRC failures without freeing upayload causes
> user_free_preparse() to see NULL and leak the allocation.
> 

Fixed with the next version.

> [ ... ]
> 
>> +/**
>> + * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
>> + * @size: size of the encoded key
>> + *
>> + * Returns the expected size of the key after base64 decoding.
>> + */
>> +static inline int nvme_dhchap_decoded_key_size(int size)
>> +{
>> +	int keylen = -EINVAL;
>> +
>> +	switch (size) {
>> +	case 32:
>> +		keylen = 48;
>> +		break;
>> +	case 48:
>> +		keylen = 72;
>> +		break;
>> +	case 64:
>> +		keylen = 92;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return keylen;
>> +}
> 
> [Severity: Low]
> This isn't a bug, but the function name and kernel-doc comment are inverted:
> this helper takes the decoded binary key size (32, 48, or 64) and returns the
> base64-encoded size including the 4-byte CRC (48, 72, or 92).
> 
Updated the kernel-doc for the next version.

>> +
>> +/**
>> + * nvme_dhchap_psk_read - read callback for dhchap key types
>> + * @key: key to read from
>> + * @buffer: buffer for the key contents
>> + * @buflen: length of @buffer
>> + *
>> + * Formets the DH-HMAC-CHAP key in base64-encoded form as
>> + * defined in the NVM Express TCP Transport Specification Rev 1.1,
>> + * Section 3.6.1.5 'PSK Interchange Format'. The payload of @key
>> + * is assumed to be of 'struct user_key_payload', with the data
>> + * consisting of the key data of length 'upayload->datalen', followed
>> + * by four bytes of CRC, one byte version, and one byte hmac fields.
>> + */
>> +static long nvme_dhchap_psk_read(const struct key *key,
>> +				 char *buffer, size_t buflen)
>> +{
>> +	const struct user_key_payload *upayload;
>> +	size_t datalen, keylen;
>> +	u8 version, hmac;
>> +	long ret;
>> +
>> +	if (!buffer || buflen == 0)
>> +		return -EINVAL;
>> +
>> +	upayload = user_key_payload_locked(key);
>> +	/*
>> +	 * Expected output string length:
>> +	 * strlen("DHHC-") +
>> +	 * version (= 1) +
>> +	 * ':' (= 1) +
>> +	 * hmac (= 2) +
>> +	 * ':' (= 1) +
>> +	 * encoded base64 key length +
>> +	 * ':' (= 1)
>> +	 */
>> +	ret = nvme_dhchap_decoded_key_size(upayload->datalen);
>> +	if (ret < 0)
>> +		return ret;
>> +	keylen = ret + 11;
>> +	if (buflen < keylen)
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Should nvme_dhchap_psk_read() return keylen instead of -EINVAL when buffer is
> NULL, buflen is 0, or buflen < keylen?
> 
> key_type->read() is required to return the needed buffer size even when no
> buffer or a too-small buffer is provided.  keyctl_read_key() calls
> __keyctl_read_key(key, NULL, 0) both when userspace probes the key length
> (such as keyctl read or keyctl print) and on the first pass whenever buflen >
> PAGE_SIZE, so returning -EINVAL breaks those reads.
> 
Fixed in the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

