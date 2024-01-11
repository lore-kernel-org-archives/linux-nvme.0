Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4882C47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbEncpMikZLGqUmBU8P8iE26TWiaibnWjjpAbbIyJpA=; b=IwkjKqcaVVrA+PLnWwO1tPw4gc
	PGLJ4n/8/ccUubpS/hdvgan2/GEnL1zf+yX9txEmLH5MZe7fWIaARhvPdFTzXtvU9LhzZZSwXwnsE
	D2GsmILRWTeF7ZMxoRe+issMOwhISo9X/FC7K5uj+XYPqvYIzIgiAWLB0qp1sGtMj0HhvfaGGdKDH
	LAqUNOiCgYpHDoth5DZ/3aY7UimtRXIEELM9ZzH0I2lI+/SkpRboJjDvmWPeTRicBQ86n+FPWNRQb
	wAwTKpx/9QLwdszv7AlJkSaNrvp945Ul0LdQ+Sk8F6FTGG7A+arg7TpauO+A34SHQTzUG2P+vCbDy
	4OpMOjNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNvlE-000FeZ-2D;
	Thu, 11 Jan 2024 14:10:20 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNvlB-000FdZ-2f
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 14:10:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E8501FBAC;
	Thu, 11 Jan 2024 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704982212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbEncpMikZLGqUmBU8P8iE26TWiaibnWjjpAbbIyJpA=;
	b=u+AbiR0pRYs5M5RtQKQ3n+sR2Y9L/g09qPippyi+H/YU/0XVw1ndgPMubWfHf9v/SlLjOG
	5mxhH1y/uep5Lvbcjttbo47q8eXavqaMA4PI6bdNrCxghEEX5Ffh5eoQNvIsMVWJqnAKOl
	1EdMCpC7lBiuYInAGnPzgRu7YaOo8Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704982212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbEncpMikZLGqUmBU8P8iE26TWiaibnWjjpAbbIyJpA=;
	b=WSZhdeWSNYs/RVWuSFc52Q4rB7/j2OUeZZjk1KUTGX2hHiOAB+KebquI5ozx3x94O1C37o
	XrrUa5mTlDQVuyCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704982212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbEncpMikZLGqUmBU8P8iE26TWiaibnWjjpAbbIyJpA=;
	b=u+AbiR0pRYs5M5RtQKQ3n+sR2Y9L/g09qPippyi+H/YU/0XVw1ndgPMubWfHf9v/SlLjOG
	5mxhH1y/uep5Lvbcjttbo47q8eXavqaMA4PI6bdNrCxghEEX5Ffh5eoQNvIsMVWJqnAKOl
	1EdMCpC7lBiuYInAGnPzgRu7YaOo8Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704982212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbEncpMikZLGqUmBU8P8iE26TWiaibnWjjpAbbIyJpA=;
	b=WSZhdeWSNYs/RVWuSFc52Q4rB7/j2OUeZZjk1KUTGX2hHiOAB+KebquI5ozx3x94O1C37o
	XrrUa5mTlDQVuyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B91F13635;
	Thu, 11 Jan 2024 14:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/hvIcT2n2XCOgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 11 Jan 2024 14:10:12 +0000
Message-ID: <6a76a20c-60ff-432d-abf8-369d6c96552b@suse.de>
Date: Thu, 11 Jan 2024 15:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Do not terminate commands when in RESETTING
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240111072929.29381-1-hare@kernel.org>
 <8e29a135-2c3f-4b85-8d9e-bf375160d3bc@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8e29a135-2c3f-4b85-8d9e-bf375160d3bc@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u+AbiR0p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WSZhdeWS
X-Spamd-Result: default: False [-5.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E8501FBAC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_061018_041579_D34A754C 
X-CRM114-Status: GOOD (  30.75  )
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

On 1/11/24 13:30, Sagi Grimberg wrote:
> 
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Terminating commands from the timeout handler might lead
>> to a data corruption as the timeout might trigger before
>> KATO expired.
>> This is the case when several commands have been started
>> before the keep-alive command and the command timeouts
>> trigger just after the keep-alive command has been sent.
>> Then the first command will trigger an error recovery,
>> but all the other commands will be aborted directly
>> and immediately retried.
>> So return BLK_EH_RESET_TIMER for I/O commands when
>> error recovery has been started to ensure that the
>> commands will be retried only after the KATO interval.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index b234f0674aeb..b9ec121b3fc6 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2429,6 +2429,18 @@ static enum blk_eh_timer_return 
>> nvme_tcp_timeout(struct request *rq)
>>            rq->tag, nvme_cid(rq), pdu->hdr.type, opc,
>>            nvme_opcode_str(qid, opc, fctype), qid);
>> +    /*
>> +     * If the error recovery is started we should ignore all
>> +     * I/O commands as they'll be aborted once error recovery starts.
>> +     * Otherwise they'll be failed over immediately and might
>> +     * cause data corruption.
> 
> I think that we can settle with a simpler comment:
>      /*
>       * If the controller is in state RESETTING, the error
>       * recovery handler will cancel all inflight commands soon
>       * which in turn may failover to a different path.
>       */
> 
> The error handler will start promptly anyways.
> 
Ok.

>> +     */
>> +    if (ctrl->state == NVME_CTRL_RESETTING && qid > 0) {
> 
> What would be the issue doing this for admin commands as well?
> 
There are several commands sent during the 'connect' workflow before
the queue is switched to 'LIVE', and we need to terminate them correctly
such that the 'connect' workflow can make progress (and we're not
deadlocking waiting for the commands to complete).
(Cf the comment after the 'LIVE' check later in the code)

Plus all commands on the admin queue do not change the state of the
data, so it doesn't matter if they got re-issued to a different
controller. Well, it _might_ matter, but then we'll be getting
an NVMe status back and we'll be notified in the message log.

Core issue with this patch is that we want to avoid a silent
failover of data I/O before KATO expires.

>> +        /* Avoid interfering with firmware download */
>> +        if (!WARN_ON(work_pending(&ctrl->fw_act_work)))
> 
> Let's ignore the fw_act_work, it's not a thing in fabrics.
> 
Wasn't sure, but if you say so, ok.

>> +            return BLK_EH_RESET_TIMER;
>> +    }
>> +
>>       if (ctrl->state != NVME_CTRL_LIVE) {
>>           /*
>>            * If we are resetting, connecting or deleting we should
> 
> I think that the comment here needs an update as well.
> 
Oh, I thought that I had modified that, too. But yes, of course.

> BTW, what happens when deleting a controller? Won't the state be
> DELETING and the situation you are trying to prevent happen as well?

Not sure. Haven't really tested that path, and it'll be hard to trigger
anyway (you would have to trigger controller deletion _just_ before the
I/O timeout hits).
But yeah, I could check for DELETING, too.

Cheers,

Hannes


