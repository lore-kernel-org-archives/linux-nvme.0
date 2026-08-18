Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1399AC5DF7E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+h76SczwQI0wRkgQOEY3gW6LMvOcWOp7NiG6KQQS8C0=; b=mtnm7r6aZa7uzaQcw/DkzM9evf
	XNRqtgWwOT8TLnAWh0sKuSIMpTbOOSgqobjH/WJ98fGwT008So+XFThkx3nSrC3aIF32Ki/c/t6Mu
	e+K9SG6UoWzV54K1nm7D4OZl55IQFRZEC7wT2tc+vAsI/pVg4bmHkVQ2sPhH4wrdvaKsXGLcLEdEt
	iiJv7ICiU5xfGxyV2PKD+rCyWwXvcUMuQTL+/VipTBd/5Rcryn7fzgMS4xNj7ISVoUOVVzALqjbvp
	7yHIEsjfytmGzEJcQk5BJa/FFcBk5R7JllgCLtc+Emk40m1CXlWGI4NJCZpQbOkPyBQxGpf6PVcB4
	43Jqt0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ1v-00000007vxY-0Qk6;
	Tue, 18 Aug 2026 12:34:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ1s-00000007vx0-2tBB
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 12:34:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 846823E48;
	Tue, 18 Aug 2026 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787056490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h76SczwQI0wRkgQOEY3gW6LMvOcWOp7NiG6KQQS8C0=;
	b=xYRoLU5r3Sb480WzLqx8R8p6SZphSTe2wbcLR8KkCYJNjggEYbhxL/sBnUg44tsY1jEYvU
	orvoIf9Rvz22RnoerGFrm3Yz52DuMKxHrPUau8zTZO7R6qMnmg4h4NwPICRNPFq988/uB7
	O/dJFbWlhLFenWN49dOhhimY9oFuvhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787056490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h76SczwQI0wRkgQOEY3gW6LMvOcWOp7NiG6KQQS8C0=;
	b=ezADmAkIPi+JJZJMK+hgDFO6CMBv22T5oYodjlBmwY4x4cgRdiKzVxDDnkx/1yghDiL9qf
	D9K6W5RiNu8hQyBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787056486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h76SczwQI0wRkgQOEY3gW6LMvOcWOp7NiG6KQQS8C0=;
	b=f7r/ozKWhtAvmWjnwbr1IodAzoRbEnrl94yiJc0y95NG8J7mrbbB/keihoR/zJ/8dd2Mvg
	Una/bce20BViKC7nbdvhnZl4g4eTjS5I+8wJ0wZ+mMimZdysYWOhmE74M6Ey5tg07TCk0K
	aY/J40PCW3/rbb5I2AQY5ZfUXv4xBRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787056486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h76SczwQI0wRkgQOEY3gW6LMvOcWOp7NiG6KQQS8C0=;
	b=DeO6VeI9PvD23Wo6GHrCvmTTciao7aqq8hJA+4UXaAwFTpwKykFsZgccQK1t/3r6Gh3RaP
	4+shQJsyHyCsHqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51240362E;
	Tue, 18 Aug 2026 12:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A0MXE2ZRhGqAEQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Aug 2026 12:34:46 +0000
Message-ID: <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de>
Date: Tue, 18 Aug 2026 14:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_blktests_nvme/062_lockdep_=E2=80=94_defer_TLS_inlin?=
 =?UTF-8?Q?e_send_to_io=5Fwork=3F?=
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Xixin Liu <liuxixin@kylinos.cn>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <ajtk1CaN1pBreS4O@shinmob>
 <cover.1782436781.git.liuxixin@kylinos.cn>
 <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de>
 <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
 <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn>
 <aoPuIUSQvZxujmv7@shinhome>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aoPuIUSQvZxujmv7@shinhome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_053456_873535_D81C817A 
X-CRM114-Status: GOOD (  20.04  )
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

On 8/18/26 7:38 AM, Shin'ichiro Kawasaki wrote:
> On Jul 01, 2026 / 09:50, Xixin Liu wrote:
>> Hi Hannes,
>>
>> On Mon, 29 Jun 2026, Hannes Reinecke wrote:
>>> The most likely testcase showing regressions would be having as many
>>> jobs as your machine has CPUs and use qd=1.
>>> Just a single job will not be enough to show a noticeable difference.
>>
>> I re-ran the TLS perf comparison with one job per CPU and queue depth 1
>> on a new test host.  Please treat the results below as the authoritative
>> perf data for this workload.
>>
>> Test setup
>> ----------
>>    aarch64 server, 128 CPUs, linux-next 7.2.0-rc1-*-perf-dirty
>>
>>    Same-machine nvmet-tcp with TLS; target backing store is a 32G file on a
>>    local NVMe SSD.  fio runs against the connected nvme-tcp namespace.
>>
>>    Compared inline send_all (baseline) vs deferring TLS inline send (io_work).
>>    fio randwrite 4k, direct I/O, 30s per run, 15s warmup discarded before
>>    each mode (10 runs total):
>>
>>    - iodepth=1, numjobs=128:
>>        baseline 54539.4 IOPS, mean 2.34ms, p99 6.02ms
>>        patched  54529.0 IOPS, mean 2.34ms, p99 5.99ms
>>
>>    - iodepth=128, numjobs=8:
>>        baseline 54632.6 IOPS, mean 18.74ms, p99 47.08ms
>>        patched  54633.6 IOPS, mean 18.74ms, p99 46.92ms
>>
>> So on a 128-CPU box with the workload you called out, deferring TLS inline
>> send still looks neutral across 10 consecutive runs after warmup.
> 
> Xixin, thank you for the effort. The nvme/062 lockdep WARN still exists with
> v7.2 kernel. Per your suggestion, I applied the patch below [*] on top of v7.2
> kernel, and confirmed the nvme/062 goes away. This is great from blktests user
> point of view.
> 
> Hannes, Xixin provided the latency numbers above. Are they enough to show no
> impact of the fix patch? Or do you think more workload variations should be
> covered?
> 
> 
> [*] trial patch
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..122d815270b9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -411,6 +411,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   	 * are on the same cpu, so we don't introduce contention.
>   	 */
>   	if (queue->io_cpu == raw_smp_processor_id() &&
> +	    !nvme_tcp_queue_tls(queue) &&
>   	    empty && mutex_trylock(&queue->send_mutex)) {
>   		nvme_tcp_send_all(queue);
>   		mutex_unlock(&queue->send_mutex);

I actually thought we could do away with this 'if' condition completely.
But that I guess requires more analysis. So for now:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Can you send a formal patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

