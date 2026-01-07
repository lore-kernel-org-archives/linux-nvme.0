Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB2CD5854
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulJHfC7iSyYI+8Xh6ofHAXqAk33v2C+F4NO+ud+3Hn4=; b=kxESTwTdGA85YhvcZB5/jBhtiW
	TUzuTmw/RYETk8VbhGSvuD4R8iEXRFQ0drLW9zH+eIijwPhb+b95gDBU/GPcjFVi2QiHWyBMHwwfk
	TfO8jqz1wNPwTAjyW5qOsf9YXDVig5yiHjw45FW/+1mMUZcXvAtkdM/TapAHsGr0i3vunGsm2Eo79
	pUyf4pIMdJ20S1n/lX+ajGUPDzWlwSlojFRFMt0dkGypNjb1iAOe4z6gG/bljyOrj6kEOZZvKEmUb
	6nts4Gj0izZW2b8n4sw7EwmFR7ErhETxO5E1I9njDV2yMe1uyUzR9I17peqbeRGTVcwLCwY+1/Pw6
	IAH2DuIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdRVk-0000000EoJz-30XO;
	Wed, 07 Jan 2026 11:15:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdRVb-0000000EoHg-0Vfk
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 11:15:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E0DF33D89;
	Wed,  7 Jan 2026 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767784517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJHfC7iSyYI+8Xh6ofHAXqAk33v2C+F4NO+ud+3Hn4=;
	b=Xt2Q41IZQJ/HDTuPGBOvK523D9oRFQysgQqpGc5sEW3IC7OqwLkFYh2glRuZ3uwAXBbDWZ
	/SdosPblB/VyVgk2M/68XjFMWO9+o6tIJSruc6Hf3BPvdaImJmNTXAVa9Z3TStP3vChYa6
	CSV+9wVq8qg/aKyKlBeT8TaIsV0QVfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767784517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJHfC7iSyYI+8Xh6ofHAXqAk33v2C+F4NO+ud+3Hn4=;
	b=bTBwjljJ/TXSYgVSultcIBwZatTO3LqzKG736PPm0godqLtvWy9dcXHlBQQz0Ml30KXlI+
	fE8F1HGl6wWS8kCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xt2Q41IZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bTBwjljJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767784517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJHfC7iSyYI+8Xh6ofHAXqAk33v2C+F4NO+ud+3Hn4=;
	b=Xt2Q41IZQJ/HDTuPGBOvK523D9oRFQysgQqpGc5sEW3IC7OqwLkFYh2glRuZ3uwAXBbDWZ
	/SdosPblB/VyVgk2M/68XjFMWO9+o6tIJSruc6Hf3BPvdaImJmNTXAVa9Z3TStP3vChYa6
	CSV+9wVq8qg/aKyKlBeT8TaIsV0QVfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767784517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJHfC7iSyYI+8Xh6ofHAXqAk33v2C+F4NO+ud+3Hn4=;
	b=bTBwjljJ/TXSYgVSultcIBwZatTO3LqzKG736PPm0godqLtvWy9dcXHlBQQz0Ml30KXlI+
	fE8F1HGl6wWS8kCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31B713EA63;
	Wed,  7 Jan 2026 11:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cf7MCkVAXmncBQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 Jan 2026 11:15:17 +0000
Message-ID: <e29303e7-b9be-4b49-a607-37bfc25173da@suse.de>
Date: Wed, 7 Jan 2026 12:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, dwagner@suse.de, axboe@kernel.dk,
 kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
 <abe16085-f0dd-4f82-b48c-f2eb125da2ee@linux.ibm.com>
 <7358ab3b-b04c-4451-85b0-5bb8073f7134@grimberg.me>
 <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
 <afcc3e2b-0317-42c0-8968-ed771ac6af14@suse.de>
 <03a08de2-07af-43f9-8d68-f5ef6b048536@linux.ibm.com>
 <37a61dbc-7d5e-4f28-b6cf-5c5c21e9cdbb@grimberg.me>
 <81d9feb1-9134-464c-9c4e-393694732426@linux.ibm.com>
 <b98e91ef-254c-44bc-b46a-0039c66539e2@grimberg.me>
 <c8fa5728-5ee1-4f79-b288-71edcefe135d@linux.ibm.com>
 <ccc78156-8969-486d-b1e9-3ed7f05b668d@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ccc78156-8969-486d-b1e9-3ed7f05b668d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6E0DF33D89
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_031523_334572_F7B0AEED 
X-CRM114-Status: GOOD (  19.11  )
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

On 1/4/26 22:06, Sagi Grimberg wrote:
> 
> 
> On 04/01/2026 11:07, Nilay Shroff wrote:
>>
>> On 12/27/25 3:07 PM, Sagi Grimberg wrote:
>>>>> Can you please run benchmarks with `blocksize_range`/`bssplit`/ 
>>>>> `cpuload`/`cpuchunks`/`cpumode` ?
>>>> Okay, so I ran the benchmark using bssplit, cpuload, and cpumode. 
>>>> Below is the job
>>>> file I used for the test, followed by the observed throughput result 
>>>> for reference.
>>>>
>>>> Job file:
>>>> =========
>>>>
>>>> [global]
>>>> time_based
>>>> runtime=120
>>>> group_reporting=1
>>>>
>>>> [cpu]
>>>> ioengine=cpuio
>>>> cpuload=85
>>>> cpumode=qsort
>>>> numjobs=32
>>>>
>>>> [disk]
>>>> ioengine=io_uring
>>>> filename=/dev/nvme1n2
>>>> rw=<randread/randwrite/randrw>
>>>> bssplit=4k/10:32k/10:64k/10:128k/30:256k/10:512k/30
>>>> iodepth=32
>>>> numjobs=32
>>>> direct=1
>>>>
>>>> Throughput:
>>>> ===========
>>>>
>>>>            numa          round-robin   queue-depth    adaptive
>>>>            -----------   -----------   -----------    ---------
>>>> READ:    1120 MiB/s    2241 MiB/s    2233 MiB/s     2215 MiB/s
>>>> WRITE:   1107 MiB/s    1875 MiB/s    1847 MiB/s     1892 MiB/s
>>>> RW:      R:1001 MiB/s  R:1047 MiB/s  R:1086 MiB/s   R:1112 MiB/s
>>>>            W:999  MiB/s  W:1045 MiB/s  W:1084 MiB/s   W:1111 MiB/s
>>>>
>>>> When comparing the results, I did not observe a significant throughput
>>>> difference between the queue-depth, round-robin, and adaptive policies.
>>>> With random I/O of mixed sizes, the adaptive policy appears to average
>>>> out the varying latency values and distribute I/O reasonably evenly
>>>> across the active paths (assuming symmetric paths).
>>>>
>>>> Next I'd implement I/O size buckets and also per-numa node weight and
>>>> then rerun tests and share the result. Lets see if these changes help
>>>> further improve the throughput number for adaptive policy. We may then
>>>> again review the results and discuss further.
>>>>
>>>> Thanks,
>>>> --Nilay
>>> two comments:
>>> 1. I'd make reads split slightly biased towards small block sizes, 
>>> and writes biased towards larger block sizes
>>> 2. I'd also suggest to measure having weights calculation averaged 
>>> out on all numa-node cores and then set percpu (such that
>>> the datapath does not introduce serialization).
>> Thanks for the suggestions. I ran experiments incorporating both points—
>> biasing I/O sizes by operation type and comparing per-CPU vs per-NUMA
>> weight calculation—using the following setup.
>>
>> Job file:
>> =========
>> [global]
>> time_based
>> runtime=120
>> group_reporting=1
>>
>> [cpu]
>> ioengine=cpuio
>> cpuload=85
>> numjobs=32
>>
>> [disk]
>> ioengine=io_uring
>> filename=/dev/nvme1n1
>> rw=<randread/randwrite/randrw>
>> bssplit=<based-on-I/O-pattern-type>[1]
>> iodepth=32
>> numjobs=32
>> direct=1
>> ==========
>>
>> [1] Block-size distributions:
>>      randread  => bssplit = 512/30:4k/25:8k/20:16k/15:32k/10
>>      randwrite => bssplit = 4k/10:64k/20:128k/30:256k/40
>>      randrw    => bssplit = 512/20:4k/25:32k/25:64k/20:128k/5:256k/5
>>
>> Results:
>> =======
>>
>> i) Symmetric paths + system load
>>     (CPU stress using cpuload):
>>
>>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO- 
>> buckets
>>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>>           -------   -------------------      --------   
>> -------------------
>> READ:    636          621                   613           618
>> WRITE:   1832         1847                  1840          1852
>> RW:      R:872        R:869                 R:866         R:874
>>           W:872        W:870                 W:867         W:876
>>
>> ii) Asymmetric paths + system load
>>     (CPU stress using cpuload and iperf3 traffic for inducing network 
>> congestion):
>>
>>           per-CPU   per-CPU-IO-buckets       per-NUMA   per-NUMA-IO- 
>> buckets
>>           (MiB/s)         (MiB/s)             (MiB/s)        (MiB/s)
>>           -------   -------------------      --------   
>> -------------------
>> READ:    553          543                   540           533
>> WRITE:   1705         1670                  1710          1655
>> RW:      R:769        R:771                 R:784         R:772
>>           W:768        W:767                 W:785         W:771
>>
>>
>> Looking at the above results,
>> - Per-CPU vs per-CPU with I/O buckets:
>>    The per-CPU implementation already averages latency effectively 
>> across CPUs.
>>    Introducing per-CPU I/O buckets does not provide a meaningful 
>> throughput
>>    improvement and remains largely comparable.
>>
>> - Per-CPU vs per-NUMA aggregation:
>>    Calculating or averaging weights at the NUMA level does not 
>> significantly
>>    improve throughput over per-CPU weight calculation. Across both 
>> symmetric
>>    and asymmetric scenarios, the results remain very close.
>>
>> So now based on above results and assessment, unless there are additional
>> scenarios or metrics of interest, shall we proceed with per-CPU weight
>> calculation for this new I/O policy?
> 
> I think it is counter intuitive that bucketing I/O sizes does not 
> present any advantage. Don't you?
> Maybe the test is not good enough of a representation...
> 
> Lets also test what happens with multiple clients against the same 
> subsystem.

I am not sure if focussing on NUMA nodes will bring us an advantage 
here. NUMA nodes would present an advantage if we can keep I/Os to
different controllers on different NUMA nodes; but with TCP this
is rarely possible (just think of two connections to different
controllers via the same interface ...), so I really think we
should keep the counters per-cpu.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

