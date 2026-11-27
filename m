Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CE606A324
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BNhfsdCf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IfriXSdI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IfriXSdI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=; b=BNhfsdCfuskpCp
	Iy82jRcsmyHlKCnLjjxdf6Vt6JFM9lYctkuwC6+D/X2DC5Gfx4pyKeb0/nXssRADT6fi1AwSQ+thC
	ItKpS39yTa7ujnvYuG71xyb1TELxLrF3M4rNutrEP7/Hq5G0uliQtfh6e3oLqOwGe/g2m3QmgT7sK
	K8TpSOJmnhyiK5xgHWEuSN38viycu9I9HRgKIDPQBHB0mffKdzQHT+uxL1wb1JNeM5TCtbgpJtt7S
	Suw0TJJmLHYe1nPo+nMdZ28Lju/k6r7FlOsweBxCgdSbPKrRZ1dWJ2eBDwxPGiNXG6yx8+xlkHGYZ
	bF9TbMl9JIASMFbMtElA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsQW-0000000FSlS-0OQV;
	Fri, 27 Nov 2026 09:39:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsQU-0000000FSl6-0tpw
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 09:39:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2EE21BCC;
	Fri, 27 Nov 2026 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795772368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=WqyzI4d7OF9Jx9D9ARNvg0y0zZbLvGXgJRJHnh9/KfdBYMtynivhi2GbdkkT2SiYV61Eui
	ST8QQLG+5EQwzh/rgfxDTFsdff9R+29ZcH4bOMu+F/84Sig7z2DaeNXtxOPadcVIDFpAWI
	uRACx8Bvuk/M1HuYIsqC04HuAPVMGjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795772368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=IfriXSdIZh9wxCVuuOI6gNhy0elbuaD1+0f2dQU0xXBBiW9QkNadahMT84f7IaWF1W5huM
	N+d10tU4dQ/UXRAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IfriXSdI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795772368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=WqyzI4d7OF9Jx9D9ARNvg0y0zZbLvGXgJRJHnh9/KfdBYMtynivhi2GbdkkT2SiYV61Eui
	ST8QQLG+5EQwzh/rgfxDTFsdff9R+29ZcH4bOMu+F/84Sig7z2DaeNXtxOPadcVIDFpAWI
	uRACx8Bvuk/M1HuYIsqC04HuAPVMGjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795772368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=IfriXSdIZh9wxCVuuOI6gNhy0elbuaD1+0f2dQU0xXBBiW9QkNadahMT84f7IaWF1W5huM
	N+d10tU4dQ/UXRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA9413432;
	Fri, 27 Nov 2026 09:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C/x8Is9PCWvfJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 09:39:27 +0000
Message-ID: <cea9934e-e152-4160-be9d-3a88886d6c04@suse.de>
Date: Fri, 27 Nov 2026 10:39:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into .nvme
 keyring
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
 <sashiko-outbox-235710@kernel.org>
 <45f16f1a-66f7-4300-bffb-3d279b6c4bfb@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <45f16f1a-66f7-4300-bffb-3d279b6c4bfb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C2EE21BCC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux.dev,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_013930_423272_80322104 
X-CRM114-Status: GOOD (  18.26  )
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

On 11/26/26 5:49 PM, Martin Belanger wrote:
> 
> 
> On 11/26/26 09:30, sashiko-bot@kernel.org wrote:
>> [Severity: High]
>> Does nvme_keyring_unlink() remove a pre-provisioned key that originally
>> lived in the .nvme keyring or is shared across multiple controllers?
> 
> Hi Hannes,
> 
> I can confirm this one with a test. nvme-keysd adds the dhchap keys to
> the .nvme keyring. After the first disconnect, or a failed connect,
> the keys are gone from the keyring, and the next connect fails.
> 
> I think the kernel should not add keys to a keyring or remove them.
> A pre-provisioned key is either in the keyring or it is not. If it is
> not, the connect fails, and it is up to the user or the key manager to
> fix that. While a controller uses the key, the reference it holds
> (ctrl->host_key) keeps the key alive. So I do not think
> nvme_keyring_link() and nvme_keyring_unlink() are needed for
> pre-provisioned keys.
> 
> Otherwise the design works for nvme-keysd: each authentication reads
> the key again, so a key the key manager updates in place reaches the
> next authentication.
> 
Yeah, linking keys was a bad idea. I'll remove it from the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

