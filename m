Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36915C3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDxTXDMj0Eb469RiWLSPUp9oiaiGrnD8qsD4psBCzLo=; b=ifwYWYZt6qA084U4/j03nCr6WK
	H/552cPkbsHZwWWZue7JBYHSEXZ9jJSTI2iUxODBRWlkz+JRwDhMvYnpkTkoJl5piz5PV01cU5dd+
	65uTzkD/jTopo+p3y8Vq34GuWJfjnfBmHZXKAk8r90OMOeUv4PJNwaxgxFGH7/62Rqe5Uiirdrgl+
	xjLKFDWBB0MuUX9q5EgOel8hd2YD6zFPlSGqgvMbuYiOREPug4j2CI5w7EoT56BFX2hUfKaFEU17y
	xeUF3z/m/OGcFBNnQG43vIM3fTd/5hTgvEVjxjqQZAC6/ARRYmUDIGy5jkxIqHvmEwanhyEyhkCAS
	SzovvBBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUKV6-0000000FvhE-27N1;
	Thu, 18 Jul 2024 06:20:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUKV3-0000000Fvg6-0T1c
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 06:20:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4D5C21C1B;
	Thu, 18 Jul 2024 06:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721283618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDxTXDMj0Eb469RiWLSPUp9oiaiGrnD8qsD4psBCzLo=;
	b=g5BqHI8RVFAE6MdJesD9zhS75pc/nTqeXlJWBeLfopKq1QFzRG6wTfC8tsA2+CoE6/lbTS
	YYs0yoz6U3tVNzwYSaaexqo2v0OIaX4rPkwmF9dSnU5op5fAxKqIKhn7va4ZhGKfgZDMIS
	QEz0AYmV+eNMNUD2+B6H4wR9KhgYe2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721283618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDxTXDMj0Eb469RiWLSPUp9oiaiGrnD8qsD4psBCzLo=;
	b=kQfjUX7suOoqvvvD49niHKohhWl1G8MqGc6piO34aS7YIPC7zfbMqErLL4wbN0bJiJqoLs
	kDI2S5YSJY8oUcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721283618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDxTXDMj0Eb469RiWLSPUp9oiaiGrnD8qsD4psBCzLo=;
	b=g5BqHI8RVFAE6MdJesD9zhS75pc/nTqeXlJWBeLfopKq1QFzRG6wTfC8tsA2+CoE6/lbTS
	YYs0yoz6U3tVNzwYSaaexqo2v0OIaX4rPkwmF9dSnU5op5fAxKqIKhn7va4ZhGKfgZDMIS
	QEz0AYmV+eNMNUD2+B6H4wR9KhgYe2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721283618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDxTXDMj0Eb469RiWLSPUp9oiaiGrnD8qsD4psBCzLo=;
	b=kQfjUX7suOoqvvvD49niHKohhWl1G8MqGc6piO34aS7YIPC7zfbMqErLL4wbN0bJiJqoLs
	kDI2S5YSJY8oUcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA361379D;
	Thu, 18 Jul 2024 06:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qqLXJCK0mGZLfAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 06:20:18 +0000
Message-ID: <7e1c9300-ab39-47cd-b3aa-c4d66ab70f6b@suse.de>
Date: Thu, 18 Jul 2024 08:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/8] nvme-tcp: improve scalability
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <3c7aafde-f08b-4ea2-b017-ceceb842238a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3c7aafde-f08b-4ea2-b017-ceceb842238a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_232021_594394_8E88977C 
X-CRM114-Status: GOOD (  24.62  )
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

On 7/17/24 23:01, Sagi Grimberg wrote:
> 
> 
> On 16/07/2024 10:36, Hannes Reinecke wrote:
>> Hi all,
>>
>> for workloads with a lot of controllers we run into workqueue contention,
>> where the single workqueue is not able to service requests fast enough,
>> leading to spurious I/O errors and connect resets during high load.
>> One culprit here was a lock contention on the callbacks, where we
>> acquired the 'sk_callback_lock()' on every callback. As we are dealing
>> with parallel rx and tx flows this induces quite a lot of contention.
>> I have also added instrumentation to analyse I/O flows, by adding
>> a I/O stall debug messages and added debugfs entries to display
>> detailed statistics for each queue.
> 
> Hanneds, I'm getting really confused with this...
> 
> Once again you submit a set that is a different direction almost
> entirely from v1 and v2... Again without quantifying what each
> change is giving us, and it makes it very hard to review and understand.
> 
I fully concur. But the previous patchsets turned out to not give a 
substantial improvements when scaling up.
And getting reliable performance numbers is _really_ hard, as there is
quite a high fluctuation in them. This was the reason for including
the statistics patches; there we get a direct insight of the I/O path
latency, and can directly measure the impact of the changes.

And that's also how I found the lock contention on the callbacks...

> I suggest we split the changes that have consensus to a separate series
> (still state what each change gets us), and understand better the rest...
> 
The patchset here is (apart from the statistics patches) just the one 
removing lock contention on callbacks (which _really_ were causing 
issues), and the alignment with blk-mq, for which I do see an improvement.

All other patches posted previously turned out to increase the latency
(thanks to the statistics patches), so I left them out from this round.

>>
>> All performance number are derived from the 'tiobench-example.fio'
>> sample from the fio sources, running on a 96 core machine with one,
>> two, or four subsystem and two paths, each path exposing 32 queues.
>> Backend is nvmet using an Intel DC P3700 NVMe SSD.
> 
> The patchset in v1 started by stating a performance issue when
> controllers have a limited number of queues, does this test case
> represent the original issue?
> 
Oh, but it does. The entire test is run on machine with 96 cores.

>>
>> write performance:
>> baseline:
>> 1 subsys, 4k seq:  bw=523MiB/s (548MB/s), 16.3MiB/s-19.0MiB/s 
>> (17.1MB/s-20.0MB/s)
>> 1 subsys, 4k rand: bw=502MiB/s (526MB/s), 15.7MiB/s-21.5MiB/s 
>> (16.4MB/s-22.5MB/s)
>> 2 subsys, 4k seq:  bw=420MiB/s (440MB/s), 2804KiB/s-4790KiB/s 
>> (2871kB/s-4905kB/s)
>> 2 subsys, 4k rand: bw=416MiB/s (436MB/s), 2814KiB/s-5503KiB/s 
>> (2881kB/s-5635kB/s)
>> 4 subsys, 4k seq:  bw=409MiB/s (429MB/s), 1990KiB/s-8396KiB/s 
>> (2038kB/s-8598kB/s)
>> 4 subsys, 4k rand: bw=386MiB/s (405MB/s), 2024KiB/s-6314KiB/s 
>> (2072kB/s-6466kB/s)
>>
>> patched:
>> 1 subsys, 4k seq:  bw=440MiB/s (461MB/s), 13.7MiB/s-16.1MiB/s 
>> (14.4MB/s-16.8MB/s)
>> 1 subsys, 4k rand: bw=427MiB/s (448MB/s), 13.4MiB/s-16.2MiB/s 
>> (13.0MB/s-16.0MB/s)
> 
> That is a substantial degradation. I also keep asking, how does null_blk 
> looks like?
> 
Tested, and doesn't make a difference. Similar numbers.
Surprisingly, but there you are.

>> 2 subsys, 4k seq:  bw=506MiB/s (531MB/s), 3581KiB/s-4493KiB/s 
>> (3667kB/s-4601kB/s)
>> 2 subsys, 4k rand: bw=494MiB/s (518MB/s), 3630KiB/s-4421KiB/s 
>> (3717kB/s-4528kB/s)
>> 4 subsys, 4k seq:  bw=457MiB/s (479MB/s), 2564KiB/s-8297KiB/s 
>> (2625kB/s-8496kB/s)
>> 4 subsys, 4k rand: bw=424MiB/s (444MB/s), 2509KiB/s-9414KiB/s 
>> (2570kB/s-9640kB/s)
> 
> There is still an observed degradation when moving from 2 to 4 
> subsystems, what is the cause of it?
> 
All subsystems are running over the same 10GigE link, so some 
performance degradation is to be expected as we are having higher
contention.

>>
>> read performance:
>> baseline:
>> 1 subsys, 4k seq:  bw=389MiB/s (408MB/s), 12.2MiB/s-18.1MiB/s 
>> (12.7MB/s-18.0MB/s)
>> 1 subsys, 4k rand: bw=430MiB/s (451MB/s), 13.5MiB/s-19.2MiB/s 
>> (14.1MB/s-20.2MB/s)
>> 2 subsys, 4k seq:  bw=377MiB/s (395MB/s), 2603KiB/s-3987KiB/s 
>> (2666kB/s-4083kB/s)
>> 2 subsys, 4k rand: bw=377MiB/s (395MB/s), 2431KiB/s-5403KiB/s 
>> (2489kB/s-5533kB/s)
>> 4 subsys, 4k seq:  bw=139MiB/s (146MB/s), 197KiB/s-11.1MiB/s 
>> (202kB/s-11.6MB/s)
>> 4 subsys, 4k rand: bw=352MiB/s (369MB/s), 1360KiB/s-13.9MiB/s 
>> (1392kB/s-14.6MB/s)
>>
>> patched:
>> 1 subsys, 4k seq:  bw=405MiB/s (425MB/s), 2.7MiB/s-14.7MiB/s 
>> (13.3MB/s-15.4MB/s)
>> 1 subsys, 4k rand: bw=427MiB/s (447MB/s), 13.3MiB/s-16.1MiB/s 
>> (13.0MB/s-16.9MB/s)
>> 2 subsys, 4k seq:  bw=411MiB/s (431MB/s), 2462KiB/s-4523KiB/s 
>> (2522kB/s-4632kB/s)
>> 2 subsys, 4k rand: bw=392MiB/s (411MB/s), 2258KiB/s-4220KiB/s 
>> (2312kB/s-4321kB/s)
>> 4 subsys, 4k seq:  bw=378MiB/s (397MB/s), 1859KiB/s-8110KiB/s 
>> (1904kB/s-8305kB/s)
>> 4 subsys, 4k rand: bw=326MiB/s (342MB/s), 1781KiB/s-4499KiB/s 
>> (1823kB/s-4607kB/s)
> 
> Same question here, your patches do not seem to eliminate the overall 
> loss of efficiency.

Never claimed that, and really I can't see that we can.
All subsystems are running over the same link, so we are having to push
more independent frames across it, and we will suffer from higher
contention here. A performance degradation when scaling up subsystems
is unavoidable.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


