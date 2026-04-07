Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A314DFB519C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 06:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AbwszduB7h01QhPwL2I2SdgLhM0MmkGhqgRT9ClygP4=; b=qhbjW3jJkamDQOYpfICVr5G84s
	qFoVVn5Ft5ohNsavshcK2MZi+3Q9Fxp5uJfXPkqPDtEps/rts00dhGEWs1bFgXA6INQTI7Avt24bN
	KPd0sspTRLc1LBR7LBc+jAfVAMGVE4abVW+w5biy3Dtr9zF9qyfLHIKojz36h00PA9DBQuj+sN3ek
	HhlF8ge07IW8b7EtimSGQCzkew5BM7Kl3bL3cSHRiFAF337ZN2l6fiGGXQJBMGgDPTnuwMO1m0V0v
	sYQ76wMFqhKLEwm+Pl3/t+/kRmptXIvQXsFt0quNOfcYFhgnZnogQfdfozY92czfyfb01NGbIO1Yr
	2DtLEC1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zm2-00000005yVG-3UjI;
	Tue, 07 Apr 2026 06:18:54 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zlz-00000005yUk-2IGq
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 06:18:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CE475BDCF;
	Tue,  7 Apr 2026 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775542729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbwszduB7h01QhPwL2I2SdgLhM0MmkGhqgRT9ClygP4=;
	b=ScuC9GZ8ZGsbTZuPXFlOQLhm6WVpLvqRk5TktdbPYNWZNJdXDmPWeYkoeJy90j7zIc2htt
	6B1Wz35+jjnd7a6mjXMuig6hHyLOtpnrE9DE4U9GAmPJwxBaldDOxvJD8Wf5+kV/3ehIWO
	DKs/drSXWhCLg3oUoF3Cp6C652NVxcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775542729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbwszduB7h01QhPwL2I2SdgLhM0MmkGhqgRT9ClygP4=;
	b=DOKMUGUCgd0kmHlX9bfcuD/7D2aQq2WOSQ6yH9jlvHsvK0tFToiOPZW9EyeN7HvWjTaPAZ
	LEmEMyq9QEY1YSAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775542729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbwszduB7h01QhPwL2I2SdgLhM0MmkGhqgRT9ClygP4=;
	b=ScuC9GZ8ZGsbTZuPXFlOQLhm6WVpLvqRk5TktdbPYNWZNJdXDmPWeYkoeJy90j7zIc2htt
	6B1Wz35+jjnd7a6mjXMuig6hHyLOtpnrE9DE4U9GAmPJwxBaldDOxvJD8Wf5+kV/3ehIWO
	DKs/drSXWhCLg3oUoF3Cp6C652NVxcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775542729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbwszduB7h01QhPwL2I2SdgLhM0MmkGhqgRT9ClygP4=;
	b=DOKMUGUCgd0kmHlX9bfcuD/7D2aQq2WOSQ6yH9jlvHsvK0tFToiOPZW9EyeN7HvWjTaPAZ
	LEmEMyq9QEY1YSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7206F4A0B0;
	Tue,  7 Apr 2026 06:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aad/Gsmh1GlcDwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 06:18:49 +0000
Message-ID: <f9dd8df2-b1e4-496d-bd62-b162ef766374@suse.de>
Date: Tue, 7 Apr 2026 08:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] nvme-keyring: add 'dhchap' key type
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-3-hare@kernel.org>
 <20260401-a15bafde727aaad4bed7f497@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260401-a15bafde727aaad4bed7f497@redhat.com>
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
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_231851_759061_1EBE2B01 
X-CRM114-Status: GOOD (  30.75  )
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

On 4/1/26 20:13, Chris Leech wrote:
> On Tue, Mar 17, 2026 at 02:00:57PM +0100, Hannes Reinecke wrote:
>> Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
>> Keys are stored with a 'user-type' compatible payload, such
>> that one can use 'user_read()' to access the raw contents
>> and the 'read()' callback to get the base64-encoded key
>> data in the DH-HMAC-CHAP secret representation.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/common/keyring.c | 216 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 216 insertions(+)
>>
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index 32d16c53133b..f7e18df438e6 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -4,6 +4,9 @@
>>    */
> ...
>> +/**
>> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
>> + * @prep: preparsed payload of the key data
>> + *
>> + * Decode the DH-HMAC-CHAP key data passed in in @prep and
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
>> +	size_t datalen = prep->datalen, keylen;
>> +	int ret;
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
>> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
>> +		   &version, &hmac) != 2) {
>> +		pr_debug("%s: invalid key data '%s'\n", __func__,
>> +			 (char *)prep->data);
>> +		prep->payload.data[0] = NULL;
>> +		prep->quotalen = 0;
>> +		return -EINVAL;
>> +	}
> 
> version should be verified to be the expected value of 1 here
> (or hardcoded to only accept 1 in the sscanf call like the repalced
> code removed in the next patch)
>   
Indeed, will be changing it.

>> +	/* skip header and final ':' character */
>> +	datalen -= 11;
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
>> +	prep->quotalen = keylen;
> 
> Uninitialized keylen is being used here to set quotelen.
> 
Ok.

>> +	prep->payload.data[0] = upayload;
>> +	ret = base64_decode(prep->data + 10, datalen, upayload->data,
>> +			    true, BASE64_STD);
>> +	if (ret < 0) {
>> +		pr_debug("%s: Failed to decode key %s\n",
>> +			 __func__, (char *)prep->data + 10);
>> +		return ret;
>> +	}
>> +	ret -= 4;
>> +	crc = ~crc32(~0, upayload->data, ret);
>> +	if (get_unaligned_le32(upayload->data + ret) != crc) {
>> +		pr_debug("%s: CRC mismatch for key\n", __func__);
>> +		/* CRC mismatch */
>> +		return -EKEYREJECTED;
>> +	}
>> +	/* append version and hmac to the payload */
>> +	upayload->data[ret + 4] = version;
>> +	upayload->data[ret + 5] = hmac;
>> +	upayload->datalen = ret;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
>> + * @size: size of the encoded key
>> + *
>> + * Returns the expected size of the key after base64 decoding.
>> + */
> 
> Isn't this the expected size after encoding, and not decoding?
> It's used before a call to base64_encode.
> 
Yeah, you are right.

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
> Why don't these keylen numbers match BASE64_CHARS()?
> 
Good question. They could.

>> +/**
>> + * nvme_dhchap_psk_read - read callback for dhchap key types
>> + * @key: key to read from
>> + * @buffer: buffer for the key contents
>> + * @buflen: length of @buffer
>> + *
>> + * Formets the DH-HMAC-CHAP key in base64-encoded form as
> 
> spelling typo /Formets/Formats/
>
Ok, will fix it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

