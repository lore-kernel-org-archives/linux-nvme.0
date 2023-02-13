Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07830C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aiaU33CIzITzosvkOL45G/lQaIrP/jOp5X3x+dmHP20=; b=oyOTj3Rnx+x0Ve+zliW1iIdof1
	q9bY/KCxue4bjUzTn1JOjpQBuNWyBkXeY/kbzVvZwl+uPuFbwWsTs49kv4U2y416Bt0EBcurgQPzZ
	uOw1FFDPnHYSMIzzHnEZk5EwRudquPus95JQrpuQCgh+JlhyVUQuaLpvqEG+ZcAXRcISpqSSF7NUg
	XvsKyNK/tGBzIiqaUeKTRLkSJ7G0pEn0xE/MFMcl02aRNhmppTFV0ovOOEjM8pIvWAXBWmNGvcVlT
	tB9tAqnoriDdrib1P1k6+n6fDcVUvNJHIGhg51HlxWHv5CQCTRY+z333Uke22rIAuKlADPaTx+Efo
	hU5q493A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZUo-00Eunx-Bm; Mon, 13 Feb 2023 14:07:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZUk-00Eumn-Ow
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 14:07:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7CB21F37C;
	Mon, 13 Feb 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676297267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiaU33CIzITzosvkOL45G/lQaIrP/jOp5X3x+dmHP20=;
	b=XHb5uB7hej/I0wRNXaB799217aAVAJvSTs96PfB8tdTlDBfMK9xnrR4MnJnXM9/l0rHzZ0
	X6huVaLYO1RP9XCJ8Gsgee8LQDq2p46hz5muXrzA00iBZltBL7d8WEiPmo8BgB+4pHtNk8
	E2N/VPUhjs1UN+tt+uIDB2xTNt7j2ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676297267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiaU33CIzITzosvkOL45G/lQaIrP/jOp5X3x+dmHP20=;
	b=Uvgavkx/gr70YMuCW+TVWoayPz9HkxbP3ncOm2stDQ1o4Wsrde7Ne79BkfJJTlCY7Ffs1e
	DDHQrsqxuziKWYCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88A71138E6;
	Mon, 13 Feb 2023 14:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SA8dIDNE6mOkdgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 13 Feb 2023 14:07:47 +0000
Message-ID: <52c8330d-2cd1-73fa-e360-0c7b233dec93@suse.de>
Date: Mon, 13 Feb 2023 15:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] nvme: retry authentication commands if DNR status bit
 is not set
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "George, Martin" <Martin.George@netapp.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-6-hare@suse.de>
 <43e6c4b4-cb58-0873-2d0e-48499fcc1e31@grimberg.me>
 <42618eea-5a4a-f0cf-9e6d-e1ae36357847@suse.de>
 <7126416a-0839-4b47-0aad-1ac1a1875681@grimberg.me>
 <504fe9d1-befc-868e-9e5f-8471bec81902@suse.de>
 <3ba9e61a-d73d-508c-734a-dd1c0707588e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3ba9e61a-d73d-508c-734a-dd1c0707588e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_060751_124389_1D9AFF56 
X-CRM114-Status: GOOD (  28.96  )
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

On 2/13/23 14:47, Sagi Grimberg wrote:
> 
>>>>>> Clear the FAILFAST_DRIVER bit for authentication commands
>>>>>> allowing them to be retried in nvme_decide_disposition() if the DNR
>>>>>> bit is not set in the command result.
>>>>>
>>>>> Can you please explain what is this fixing? and is there a test
>>>>> to reproduce this?
>>>>>
>>>>>>
>>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>>> ---
>>>>>>   drivers/nvme/host/auth.c | 2 ++
>>>>>>   1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>>>> index ef5dcd885b0c..935f340607a7 100644
>>>>>> --- a/drivers/nvme/host/auth.c
>>>>>> +++ b/drivers/nvme/host/auth.c
>>>>>> @@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl 
>>>>>> *ctrl, int qid,
>>>>>>               "qid %d auth_submit failed to map, error %d\n",
>>>>>>               qid, ret);
>>>>>>       } else {
>>>>>> +        /* Clear failfast flag to allow for retries */
>>>>>> +        req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
>>>>>
>>>>> This should come right after the allocation.
>>>>> But what makes this special than any other fabrics/admin command?
>>>>> Why is it different than connect for example?
>>>>
>>>> It is not different; it does, however, introduce a difference in 
>>>> behaviour.
>>>> And hence I didn't enable it for all commands, as previously we 
>>>> didn't retry, and it's questionable if we should for things like 
>>>> 'reg_read'/'reg_write' and friends.
>>>>
>>>> But you are correct for connect, though; we really should retry that 
>>>> one, too, if the DNR bit is not set.
>>>
>>> I'm not sure. if the transport is unavailable, we cannot set DNR, which
>>> will lead to a retry of the connect (or equivalent) command. Today the
>>> host will schedule another full controller connect within
>>> reconnect_delay, which is what we want right?
>>
>> I knew this would be coming up, which is why I left it out of the 
>> initial patchset.
>>
>> Long explanation:
>>
>> Thing is, connect handling is not _just_ connect handling.
>> With linux we only have a single (ioctl-like) entry for the userspace 
>> 'nvme connect' call.
>>
>> That really does several things:
>> - Setting up the transport
>> - Create the transport association for the admin q
>> - Create the admin q
>> - send 'connect' over that queue
>> - Create transport associations for the i/o qs
>> - create i/o qs
>> - send 'connect' over those queues
>>
>> And my point here is that the actual 'connect' commands really are 
>> straight NVMe commands. And as such should be subjected to the normal 
>> status evaluation rules for NVMe commands.
>> The problem here is the strange 'half-breed' nature of the connect 
>> command:
>>
>> _Technically_ the association and the 'connect' command are 
>> independent, and as such we would be entirely within spec to allow the 
>> 'connect'
>> command to fail without having the association torn down. But due to
>> our implementation that would leave us unable to re-use the association
>> for further connect commands, as that would need to be triggered by
>> userspace (which will always create a new association).
>>
>> Consequently I would advocate for having any non-retryable failure of 
>> the 'connect' command to always tear down the association, too.
>>
>> That would be a deviation from our normal rules (where we always retry
>> transport failures), but really is something we need to do if we 
>> enable DNR evaluation for the 'connect' command.
> 
> How the host handles connect or any other request failing is entirely
> the host choice.
> 
> In this patch, you decided to effectively to retry for transport errors,
> which will effectively retry nvme_max_retries times. Can you please help
> me understand what is the patch actually solving? I'm assuming that this
> is an actual completion that you see from the controller, my second
> question is what happens with this patch when the transport is the
> source of the completion?
> 
Hmm. All what this patch does is to enable retries by modifying the flow 
in nvme_decide_disposition().
And nvme_decide_disposition() only deals with NVMe errors; if
nvme_req(req)->status would be an error number we'd be in much worse 
problems than just retries.

So where do you see the transport errors being retried?

And I need to retry as some controller implementations temporarily 
return the authentication commands with the 'DNR' bit set, presumeably 
to initialize the authentication subsystem.

Cheers,

Hannes


