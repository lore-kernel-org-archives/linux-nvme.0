Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F7DCA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9VOczD7wnlD/9Rk2SoJ6CG6SjkYaZyS4WLeGeK7Gig=; b=BpHZDrd9YvGY73RsgPCbBAEOoo
	haAVadH2o1CE6+Pe2viXMleKLuEGNS/QFb3Vq4Lb6SkIjsZexN3Cj8Z4Y2lZ/fcmPdbxWVT5RBDNX
	vkePCnUSPzk3HLVc7X1cfzN3TxC0yrmJAEwak5nZbxGPUXh8MibVGDtokwjJNeI6xT1TygtHn+LRn
	vDwFvAk4B9MA3pqBt939drxK+/qGGEPHHQzUBwBpnrbNacTNRjvkIM+AsSlsiM0ds2vk3ojINoY8w
	zcLiNqg7/B/mX7ZSRwgIALOTENRVV5hznTjiJsq1xUwhsAsJpW4jl7Y1eh1iFDopGeTJTw+8yRIB+
	vYvv6RoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg3OW-003Q7f-0x;
	Tue, 12 Sep 2023 13:25:32 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg3OT-003Q6I-1b
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 13:25:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 625751F45A;
	Tue, 12 Sep 2023 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694525123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9VOczD7wnlD/9Rk2SoJ6CG6SjkYaZyS4WLeGeK7Gig=;
	b=nCM/YrbgHMU0yGi5asS3sxmm+S2fgEO49xpafoHQrzCZT3H7bUc9qTMSws8AoM2jQShuEJ
	6eL4TIzn2kCuhifsPPNL+iDAEottn/eIAnW0fwU/XHV5dBl66GJMIuJCayVaHbeScl8ugI
	KxoF+cJYjeNv3w/E+OIEU7CNBMw1ooE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694525123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9VOczD7wnlD/9Rk2SoJ6CG6SjkYaZyS4WLeGeK7Gig=;
	b=f+uOaHgLai3ym3vC78Bdkvku2ED01hkK8a6X8Ptq0CtlHMDMmKQnfb2eqtic86VXkzPhst
	sC1b7gi5shcb2+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 543DD139DB;
	Tue, 12 Sep 2023 13:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 82lTFMNmAGVrNgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 13:25:23 +0000
Message-ID: <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
Date: Tue, 12 Sep 2023 15:25:23 +0200
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_062529_676913_3A77B2B2 
X-CRM114-Status: GOOD (  24.12  )
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

On 9/12/23 14:12, Sagi Grimberg wrote:
> 
>>>> Hi all,
>>>>
>>>> there have been some very insistent reports of data corruption
>>>> with certain target implementations due to command retries.
>>>
>>> None of which were reported on this list...
>>>
>> Correct. I can ask them to post their finding here if that would make 
>> a difference.
>>
>>>> Problem here is that for TCP we're starting error recovery
>>>> immediately after either a command timeout or a (local) link loss.
>>>
>>> It does so only in one occasion, when the user triggered a
>>> reset_controller. a command timeout is greater than the default
>>> kato (6 times in fact), was this the case where the issue was
>>> observed? If so, the timeout handler should probably just wait
>>> the kato remaining time.
>>>
>> Nothing to do with reset_controller.
>> The problem really is in nvme_tcp_state_change(), which will blindly 
>> start error recovery (and a subsequent command retry) whenever the 
>> local link drops.
> 
> That is incorrect. A link drop does not trigger a socket state change.
> a state change is triggered for specific socket states
> (see net/ipv4/tcp.c for description of socket states).
> 
> These are a set of states that describes local and remote sides
> shutting down (or a TIME_WAIT). The cases where the host
> triggers error recovery without the controller acknowledging it
> (in case the link is down) are FIN_WAIT1/2, and these happen
> when the user triggers a controller reset/disconnect.
> 
> In the other circumstances, we'll see a TCP_CLOSE/CLOSE_WAIT/CLOSING
> which should indicate the controller acknowledged the shutdown.
> 

Ah, now. It's really neither.
Complaint from the customer was that we are retrying commands without 
waiting for KATO. Actual claim was that we're retrying more-or-less 
immediately.

So, the problem here is not the first command running into a timeout;
the problem really is with the _subsequent_ commands running into a 
timeout (cf my comments to patch 1/3).
The first command will set the status to RESETTING and start error 
recovery, all fine. But all _other_ commands will be aborted directly,
causing them to be retried immediately without any delay.

>> And that error recover does _not_ wait for KATO, but rather
>> causes an immediate retry.
> 
> We can't blindly wait for KATO. If the controller saw the socket
> closure, there is no point waiting kato.
> 
Agreed. So we should be marking out FIN_WAIT1 as that one requiring us
to wait for KATO.

> If the user sets KATO to be 3 hours, and does a controller reset,
> what happens now?
> 
See above. I'd be fine with delaying error recovery for FIN_WAIT1 only.

> Only when the host triggers the shutdown, and that is not acknowledged
> by the controller, then yes, the host needs to wait the remaining of
> kato.

I'll be modifying the patchset to updating the description for the first
patch and only delaying error recovery for FIN_WAIT1.

Cheers,

Hannes


