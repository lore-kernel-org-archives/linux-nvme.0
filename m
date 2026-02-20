Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD29C531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ayd1LtzLLxiXMWHsSRB+fIEPNOplWZj/LagtzjWS2wk=; b=ivOKfYIBZjkjhK1gli3iLk7mY7
	hYwcFyLBfFmE75j4pnk4jdU/7l1hTgbdeu6IUnN09BDbzFhvOcEtjkwlaJIUYq5dXKvtNxbbq6N+i
	4EP/9lxO7lUCo+AgAu2ls2auWzOim5J4Ujjz9o5Vq5y7zl9uS9tARdL1Hyo17bGU7CySoyqGr2T0M
	LI2kokhen45bWi8HRDAmdYU1oFNbrnObvf+Y9f0OdORiCMykIfRJnSWjhkslbpe7IOsgai6UH4gJi
	U/Fc+UueGT660Hq0xvCCIscSexBurreDB3+kjBYEbMFIdggjjq/pp9pKZbfQ3u8J+Y9IKj5pMK3H+
	+KSRfjZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtKrV-0000000DLXo-0cnx;
	Fri, 20 Feb 2026 07:23:41 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtKrR-0000000DLX0-2XtL
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 07:23:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D70DC3E6E5;
	Fri, 20 Feb 2026 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771572215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayd1LtzLLxiXMWHsSRB+fIEPNOplWZj/LagtzjWS2wk=;
	b=vE8FVJ+9ccW5RrE4Z18OT/AvGUMetE+l9dv4/JIRoezeiTZJQdWaOmURis0Zc7NhoT76/w
	++hYLk6pd6YmAY+92njBkWAm6BpZbax2Z1MMK0AVnQ2qFzN+W76p5a6qz5Wf41iboDprHJ
	hjXgpQnMp79G+uRlkLNQTkS3rbxU+WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771572215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayd1LtzLLxiXMWHsSRB+fIEPNOplWZj/LagtzjWS2wk=;
	b=/rwberAvMsOBjO3mro/GR6nHDwWOcvB32vpxfbeCZ6MDQiU3fbe3kmRPDQ7Rvwma8KIybF
	EfgGGnsZlhFNiLBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kYvEPbHW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+SGclGKV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771572214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayd1LtzLLxiXMWHsSRB+fIEPNOplWZj/LagtzjWS2wk=;
	b=kYvEPbHW3b2defptAopNlWqAolH2Kgm98ywGfn+ysrnDB9I4S3AuYziIDjzo8caZtZgWGC
	+5T1YTFY1FkCkiVCqQ01GyHY2UVZmuBtpWTvUzlDHmQria8ElI3SxL6HbZg3wMy20YkGkw
	JutcoPvuCDNRvV+iNf5smPGmCUnm/Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771572214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayd1LtzLLxiXMWHsSRB+fIEPNOplWZj/LagtzjWS2wk=;
	b=+SGclGKVSGqojLIzf4H5zIwfYmGldMOnwlgy7eworc3FJwA+VdiAc0nTRUtGR8fnlTVMC8
	rFmReOPrs/hxf1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F09793EA65;
	Fri, 20 Feb 2026 07:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t6hROfULmGk0ZwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Feb 2026 07:23:33 +0000
Message-ID: <a01e1796-8284-447f-81b1-3bf795eab8e9@suse.de>
Date: Fri, 20 Feb 2026 08:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: James Smart <jsmart833426@gmail.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com>
 <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com>
 <96ea8e82-ead3-498f-bb87-5b2809089950@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <96ea8e82-ead3-498f-bb87-5b2809089950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,purestorage.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D70DC3E6E5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_232337_804497_645B4678 
X-CRM114-Status: GOOD (  39.22  )
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

On 2/20/26 02:22, James Smart wrote:
> On 2/17/2026 7:35 AM, Mohamed Khalfella wrote:
>> On Tue 2026-02-17 08:09:33 +0100, Hannes Reinecke wrote:
>>> On 2/16/26 19:45, Mohamed Khalfella wrote:
>>>> On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
>>>>> On 2/14/26 05:25, Mohamed Khalfella wrote:
>>>>>> TP8028 Rapid Path Failure Recovery does not define how much time the
>>>>>> host should wait for CCR operation to complete. It is reasonable to
>>>>>> assume that CCR operation can take up to ctrl->cqt. Update wait 
>>>>>> time for
>>>>>> CCR operation to be max(ctrl->cqt, ctrl->kato).
>>>>>>
>>>>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>>>>> ---
>>>>>>     drivers/nvme/host/core.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index 0680d05900c1..ff479c0263ab 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct 
>>>>>> nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
>>>>>>         if (result & 0x01) /* Immediate Reset Successful */
>>>>>>             goto out;
>>>>>> -    tmo = secs_to_jiffies(ictrl->kato);
>>>>>> +    tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
>>>>>>         if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
>>>>>>             ret = -ETIMEDOUT;
>>>>>>             goto out;
>>>>>
>>>>> That is not my understanding. I was under the impression that CQT 
>>>>> is the
>>>>> _additional_ time a controller requires to clear out outstanding
>>>>> commands once it detected a loss of communication (ie _after_ KATO).
>>>>> Which would mean we have to wait for up to
>>>>> (ctrl->kato * 1000) + ctrl->cqt.
>>>>
>>>> At this point the source controller knows about communication loss. We
>>>> do not need kato wait. In theory we should just wait for CQT.
>>>> max(cqt, kato) is a conservative guess I made.
>>>>
>>> Not quite. The source controller (on the host!) knows about the
>>> communication loss. But the target might not, as the keep-alive
>>> command might have arrived at the target _just_ before KATO
>>> triggered on the host. So the target is still good, and will
>>> be waiting for _another_ KATO interval before declaring
>>> a loss of communication.
>>> And only then will the CQT period start at the target.
>>>
>>> Randy, please correct me if I'm wrong ...
>>>
>>
>> wait_for_completion_timeout(&ccr.complete, tmo)) waits for CCR operation
>> to complete. The wait starts after CCR command completed successfully.
>> IOW, it starts after the host received a CQE from source controller on
>> the target telling us all is good. If the source controller on the target
>> already know about loss of communication then there is no need to wait
>> for KATO. We just need to wait for CCR operation to finish because we
>> know it has been started successfully.
>>
>> The specs does not tell us how much time to wait for CCR operation to
>> complete. max(cqt, kato) is an estimate I think reasonable to make.
> 
> So, we've sent CCR, received a CQE for the CCR within KATO (timeout in 
> nvme_issue_wait_ccr()), then are waiting another max(KATO, CQT) for the 
> io to die.
> 
> As CQT is the time to wait once the ctrl is killing the io, and as the 
> response indicated it certainly passed that point, a minimum of CQT 
> should be all that is needed. Why are we bringing KATO into the picture?
> 

Well, a successful CCR completion (without the IRS bit) just indicates
that the controller has started aborting commands.
The host has still to wait for that the finish.
The controller signals command abort completion via an AEN and
corresponding logpage. For which we have to wait for up to CQT.

But as commands are involved (we have to wait for the AEN) the
actual waiting time is max(KATO,CQT).

> -- this takes me over to patch 8 and the timeout on CCR response being 
> KATO:
> Why is KATO being used ? nothing about getting the response says it is 
> related to the keep alive. Keepalive can move along happily while CCR 
> hangs out and really has nothing to do with KATO.
> 
The keepalive timeout is a measure for connectivity loss.
Or, more general, the minimal time each side is required to wait before
declaring any command as 'lost' (a bit like R_A_TOV ...).
So sending the CCR command (and waiting for the response) is governed
by KATO.

> If using the rationale of a keepalive cmd processing - has roundtrip 
> time and minimal and prioritized processing, as CCR needs to do more and 
> as the spec allows holding on to always return 1, it should be 
> KATO+<something>, where <something> is no more than CQT.
> 
Again, this is not so much about the keepalive command but rather about
the _time_ each side is required to wait for the keepalive response.

Technically you are correct, though, and CCR should be treated just
like any other command. But the problem currently is that the nvme
timeout handler triggers on _command timeout_, not on KATO timeout.
We're trying to change that, but it takes time ...

> But given that KATO can be really long as its trying to catch 
> communication failures, and as our ccr controller should not have comm 
> issues, it should be fairly quick. So rather than a 2min KATO, why not 
> 10-15s ? This gets a little crazy as it takes me down paths of why not 
> fire off multiple CCRs (via different ctlrs) to the subsystem at short 
> intervals (the timeout) to finally find one that completes quickly and 
> then start CQT. And if nothing completes quickly bound the whole thing 
> to fencing start+KATO+CQT ?
> 
As it currently stands, CCR is only useful if the entire execution time
is significantly shorter than KATO.
In the current model error handling starts once KATO timeout triggers;
then CCR is sent and we're waiting for the AEN for max(CQT,KATO) before
retrying commands.
(I _think_ to be absolutely correct we would have to wait for CQT + 
KATO, but that's beside the point).

So the main difference between the current error handling is the
additional waiting time for CCR or max(CQT,KATO) if CCR fails.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

