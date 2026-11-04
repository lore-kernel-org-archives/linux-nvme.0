Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3E606A32D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JDaWgRgs;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wghdtQyh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5e+z+Nsh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ind5LpWH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f7IiroDZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=; b=JDaWgRgsI+D1MR
	ifNjDr9NK3CZPfCYnM+Hxuuzq4CxhGORh849CFe3/MdwOWTHQNof8F0a1FbsZvPrPgKVtt7UlKdxY
	AmTZWXEP5QIywGnw4DSAgjDpgkwdqRDvyqd3cfp6UZe4UwfNyGBFSk/xfi3rqgdV0gWVzOG6VMXbX
	l5qCS2ELs164G6ehH4MmzescVPJ0o+OkUVsM0y7hSzA1Le2bGig4ZiCcGDcRx3xqCoJNdaXkV0LD/
	/WSZPpEi6Nl3jZvjQYZgK0k3lEY5uUxitK5dfvGHoTYHEWKQiBf0+DiIkR3ndkbzGcwpSxX/YIIDM
	u7ZL6hANH1QRaAkNkG3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVgM-00000004aeZ-49xF;
	Wed, 04 Nov 2026 07:45:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVgK-00000004adl-0Hpp
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 07:45:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25D882205F;
	Wed,  4 Nov 2026 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793778314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=wghdtQyhWEfjtpGbObiLPzLgyFip+CZJswewFMwCM0XMARhG85CBg9faYTlPj4jgvAU7/f
	dUR2iNw2bTpyosHBV4H7mv73WdXbwItdVo6Vn9giOFxPIkT2fcmD/qm2BQmtxCUpCfcc+f
	YxS7KFnIbxOQFrCcEmyxN10N61ccOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793778314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=5e+z+NshI0xnLKXjjQEg4AZOt1Yt+Ps62MKeD2xFknD9HXidtU9ceQsNQg4sxxOhNjO6r3
	FoE6r9cTAcY0xaBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793778313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=ind5LpWHqbJn0QlS3pxCRiSp7gXfjfrg29loUOgSiQCoPL2P9yYDbMNktfRilsgxhmEfte
	bA9OOt3oQpiTXr0RtNIwTAaOyHXUFtoC+g5+60fT6KTfsmv1VK81iz2BCOhf+NCWb+tVwv
	hGcmtk5Y3S91m+UFkTYzEC3jtOfGC24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793778313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=f7IiroDZAc5A1GyVmAqFVJj7z/lajZ4WLhNVJYJTPecQVeLEEyrQ+YA23/iSnJVYrFESs2
	Fya6VK2ty3ck/nAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85CBC134A5;
	Wed,  4 Nov 2026 07:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1OCFYji6mqvSgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Nov 2026 07:45:12 +0000
Message-ID: <73883d88-b772-4c5a-8f1f-6b12c4501bb5@suse.de>
Date: Wed, 4 Nov 2026 08:45:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
To: Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
 stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Hannes Reinecke <hare@kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261103030226.2685251-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.ibm.com,kernel.dk,lst.de,grimberg.me,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_234516_577673_0138DD17 
X-CRM114-Status: GOOD (  14.93  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 4:02 AM, Jarkko Sakkinen wrote:
> Call key_put() before returning -EKEYREVOKED, as the reference count gets
> incremented by key_lookup().
> 
> Cc: stable@vger.kernel.org # v6.12+
> Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   drivers/nvme/common/keyring.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 32d16c53133b..87cb51e1f5a7 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -35,6 +35,7 @@ struct key *nvme_tls_key_lookup(key_serial_t key_id)
>   	}
>   	if (nvme_tls_psk_revoked(key)) {
>   		pr_err("key id %08x revoked\n", key_id);
> +		key_put(key);
>   		return ERR_PTR(-EKEYREVOKED);
>   	}
>   	return key;

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

