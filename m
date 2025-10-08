Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7A8CAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Oct 2025 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G30fkVhy2gt4+zO5lsG/AarvvqJdFSCDE0XNQeDoy7Y=; b=Whex4Vxk5ZPZpPk+FhjSAlmj2O
	Ik0Iy7qAwPsC1u1QXoT4FP0sI1y/vl6bMGaMMyuUREIM3YxPEcF3ZJDbtDRWJ7RDQVwlRhKjBe5VS
	RGyF0Kf67Jh0q6H0M0/Q2ncufiWp563tKUOzo2dmm6lqhNyJG+3+88ZxXpNCvl/o4+/BFCwXeLn+r
	mVv9N2fnPiKHpuChyS1rIKUB4wSMUKYeFBBCfZNpxzSyVz3pP1hMWCjITVirrLZEg7/C78x1edN21
	5eYloO79Sl2RXUULErRomQxQGAeoV6mMf8tdnstzAlQwv1xq9e5ZLwHvLXZER2oXTAV8EmPnS2BU+
	0fT4kn5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Nep-00000003IQK-0iMU;
	Wed, 08 Oct 2025 06:28:15 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Nem-00000003IPt-3Cgk
	for linux-nvme@lists.infradead.org;
	Wed, 08 Oct 2025 06:28:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EC712203A;
	Wed,  8 Oct 2025 06:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759904890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G30fkVhy2gt4+zO5lsG/AarvvqJdFSCDE0XNQeDoy7Y=;
	b=p39IZFgJGEXpxI8KHuPkVWfzKOGbDP01J9Yk+pbT1/Knpf7vdUBg0ddKe3J6i5cpP/DWr1
	qVjG088Dyb2wMxBE6w/OIzouPuEuz13sh+JNyJixw8Y22MEMJCJ7QjV6TUSCWMC2hnX/4m
	+vSMY3h8ZtqluRCfbI7Wl9ecnfuy2HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759904890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G30fkVhy2gt4+zO5lsG/AarvvqJdFSCDE0XNQeDoy7Y=;
	b=m+69fe7Wbdvt+M1FfZytQ8kiqqgqxwUNDoQj5bQ5XOwQN6DW8Ue30/4zSwDUO7RsmTsWdF
	Oh5KCLNkf5TdbfDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759904890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G30fkVhy2gt4+zO5lsG/AarvvqJdFSCDE0XNQeDoy7Y=;
	b=p39IZFgJGEXpxI8KHuPkVWfzKOGbDP01J9Yk+pbT1/Knpf7vdUBg0ddKe3J6i5cpP/DWr1
	qVjG088Dyb2wMxBE6w/OIzouPuEuz13sh+JNyJixw8Y22MEMJCJ7QjV6TUSCWMC2hnX/4m
	+vSMY3h8ZtqluRCfbI7Wl9ecnfuy2HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759904890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G30fkVhy2gt4+zO5lsG/AarvvqJdFSCDE0XNQeDoy7Y=;
	b=m+69fe7Wbdvt+M1FfZytQ8kiqqgqxwUNDoQj5bQ5XOwQN6DW8Ue30/4zSwDUO7RsmTsWdF
	Oh5KCLNkf5TdbfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E15C813693;
	Wed,  8 Oct 2025 06:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cschNXkE5mgGRQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 08 Oct 2025 06:28:09 +0000
Message-ID: <c05ac7b9-d71b-4069-ac73-19a082eea559@suse.de>
Date: Wed, 8 Oct 2025 08:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
 <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
 <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
 <143591bfd3499f2ee90034190a94154a965f563d.camel@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <143591bfd3499f2ee90034190a94154a965f563d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_232812_977996_F402911A 
X-CRM114-Status: GOOD (  23.51  )
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

On 10/8/25 04:11, Wilfred Mallawa wrote:
> On Tue, 2025-10-07 at 11:51 +0200, Hannes Reinecke wrote:
>> On 10/7/25 11:24, Wilfred Mallawa wrote:
>>> On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
>>>> On 10/7/25 02:46, Wilfred Mallawa wrote:
>>>>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>>>
>>>>
>>> [...]
>>>> I wonder: Do we really need to check for a partially assembled
>>>> record,
>>>> or wouldn't it be easier to call queue->write_space() every time
>>>> here?
>>>> We sure would end up with executing the callback more often, but
>>>> if
>>>> no
>>>> data is present it shouldn't do any harm.
>>>>
>>>> IE just use
>>>>
>>>> if (nvme_tcp_queue_tls(queue)
>>>>        queue->write_space(sk);
>>>
>>> Hey Hannes,
>>>
>>> This was my initial approach, but I figured using
>>> tls_is_partially_sent_record() might be slightly more efficient.
>>> But if
>>> we think that's negligible, happy to go with this approach
>>> (omitting
>>> the partial record check).
>>>
>> Please do.
>> Performance testing on NVMe-TCP is notoriously tricky, so for now we
>> really should not assume anything here.
>> And it's making the patch _vastly_ simpler, _and_ we don't have to
>> involve the networking folks here.
> 
> Okay, will send a V2 with this approach.
> 
>> We have a similar patch for the data_ready() function in nvmet_tcp(),
>> and that seemed to work, too.
>> Nit: we don't unset the 'NOSPACE' flag there. Can you check if that's
>> really required?
>> And, if it is, fixup nvmet_tcp() to unset it?
>> Or, if not, modify your patch to not clear it?
> 
> I don't see why we would need to clear the NOSPACE flag in
> data_ready()? My understanding is that this flag is used when the send
> buffer is full.
> 
> I would think the clear_bit() is necessary in write_space() since it
> would typically get done in something like sk_stream_write_space()?
> However, running some quick FIOs with the clear_bit() removed, things
> seem to work. Not sure if removing it has any further implications
> though...
> 
I am not sure, either. Code analysis suggests that we don't need to
do that, but then we're the first ever to explore that area.
So I would think we don't need to worry (as nvmet-tcp doesn't do that,
either). Sounds like a question for LPC.
So let's drop the 'NOSPACE' flag handling to get the
partial records fixed, and address the NOSPACE issue separately.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

