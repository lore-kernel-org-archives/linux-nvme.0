Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21121C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q2XpkOlsLeOznDgA6tG0dwxiHhVAFIknvk5XyGGv0eE=; b=0scqt2SQR73tMm6/sALDyN/rVI
	69n2hY303bCZQzGAIO2n6YYGK+J5LjH0UUxt5LzwajGPOcizmahjLG+sYUXZr59Um7vuKeBEyVRD0
	3bcYz2x6PGTwEWgO+LFW3QVIwN8gp9U3EFyb7rQcg426YNR4eqcKimbTiB7OvTr0eC2CZWkoS2mx3
	WPxgL/jkC1b0iPD/PEHUoijdgfJoMrL4LDNtHl8FmldywDHF+LscXhvTA6VhXBYiFJ1CJObCpdB4y
	Jqx4P6zzMoGU+DXjDDPMFrnyNTsq7XXSF3R7mhhOznRh9PmKJL2xcOfCyvfkWAPHTqwUF5IiiS+Ri
	57Tsw3Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4xeK-00000008iSV-1j0N;
	Wed, 16 Apr 2025 07:57:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4xd2-00000008iCs-0p74
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 07:56:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23FBF1F785;
	Wed, 16 Apr 2025 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744790173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2XpkOlsLeOznDgA6tG0dwxiHhVAFIknvk5XyGGv0eE=;
	b=r1mzpihaPZbkgImIp+OR7Dfx7FpKU92T3cn8wy0xglOinipuwN+AupwGM9YFWRrrH2YwSO
	gr9Y24lVsS1PNoTze3abDEteJCgyx0oPDjGimcTgn5hUr8XMH6jMCrnbemtne7VKOv6JyA
	F68fxx+9y6R2lnMbu0jtdSfpfpX8AKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744790173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2XpkOlsLeOznDgA6tG0dwxiHhVAFIknvk5XyGGv0eE=;
	b=Z2vo6fUbp6UcifHBRrJ9zvIBzMCC9yEtXfN2tPgW6yHyQCykqkzCtMkSuMBefIggXHkoQD
	Nm9DsUIYx2tPVYCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r1mzpiha;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z2vo6fUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744790173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2XpkOlsLeOznDgA6tG0dwxiHhVAFIknvk5XyGGv0eE=;
	b=r1mzpihaPZbkgImIp+OR7Dfx7FpKU92T3cn8wy0xglOinipuwN+AupwGM9YFWRrrH2YwSO
	gr9Y24lVsS1PNoTze3abDEteJCgyx0oPDjGimcTgn5hUr8XMH6jMCrnbemtne7VKOv6JyA
	F68fxx+9y6R2lnMbu0jtdSfpfpX8AKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744790173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2XpkOlsLeOznDgA6tG0dwxiHhVAFIknvk5XyGGv0eE=;
	b=Z2vo6fUbp6UcifHBRrJ9zvIBzMCC9yEtXfN2tPgW6yHyQCykqkzCtMkSuMBefIggXHkoQD
	Nm9DsUIYx2tPVYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21B0139A1;
	Wed, 16 Apr 2025 07:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dDCUNZxi/2dGVQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 16 Apr 2025 07:56:12 +0000
Message-ID: <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
Date: Wed, 16 Apr 2025 09:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23FBF1F785
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_005616_532978_65CAC4FB 
X-CRM114-Status: GOOD (  31.62  )
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

On 4/15/25 23:35, Sagi Grimberg wrote:
> 
> 
> On 15/04/2025 10:07, Hannes Reinecke wrote:
>> On 4/3/25 08:55, Hannes Reinecke wrote:
>>> When the socket is busy processing nvme_tcp_try_recv() might
>>> return -EAGAIN, but this doesn't automatically imply that
>>> the sending side is blocked, too.
>>> So check if there are pending requests once nvme_tcp_try_recv()
>>> returns -EAGAIN and continue with the sending loop to avoid
>>> I/O stalls.
>>>
>>> Acked-by: Chris Leech <cleech@redhat.com>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/tcp.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 1a319cb86453..87f1d7a4ea06 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>           result = nvme_tcp_try_recv(queue);
>>>           if (result > 0)
>>>               pending = true;
>>> -        else if (unlikely(result < 0))
>>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>>               return;
>>>   +        if (nvme_tcp_queue_has_pending(queue))
>>> +            pending = true;
>>> +
>>>           if (!pending || !queue->rd_enabled)
>>>               return;
>>
>> The various 'try_send' function will return -EAGAIN for a partial send.
>> But it doesn't indicate a blocked Tx, rather we should retry directly.
>> Hence this check.
>>
>> Unless you tell me differently and even a partial send will cause
>> ->write_space() to be invoked, then we wouldn't _need_ it.
> 
> Umm, that is my understanding. If you tried to send X and were able to
> send Y where Y < X, you shouldn't have to keep trying in a busy loop, 
> the stack should tell you when you can send again.
> 
Okay, I could try that.

>> It would
>> still be an optimisation as we're saving the round-trip via socket
>> callbacks.
> 
> But you are doing a busy loop on a socket that cannot accept new data, 
> there are other sockets that the kthread can be working on.
> 
But we might be _sending_ data, right?

>>
>> We could aim for a different error here, to differentiate between a
>> 'real' EAGAIN and a partial send.
>> Whatever you prefer.
> 
> I still don't understand why a partial send warrants a busy loop call to 
> sock_sendmsg...
> 
This is, it's not just sendmsg. It's the combination of send and recv.
In my tests I have seen sendmsg return with a partial/incomplete status,
consequently recvmsg has nothing to receive, and io_work stops.
And that is what the patch fixes.

I haven't checked the ->write_space() callback (which should've been 
triggered), but my feeling is that the ->write_space() callback
hit when we were still busy processing, so the queue_work() went
nowhere.

Maybe we can fix it with setting a flag when ->write_space()
triggers ('hey, more data to process'), to be evaluated during
the io_work() loop. But that would be pretty close to the
check 'nvme_tcp_queue_has_pending', so I'm not sure if we
gain anything.

And I really haven't seen any detrimental performance effects
with this patch; in the contrary, performance was on par,
and if anything standard deviation went down.

> My assumption is that the call right after the partial send, will see 
> EAGAIN error. But I may
> be missing something here... I just never expected that a partial write 
> means that we must busy loop sending to the socket.
> 
Well ... we do it in nvme_tcp_try_send_data().

> What does a blocking sendmsg do under the hood? does it also follow this 
> practice?

How would I know. But I haven't seen any negative effects
during performance testing with this patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

