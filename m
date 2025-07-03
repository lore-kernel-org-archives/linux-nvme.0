Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E9C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eG55YO1q3oy3zBWn+wNNbAJSRwu9AnA7m0WPoR4rSPg=; b=ScCQVczUvtn4npDY1GrsNQZZdx
	TYB0m20HHF/xKCFhgQ+b8MM0McXfeooVWk6aX+lgnq69OGLK8OReNHuad6exODGO67lFiG//1E871
	3N0DoXLup1Q69rIsEjCKYzA7BFJ0+HEaBi8mraqlz7vfAqwtwSxadQW/mEGN8C6UPPnXJRM1Q60md
	xj9LR94miRQsyLa7fq/33lDhR7W02DuN7VrZey98SWXsz6wAlx01uavTRZshchlP7g0/p87bSU0bc
	Bx0yIrgZ7jbqsxEXcDTQMtyKh2tLu62d9MkGMGpBSa9oDiiJ6UzrVFqNSOAgZiNljZ1b+/N2nWgo3
	fobjdcwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGVU-0000000AsBs-160g;
	Thu, 03 Jul 2025 09:45:28 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGSY-0000000Arag-1JjY
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:42:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B84522116E;
	Thu,  3 Jul 2025 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751535744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eG55YO1q3oy3zBWn+wNNbAJSRwu9AnA7m0WPoR4rSPg=;
	b=DO2cx/ECbMP/J9tFwYBo5iekvV6LWLlq7GaWsKLpsE/iDPLSCWsqreC00eao0+MOD0aXkK
	OGSjQ/q9fib8tjXi8J9lHGYWT95pUa7U4q9vWG7LuDZpkxnb227dWXzhTXArXj60YNvWMw
	pSapXcAyHdv/wSv3L6sqAkYwNul0D0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751535744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eG55YO1q3oy3zBWn+wNNbAJSRwu9AnA7m0WPoR4rSPg=;
	b=9fCsnIkVs4PG8E/5UTv0R9jHcay3BeWHIikp5iLtZt3+ykjAD6vtFkV+q9vJOMHsN+nAh7
	H6iV6qgKCG6Qg1DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DO2cx/EC";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9fCsnIkV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751535744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eG55YO1q3oy3zBWn+wNNbAJSRwu9AnA7m0WPoR4rSPg=;
	b=DO2cx/ECbMP/J9tFwYBo5iekvV6LWLlq7GaWsKLpsE/iDPLSCWsqreC00eao0+MOD0aXkK
	OGSjQ/q9fib8tjXi8J9lHGYWT95pUa7U4q9vWG7LuDZpkxnb227dWXzhTXArXj60YNvWMw
	pSapXcAyHdv/wSv3L6sqAkYwNul0D0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751535744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eG55YO1q3oy3zBWn+wNNbAJSRwu9AnA7m0WPoR4rSPg=;
	b=9fCsnIkVs4PG8E/5UTv0R9jHcay3BeWHIikp5iLtZt3+ykjAD6vtFkV+q9vJOMHsN+nAh7
	H6iV6qgKCG6Qg1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BD7713721;
	Thu,  3 Jul 2025 09:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OEGAJYBQZmjxBQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Jul 2025 09:42:24 +0000
Message-ID: <53116592-1949-4fdf-8935-e324b8779900@suse.de>
Date: Thu, 3 Jul 2025 11:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: prevent ioq creation for discovery
 controllers
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-4-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250702005830.889217-4-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B84522116E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_024226_498432_1AC3B2B3 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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

On 7/2/25 02:58, Kamaljit Singh wrote:
> Prevent ioq creation for discovery-controllers as the spec prohibits
> them, similarly to the administrative controllers.
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.
> 
While this might be true, we already deal with discovery controllers
just fine, and never had issues with I/O queues being created.
Presumably because discovery controllers never exposed I/O queues
in the first place.

Which also means that admin controllers should work already if they
would not expose I/O queues.

We _might_ reduce the number of queues to '1' in nvme_set_queue_count(),
but then we should issue a warning here as this would be a configuration
error on the target side.

'Prohibited' cuts both ways; the host shouldn't ask for it and the
controller shouldn't advertise it...

Or that's at least my reading. Might be worthwhile clarifying this
at FMDS.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

