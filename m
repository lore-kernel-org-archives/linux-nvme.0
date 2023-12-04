Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A3DC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8Kv7odb2FB6VIqUpVUW3L43Gay7U6d2Ko1btVln/QU=; b=xSAU0PwoJyKH0FgQTfp8j9JYBM
	v0Qb2Esh2OHejL6saoqwDe2o5IDGl+uBs4xNR/7AxTYNmld6J/iLHoXs01dSF6X6Hkc2x3unAXaY4
	mhUQxbol2GM2hkbqv8jnNTeuTO8EDVutQEpTo5vj1MUEGkiJKDf7KLGIIj0LxsxrWwf/fpt4Ue2Gl
	1PafI/udPvUMF2hkrcsWNDeitRHk0tkBCFfuBwIs++svcnwnhhqgSFCV8hMV+Gk0WbjJKS2FK+/G8
	Iz2+BvN3i6ypj34GukmLtFp08NSTKkMVivq7cVIPgSL6eNRVxny/Pa/gOvaKCwu6KPfgwli6IWH3t
	oobgP2QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA9jO-004jst-1p;
	Mon, 04 Dec 2023 14:15:30 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA9jK-004jsD-1g
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 14:15:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D29E1220CF;
	Mon,  4 Dec 2023 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701699323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8Kv7odb2FB6VIqUpVUW3L43Gay7U6d2Ko1btVln/QU=;
	b=vN55FMOFFJKSJuXHcDK+rhDe57/P3ZXlAbCy1S0S0CKDTuCNgJyrTYwSG3E9gjc+bunvET
	/ZfXzRl3jMTClo4F3H7s9F9OatNQDQCahHOLqMelmgt9y24GnU8LEMXJqLalNDkRJdjiXi
	HHNnddF9mnvMeZhDpza0taVX4PpXBuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701699323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8Kv7odb2FB6VIqUpVUW3L43Gay7U6d2Ko1btVln/QU=;
	b=4lqFAkjnrOKvjMxox8XkGq4stU2Uy9MgIBsruK9xsQ9XgPTsF1FEVvf0U/JJFrKUGTvKwS
	JPkS5oK9L51qt+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A018A139AA;
	Mon,  4 Dec 2023 14:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ddoLJfvebWVUMwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Dec 2023 14:15:23 +0000
Message-ID: <92367bab-4d56-42bb-a82e-66fc984a2894@suse.de>
Date: Mon, 4 Dec 2023 15:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
 <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
 <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
 <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
 <349c1dbe-82c3-f5e8-2158-211772e73771@grimberg.me>
 <b7b72df8-917c-4d4e-8440-47f85c50973d@grimberg.me>
 <765a21bd-e876-4e0f-a5ff-dd25fa7265fa@suse.de>
 <c0721f45-0615-4d06-9be2-b0edb2713dc7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c0721f45-0615-4d06-9be2-b0edb2713dc7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.941];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_061526_771450_3792552B 
X-CRM114-Status: GOOD (  48.79  )
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

On 12/4/23 14:27, Sagi Grimberg wrote:
> 
> 
> On 12/4/23 13:37, Hannes Reinecke wrote:
>> On 12/4/23 11:30, Sagi Grimberg wrote:
>>>
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> there have been some very insistent reports of data corruption
>>>>>>>>> with certain target implementations due to command retries.
>>>>>>>>
>>>>>>>> None of which were reported on this list...
>>>>>>>>
>>>>>>> Correct. I can ask them to post their finding here if that would 
>>>>>>> make a difference.
>>>>>>>
>>>>>>>>> Problem here is that for TCP we're starting error recovery
>>>>>>>>> immediately after either a command timeout or a (local) link loss.
>>>>>>>>
>>>>>>>> It does so only in one occasion, when the user triggered a
>>>>>>>> reset_controller. a command timeout is greater than the default
>>>>>>>> kato (6 times in fact), was this the case where the issue was
>>>>>>>> observed? If so, the timeout handler should probably just wait
>>>>>>>> the kato remaining time.
>>>>>>>>
>>>>>>> Nothing to do with reset_controller.
>>>>>>> The problem really is in nvme_tcp_state_change(), which will 
>>>>>>> blindly start error recovery (and a subsequent command retry) 
>>>>>>> whenever the local link drops.
>>>>>>
>>>>>> That is incorrect. A link drop does not trigger a socket state 
>>>>>> change.
>>>>>> a state change is triggered for specific socket states
>>>>>> (see net/ipv4/tcp.c for description of socket states).
>>>>>>
>>>>>> These are a set of states that describes local and remote sides
>>>>>> shutting down (or a TIME_WAIT). The cases where the host
>>>>>> triggers error recovery without the controller acknowledging it
>>>>>> (in case the link is down) are FIN_WAIT1/2, and these happen
>>>>>> when the user triggers a controller reset/disconnect.
>>>>>>
>>>>>> In the other circumstances, we'll see a TCP_CLOSE/CLOSE_WAIT/CLOSING
>>>>>> which should indicate the controller acknowledged the shutdown.
>>>>>>
>>>>>
>>>>> Ah, now. It's really neither.
>>>>> Complaint from the customer was that we are retrying commands 
>>>>> without waiting for KATO. Actual claim was that we're retrying 
>>>>> more-or-less immediately.
>>>>>
>>>>> So, the problem here is not the first command running into a timeout;
>>>>> the problem really is with the _subsequent_ commands running into a 
>>>>> timeout (cf my comments to patch 1/3).
>>>>> The first command will set the status to RESETTING and start error 
>>>>> recovery, all fine. But all _other_ commands will be aborted directly,
>>>>> causing them to be retried immediately without any delay.
>>>>
>>>> This is still unclear to me.
>>>> The default io timeout is 30s, which is 6 times larger than the
>>>> default kato. So effectively we are hitting a case where we waited
>>>> 6 kato periods, and with your patch we are waiting 7 kato periods?
>>>>
>>>> There is a disconnect for me here.
>>>>
>>>> Can you please clarify:
>>>> 1. what is your kato?
>>>> 2. what is your io timeout?
>>>> 3. was the controller RESETTING state triggered from kato? or
>>>>     from io timeout?
>>>>     if the latter, it indicates that kato is higher than io timeout,
>>>>     otherwise the transport is perfectly fine, and this is essentially
>>>>     a controller io that is taking longer than the host io timeout?
>>>>
>>>> Do you have some trace that points out how a command is sent down to
>>>> the controller (successfully arrives to the controller) the network 
>>>> goes
>>>> down, and the io is retried before kato expires?
>>>>
>>>> What is unclear to me here, is how kato expires, but the controller
>>>> continues to process commands.
>>>>
>>
>> Argument here is that there is a race window between command timeout
>> triggering (ie the call to nvme_tcp_timeout()) and scheduling of the
>> 'err_work' workqueue function. If you have a burst of commands all
>> expiring at roughly the same time the first command will set the 
>> controller state to 'RESETTING', and schedule the 'err_work' workqueue
>> function.
> 
> Yes, that is correct. It is also the keep-alive itself that can
> trigger the timeout handler. In fact, it is the more likely one
> because it will by default have a lower timeout than IO commands.
> 
> This is a part of where I lose the trail here, because I'd expect
> the keep-alive to expire far before any of the IO commands, especially
> with the latest changes to expedite the keep-alive execution pace.
> 
That's not necessarily the case. We don't have any checks to align 
command timeouts to KATO, and we don't mandate anywhere that command
timeouts need to be larger than KATO.
And even then we can get pathological cases where commands take up
to the timeout for processing, and the last keep-alive was just sent
before that.
So I'd rather prefer to fix the race condition.

>> The second command will timing out _before_ err_work is scheduled,
>> will see the RESETTING state in nvme_tcp_timeout(), and directly
>> complete and retry (via nvme_tcp_complete_timed_out()) without
>> waiting for KATO.
> 
> That is something we probably can address by analyzing the controller
> state a bit deeper. We've always failed IO commands quickly in the
> timeout handler because these commands can be part of the ctrl setup
> sequence, which means the error recovery will not run and fail the 
> commands on their behalf reliably. I also think there were issues with
> issues in the teardown stage (shutdown or disable).
> 
Sure. That's what I tried to address with the first patch.

>> That is the issue the customer had been seing, and that is what is
>> causing data corruption on their end.
>>
>> This patchset is an attempt to fix this issue.
> 
> In your patch 3, you take nvme_keep_alive_work_period(), which is
> either kato/2 or kato/4. It is not clear to me why these values
> were chosen other than "the issue went away".
> 
Yeah, that is wrong. The idea is to ensure that command timeout _always_ 
start error recovery at least after the KATO period expired, but that an 
actual KATO timeout would schedule the error handling directly (ie 
flushing the scheduled error recovery workqueue item).
That way the KATO timeout is the upper limit, but will be started 
earlier depending on the timing between command and keep-alive timeout.

> Also, what happens if kato (which is user configurable), is arbitrarily
> long? This means that IO failover can take say 60 minutes? Do you think
> its reasonable? This is where I'm concerned about the unconditional
> delay.
> 
Yes, unfortunately that's true. But that's what's mandated by the spec.
We could add an option to stick to the original behaviour, though, as 
one could argue that this is what users are expecting now.

> I think that the idea was that an appropriate delay would be indicated
> by the controller, rather than being determined by a user controlled
> variable.
> 
Yep. The standard will be updated to cover that, but we're not there yet.

> Regardless we should limit to exactly when such a delay is actually
> needed.
> 
> Plus, I haven't seen anything for nvme-rdma and it is unclear to me
> why this is a host specific to tcp.
> 
That's because the testing had been done on TCP only, and I wanted to
resolve the discussion before posting a full patchset.

>> We'd be happy to pick up this thread, it just had been pushed back
>> internally as we put in a band-aid for that customer in our kernels...
> 
> Well, my assumption is that we want this addressed upstream. Just a
> matter of how.

Agreed.

Cheers,

Hannes


