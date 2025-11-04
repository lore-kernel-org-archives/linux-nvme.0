Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A246ECCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWLSGlxzsX7f5WHL9BQun+aJuLqBVxYOuEaZFUBIfwQ=; b=K2PHXMksdD5fdaGIleivr1yNh5
	UGRRoYnQVEUvdVEBwIRR5DXbGFW9L5bHUFTpFCYwzXadrSyPVFYrLQikXQAQqGArkNJpgrplYYdL3
	e9zS1RFQTggBooQRID0QLf/PC2sZhCW20wrDMMjL+INrRKUIjPDaZT9LFW6o+pD5cPF9H5olZu4S6
	QowLqlSkk0Tvay0uMHdIuTagri1oaEV7lA7cojt1t16k8bGOPRWTS1pWgZ+JxZrslPuaQVHiMXKRc
	0wt75YxC2Qxe2b8SeIoVTe6/pMPrG11McUfx3n2S83J7xkY/8JxT39ZiCWQv63BiPayA6LllbNsMo
	ap+gKl4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGITR-0000000C0qC-42Km;
	Tue, 04 Nov 2025 14:57:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGITQ-0000000C0pf-1I5r
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 14:57:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E455B1F387;
	Tue,  4 Nov 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762268245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWLSGlxzsX7f5WHL9BQun+aJuLqBVxYOuEaZFUBIfwQ=;
	b=yzG2+kx4yQrPilrcdOzXc35KjErOn3G3Dibn+OL0BNr7pdRKQWsqJsWVF5OHJNBWLnqT5I
	u947LYxBW4DY/o6GM8uO0jG3CB3MAJKtB6DOeaBdS/3p79O5EAtvz7+9CGMTjfEY+VQnhl
	pjFM2JwFdUcsm3Q2HU7k1aPuMqS9BU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762268245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWLSGlxzsX7f5WHL9BQun+aJuLqBVxYOuEaZFUBIfwQ=;
	b=PiGa27f57XxicoBjB4820n7d4FMnD95fMUTSXo2O5/Y+/xy1Ndo4s4tS4xzYHUl3o0ojKS
	36JCYF5yGbpe/tCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762268244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWLSGlxzsX7f5WHL9BQun+aJuLqBVxYOuEaZFUBIfwQ=;
	b=HoUBDhxpU1ggEs4ZAGaPVZPiFOALDpqElLzI+0bc05ClQd6/bimUYR0TGaHMQG5vtzQ+dv
	ub+pbnN+EeHXNuw0qNjXV5PYHJOX8R566UrkvGSeVkkWsNqG3CjyQzFa77Wl2FZ9VFR+81
	yi8JOYeQtU/HdM91LjS/YVw8GZmQDAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762268244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWLSGlxzsX7f5WHL9BQun+aJuLqBVxYOuEaZFUBIfwQ=;
	b=TBRhIB0qbNBU/eA1dfltQybtBR+Er1N4xFFRAfKrTRLRAQjjVttqF51Fj+fi3PB7cnXJYH
	wfVr8MKwP6KcyHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8EDC139A9;
	Tue,  4 Nov 2025 14:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 33a3LFQUCmnuaQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 14:57:24 +0000
Message-ID: <b07e9fa2-1f7a-47b5-bbd0-9d8d3d35d8ba@suse.de>
Date: Tue, 4 Nov 2025 15:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv4 2/6] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, dwagner@suse.de,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20251104104533.138481-1-nilay@linux.ibm.com>
 <20251104104533.138481-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104104533.138481-3-nilay@linux.ibm.com>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_065728_521450_BB31D1D1 
X-CRM114-Status: GOOD (  16.53  )
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

On 11/4/25 11:45, Nilay Shroff wrote:
> This commit introduces a new I/O policy named "adaptive". Users can
> configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
> subsystemX/iopolicy"
> 
> The adaptive policy dynamically distributes I/O based on measured
> completion latency. The main idea is to calculate latency for each path,
> derive a weight, and then proportionally forward I/O according to those
> weights.
> 
> To ensure scalability, path latency is measured per-CPU. Each CPU
> maintains its own statistics, and I/O forwarding uses these per-CPU
> values. Every ~15 seconds, a simple average latency of per-CPU batched
> samples are computed and fed into an Exponentially Weighted Moving
> Average (EWMA):
> 
> avg_latency = div_u64(batch, batch_count);
> new_ewma_latency = (prev_ewma_latency * (WEIGHT-1) + avg_latency)/WEIGHT
> 
> With WEIGHT = 8, this assigns 7/8 (~87.5%) weight to the previous
> latency value and 1/8 (~12.5%) to the most recent latency. This
> smoothing reduces jitter, adapts quickly to changing conditions,
> avoids storing historical samples, and works well for both low and
> high I/O rates. Path weights are then derived from the smoothed (EWMA)
> latency as follows (example with two paths A and B):
> 
>      path_A_score = NSEC_PER_SEC / path_A_ewma_latency
>      path_B_score = NSEC_PER_SEC / path_B_ewma_latency
>      total_score  = path_A_score + path_B_score
> 
>      path_A_weight = (path_A_score * 100) / total_score
>      path_B_weight = (path_B_score * 100) / total_score
> 
> where:
>    - path_X_ewma_latency is the smoothed latency of a path in nanoseconds
>    - NSEC_PER_SEC is used as a scaling factor since valid latencies
>      are < 1 second
>    - weights are normalized to a 0–64 scale across all paths.
> 
> Path credits are refilled based on this weight, with one credit
> consumed per I/O. When all credits are consumed, the credits are
> refilled again based on the current weight. This ensures that I/O is
> distributed across paths proportionally to their calculated weight.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  15 +-
>   drivers/nvme/host/ioctl.c     |  31 ++-
>   drivers/nvme/host/multipath.c | 425 ++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  74 +++++-
>   drivers/nvme/host/pr.c        |   6 +-
>   drivers/nvme/host/sysfs.c     |   2 +-
>   6 files changed, 530 insertions(+), 23 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

