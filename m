Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A4C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4E186nOsJXAjevZ2sK39V7ojOlrnI3phfzWa9BwfSM=; b=XsnvpDAXfhqRf61SC620tpIb0p
	dVShYuVRyCXsTZBhve9QNLuq1PCs+/tOYtZ37N4nsnEvuKjCiP0akUJJ9oF7LHsmmZ7nbrxWKN2We
	MxdLXDCgEoV/lX9k+8m4QDJxhHhq0u5YEZHo2Q3ZR4pyYlyzitra8Okv97YKuJoNJRqUwVCMtY2Sx
	J9WaxqhSXrjr5Pyr1BeuZRwLywAktAduPoPf4fMlg++i/QTwQdGDs7ZGppuvvBrdt75KNIpCuWEuW
	FcN6Rm+9/06bc/BXVHLNwMMoOFnN4P5VK8Gy3nEFizBaN7BV7LEeHGAayHtP1jC2d8fKhoN1erd9y
	wWfmDjFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA86q-0042N3-0I;
	Mon, 04 Dec 2023 12:31:36 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA86m-0042Jz-33
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 12:31:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9CBA1FE6A;
	Mon,  4 Dec 2023 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701693090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4E186nOsJXAjevZ2sK39V7ojOlrnI3phfzWa9BwfSM=;
	b=oGT0ATqTjcIK7k8g8nSQeTI6LK+7VLcIu6Rsp5OTVZrPT9uO8FiFG92N773bQthFxgIRKZ
	jFkgIM53kgl4x/lVKaOwAU79+2IlTYHCcukLXTvxqPAEygOYGFPqRHkD/a4sC251OpPvjI
	ux6XVej1x/lhH9ZckvboyAaT8eDJWE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701693090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4E186nOsJXAjevZ2sK39V7ojOlrnI3phfzWa9BwfSM=;
	b=uHhos1a3BqheH/8qmFOInZf4v6486Y93k95E71HHyD1XT7OyeYFeg7IBJ+uekiYBI0zlIV
	bRJdnXZ6uZm6e2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B48F21398A;
	Mon,  4 Dec 2023 12:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MmbiKqLGbWVdCQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Dec 2023 12:31:30 +0000
Message-ID: <e3fa3584-47e3-4712-a2ce-7fc59e603898@suse.de>
Date: Mon, 4 Dec 2023 13:31:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
 <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
 <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
 <52bd0ef3-b91e-492e-8117-41a290b6cfe6@grimberg.me>
 <c261fe62-e8e6-4470-b9e2-3047fd4c3d99@suse.de>
 <9ca33803-e2ca-4550-8d6e-1e64219fb3d9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9ca33803-e2ca-4550-8d6e-1e64219fb3d9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_043133_137932_F04EDB29 
X-CRM114-Status: GOOD (  23.96  )
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

On 12/4/23 12:57, Sagi Grimberg wrote:
> 
> 
> On 12/4/23 13:49, Hannes Reinecke wrote:
>> On 12/4/23 11:19, Sagi Grimberg wrote:
>>>
>>>
>>> On 11/20/23 15:48, Sagi Grimberg wrote:
>>>>
>>>>>> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing
>>>>>> controller teardown") this is just for reducing the memory footprint.
>>>>>> Wonder if we need to bother, and whether it won't be better to remove
>>>>>> the whole thing entirely.
>>>>>
>>>>> Well, Sagi added it, so I'll let him chime in on the usefulness.
>>>>
>>>> While I don't like having nvmet arbitrarily replying busy and instead
>>>> have lockdep simply just accept that its not a deadlock here, but we 
>>>> can
>>>> simply just sidetrack it as proposed I guess.
>>>>
>>>> But Hannes, this is on the other extreme.. Now every connect that nvmet
>>>> gets, if there is even a single queue that is disconnecting (global
>>>> scope), then the host is denied. Lets give it a sane backlog.
>>>> We use rdma_listen backlog of 128, so maybe stick with this magic
>>>> number... This way we are busy only if more than 128 queues are tearing
>>>> down to prevent the memory footprint from exploding, and hopefully 
>>>> it is
>>>> rare enough that the normal host does not see an arbitrary busy
>>>> rejection.
>>>>
>>>> Same comment for nvmet-tcp.
>>>
>>> Hey Hannes, anything happened with this one?
>>>
>>> Overall I think that the approach is fine, but I do think
>>> that we need a backlog for it.
>>
>> Hmm. The main issue here is the call to 'flush_workqueue()', which 
>> triggers the circular lock warning. So a ratelimit would only help
>> us so much; the real issue is to get rid of the flush_workqueue()
>> thingie.
>>
>> What I can to is to add this:
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 4cc27856aa8f..72bcc54701a0 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -2119,8 +2119,20 @@ static u16 nvmet_tcp_install_queue(struct 
>> nvmet_sq *sq)
>>                  container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>>
>>          if (sq->qid == 0) {
>> +               struct nvmet_tcp_queue *q;
>> +               int pending = 0;
>> +
>>                  /* Let inflight controller teardown complete */
>> -               flush_workqueue(nvmet_wq);
>> +               mutex_lock(&nvmet_tcp_queue_mutex);
>> +               list_for_each_entry(q, &nvmet_tcp_queue_list, 
>> queue_list) {
>> +                       if (q->nvme_sq.ctrl == sq->ctrl &&
>> +                           q->state == NVMET_TCP_Q_DISCONNECTING)
>> +                               pending++;
>> +               }
>> +               mutex_unlock(&nvmet_tcp_queue_mutex);
>> +               /* Retry for pending controller teardown */
>> +               if (pending)
>> +                       return NVME_SC_CONNECT_CTRL_BUSY;
>>          }
>>
>> which then would only affect the controller we're connecting to.
>> Hmm?
> 
> Still I think we should give a reasonable backlog, no reason to limit
> this as we may hit this more often than we'd like and the sole purpose
> here is to avoid memory overrun.

So would 'if (pending > tcp_backlog)' (with eg tcp_backlog = 20) fit the 
bill here?

Cheers,

Hannes


