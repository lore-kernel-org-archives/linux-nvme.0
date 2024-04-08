Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E174ECD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7c11iYpFVcO2H/pnSETDABieajYPJipu7LH9LvQGzA=; b=reluIfP1zWJRMfOs2mwYwC6rLF
	5jP9XkgfGLq5s71zRwn1kexr5I8QFYtI4R9tABXxeyDl1VUtyDI1Bx5pnyc8q6L6/Nk0rJBmd3zzb
	zdl53bb8XqktcYJVdUuq8L7xTDaplc1xBTxLkx4scy7Gnu4A52EhR+EVBTSLQCWtU0l8fwYiK8Ub0
	VEp1QI5TVRXDaHYuscEHb1GIUsNNgC7WSonRJroay9HYFsG6z8LlALWV1y6Y9AUl8PlI/nwK67DDz
	fgr70govM2WpbYV8ZcXHNpxapAnJnuU5Sh+NYki22M/FMzi/7t9K2AR23DLscZpcoqwJ/3/G7bpt+
	0RumTeGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwc6-0000000GuDk-0qv3;
	Mon, 08 Apr 2024 21:33:14 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwbz-0000000GuAu-1tSt
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 21:33:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7D8E22D52;
	Mon,  8 Apr 2024 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712611984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7c11iYpFVcO2H/pnSETDABieajYPJipu7LH9LvQGzA=;
	b=COYkFQAX6celVkzXDkcNPpi8fdpcJN4v63hT7GT0O65DvuqT7YDpkqZ6Xbv7A4/3YFQzE+
	hd4piBm4hNIyCVaD8+TaYkKQEcrQXPo83JuXA3JQSj9VYrl5aAGK8aQxChrc1CrwVS66q+
	NgCGF2H9QsWb35GDEWJHsWVYDqGS3dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712611984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7c11iYpFVcO2H/pnSETDABieajYPJipu7LH9LvQGzA=;
	b=BuFWNKnNUIyQEmBJOle1Tu7/Ou6lFURQz0B58JhsIBysZRpELosiAdawX16aAxoyI/JmBN
	KzcoAo/vx42uV2CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712611983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7c11iYpFVcO2H/pnSETDABieajYPJipu7LH9LvQGzA=;
	b=APuPilHXt89bAdjKxDxn/mhZnVcJ8emCiwZ508ZHxy4SJ3ovmsYKQm2QKFfi2OvVzgmzN/
	wBvxnCpgqxg/P0MWhfQyDmaTxhAv/vdFvHLkFQFgA2uPSr92n/sGcss6rV8LwAlSBGtTm4
	ZCURh/LA+92/CqyFgW+h9idobgpf0ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712611983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7c11iYpFVcO2H/pnSETDABieajYPJipu7LH9LvQGzA=;
	b=QWhy/2LOnzRuzX7DfEabjdWTlIfVlY9WcMvnD1stAAzHIJB2FM2qizm6oQqYlCcHdQTFDh
	e+mGe3sW13zRGlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7B4813675;
	Mon,  8 Apr 2024 21:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U+llKo9iFGatNAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 21:33:03 +0000
Message-ID: <6606a2f5-1c05-4730-b8ed-727e862148b2@suse.de>
Date: Mon, 8 Apr 2024 23:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] nvme-tcp: sanitize TLS key handling
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-9-hare@kernel.org>
 <e7200e48-7c86-4cd0-9fa8-4a3d62578a12@grimberg.me>
 <8afbaa30-ae8c-4816-9ba1-59597838184b@suse.de>
 <bcc7ed23-5ee4-4ce0-981b-bedce0af7984@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bcc7ed23-5ee4-4ce0-981b-bedce0af7984@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_143308_214601_46992998 
X-CRM114-Status: GOOD (  14.11  )
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

On 4/8/24 23:07, Sagi Grimberg wrote:
> 
> 
> On 08/04/2024 9:48, Hannes Reinecke wrote:
>> On 4/7/24 23:15, Sagi Grimberg wrote:
>>>
>>>
>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> There is a difference between TLS configured (ie the user has
>>>> provisioned/requested a key) and TLS enabled (ie the connection
>>>> is encrypted with TLS). This becomes important for secure 
>>>> concatenation,
>>>> where the initial authentication is run unencrypted (ie with
>>>> TLS configured, but not enabled), and then the queue is reset to
>>>> run over TLS (ie TLS configured _and_ enabled).
>>>
>>> 1. configured/enabled confuse (me at least) in this context.
>>> 2. What does "queue is reset" mean?
> 
> Can you answer this?
> 
Sorry, I meant 'controller reset'.

>>>
>>>> So to differentiate between those two states store the provisioned
>>>> key in opts->tls_key (as we're using the same TLS key for all queues)
>>>> and only the key serial of the key negotiated by the TLS handshake
>>>> in queue->tls_pskid.
>>>
>>> I have some recollection of asking about it, but can you explain why is
>>> a tls_pskid now stored per-queue? What do we lose if tls_pskid moves 
>>> from
>>> nvme_tcp_queue to nvme_tcp_ctrl ?
>>>
>> We need to have a distinction between 'the queue is TLS enabled' (ie TLS
>> handshake should be started on that queue) and 'the queue is tls 
>> encrypted' (ie TLS handshake has completed on that queue).
>> The former indeed can be derived from controller settings, and for the
>> latter we use the 'tls_pskid' setting.
>> Additionally it's the value for the tls_key sysfs attribute.
>> I could have used a per-queue flag, but using the tls_pskid was just
>> too easy here :-)
> 
> I think a flag would be clearer, because a per-queue pskid suggest that 
> it is unique per queue while you concur that it isn't.

Ok. Let's see how this works out.

Cheerc,

Hannes


