Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99DCF9B61D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBPWIf+cB4XheXhYFMUXun2C/zKcVN0FlLMQ9xx+r0o=; b=ixywBv/FlAFogShrZCYLeEBQae
	u0rYCyvjCwjYyza74Mgbv9kgAxuHi+2Nq5UFybWRM2ZD6YdEMJOU8NmqGo3t6Cn7s9cpQ1kTdGKBX
	Mv9wtP6NzWogZLx0YZT1OBYvrnq/qFNqC25pnAQ7/nlWgF7uqwBEWR9CP6x7rBhx/SM4bwYPsJReN
	RNmpzyhfOdpLcfrwq4EVkp8Q9+mopVgHkKYDgsFs9VmoljOkmtwgl8uOs69CHKowv/PfyCwwZAeQX
	jCqjsAkg9Q455GdoV8ezR9L+NcrhnzAfE6E92VhvkQQFWY0Bugoc69fert2YghsqfAtzZrE3uu/B/
	LThXnLbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFVTI-00000009yvt-160p;
	Wed, 22 Apr 2026 11:10:20 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFVTF-00000009yvC-2G6T
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 11:10:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6614C5BD33;
	Wed, 22 Apr 2026 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776856214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBPWIf+cB4XheXhYFMUXun2C/zKcVN0FlLMQ9xx+r0o=;
	b=ABVMD65Cru2GMIwcPUxwKyuwVtUSfgR/dkkpkt7piz83q3wkYFXwDNscJb8E283X+hSteM
	Bp/G64bPD6kqs2MtGb0xOnThc8qE+PJgk9KKTf+GzqYwlxvmSrRVbJ1CMYBI8mQ//JGhcq
	Y0dGRTkyol+WupVHhE0hAuznou50/pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776856214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBPWIf+cB4XheXhYFMUXun2C/zKcVN0FlLMQ9xx+r0o=;
	b=fSVdK8jaj0CgwoF+JgONZc1VnEDMEKEyNZV4HM/Kn7pjixiWKF9P1X1At/73lLxufRAMeM
	G4HL6WlXE2apyPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776856214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBPWIf+cB4XheXhYFMUXun2C/zKcVN0FlLMQ9xx+r0o=;
	b=ABVMD65Cru2GMIwcPUxwKyuwVtUSfgR/dkkpkt7piz83q3wkYFXwDNscJb8E283X+hSteM
	Bp/G64bPD6kqs2MtGb0xOnThc8qE+PJgk9KKTf+GzqYwlxvmSrRVbJ1CMYBI8mQ//JGhcq
	Y0dGRTkyol+WupVHhE0hAuznou50/pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776856214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBPWIf+cB4XheXhYFMUXun2C/zKcVN0FlLMQ9xx+r0o=;
	b=fSVdK8jaj0CgwoF+JgONZc1VnEDMEKEyNZV4HM/Kn7pjixiWKF9P1X1At/73lLxufRAMeM
	G4HL6WlXE2apyPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F3ED593B0;
	Wed, 22 Apr 2026 11:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a2KiEpas6GkFHQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 22 Apr 2026 11:10:14 +0000
Message-ID: <649036dd-b99f-4f60-93f4-16979e11f520@suse.de>
Date: Wed, 22 Apr 2026 13:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] nvme-tcp: NIC topology aware I/O queue scaling
 and queue info export
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260420115716.3071293-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_041017_729355_4D91A5DF 
X-CRM114-Status: GOOD (  21.28  )
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

On 4/20/26 13:49, Nilay Shroff wrote:
> Hi,
> 
> The NVMe/TCP host driver currently provisions I/O queues primarily based
> on CPU availability rather than the capabilities and topology of the
> underlying network interface.
> 
> On modern systems with many CPUs but fewer NIC hardware queues, this can
> lead to multiple NVMe/TCP I/O workers contending for the same TX/RX queue,
> resulting in increased lock contention, cacheline bouncing, and degraded
> throughput.
> 
> This RFC proposes a set of changes to better align NVMe/TCP I/O queues
> with NIC queue resources, and to expose queue/flow information to enable
> more effective system-level tuning.
> 
> Key ideas
> ---------
> 
> 1. Scale NVMe/TCP I/O queues based on NIC queue count
>     Instead of relying solely on CPU count, limit the number of I/O workers
>     to:
>         min(num_online_cpus, netdev->real_num_{tx,rx}_queues)
> 
> 2. Improve CPU locality
>     Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ affinity
>     to reduce cross-CPU traffic and improve cache locality.
> 
> 3. Expose queue and flow information via debugfs
>     Export per-I/O queue information including:
>         - queue id (qid)
>         - CPU affinity
>         - TCP flow (src/dst IP and ports)
> 
>     This enables userspace tools to configure:
>         - IRQ affinity
>         - RPS/XPS
>         - ntuple steering
>         - or any other scaling as deemed feasible
> 
> 4. Provide infrastructure for extensible debugfs support in NVMe
> 
> Together, these changes allow better alignment of:
>      flow -> NIC queue -> IRQ -> CPU -> NVMe/TCP I/O worker
> 
> Performance Evaluation
> ----------------------
> Tests were conducted using fio over NVMe/TCP with the following parameters:
>      ioengine=io_uring
>      direct=1
>      bs=4k
>      numjobs=<#nic-queues>
>      iodepth=64
> System:
>      CPUs: 72
>      NIC: 100G mlx5
> 
> Two configurations were evaluated.
> 
> Scenario 1: NIC queues < CPU count
> ----------------------------------
> - CPUs: 72
> - NIC queues: 32
> 
>                  Baseline        Patched        Patched + tuning
> randread        3141 MB/s       3228 MB/s      7509 MB/s
>                  (767k IOPS)     (788k IOPS)    (1833k IOPS)
> 
> randwrite       4510 MB/s       6172 MB/s      7518 MB/s
>                  (1101k IOPS)    (1507k IOPS)   (1836k IOPS)
> 
> randrw (read)   2156 MB/s       2560 MB/s      3932 MB/s
>                  (526k IOPS)     (625k IOPS)    (960k IOPS)
> 
> randrw (write)  2155 MB/s       2560 MB/s      3932 MB/s
>                  (526k IOPS)     (625k IOPS)    (960k IOPS)
> 
> Observation:
> When CPU count exceeds NIC queue count, the baseline configuration
> suffers from queue contention. The proposed changes provide modest
> improvements on their own, and when combined with queue-aware tuning
> (IRQ affinity, ntuple steering, and CPU alignment), enable up to
> ~1.5x–2.5x throughput improvement.
> 
> Scenario 2: NIC queues == CPU count
> -----------------------------------
> 
> - CPUs: 72
> - NIC queues: 72
> 
>                  Baseline                Patched + tuning
> randread        4310 MB/s               7987 MB/s
>                  (1052k IOPS)            (1950k IOPS)
> 
> randwrite       7947 MB/s               7972 MB/s
>                  (1940k IOPS)            (1946k IOPS)
> 
> randrw (read)   3583 MB/s               4030 MB/s
>                  (875k IOPS)             (984k IOPS)
> 
> randrw (write)  3583 MB/s               4029 MB/s
>                  (875k IOPS)             (984k IOPS)
> 
> Observation:
> When NIC queues are already aligned with CPU count, the baseline performs
> well. The proposed changes maintain write performance (no regression) and
> still improve read and mixed workloads due to better flow-to-CPU locality.
> 
> Notes on tuning
> ---------------
> The "patched + tuning" configuration includes:
>      - aligning NVMe/TCP I/O workers with NIC queue count
>      - IRQ affinity configuration per RX queue
>      - ntuple-based flow steering
>      - CPU/queue affinity alignment
> 
> These tuning steps are enabled by the queue/flow information exposed through
> this patchset.
> 
> Discussion
> ----------
> This RFC aims to start discussion around:
>    - Whether NVMe/TCP queue scaling should consider NIC queue topology
>    - How best to expose queue/flow information to userspace
>    - The role of userspace vs kernel in steering decisions
> 
> As usual, feedback/comment/suggestions are most welcome!
> 
> Reference to LSF/MM/BPF abstarct: https://lore.kernel.org/all/5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com/
> 

Weelll ... we have been debating this back and forth over recent years:
Should we check for hardware limitations for NVMe-over-Fabrics or not?

Initially it sounds appealing, and in fact I've worked on several 
attempts myself. But in the end there are far more things which need
to be considered:
-> For networking, number of queues is not really telling us anything.
    Most NICs have distinct RX and TX queues, and the number (of both!)
    varies quite dramatically.
-> The number of queues does _not_ indicate that all queues are used
    simultaneously. That is down to things like RSS and friends.
    I gave a stab at configuring _that_ but it's patently horrible
    trying to out-guess things for yourself.
-> It'll only work if you run directly on the NIC. As soon as there
    is anything in between (qemu? Tunnelling?) you are out of luck.

So yeah, we should have a discussion here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

