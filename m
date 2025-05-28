Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABA7C3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdcO4rIHrJAmEweTjAfdnU30JgA0ieALa7tTJP2IfBo=; b=S8MATygoKxugMRLxdyYQ0/a7w2
	78ptNUABESrNvZBH91M5fR9sBJ/29LlWzvuUIF4QJExXqblmmaXPag6gYcP58bR9hf3ym2IPnpSaf
	v6XkxNBRvJb3PzCHjEbiIoEvf6qffF6cpqxea55FgK81xLSWfI8jsngx7kB5x78ByNMhnrK1pEJI7
	9qhVxR37GHQS+uYaDdfGRYEcBx/bTEdp5Q0P+Y6Rc2VaZHKPkFyTzlF74x+7l3Biw2ll0lwPFwNxh
	p6/wxiGMi1unH3UrxAiGHC7cZrY1VeHDovxxgr1Vi41SR5qOBj6aS0brABOaMzqMGzyx3YwXaSOjy
	4X7NfuJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKALh-0000000CIkq-1R49;
	Wed, 28 May 2025 06:33:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKALX-0000000CIj5-3fKH
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 06:33:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC48D21A2E;
	Wed, 28 May 2025 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748413981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdcO4rIHrJAmEweTjAfdnU30JgA0ieALa7tTJP2IfBo=;
	b=jjOBTpXzw9UTuvobFrrHFlnjZKiSNTuErVTU8CEdT4LyoSotsKTweiW1J0cj9j/qcUvTPG
	G9DbJK6P812SOW9yHUhL9cRBLLgRaO+WUkxlfMZDTlx1SSKaK0piKW2KORrz/3j6/FLGaq
	Bh22rIaAEhZxkMaR+Y2Ov7D16TWgI58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748413981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdcO4rIHrJAmEweTjAfdnU30JgA0ieALa7tTJP2IfBo=;
	b=DZ1HnLZKwLkQ1Cbkajoygz2EznTyamZl/C0PYR0sW223JuuWrgF6k6L+otwvhQsQkH+yiw
	Y5Df2E1xhKLdiHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748413980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdcO4rIHrJAmEweTjAfdnU30JgA0ieALa7tTJP2IfBo=;
	b=n8PJ9tdMvnfxbiandR7Ke6zVd6U7tOuPc0K3VqpJdxhpPFEVJ0YeSS5EawPrOi48no/HWk
	McudDTeT9B8W5EZuC5kAyG0ab3w2aheknps0UmE6zE+Um0M/eZWfsLcaQ9uPtWfooHUk/I
	sRy9ISaBZ6ibvG/zqcpOJ+ciqZJS4PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748413980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdcO4rIHrJAmEweTjAfdnU30JgA0ieALa7tTJP2IfBo=;
	b=cdLBNrwNExMfZs+AwvwsyBAB+ZUPJRfA19UZTV0utEUtTjtbTHuDEjsw+0bG5qCt3gX8Lu
	W4BX2gGkOBiX6RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB3CD136E0;
	Wed, 28 May 2025 06:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id czicJxyuNmiNNQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 May 2025 06:33:00 +0000
Message-ID: <87aa511e-f65d-4521-98f2-edae0fa31be2@suse.de>
Date: Wed, 28 May 2025 08:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Sagi Grimberg
 <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
 <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
 <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
 <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
 <ede69310-a640-489c-8922-24dd62cf6ea1@grimberg.me>
 <7f7e08be-4930-47e5-80df-91329c827915@grimberg.me>
 <BY5PR04MB6849D665ACF1F64022583047BC67A@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BY5PR04MB6849D665ACF1F64022583047BC67A@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_233304_059877_B73A8B9C 
X-CRM114-Status: GOOD (  16.03  )
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

On 5/28/25 03:43, Kamaljit Singh wrote:
> Hi Sagi,
> 
>> On 27/05/2025 2:49, Sagi Grimberg wrote:
>>>>
>>>> We still need to hunt these down. I'm still puzzled why adding the
>>>> WAKE_SENDER
>>>> flag was able to make this issue disappear? I'll have another look at
>>>> this patch.
>>>>
>>>> For now, I think we can go with this patchset, and then incrementally
>>>> fix the remains.
>>>
>>> Kamaljit, can you check the following patch on top of the patchset
>>> from Hannes that
>>> gets a reproduction?
>>>
>>> --
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 835e29014841..2f5f2fcfb078 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1075,7 +1075,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>>>
>>>          read_lock_bh(&sk->sk_callback_lock);
>>>          queue = sk->sk_user_data;
>>> -       if (likely(queue && sk_stream_is_writeable(sk))) {
>>> +      if (likely(queue)) {
>>>                  clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>>>                  queue_work_on(queue->io_cpu, nvme_tcp_wq,
>>> &queue->io_work);
>>>          }
>>> --
>>>
>>> This think this may be preventing the scheduling of io_work. But now
>>> that io_work is
>>> also ceasing based on sk_stream_is_writeable, we should probably still
>>> schedule it.
>>
>> Kamaljit? Any info on this?
> 
> Sorry for the delayed reply. We've been hitting one issue after another,
> hence the delays. Hoping that by tomorrow I should have clean results with
> a clear a-b comparison of only the changes you suggested.
> 
Just to make you aware, I've found another issue wrt 
sk_stream_is_writeable(); we are checking it from the data_ready
callback, and do not schedule io_work if no write space is available.
Problem here is that the data_ready callback indicates that there
_should_ be space available, so by checking sk_stream_is_writeable()
we already assume that the actual write space might change, and
the callback might not be a reliable indicator.
But from that follows that also the opposite might be true, namely
that write space _might_ be available by the time io_work is scheduled.
I'll repost the series.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

