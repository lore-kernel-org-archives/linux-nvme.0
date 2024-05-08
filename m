Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24769C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naJhzpe01uRHScrdJo7dairx5aI1J+hPZriUaviU224=; b=G1DWzwlR8/dqVwT+3U0qJ4gVq9
	fTpSsw19sHT4hppSMYql3q7UHTk6EdghtNRj0Dg2fNySujOTEcCHmxs+20zziNj0izF0X0VRk0xRW
	UsrCVfEEmba3luVkBrQ0nQgj65iEaG3Ovxcvz4bu0PatE/3z2MSDxdV1KFu8H8eqWbG0KOd2XxHq9
	emPJx93V/nfK8EN0q7QFktsNG15+dDwTC0S0QS29s0iSLTrofdMhc5Pv4l9I5w6wTkg9kx1QHLTs0
	tF1dQ3jdCFFbthW9t2hCk76jDyUaG4LkVt7KIFE/s71x86tHz5cj+DYkWdqZNtJbW2AA+aMtUSyJk
	bqLetzlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4dV0-0000000ElJk-3NUX;
	Wed, 08 May 2024 09:22:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4dUu-0000000ElIB-1cSY
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 09:22:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6433434E9E;
	Wed,  8 May 2024 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715160109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naJhzpe01uRHScrdJo7dairx5aI1J+hPZriUaviU224=;
	b=cu6pnL0Gwwf1zpBuSqn6CujxCQcoBth44rAV7K0Sgo44DyAJDQPiNNq2FDBF+7yOAet6TU
	q957NQoGljlXORq/qNa4D0WnJWgrKXKWfQvS1fpMGCeWaD9dNkvxQ3YcLgIDe6rYi8Oy1d
	h9pRjl8fyokuWZMRIEun4NXknD274Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715160109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naJhzpe01uRHScrdJo7dairx5aI1J+hPZriUaviU224=;
	b=gmDBve6WZkHOpjMDYAymmi6nOE5lOfWsKkgfZpqAB32YZvIOG8KlzMaf4iqrbRPdGx5nt9
	PcsdLWsMhWuvprAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cu6pnL0G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gmDBve6W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715160109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naJhzpe01uRHScrdJo7dairx5aI1J+hPZriUaviU224=;
	b=cu6pnL0Gwwf1zpBuSqn6CujxCQcoBth44rAV7K0Sgo44DyAJDQPiNNq2FDBF+7yOAet6TU
	q957NQoGljlXORq/qNa4D0WnJWgrKXKWfQvS1fpMGCeWaD9dNkvxQ3YcLgIDe6rYi8Oy1d
	h9pRjl8fyokuWZMRIEun4NXknD274Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715160109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naJhzpe01uRHScrdJo7dairx5aI1J+hPZriUaviU224=;
	b=gmDBve6WZkHOpjMDYAymmi6nOE5lOfWsKkgfZpqAB32YZvIOG8KlzMaf4iqrbRPdGx5nt9
	PcsdLWsMhWuvprAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F38B13A27;
	Wed,  8 May 2024 09:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wk9rES1EO2a0GgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 08 May 2024 09:21:49 +0000
Message-ID: <33365716-a6db-4722-9c9e-18285c9c2be6@suse.de>
Date: Wed, 8 May 2024 11:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] nvme-fabrics: reset connection for secure
 concatenation
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-13-hare@kernel.org>
 <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
 <a1395ee5-fbff-47ef-9400-56b8f3a0d1f5@suse.de>
 <ad9eb876-061b-4f85-9c6f-add1719b72c8@grimberg.me>
 <c4e7d9bc-aebe-4efc-bcde-11a481f76a6f@suse.de>
 <cdc98a0e-d196-42d4-9184-864bcf2a084c@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cdc98a0e-d196-42d4-9184-864bcf2a084c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6433434E9E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_022200_619504_DC92CB3A 
X-CRM114-Status: GOOD (  31.08  )
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

On 4/21/24 13:20, Sagi Grimberg wrote:
> 
> 
> On 09/04/2024 1:08, Hannes Reinecke wrote:
>> On 4/8/24 23:21, Sagi Grimberg wrote:
>>>
>>>
>>> On 08/04/2024 9:21, Hannes Reinecke wrote:
>>>> On 4/7/24 23:46, Sagi Grimberg wrote:
>>>>>
>>>>>
>>>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>>>> When secure concatenation is requested the connection needs to be
>>>>>> reset to enable TLS encryption on the new cnnection.
>>>>>> That implies that the original connection used for the DH-CHAP
>>>>>> negotiation really shouldn't be used, and we should reset as soon
>>>>>> as the DH-CHAP negotiation has succeeded on the admin queue.
>>>>>> The current implementation does not allow to easily skip
>>>>>> connection attempts on the I/O queues, so we connect I/O
>>>>>> queues, but disable namespace scanning on these queues.
>>>>>> With that no I/O can be issued on these queues, so we
>>>>>> can tear them down quickly without having to wait for
>>>>>> quiescing etc.
>>>>>
>>>>> We shouldn't have to connect io queues here. The scan prevention
>>>>> is just a hack...
>>>>>
>>>> Oh, believe me, I tried. What _should_ be possible is to create a
>>>> controller with just admin queues, and skip the io queue setup part.
>>>> But once you do that it's impossible to create io queues after reset
>>>> (which is what you'd need here).
>>>> I tried to fix this, but that ended up with a massive 
>>>> rewrite/reordering
>>>> of the init path. Which sure has its merits, but I deemed out of scope
>>>> for this patchset.
>>>>
>>>> So I decided for this 'hack', and shelved the init path reorg for a
>>>> later patchset.
>>>
>>> Interesting that it requires a full rewrite. Can you share some info
>>> what particularly breaks when you change the nr_io_queues between
>>> resets? nr_io_queues can be changed across resets from the controller 
>>> side
>>> as well.
>>>
>> Just look at the 'new' parameter to nvme_tcp_configure_io_queues(),
>> and try to modify the code to _not_ required the parameter.
> 
> What happens if you set ctrl->queue_count to 0 and then restore it?
> 
That way lays madness.

The tagset is allocated only _once_ when nvme_tcp_configure_io_queues()
is called with new == true (ie during the initial connect call).
So we cannot just skip the call and delegate it to reset as then the 
tagset will never be allocated.

And we have to call 'nvme_tcp_alloc_io_queues()' before the tagset is
allocated, as nvme_alloc_io_tag_set() recurses into 
nvme_tcp_init_request(), which requires the queues to be allocated.

So the only 'simple' choice is to not call nvme_tcp_start_io_queues(),
but then all queues are already connected and we're having to tear them
down _anyway_.

Essentially we will just skip sending the 'connect' command for the I/O
queues, everything else will have to stay the same.
Which we can, but then we're not saving that much here.

>> Key observation here is that the _size_ of the I/O tagset is actually
>> defined by the parameters for the connect command; we cannot grow
>> beyond that. Which means that we should be allocate the I/O tagset
>> right at the start, and only modify the number of queue which we _use_
>> based on the information we get back from the controller.
> 
> What does the tagset has to do with connecting the queues?
> 
See above. allocating the tagset recurses into init_request, which 
requires the queues to be allocated.

>> Currently the io tagset allocation is tied to the number of queues
>> for the controller, and trying to modify that is an even worse hack
>> than suppressing the namespace scan.
> 
> I don't think it is... All I'm saying is that if we are connecting 64 io 
> queues
> to just right after reconnect them with tls, we are doing something wrong.
> 

No argument here.

>>
>> Anyway,it's quite a different patchset which is basically unrelated
>> to the secure concatenation work.
> 
> Well, they are required by the secure concatenation, but agree that
> they are preparatory.
> 
>>
>> I do have a preliminary patchset for this if there's interest.
> 
> Again, the fact that we connect io queues, disconnect them and then
> connect them again is backwards I think.
> 
Indeed.
But I'll guess we'll have a discussion at LSF about initial connect 
logic anyway.

Cheers,

Hannes


