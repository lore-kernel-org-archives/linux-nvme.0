Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01F606A33B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zKUK33dU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RLC0+r9T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AN3dWK+H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RLC0+r9T;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AN3dWK+H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DznOofe412VasY5NfottlhLZcx2QvPorpPeMVccyu8I=; b=zKUK33dUrv1HiL
	+qNUbOkFPGicO1Np70g/Y93OkMJGUvos0N3P1o53MPEqYccxgSbwS3VaJqrt4Uu+m49L4tRU3j+S5
	Q89jKyhm/DVQuOvhkeU7rzwoeveKImrtfIMdvzdpHoSF1l+vPfd9CTQlpxZd/pUAH0zUlhZt7lErV
	er+VSpGXg/KxlAAEG4acfuICcLlwejK+vE3YSU9UbS9PmMUPCQmyTE3/7+2kCDipf3AhVKtS+/7sV
	phM4KsTYrgwHJs2DtyZ2YF+7wdxugI4/xSwOyIdnHgV87QABAg6psTkgZ5of41XGzbW5b4xrNBVOo
	KkQgsoBzoY/0PfgD3hnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQgAu-00000002trT-2IZ5;
	Tue, 10 Nov 2026 07:21:48 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQgAq-00000002toE-0R1c
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 07:21:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B69021E65;
	Tue, 10 Nov 2026 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794295300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DznOofe412VasY5NfottlhLZcx2QvPorpPeMVccyu8I=;
	b=RLC0+r9TTnJzZ+HeI5v+F7rATGZ+6b7e17nvnwxdDdAmpWm6qX2/KSqiktS30s/ZJ/Xapu
	cwm2MMqIQUHBKuR4D+fl3wbh9zV3liuLUpBTtpL1Q5ZNG7qHaOx+jOCAlEojsZfPG8VwcE
	t2mnFBPZ3j3BNLfJmT8GshcnBt9aS0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794295300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DznOofe412VasY5NfottlhLZcx2QvPorpPeMVccyu8I=;
	b=AN3dWK+H2q5gKttAySoq+r4Zl2PEHrxEl4QTXBeS6rHLtVkJhJDaXUeC2UzVjU+y2q1cgo
	NtvVDyxtBdgzO8Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794295300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DznOofe412VasY5NfottlhLZcx2QvPorpPeMVccyu8I=;
	b=RLC0+r9TTnJzZ+HeI5v+F7rATGZ+6b7e17nvnwxdDdAmpWm6qX2/KSqiktS30s/ZJ/Xapu
	cwm2MMqIQUHBKuR4D+fl3wbh9zV3liuLUpBTtpL1Q5ZNG7qHaOx+jOCAlEojsZfPG8VwcE
	t2mnFBPZ3j3BNLfJmT8GshcnBt9aS0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794295300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DznOofe412VasY5NfottlhLZcx2QvPorpPeMVccyu8I=;
	b=AN3dWK+H2q5gKttAySoq+r4Zl2PEHrxEl4QTXBeS6rHLtVkJhJDaXUeC2UzVjU+y2q1cgo
	NtvVDyxtBdgzO8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46DDF1339F;
	Tue, 10 Nov 2026 07:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pdnABwTG8mppagAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 07:21:40 +0000
Message-ID: <c1c1d946-8692-43c8-86af-4eeccf692100@suse.de>
Date: Tue, 10 Nov 2026 08:21:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-auth: use the parsed offset for the DH-CHAP key
To: shao.mingyin@zte.com.cn, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_232144_301837_616E0B74 
X-CRM114-Status: GOOD (  22.45  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 3:59 PM, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> nvme_auth_parse_key() accepts the DH-HMAC-CHAP key with
> 
> 	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> 		return -EINVAL;
> 
> and then skips a hardcoded ten characters:
> 
> 	key = nvme_auth_extract_key(secret + 10, key_hash);
> 
> The ten characters assume that the hash identifier is exactly two
> characters long.  A string such as "DHHC-1:1:" still makes sscanf()
> return 1, and secret + 10 then points one byte past the NUL terminator
> of the buffer.  nvme_auth_extract_key() starts with
> strlen(secret), so it reads past the end of the allocation.  The sysfs
> dhchap_secret and dhchap_ctrl_secret stores only require seven
> characters and a "DHHC-1:" prefix, so a short value reaches this code
> (even though the nvme-fabrics option parser rejects secrets shorter than
> eleven characters).
> 
> Use the %n conversion to obtain the real offset after the
> "DHHC-1:<hash>:" prefix and reject a string where the prefix is not
> complete.  This accepts both one and two character hash identifiers and
> never starts the key past the terminator.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with a live loop
> controller and host DH-CHAP.
> 
> Writing the 9-byte secret "DHHC-1:1:" to the dhchap_secret sysfs
> attribute makes the driver start the key ten bytes in, one byte past
> the NUL terminator:
> 
>    unpatched                            patched
>    KASAN slab-out-of-bounds in          write rejected (-EINVAL)
>    strlen/strrchr, nvme_auth_extract_key
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index e2e0c736540a..1fdc4e4ed0b9 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -489,17 +489,19 @@ int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key)
>   {
>   	struct nvme_dhchap_key *key;
>   	u8 key_hash;
> +	int offset = 0;
>   
>   	if (!secret) {
>   		*ret_key = NULL;
>   		return 0;
>   	}
>   
> -	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> +	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
> +	    !offset)
>   		return -EINVAL;
>   
>   	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> -	key = nvme_auth_extract_key(secret + 10, key_hash);
> +	key = nvme_auth_extract_key(secret + offset, key_hash);
>   	if (IS_ERR(key)) {
>   		*ret_key = NULL;
>   		return PTR_ERR(key);

An easier fix would've been to check that the string is longer
than 10 bytes. But anyway.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

