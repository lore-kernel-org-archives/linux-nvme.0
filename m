Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536C606A682
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=comT7VXv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PSgnByZw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=J25ShKko;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PSgnByZw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=J25ShKko
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IPWf29Ud9WhaTTrAL8Sio6mm9zTZA1n/ebtoOZ/3hzA=; b=comT7VXvA2ijut
	/BrezYQrJVWNPlvQjADYpHI8nykXa7v5I/BW7nG4X8NE8dZ4FuAY60rLKRaNcMm1BUXjp6gd8Pjlz
	oTzWtpRRivpqCzbYttBF+cNC6VplK8vXgT0PkGZJZdF5iE/hUlcmfKUMZr7/I5o1kwskhlM+gCDI1
	q+qiho6riIND7umL/BEmJPaoKzuBzHLygPUWCpDVKyUpr86MVMKj5ZzqrEOd0xpk4MN+BKI6rlAqG
	SApVP4o29UKvzfMUwY1/lR+FMb8IEiySWZZSChKYGu/u2Gi/VLvlJp2KlpFRrwDC8eBLeDhvpZQFp
	HHDzaI6jCTLfJz2/fWLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWF9t-0000000AQkM-0Wy3;
	Wed, 25 Nov 2026 15:43:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWF9m-0000000AQgX-3LYk
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 15:43:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 338161F855;
	Wed, 25 Nov 2026 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795621413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPWf29Ud9WhaTTrAL8Sio6mm9zTZA1n/ebtoOZ/3hzA=;
	b=PSgnByZwB70WlhPqQ1ZfFGP6kqEymEQM1aeRCnTyoIgL82qHayBMh8UI3if65skg1gcEXX
	4jMhrTsuL1vMTA1U2gmwmdwN3JeRqMhDF/0uLpNCA3UF2KalQqm9YWTuzWQmvOe3oaxKwD
	WmtN886VnWSKqiY+Vha3hsctDuhK2Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795621413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPWf29Ud9WhaTTrAL8Sio6mm9zTZA1n/ebtoOZ/3hzA=;
	b=J25ShKkozirXFEnmi/SBbmFOlqoUXJ6gC0cFrABl05JubDLAyndyiYeSJLqeGxWO9FujUw
	TOqvx3MY7Hxn5rCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795621413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPWf29Ud9WhaTTrAL8Sio6mm9zTZA1n/ebtoOZ/3hzA=;
	b=PSgnByZwB70WlhPqQ1ZfFGP6kqEymEQM1aeRCnTyoIgL82qHayBMh8UI3if65skg1gcEXX
	4jMhrTsuL1vMTA1U2gmwmdwN3JeRqMhDF/0uLpNCA3UF2KalQqm9YWTuzWQmvOe3oaxKwD
	WmtN886VnWSKqiY+Vha3hsctDuhK2Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795621413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPWf29Ud9WhaTTrAL8Sio6mm9zTZA1n/ebtoOZ/3hzA=;
	b=J25ShKkozirXFEnmi/SBbmFOlqoUXJ6gC0cFrABl05JubDLAyndyiYeSJLqeGxWO9FujUw
	TOqvx3MY7Hxn5rCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D631339F;
	Wed, 25 Nov 2026 15:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VqI3JyQCB2vjNAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Nov 2026 15:43:32 +0000
Message-ID: <18f90b98-470e-4693-bf28-64d7cf3df078@suse.de>
Date: Wed, 25 Nov 2026 16:43:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
 <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
 <20261124213222.GD2227373@google.com>
 <c2163003-948c-49fa-815e-b1f91814a80a@gmail.com>
 <561e1abd-2430-4808-af99-cbdd3fd86d31@suse.de>
 <a71a3d9f-0f19-45f4-bc98-a5663ad537b2@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a71a3d9f-0f19-45f4-bc98-a5663ad537b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.79
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_074339_011578_65283593 
X-CRM114-Status: GOOD (  30.43  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Martin,

On 11/25/26 1:18 PM, Martin Belanger wrote:
> 
> 
> On 11/25/26 02:26, Hannes Reinecke wrote:
>> And the other problem with your approach is that DH-CHAP
>> key don't actually have 'names'; they are just binary blobs.
>> If we want to refer to them by name we first would need to
>> agree on what the name actually _is_.
>>
>> What we could do is to store the key serial in struct
>> nvmf_ctrl_options; that would allow keysd to provision
>> the keys and rotate them via 'keyctl update' (or whatever
>> it's doing internally). And would get away from the
>> business of having to come up with a name for the key.
> 
> Yes, a key serial works for me. The kernel then needs no name for
> the key. The key description stays a userspace matter:
> 
> - The admin names each secret in the configuration: the connection
>    configuration of nvme-cli or nvme-discoverd refers to the secret by
>    that name, and nvme-keysd's configuration (or the KMIP server) holds
>    the secret under the same name.
> - At boot, nvme-keysd adds each secret to the keyring with
>    add_key("dhchap", <name>, ...). The name becomes the key
>    description.
> - At connect, libnvme takes the name from the connection
>    configuration, looks up the serial with keyctl_search() and passes
>    the serial to the kernel, as tls_key= does for TLS. libnvme already
>    does this lookup today, to check that the key exists before the
>    connect.
> 
> For rotation, the serial must stay the same when the secret changes,
> so that a connected controller uses the new secret at its next
> authentication. For this, v7 needs an .update operation in the
> dhchap key type (user_update() should do). nvme-keysd then rotates a
> secret with add_key() under the same description, which replaces the
> payload of the existing key. nvme-keysd does not need to know which
> controllers use the key, and no sysfs or configfs write is needed.
> 
Okay, good point. Will be doing that.

> For the sysfs and configfs attributes:
> 
> - For a key from the keyring, a read returns the key serial, as
>    tls_key and tls_configured_key do. The serial names the key the
>    controller uses. The description is available with keyctl describe.
> - A write of a serial is rejected. The serial is set at connect, and
>    after that the keyring is the only way to change the secret. I do
>    not want a second way to change a key: a writable serial would be
>    one, and it would let a write point the controller at any dhchap
>    key on the system.
> - A write of a raw secret (DHHC-1:...) keeps the current behavior,
>    because existing tools use it.
> 
> The same applies to dhchap_key and dhchap_ctrl_key in nvmet configfs.
> 
Okay, I see to get this included for the next round.
I will also move keyring handling towards linking any additional keyring
into the .nvme keyring for in-kernel usage. That will get us away from
the problem of not being able to access users-specified keyrings, and
also makes the internal interfaces easier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

