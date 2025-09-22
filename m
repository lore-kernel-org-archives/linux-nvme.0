Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B3CAC5A7
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/USTtINFklnXZPpUQi0zFQKDHxtSnpyY/dOGg5eqXgA=; b=ItqO1QyE9YsHOLesSjixW5lGnz
	FYi2Rl0WAO45IWwOXOoffc181hfSWg/wzbV2hxiuair3vqk05BLHO3lmH0NGHD/KIZYacrbFLv75h
	a98fBRI+pM5KxdOQvJel5oKQtBA9Vra3v2g1XFeAvsjDGNylmMw2auusUJ8hT9EVHBnygFIAj0K+G
	nuk+7LCbKELRPgBc01V5lTg9Ga7MbblgYCXdxBB1iTuBGMSHHV4JDAqy7qyB0Vimo/afEhri5uOjd
	QOslUlqW8yFRhmJPPN56mxyoeCjiQgEq3xSkQ1icK/kiTSCDAtONa5tmwZdN1P7t6HJW5+2eRhLdN
	kvLqi2Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0b50-00000009NOe-32Gz;
	Mon, 22 Sep 2025 07:35:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0b4y-00000009NMA-0BaJ
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 07:35:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 296E22209A;
	Mon, 22 Sep 2025 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758526518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/USTtINFklnXZPpUQi0zFQKDHxtSnpyY/dOGg5eqXgA=;
	b=RDqy8uvwBF0yG/v6osRcamBSs4ZuR4XDKbWn7yS/yCqGJZ75/I/M/jtgUWprXbeaDLdSR6
	Z6jaFP+UFttx57fkBx0IQ9tcLrZ6NhXQD2co1a9JO0AtQQFt94rINoYLsh3E7QdjVDRXLt
	/kfKmtvKIGweQJBPlZmgQAFBC4i86t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758526518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/USTtINFklnXZPpUQi0zFQKDHxtSnpyY/dOGg5eqXgA=;
	b=wO9EgpPS3uqsjpBQWPUjADya7lS23t4ijwBx1n20LXfwvaplNV+h1Gb4bSe1rjtm8+QL5V
	VoG0YCZecT/u6kCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758526518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/USTtINFklnXZPpUQi0zFQKDHxtSnpyY/dOGg5eqXgA=;
	b=RDqy8uvwBF0yG/v6osRcamBSs4ZuR4XDKbWn7yS/yCqGJZ75/I/M/jtgUWprXbeaDLdSR6
	Z6jaFP+UFttx57fkBx0IQ9tcLrZ6NhXQD2co1a9JO0AtQQFt94rINoYLsh3E7QdjVDRXLt
	/kfKmtvKIGweQJBPlZmgQAFBC4i86t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758526518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/USTtINFklnXZPpUQi0zFQKDHxtSnpyY/dOGg5eqXgA=;
	b=wO9EgpPS3uqsjpBQWPUjADya7lS23t4ijwBx1n20LXfwvaplNV+h1Gb4bSe1rjtm8+QL5V
	VoG0YCZecT/u6kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C80901388C;
	Mon, 22 Sep 2025 07:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yhzgLjX80GijfwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Sep 2025 07:35:17 +0000
Message-ID: <a89e6316-3857-4ae2-b907-5d8973777a6a@suse.de>
Date: Mon, 22 Sep 2025 09:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] nvme-multipath: add sysfs attribute for adaptive
 I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250921111234.863853-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_003520_228859_9C3C1EB7 
X-CRM114-Status: GOOD (  14.67  )
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

On 9/21/25 13:12, Nilay Shroff wrote:
> This commit introduces a new sysfs attribute, "adp_stat", under the
> nvme path block device. This attribute provides visibility into the
> state of the adaptive I/O policy and is intended to aid debugging and
> observability. We now also calculate the per-path aggregated smoothed
> (EWMA) latency for reporting it under this new attribute.
> 
> The attribute reports per-path aggregated statistics, including I/O
> weight, smoothed (EWMA) latency, selection count, processed samples,
> and ignored samples.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 77 ++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h      |  2 +
>   drivers/nvme/host/sysfs.c     |  5 +++
>   3 files changed, 82 insertions(+), 2 deletions(-)
> 
Wouldn't this be better off if situated in the debugfs directly?
Exposing the stats is not really crucial to operations, and mainly
for debugging purposes only.

Exposing the weight from the EWMA algorithm, OTOH, really does influence
the performance, and might be an idea to expose.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

