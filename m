Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC7BC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70fuSure0bebbY5Tn7+sv81a2OQfww2UpSe24KjKHWU=; b=3CYgejWA+/sBPxNT1SF2LON7d6
	SesAPbL3RnwIxk1iLmhEzOq3rl0biNGDoksc6v/GfwxhuCCZQuIMR9JRxxHyxyMczw1WhdtgsmybR
	snehAO/dZZIr1lJFJaXz5O7b5Np/mkSgYcISkP86SRNyWbnsu25rmzPg1URofs6ajw7/KXqJgrKLJ
	NClH+EVvCbb0BZtCVXJx5JcIIWT+/vFAbxM74DUNBLAWjE9oZtpvnaDEMCPoMmCveWrDAb/U3zctu
	Gk4yiisphD5zyCiPYrvxgTbrL/lDqqbcWlNHFPXvk/sUoUY2BI3Na3JPSTVBFKS93MD5pBywy8b0o
	eB13PQyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJs8C-00000000hbv-49no;
	Wed, 19 Jun 2024 10:01:32 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJs7x-00000000hVm-3vqj
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:01:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D22F41F803;
	Wed, 19 Jun 2024 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718791274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70fuSure0bebbY5Tn7+sv81a2OQfww2UpSe24KjKHWU=;
	b=UvwWeh2zbMrZVTfKW97/xdOCuwbEfQTHTJb+YXDxWL2hr4DPGJ+6l1ceFPqJF0GRvFTQA+
	tGkulQb6pL78SoXXvhLQRZkd1681i2s/uKPei8yN+/gKoEi0QJQx3KAjXaFTUXnoQR8biJ
	S8PTk0vmVDmpHIC7UJl1d3l4S0KHwpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718791274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70fuSure0bebbY5Tn7+sv81a2OQfww2UpSe24KjKHWU=;
	b=nurLeybf5Dpr5qdynwW1UMH+WaurLafhEbAx8HJ2cn9GMzTL4hty+rS8C62yfrDai/p82R
	gy8SzQie3Q9gBrCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L8RQKjrJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eertdvBL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718791272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70fuSure0bebbY5Tn7+sv81a2OQfww2UpSe24KjKHWU=;
	b=L8RQKjrJORdjMzIeg9X0ZyD6R0coMqMj3OKy0DhKOPl4SyvKz1vJbvJ3oub6VDS5R7bBvQ
	4dk1DW/adMdRrYECO2N87VH65cj2uniSHQGVC9rViescr+0YE74W6jyrdk/EkIdXAzghrF
	cUIC6PsUJQ96J55TurhdwE0xiYOiOok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718791272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70fuSure0bebbY5Tn7+sv81a2OQfww2UpSe24KjKHWU=;
	b=eertdvBLv7LrXyr3cI8rH9j2HIqlxDhvjKPDkP5Mp+3PlPXUm5YioJ+ggnp1BmnegrTtEk
	Ca1OXGcN2SuKmJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A746113ABD;
	Wed, 19 Jun 2024 10:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lokqJ2iscmZSOgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Jun 2024 10:01:12 +0000
Message-ID: <f30bff6b-5c9a-46e4-89df-1a1df088faeb@suse.de>
Date: Wed, 19 Jun 2024 12:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: align I/O cpu with blk-mq mapping
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240618120345.64761-1-hare@kernel.org>
 <20240619053015.GB29159@lst.de>
 <e8d5e591-0f19-4cc8-b7a4-9d6a5687b019@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e8d5e591-0f19-4cc8-b7a4-9d6a5687b019@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D22F41F803
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_030118_194607_30AD974D 
X-CRM114-Status: GOOD (  18.59  )
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

On 6/19/24 10:57, Sagi Grimberg wrote:
> 
> 
> On 19/06/2024 8:30, Christoph Hellwig wrote:
>> On Tue, Jun 18, 2024 at 02:03:45PM +0200, Hannes Reinecke wrote:
>>> Add a new module parameter 'wq_affinity' to spread the I/O
>>> over all cpus within the blk-mq hctx mapping for the queue.
>>> This avoids bouncing I/O between cpus when we have less
>>> hardware queues than cpus.
>> What is the benefit when setting it?  What is the downside?  Why do you
>> think it needs to be conditional?
> 
> Not entirely sure.
> 

Hehe. But I am :-)

> Hannes,
> 
> Can you please show what is the hctx<->cpu mappings before/after this
> patch? Please use different queue counts so we can see the pattern.
> 
> Can you please show any performance comparisons for low and high
> queue counts?
> 
> I'm not entirely clear what exactly "spreads I/O over all CPUs" mean.
> Every nvme-tcp queue has an io context that does network sends and receives
> (unless it goes within .queue_rq() context when possible). Does this 
> somehow mean
> that now a queue io context will run from multiple cpus at the same time?

We are having on connection per queue, doing a 'queue_work_on()' for 
each queue, based on the value of 'io_cpu'.
That cpu should align to the set of CPUs per associated hwctx, otherwise
we need to bounce the thread from one cpu to another.
Case in point on this AMD machine I get this blk-mq mapping:

queue 0: 6, 7, 8, 54, 55, 56
queue 1: 9, 10, 11, 57, 58, 59
queue 10: 42, 43, 44, 90, 91, 92
queue 11: 45, 46, 47, 93, 94, 95
queue 12: 12, 13, 14, 60, 61, 62
queue 13: 15, 16, 17, 63, 64, 65
queue 14: 0, 1, 2, 48, 49, 50
queue 15: 3, 4, 5, 51, 52, 53
queue 2: 18, 19, 20, 66, 67, 68
queue 3: 21, 22, 23, 69, 70, 71
queue 4: 24, 25, 26, 72, 73, 74
queue 5: 27, 28, 29, 75, 76, 77
queue 6: 30, 31, 32, 78, 79, 80
queue 7: 33, 34, 35, 81, 82, 83
queue 8: 36, 37, 38, 84, 85, 86
queue 9: 39, 40, 41, 87, 88, 89

- default behaviour:

nvme nvme1: mapped 16/0/0 default/read/poll queues.
nvme nvme1: queue 1: using cpu 0
nvme nvme1: queue 2: using cpu 1
nvme nvme1: queue 3: using cpu 2
nvme nvme1: queue 4: using cpu 3
nvme nvme1: queue 5: using cpu 4
nvme nvme1: queue 6: using cpu 5
nvme nvme1: queue 7: using cpu 6
nvme nvme1: queue 8: using cpu 7
nvme nvme1: queue 9: using cpu 8
nvme nvme1: queue 10: using cpu 9
nvme nvme1: queue 11: using cpu 10
nvme nvme1: queue 12: using cpu 11
nvme nvme1: queue 13: using cpu 12
nvme nvme1: queue 14: using cpu 13
nvme nvme1: queue 15: using cpu 14
nvme nvme1: queue 16: using cpu 15

So just queue 12 is using the correct CPU; all other queues are
scheduled on cpus which are not part of the hwctx map.

- wq_affinity behaviour:

nvme nvme1: queue 1: using cpu 6
nvme nvme1: queue 2: using cpu 9
nvme nvme1: queue 3: using cpu 18
nvme nvme1: queue 4: using cpu 21
nvme nvme1: queue 5: using cpu 24
nvme nvme1: queue 6: using cpu 27
nvme nvme1: queue 7: using cpu 30
nvme nvme1: queue 8: using cpu 33
nvme nvme1: queue 9: using cpu 36
nvme nvme1: queue 10: using cpu 39
nvme nvme1: queue 11: using cpu 42
nvme nvme1: queue 12: using cpu 45
nvme nvme1: queue 13: using cpu 12
nvme nvme1: queue 14: using cpu 15
nvme nvme1: queue 15: using cpu 0
nvme nvme1: queue 16: using cpu 3

All queues are scheduled on a cpu which is part of the
blk-mq hwctx map.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


