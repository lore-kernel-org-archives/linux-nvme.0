Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8D8C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6RUn791RhTOMNHCzsVcWkJy51n2kukSH+jRIvUaILJg=; b=mrbhtotGpF6fWRafHOEenLPoHM
	1eUROBopgqyUD3PevchjRqQXnZYg2qXVWZV8f81dunpdG8ofd9yInpUwHkVe0AUocou2dp7RX/Q21
	IwJj7f6LMWcG3NhWt43om3ZdUmhQGJeeXo0UpRVgDPG9xyNCqX2by09cDoxpNyrg3WSqN5WIsBm0m
	k1YOaLKcyOSCb8JJBZP+PTg+K7HO90bdkoDKqmkqXiobP3/wsGW0UFKW8Pw+CS6VSrJ0/FA7KiFNb
	7/AnPLqJNVbbRn8Utqj73VbJuTwbXzVeWxiJZorlSWMZ7JKZyjCspfeLDFl5uucSXgcFJD/+2ASqm
	HkTe0p6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnmy-00000003qJn-3FrT;
	Mon, 08 Jul 2024 12:48:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnmu-00000003qI4-0AWT
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 12:48:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9826219E0;
	Mon,  8 Jul 2024 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720442890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RUn791RhTOMNHCzsVcWkJy51n2kukSH+jRIvUaILJg=;
	b=0E/oQRneKsKxov7QRIYFtG1VoTzAQbJ8lp+Qjd5tivLrpYAUtNbuj0waWG5W+lOTxAFjk+
	KA+LH1E0ig4oem+ULX4dkGEQG1wPwxp3XwqGo5kqe4K80mElyJEUqei4SgOd+l0bCE73pp
	wtJLsTf7XU3mOwqxcQZeUoBOV3aDn6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720442890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RUn791RhTOMNHCzsVcWkJy51n2kukSH+jRIvUaILJg=;
	b=oop0PF+QuNVj6azVaE3Ey+WyjpTzDVofojZj0krnpMiL+kLrcSFDy0t97pp74pXJXNtgl3
	t0kwVdpaD8WN1CAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xVFvetsL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PLM1nvvV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720442889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RUn791RhTOMNHCzsVcWkJy51n2kukSH+jRIvUaILJg=;
	b=xVFvetsL68VP7YufdcHcki8BTRWSlJjQEbSzhHJDBPLCv6ubBTB+va9nq2T0BQXtIA8Hrb
	dlCzgpmdgRk2O/s+W88IBRXIJ5lIML5J+JgF9OU2hBuiU7hsSDuxwv5XoYONEIkreLPn/b
	LG2CsscmN/rSB49O+UZP7DpJJ3KbBvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720442889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RUn791RhTOMNHCzsVcWkJy51n2kukSH+jRIvUaILJg=;
	b=PLM1nvvVa3TDW7XD6N/ExniU9JXg4WTETonlg+tlQu0SWpEgYTad/fMlPjTNCiLKMuNgEb
	AUCBmxyPBQ0oulAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5CE613A82;
	Mon,  8 Jul 2024 12:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fTK/Kwngi2YKcgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Jul 2024 12:48:09 +0000
Message-ID: <bfc5f071-a151-4f2a-95f7-a94b5e385dd8@suse.de>
Date: Mon, 8 Jul 2024 14:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: per-controller I/O workqueues
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-4-hare@kernel.org>
 <15107646-6467-46af-8fd8-5d83225612ee@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <15107646-6467-46af-8fd8-5d83225612ee@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9826219E0
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_054812_253163_DBA70E5B 
X-CRM114-Status: GOOD (  13.38  )
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

On 7/8/24 14:12, Sagi Grimberg wrote:
> 
> 
> On 08/07/2024 10:10, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Implement per-controller I/O workqueues to reduce workqueue contention
>> during I/O and improve I/O performance.
>>
>> Performance comparison:
>>                 baseline rx/tx    blk-mq   multiple workqueues
>> 4k seq write:  449MiB/s 480MiB/s 524MiB/s 540MiB/s
>> 4k rand write: 410MiB/s 481MiB/s 524MiB/s 539MiB/s
>> 4k seq read:   478MiB/s 481MiB/s 566MiB/s 582MiB/s
>> 4k rand read:  547MiB/s 480MiB/s 511MiB/s 633MiB/s
> 
> I am still puzzled by this one.
> 
> This is for 2 controllers? or more?
> It is intresting that the rand read sees higher boost from the seq read.
> Is this a nature of the SSD? What happens with null_blk ?
> 
See the patchset description.
Two controllers, one subsystem.

> CCing Tejun. Is it possible that using two different workqueues
> for a symmetrical workload is better than a single global workqueue?

Yes, that is the implication.
It might simply due to the fact that the number of workers in a 
workqueue pool is limited to 512:

workqueue.h:      WQ_MAX_ACTIVE           = 512,    /* I like 512, 
better ideas? */

so by using a workqueue per controller we effectively raise the number
of possible workers. And we're reducing the concurrency between 
controllers, as each controller can now schedule I/O independent on
the other.

Let me check what would happen if I increase MAX_ACTIVE ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


