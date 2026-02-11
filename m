Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D244E9E311
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a8U+QEk8aQDTtDbGKLW9Vhi9AhmsnTb/jXYzZNRRWyM=; b=RWtRgmOiHZuSPMa7AtAiUib/OD
	xDBWg8vAe6JG6zxurI08+J+GhXFrOi2+gtD6BLwVC9EJs7z5h33b3I0ZrT/cvphOuTwVFlf6CD9g5
	iJP9TQ0mWeRunl8wDmIfJfBmc9Dgh5hAtPL/Hv/L3nI4lSivqT2+YoFQkGiwmt2Rkzh7ZV+SnU468
	RZ8gz4z9hj9Fn0KAuerrjKOSuJ4ReCvOVkcj7dnW2bnY6iy5NbWILW/KgjTX7q1sbUNcJNC96MUU6
	R/Udg9qOENokvIAn2GVyvCkoG0nAVkGPJqud4fB3lSAskyuerSQhOfT4++slTlgyvYErKbIUoUP7Q
	lB32oRpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqBzz-00000000m4H-0OqU;
	Wed, 11 Feb 2026 15:19:27 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqBzw-00000000m3b-0Vrr
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 15:19:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FE143E715;
	Wed, 11 Feb 2026 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770823160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8U+QEk8aQDTtDbGKLW9Vhi9AhmsnTb/jXYzZNRRWyM=;
	b=SbElvdGzW58Ya0taV3EbbCKhmHDtDGv/gwPAv4ltId27kFeGMm948MFPiwdMEOy1vhlmS+
	snleGRicS0RmoxPWhd0HVpHIFL2h01tR+pNNhva7Zb+h0JIZT4sdc22b/XUXlo1Gm7RwPN
	Tw1PAbnRit/C2PybrtKsqVLI4q8MInQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770823160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8U+QEk8aQDTtDbGKLW9Vhi9AhmsnTb/jXYzZNRRWyM=;
	b=K7KQIYHWB0uQ+jjzut98Hd0OGZa8YZ3XxET1hxFsNo6NGcxEfhNSapsRO1WFahPHAVuY+/
	JEeDb9GI7yKKD1AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SbElvdGz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K7KQIYHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770823160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8U+QEk8aQDTtDbGKLW9Vhi9AhmsnTb/jXYzZNRRWyM=;
	b=SbElvdGzW58Ya0taV3EbbCKhmHDtDGv/gwPAv4ltId27kFeGMm948MFPiwdMEOy1vhlmS+
	snleGRicS0RmoxPWhd0HVpHIFL2h01tR+pNNhva7Zb+h0JIZT4sdc22b/XUXlo1Gm7RwPN
	Tw1PAbnRit/C2PybrtKsqVLI4q8MInQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770823160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8U+QEk8aQDTtDbGKLW9Vhi9AhmsnTb/jXYzZNRRWyM=;
	b=K7KQIYHWB0uQ+jjzut98Hd0OGZa8YZ3XxET1hxFsNo6NGcxEfhNSapsRO1WFahPHAVuY+/
	JEeDb9GI7yKKD1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 015EC3EA62;
	Wed, 11 Feb 2026 15:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVBPOvedjGnMIAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 11 Feb 2026 15:19:19 +0000
Message-ID: <d651af57-89aa-43fa-b7a4-6c4315fbd996@suse.de>
Date: Wed, 11 Feb 2026 16:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Randy Jennings <randyj@purestorage.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>, Dhaval Giani
 <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
 <20260203200048.GE3729-mkhalfella@purestorage.com>
 <481562cd-0444-49db-8755-29436bec02de@suse.de>
 <20260204232456.GM3729-mkhalfella@purestorage.com>
 <CAPpK+O02_ua4Rz+uggMKpp4gpgm-JugmKCs9CUECsdV9WuVdig@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAPpK+O02_ua4Rz+uggMKpp4gpgm-JugmKCs9CUECsdV9WuVdig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,purestorage.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6FE143E715
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_071924_477018_2846C31E 
X-CRM114-Status: GOOD (  28.95  )
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

On 2/11/26 04:44, Randy Jennings wrote:
> On Wed, Feb 4, 2026 at 3:24 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
>>
>> On Wed 2026-02-04 02:10:48 +0100, Hannes Reinecke wrote:
>>> On 2/3/26 21:00, Mohamed Khalfella wrote:
>>>> On Tue 2026-02-03 06:19:51 +0100, Hannes Reinecke wrote:
>>>>> On 1/30/26 23:34, Mohamed Khalfella wrote:
>>> [ .. ]
>>>>>> + timeout = nvme_fence_timeout_ms(ictrl);
>>>>>> + dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
>>>>>> +
>>>>>> + now = jiffies;
>>>>>> + deadline = now + msecs_to_jiffies(timeout);
>>>>>> + while (time_before(now, deadline)) {
>>>>>> +         sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
>>>>>> +         if (!sctrl) {
>>>>>> +                 /* CCR failed, switch to time-based recovery */
>>>>>> +                 return deadline - now;
>>>>>> +         }
>>>>>> +
>>>>>> +         ret = nvme_issue_wait_ccr(sctrl, ictrl);
>>>>>> +         if (!ret) {
>>>>>> +                 dev_info(ictrl->device, "CCR succeeded using %s\n",
>>>>>> +                          dev_name(sctrl->device));
>>>>>> +                 nvme_put_ctrl_ccr(sctrl);
>>>>>> +                 return 0;
>>>>>> +         }
>>>>>> +
>>>>>> +         /* CCR failed, try another path */
>>>>>> +         min_cntlid = sctrl->cntlid + 1;
>>>>>> +         nvme_put_ctrl_ccr(sctrl);
>>>>>> +         now = jiffies;
>>>>>> + }
>>>>>
>>>>> That will spin until 'deadline' is reached if 'nvme_issue_wait_ccr()'
>>>>> returns an error. _And_ if the CCR itself runs into a timeout we would
>>>>> never have tried another path (which could have succeeded).
>>>>
>>>> True. We can do one thing at a time in CCR time budget. Either wait for
>>>> CCR to succeed or give up early and try another path. It is a trade off.
>>>>
>>> Yes. But I guess my point here is that we should differentiate between
>>> 'CCR failed to be sent' and 'CCR completed with error'.
>>> The logic above treats both the same.
>>>
>>>>>
>>>>> I'd rather rework this loop to open-code 'issue_and_wait()' in the loop,
>>>>> and only switch to the next controller if the submission of CCR failed.
>>>>> Once that is done we can 'just' wait for completion, as a failure there
>>>>> will be after KATO timeout anyway and any subsequent CCR would be pointless.
>>>>
>>>> If I understood this correctly then we will stick with the first sctrl
>>>> that accepts the CCR command. We wait for CCR to complete and give up on
>>>> fencing ictrl if CCR operation fails or times out. Did I get this correctly?
>>>>
>>> Yes.
>>> If a CCR could be send but the controller failed to process it something
>>> very odd is ongoing, and it's extremely questionable whether a CCR to
>>> another controller would be succeeding. That's why I would switch to the
>>> next available controller if we could not _send_ the CCR, but would
>>> rather wait for KATO if CCR processing returned an error.
>>>
>>> But the main point is that CCR is a way to _shorten_ the interval
>>> (until KATO timeout) until we can start retrying commands.
>>> If the controller ran into an error during CCR processing chances
>>> are that quite some time has elapsed already, and we might as well
>>> wait for KATO instead of retrying with yet another CCR.
>>
>> Got it. I updated the code to do that.
> It is not true that CCR failing means something odd is going on.  In a
> tightly-coupled storage HA pair, hopefully, all the NVMe controllers
> will be able to figure out the status of the other NVMe controllers.
> However, I know of multiple systems (one of which I care about) where
> the NVMe controllers may have no way of figuring out the state of some
> other NVMe controllers.  In that case, the log page entry indicates
> that the CCR might succeed on some other NVMe controller (and in these
> systems, I expect they would not be able to be particularly specific
> about which one).  Very little time will elapse for that to happen.
> 
> It is important for those systems to have a retry on another NVMe
> controller.
> 
Ah, well; that's me being mainly focused on command timeouts.
If we get an NVMe status back indicating we should retry on
another controller then clearly we should be doing that.
The comment above was primarily geared for a CCR command for
which we do _not_ get a result back.

Or, put it another way: as long as we're within the KATO timeout
range we should retry the CCR command on another path.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

