Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1A9CCA476
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 06:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCs4/10jZWIewI6q7PY6opm0f/ZX2iCX2X3Rct1nl+o=; b=3tpBOgpuaKRgKxFoF2GBdhnm8V
	UEOKcji0eGCyJ909FO3MIByyHoTtQD+nYHl5Ri94pvRMc4JpGVZ6/o2D/lAOJ+9mM+f7JexjLZIph
	E4rGf2JscDKR8N0uPMK89lvaV628Satr5cqEdWjCPTGqgqzPZw1K3GE0LALZAfn6HEa0yXuB4l3pf
	CUaKrvCZqXj35dLPjPcVGYtVIwdvmA3YzFAeHQnyCsf2bQT9XNXC3TPnbGk8yyENu+fGYfitrfR2d
	ORdElwcAbkR/kfPXvy68ysH3Wo3DBWPBxCurYDtyNZLXxG6Nsq2EavclO/r/h9oqKNr2fXzaPS8Mq
	wjQ2YpPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8C7q-0000000CPJM-2M6m;
	Mon, 13 Oct 2025 06:33:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8C7o-0000000CPHz-0Qy3
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 06:33:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7735E1F460;
	Mon, 13 Oct 2025 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760337218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCs4/10jZWIewI6q7PY6opm0f/ZX2iCX2X3Rct1nl+o=;
	b=kukHxyOWeMx6ftEO15foZhS/9LWtrNKe1lmNsAANBAzhiK+/RrJaqT+1b7/U5gyCsWtu8v
	Kc15WQiK7yKag0M5sWXzyP4IGyPzt3ZNYHpZK0sYAtg5P8z2AapbU1xpDYvs8V3JnaZB4q
	j0ZWmXU8o+3/yQETsM54gMVCORSKtWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760337218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCs4/10jZWIewI6q7PY6opm0f/ZX2iCX2X3Rct1nl+o=;
	b=tl9nUXmkqKPMZUraOTrE5tU1OPiv3E82pLDQaoIsKIsxNf8TenhgAefHCK0EI/05OXzNFx
	BDaYwDra6J16dpBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kukHxyOW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tl9nUXmk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760337218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCs4/10jZWIewI6q7PY6opm0f/ZX2iCX2X3Rct1nl+o=;
	b=kukHxyOWeMx6ftEO15foZhS/9LWtrNKe1lmNsAANBAzhiK+/RrJaqT+1b7/U5gyCsWtu8v
	Kc15WQiK7yKag0M5sWXzyP4IGyPzt3ZNYHpZK0sYAtg5P8z2AapbU1xpDYvs8V3JnaZB4q
	j0ZWmXU8o+3/yQETsM54gMVCORSKtWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760337218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCs4/10jZWIewI6q7PY6opm0f/ZX2iCX2X3Rct1nl+o=;
	b=tl9nUXmkqKPMZUraOTrE5tU1OPiv3E82pLDQaoIsKIsxNf8TenhgAefHCK0EI/05OXzNFx
	BDaYwDra6J16dpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 384BC13874;
	Mon, 13 Oct 2025 06:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mmH1C0Kd7GgcOgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Oct 2025 06:33:38 +0000
Message-ID: <359e3d8f-4db7-4430-8520-4fed9de4f48e@suse.de>
Date: Mon, 13 Oct 2025 08:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 4/4] nvme-multipath: add debugfs attribute for
 adaptive I/O policy stat
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, dwagner@suse.de,
 gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251009100608.1699550-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7735E1F460
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_233340_285099_83346D96 
X-CRM114-Status: GOOD (  10.60  )
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

On 10/9/25 12:05, Nilay Shroff wrote:
> This commit introduces a new debugfs attribute, "adaptive_stat", under
> both per-path and head debugfs directories (defined under /sys/kernel/
> debug/block/). This attribute provides visibility into the internal
> state of the adaptive I/O policy to aid in debugging and performance
> analysis.
> 
> For per-path entries, "adaptive_stat" reports the corresponding path
> statistics such as I/O weight, selection count, processed samples, and
> ignored samples.
> 
> For head entries, it reports per-CPU statistics for each reachable path,
> including I/O weight, path score, smoothed (EWMA) latency, selection
> count, processed samples, and ignored samples.
> 
> These additions enhance observability of the adaptive I/O path selection
> behavior and help diagnose imbalance or instability in multipath
> performance.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |   3 +
>   drivers/nvme/host/debugfs.c   | 117 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/multipath.c |   2 +
>   3 files changed, 122 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Might be an idea to have support for queue-depth in here, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

