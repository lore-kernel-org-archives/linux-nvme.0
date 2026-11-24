Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E5606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x4RSAfBe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wPJRofyC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Owqs9kbL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wPJRofyC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Owqs9kbL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NFjJHepG+NxU5tNZbWIwXsv4T5TkeIw8paL5rl/I5WE=; b=x4RSAfBeDxJJWl
	SAXXS8o5V4de8Tj5w+P7pwnERtT7NTOJdJ0fR+WSTfypKssRVgi09c2Da/pDHPYwmtWfUOfMBjeJ7
	gDkazUBXykS/jTldK7wS7xAwXkS5VLT4xMWFrhdD89OxdrblXKP0/gtMIijDZtEuNR7pA6+P0ipz8
	UvPkvwKATrbAOM1xu2xyQtryZ3qTTZkCKDT5dLRoj44HAzUbDC1NSvfrCCs8Usce+leftFlO9AljN
	ZrsMnbNZqR5QhoeOztlr4egjYTXKBz6m91DKh+UQyM2I/K0X/uSR66MRE5FQ/6hplWg+eax43PUsD
	h0EzdBqI2cyeYepax7sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVl7x-00000005mty-1YJ1;
	Tue, 24 Nov 2026 07:39:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVl7u-00000005mta-0hKr
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 07:39:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1C081FB32;
	Tue, 24 Nov 2026 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795505979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFjJHepG+NxU5tNZbWIwXsv4T5TkeIw8paL5rl/I5WE=;
	b=wPJRofyCZ/T5ui0d+DTWblKoip5q+EWDwNrontNwwBLcl35sI2JfhW+m/3zUWJqBqSxqUp
	kBMhEIRoGv1+LN2AQi6JPR1oICf0HBjvoRpT5zXSnlX2Q9GNKU++wqCMuTYLoFy/t0twTn
	WZeI7owhyaEiAyVMalXshuKvLopZi4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795505979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFjJHepG+NxU5tNZbWIwXsv4T5TkeIw8paL5rl/I5WE=;
	b=Owqs9kbLmdlWTk+rgMbh4eOA44IauahvuM56SNunHJrPFRF/N6bfUNXpPiJLTFPeaxUJtL
	BXimfQqIQOyldwCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795505979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFjJHepG+NxU5tNZbWIwXsv4T5TkeIw8paL5rl/I5WE=;
	b=wPJRofyCZ/T5ui0d+DTWblKoip5q+EWDwNrontNwwBLcl35sI2JfhW+m/3zUWJqBqSxqUp
	kBMhEIRoGv1+LN2AQi6JPR1oICf0HBjvoRpT5zXSnlX2Q9GNKU++wqCMuTYLoFy/t0twTn
	WZeI7owhyaEiAyVMalXshuKvLopZi4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795505979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFjJHepG+NxU5tNZbWIwXsv4T5TkeIw8paL5rl/I5WE=;
	b=Owqs9kbLmdlWTk+rgMbh4eOA44IauahvuM56SNunHJrPFRF/N6bfUNXpPiJLTFPeaxUJtL
	BXimfQqIQOyldwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DED71339F;
	Tue, 24 Nov 2026 07:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ztS9Bzs/BWvuWQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Nov 2026 07:39:39 +0000
Message-ID: <cc10fc18-3943-44cb-a93f-116eda43ec78@suse.de>
Date: Tue, 24 Nov 2026 08:39:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] nvme-keyring: add 'dhchap' key type
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-2-5082a49715ab@kernel.org>
 <sashiko-outbox-229754@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229754@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_233942_566236_B2835705 
X-CRM114-Status: GOOD (  36.04  )
X-Spam-Score: -2.1 (--)
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

On 11/23/26 6:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [Critical] nvme-keyring: out-of-bounds read on prep->data in
>    nvme_dhchap_psk_preparse()
> - [Medium] nvme-keyring: broken colon handling in
>    nvme_dhchap_psk_preparse()
> - [Medium] nvme-keyring: broken buffer length check in
>    nvme_dhchap_psk_read()
> - [Low] nvme-keyring: use kfree_sensitive() on error in
>    nvme_dhchap_psk_preparse()
> - [Low] nvme-keyring: inverted name and comment for
>    nvme_dhchap_decoded_key_size()
> --
> 
> commit 821eb4c808c34e952c59ff2fa90f5898d0eb2667
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-keyring: add 'dhchap' key type
> 
> This commit adds a 'dhchap' key type to the NVMe keyring to store and read
> DH-HMAC-CHAP secret keys in a user-key compatible payload.
> 
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index 87cb51e1f5a7f..fc7f833a7c6b6 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -253,6 +256,213 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
> 
> [ ... ]
> 
>> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
>> +{
>> +	struct user_key_payload *upayload;
>> +	size_t datalen = prep->datalen;
>> +	int ret, offset = 0;
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
>> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
>> +		   &version, &hmac, &offset) != 2 || offset != 10) {
>> +		pr_debug("%s: invalid key header\n", __func__);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (version != 1 || hmac > 3) {
>> +		pr_debug("%s: invalid key version\n", __func__);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* skip header and final ':' character */
>> +	if (offset > prep->datalen) {
>> +		pr_debug("%s: invalid key data\n", __func__);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
> 
> [Severity: Critical]
> As reported by Martin Belanger on v5 [1], can sscanf() and the pr_debug()
> below read past the end of prep->data?
> 
> add_key() allocates a buffer of size plen (prep->datalen) and copies the raw
> userspace payload without appending a NUL terminator:
> 
> security/keys/keyctl.c:SYSCALL_DEFINE5(add_key)() {
>      ...
> 	if (_payload) {
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
> When userspace passes a non-NUL-terminated payload (for example, fewer than
> 10 bytes, or "DHHC-" followed by whitespace), sscanf() scans past
> prep->data + prep->datalen into adjacent kernel memory before the
> offset > prep->datalen check runs.  Similarly, when base64_decode() fails
> below, pr_debug("%s: Failed to decode key %s\n", ...) formats
> (char *)prep->data + offset with %s without bounding it by datalen.
> 
Fixed with the next version.

>> +	datalen = prep->datalen - offset;
>> +	p = memchr(prep->data + offset, ':', datalen);
>> +	if (p)
>> +		datalen--;
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
> 
> [Severity: Medium]
> Does decrementing datalen by 1 leave the trailing ':' in the base64 input
> whenever the payload ends with a NUL byte or newline?
> 
> If userspace passes a NUL-terminated or newline-terminated key string, ':'
> is not the final byte of prep->data, so datalen-- only strips the trailing
> NUL or newline and leaves ':' inside the slice passed to base64_decode(),
> which then fails with -EINVAL.  Truncating at p (datalen = p - (char *)
> (prep->data + offset)) and validating that datalen is a supported encoded
> key size before calling kzalloc() would also avoid allocating an arbitrary
> buffer up to 1 MB prior to length validation.
> 
Fixed with the next version.

>> +
>> +	/* decode the data */
>> +	prep->payload.data[0] = upayload;
>> +	ret = base64_decode(prep->data + offset, datalen, upayload->data,
>> +			    true, BASE64_STD);
>> +	if (ret < 0) {
>> +		pr_debug("%s: Failed to decode key %s\n",
>> +			 __func__, (char *)prep->data + offset);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		kfree(upayload);
>> +		return -EINVAL;
>> +	}
>> +	if (ret != 36 && ret != 52 && ret != 68) {
>> +		pr_debug("%s: invalid decoded key size '%d'\n",
>> +			 __func__, ret);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		kfree(upayload);
>> +		return -EINVAL;
>> +	}
>> +	ret -= 4;
>> +	crc = ~crc32(~0, upayload->data, ret);
>> +	if (get_unaligned_le32(upayload->data + ret) != crc) {
>> +		pr_debug("%s: CRC mismatch for key\n", __func__);
>> +		/* CRC mismatch */
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		kfree(upayload);
>> +		return -EKEYREJECTED;
>> +	}
> 
> [Severity: Low]
> Should these three error paths use kfree_sensitive(upayload) instead of
> kfree(upayload)?  base64_decode() has already written decoded secret key
> bytes into upayload->data, and clearing prep->payload.data[0] prevents
> user_free_preparse() from zeroizing the buffer.
> 
Indeed. Fixed with the next version.

> [ ... ]
> 
>> +/**
>> + * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
>> + * @size: size of the encoded key
>> + *
>> + * Returns the expected size of the key after base64 decoding
>> + * include 4 bytes of CRC.
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
> this helper takes the decoded key size (32, 48, or 64) and returns the
> base64-encoded size including the 4-byte CRC (48, 72, or 92).
> 
Fixed with the next version.

>> +
>> +/**
>> + * nvme_dhchap_psk_read - read callback for dhchap key types
>> + * @key: key to read from
>> + * @buffer: buffer for the key contents
>> + * @buflen: length of @buffer
>> + *
>> + * Formats the DH-HMAC-CHAP key in base64-encoded form as
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
>> +	if (!buffer && !buflen)
>> +		return keylen;
>> +	else if (buflen < keylen)
>> +		return -EINVAL;
>> +
>> +	memset(buffer, 0, buflen);
> 
> [Severity: Medium]
> Does this buffer check violate the key_type->read() contract and allow a
> NULL pointer dereference in memset()?
> 
> Per include/linux/key-type.h and keyctl_read_key(), ->read() should return
>   the required buffer size whenever buffer is NULL or buflen is too small
> (if (!buffer || buflen < keylen) return keylen;).  As written, calling
> keyctl(KEYCTL_READ) with a non-NULL buffer and 0 < buflen < keylen fails
> with -EINVAL instead of returning keylen, and a call with buffer == NULL and
> buflen >= keylen falls through to memset(NULL, 0, buflen).
> 
> [1] https://lore.kernel.org/r/463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

