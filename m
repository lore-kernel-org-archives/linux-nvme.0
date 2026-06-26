Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8C4CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kgw24C4u1dXREp3P602ZAvTMwqRZ4MfmUIn0C4brfVA=; b=V5p88MuvdjdQtsvi9tCTXFVmf/
	RFXg8t3c9vuxlOU3bGvhtgfz9J5Z+uXSZdbihMfqwWLo88vZ6FWDJ5ZZqB13NgQ6HpSqcgRhBYopt
	4kWqTna75fL6ZbmUabCcubMwEifnOpmnFxAJS3x1bFdk2GTVFlQ1WjViGw+20nE6ptyDeEcPR2eiK
	G1d/M6NcvtCK/jU29Q59cUctdQZDlrtf6nbojHgqKkUrllahGrqsGZ6ggEp6COjMUqdc9gbhYZd3X
	wWfAWHRmEoo/ns1ImD0pMcDZ5S+dTzjKNy86LnyrEqGFKeh77OkdA2L6sES4FrAKZLobuQaC/SSvX
	U1UgRdxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0ES-0000000Abob-3Zn3;
	Fri, 26 Jun 2026 06:40:08 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0EP-0000000Abo0-3u9Q
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:40:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FB0275B30;
	Fri, 26 Jun 2026 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782456002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgw24C4u1dXREp3P602ZAvTMwqRZ4MfmUIn0C4brfVA=;
	b=JMM9xb+NNhx0v5VYAgcjfCUzG/bnibKHLf5OUmp+Qd0QY9MpXh4+ISpk8sEmxzx85tbqvw
	uIp7gB0HrRiSk5UqhPPJPL71FYtzFBN7baeAOQZBNe8MKNorNN9aQH4mGk+gW5o9Qnqa+N
	fY+z+WX58bgHZXq3eitdywsCETOL7IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782456002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgw24C4u1dXREp3P602ZAvTMwqRZ4MfmUIn0C4brfVA=;
	b=cVg1mM0AooVh5RYBuXkW4VAOsQ4+juBWEGBmTvr04WyUgEiuO4QAIbLiUm1zpA0JClhAqz
	8Fb5HzzXTFDWdaBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782456002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgw24C4u1dXREp3P602ZAvTMwqRZ4MfmUIn0C4brfVA=;
	b=JMM9xb+NNhx0v5VYAgcjfCUzG/bnibKHLf5OUmp+Qd0QY9MpXh4+ISpk8sEmxzx85tbqvw
	uIp7gB0HrRiSk5UqhPPJPL71FYtzFBN7baeAOQZBNe8MKNorNN9aQH4mGk+gW5o9Qnqa+N
	fY+z+WX58bgHZXq3eitdywsCETOL7IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782456002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kgw24C4u1dXREp3P602ZAvTMwqRZ4MfmUIn0C4brfVA=;
	b=cVg1mM0AooVh5RYBuXkW4VAOsQ4+juBWEGBmTvr04WyUgEiuO4QAIbLiUm1zpA0JClhAqz
	8Fb5HzzXTFDWdaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCAB7779A8;
	Fri, 26 Jun 2026 06:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RHZ5MMEePmqUIAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 26 Jun 2026 06:40:01 +0000
Message-ID: <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de>
Date: Fri, 26 Jun 2026 08:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_blktests_nvme/062_lockdep_=E2=80=94_defer_TLS_inlin?=
 =?UTF-8?Q?e_send_to_io=5Fwork=3F?=
To: Xixin Liu <liuxixin@kylinos.cn>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 shinichiro.kawasaki@wdc.com
References: <ajtk1CaN1pBreS4O@shinmob>
 <cover.1782436781.git.liuxixin@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cover.1782436781.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234006_273396_5E0C6583 
X-CRM114-Status: GOOD (  19.96  )
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

On 6/26/26 3:19 AM, Xixin Liu wrote:
> Hi,
> 
> I'm looking at the nvme/062 failure Shinichiro reported on linux-7.1.y
> (PROVE_LOCKING=y, blktests v5a62429536b1) and would like to sanity-check
> a fix direction before sending a formal patch.
> 
> Link: https://lore.kernel.org/linux-nvme/ajtk1CaN1pBreS4O@shinmob/T/
> 
> Problem (reproduced on linux-next, same test)
> ---------------------------------------------
> With PROVE_LOCKING=y, nvme/062 (TLS connect) fails with dmesg:
> 
>    WARNING: possible circular locking dependency detected
>    ...
>    tx_lock (tls_sw_sendmsg)
>    ...
>    &set->srcu (blk_mq / kblockd context)
> 
> The #0 stack is nvme_tcp_queue_request() doing an inline nvme_tcp_send_all()
> from queue_rq, which calls tls_sw_sendmsg() while blk_mq still holds srcu.
> Lockdep already knows tx_lock -> elevator_lock -> srcu, so the reverse
> order triggers the cycle.
> 
> Teardown fixes (__fput_sync, memalloc_noio_save, 26bb12b9caaf) are already
> present in current trees; 062 still fails — this looks like the TLS send
> path on top of blk_mq, not the disconnect/teardown chain.
> 
> Proposed fix (one line + comment)
> ---------------------------------
> Skip the queue_rq inline-send optimization when nvme_tcp_queue_tls(queue):
> 
>    if (queue->io_cpu == raw_smp_processor_id() &&
>        !nvme_tcp_queue_tls(queue) &&
>        empty && mutex_trylock(&queue->send_mutex)) {
>            nvme_tcp_send_all(queue);
>            ...
>    }
> 
> TLS traffic would always go through nvme_tcp_io_work on nvme_tcp_wq (same
> as write_space / backpressure paths already do).  Lab check: nvme/062
> passes, no lockdep splat in dmesg.
> 
> Does skipping inline send for TLS queues (plain TCP unchanged) look like a
> reasonable fix to you?  I can post [PATCH] if this direction sounds OK.
> 

I always found the call to nvme_tcp_send_all() a bit questionable here. 
Technically we should be submitting the first PDU of the request only; 
with the current setup we'll be sending the first PDU of this request
_and_ all other requests which might be added to the queue while we've
been sending.
That causes quite some unfairness in I/O submission, and play
havoc for someone trying to do QoS here.

One could try to use 'nvme_tcp_try_send()' instead of 
'nvme_tcp_try_send_all()',  but not sure if that would
help for the lockdep splat.

You could remove that call (it's an optimisation, after all),
but that might cause a latency degradation.
So if you do that please run some performance testing to check
if the latency is affected?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

