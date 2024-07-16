Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A042C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=viX+2Do7OzEOGPptVU4bpf8pJLLvILtSTXIFWsJN2+0=; b=AnyjoNo/X8K5qF9w7sCES1Z+fd
	1QjOu0JZwKJUJILW6KZgOV7k4enRSSve8EQpTX72PSKz2DvwQ3Ofu4GD1Ca6wWhxqFSTxgZuNq67R
	ZFb9ZHonQ7zOpcWmgdiSqp7aUE0pZOxFe1cEvdysV2HydJ5ByB7tvhy1K/v34hOOBPo/fMNB3oxYG
	bvv1XfPAoMSISh/3ZCBCcoQJMpONfr/osxIlymPZrCdOH2RdHXLaFh9tOm9TojrEgon6kfCrk4PCb
	6MIoHAhOKNjpFqqEr/5QqwfgMWvh3McwBFPz/Z47c/ew88Q6u4B2EUE+aYbXOv9VJgSstPbIC0Vi3
	jLM0ggrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfG8-0000000A0UG-3mcU;
	Tue, 16 Jul 2024 10:18:12 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfG4-0000000A0TI-0jTF
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 10:18:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A9FE21C01;
	Tue, 16 Jul 2024 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721125086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viX+2Do7OzEOGPptVU4bpf8pJLLvILtSTXIFWsJN2+0=;
	b=N4I2Ks/+Qzzv3WNZwrCbT0kwMI8/M67UgR+o2NVjjVEqI3MlCUvt515kI2ZK3Fda/AZ1yM
	40H5FrOhWFMHYlhKUatd//OiFdFvP0T6lEtUh5ccLCtWBQseVNJqrxFuua1fpQybTz7v28
	o602Srgqv1M7hUFHVAabpHqE0BJlUhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721125086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viX+2Do7OzEOGPptVU4bpf8pJLLvILtSTXIFWsJN2+0=;
	b=m8MpC0mNTlHXnxBTSEfy2CBXNo4zIab3mtG+UOIJnXjFylaiPdE37iAJWVljPdwlIB/E/n
	WVWPME0F/dfzb6Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="N4I2Ks/+";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m8MpC0mN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721125086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viX+2Do7OzEOGPptVU4bpf8pJLLvILtSTXIFWsJN2+0=;
	b=N4I2Ks/+Qzzv3WNZwrCbT0kwMI8/M67UgR+o2NVjjVEqI3MlCUvt515kI2ZK3Fda/AZ1yM
	40H5FrOhWFMHYlhKUatd//OiFdFvP0T6lEtUh5ccLCtWBQseVNJqrxFuua1fpQybTz7v28
	o602Srgqv1M7hUFHVAabpHqE0BJlUhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721125086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viX+2Do7OzEOGPptVU4bpf8pJLLvILtSTXIFWsJN2+0=;
	b=m8MpC0mNTlHXnxBTSEfy2CBXNo4zIab3mtG+UOIJnXjFylaiPdE37iAJWVljPdwlIB/E/n
	WVWPME0F/dfzb6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FD13136E5;
	Tue, 16 Jul 2024 10:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QwNsA95IlmZMLAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jul 2024 10:18:06 +0000
Message-ID: <0fc55448-e73e-426b-b105-40ce0401348a@suse.de>
Date: Tue, 16 Jul 2024 12:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
To: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Lawrence Troup <ltroup@cisco.com>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <20240702115002.GA16219@lst.de> <ZoPum7MPTuA6/t7O@fedora>
 <hdvvssh5azfwzgymk3olmtfwwpc2fnyzjflqt4pl2jt3pm4s2w@nbek7v47kzcv>
 <ZoSuhqlKvKyyMQn5@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoSuhqlKvKyyMQn5@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3A9FE21C01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_031808_387591_8022282C 
X-CRM114-Status: GOOD (  19.54  )
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

On 7/3/24 03:51, Ming Lei wrote:
> On Tue, Jul 02, 2024 at 06:28:19PM +0200, Daniel Wagner wrote:
>> On Tue, Jul 02, 2024 at 08:12:11PM GMT, Ming Lei wrote:
>>> On Tue, Jul 02, 2024 at 01:50:02PM +0200, Christoph Hellwig wrote:
>>>> On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
>>>>> From: Keith Busch <kbusch@kernel.org>
>>>>>
>>>>> People _really_ want to control their interrupt affinity in some
>>>>> cases, such as Openshift with Performance profile, in which each
>>>>> irq's affinity is completely specified from userspace. Turns out
>>>>> that 'isolcpus=managed_irqs' isn't enough.
>>>>>
>>>>> Add module parameter to allow unmanaged interrupts, just as some
>>>>> SCSI drivers are doing.
>>>>
>>>> Same as before: hell no.  We can't just add hacky global kernel
>>>> parameters everywhere.  We need the cpu isolation infrastructure to
>>>> work properly instead of piling hacks of hacks in every relevant driver.
>>>
>>> Per my understanding, here cpu isolation infrastructure can't work for
>>> Openshift, in which IO workload can be run on applications which are executed
>>> on isolated CPUs, meantime userspace do expect that interrupts can be
>>> triggered on user-specified CPU cores only in controllable way.
>>>
>>> Marcelo and Lawrence may have more input in this area.
>>>
>>> Also irq allocation really belongs to device & driver stuff, how can that be
>>> hack? We even may not abstract public API in block layer for handling
>>> irq related thing.
>>
>> I am confused. I though you told me that my series 'nvme-pci: honor
>> isolcpus configuration' is not necessary. But you still need this patch
> 
> Your patch fixes nothing basically, meantime it introduces regression. But
> I don't object the approach if blk-mq regressions can be solved.
> 
>> to get the affinity sorted out? Wouldn't it make sense to figure out how
>> we can make my series working also for your use case? E.g. we could
>> introduce another HK type (io_queue) to control the affinity. This would
>> decouple if from the managed_irq option.
> 
> Adding new HK type can't help this issue because Openshift environment needs
> to control each irq's affinity by themselves dynamically, and even IO workload
> may be run on isolated CPUs.
> 
Understood, but that is what Daniel is working on, namely split the pool 
of available interrupts such that each side (housekeeping and isolcpus) 
gets a fair share of interrupts.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


