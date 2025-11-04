Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E28CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ef94CcKkJE3LbBov/USUDx0TsKmvean7QfBbRPRwTAk=; b=vWv6MFFck+R26DV1ZgHR45AR7z
	ScZqyiQHKym8aEMV+RK6iiJHc9jvsk8QgrpXIz3htIaCT7ynDK1A8NDGpzznGhpAxAKj9T40pKiBK
	73tqYMiqJVS4qX4JfbWkwdkp9CFOC7Q0gIcTSD7rdahCSzVBLFw/7mRaLV7eDJ2tpxTa+onMEJkas
	qXsDUtL2PHjW5N0Kgi3wg8vHunh5h8VFwyG7vPMES/BMHT6whN4wkM/gHHITcY2f0DV/Q4NOcYsxp
	4Y61wKtZGdGBkClARrwQ2u8igoDpgeMlx+RgWjGoq9XkFW/Rr1h4mudujFe8Y/3FDZiSNZVzd2cli
	ksxUXoIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIU7-0000000C0uM-1eh9;
	Tue, 04 Nov 2025 14:58:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIU4-0000000C0tm-2KWz
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 14:58:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC4A61F387;
	Tue,  4 Nov 2025 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762268286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef94CcKkJE3LbBov/USUDx0TsKmvean7QfBbRPRwTAk=;
	b=Ve8IWvQRwvVe7OBH7VneYTcp9BMgOAF7bWk6m9DFkNeZtuMOpsYvu4cizgmJwn2QrZJhgm
	xfyvnT3BwWz2JLxQ/aPgKRv8uv9ta5wCyV8EevgKZqptpJ2Q/LDLXChIVEivQ84OMMAtdG
	xHKgO7svNdpS4J2CFALItonaUxOh9k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762268286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef94CcKkJE3LbBov/USUDx0TsKmvean7QfBbRPRwTAk=;
	b=eSfub76kCGKk/+HMgGZkKwCzuZJT8Kuiz6SsclD/YJEvmUzwOuGEgZUIa0voFbcqizbNAo
	J/QxU5jC6ip5KDAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762268285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef94CcKkJE3LbBov/USUDx0TsKmvean7QfBbRPRwTAk=;
	b=O8yswhChNOT7kyUr91EkDauQzPwyqc1D0pV1BmgrxANypwZwpvR4+vWTNCAI3BoYy3NP5F
	Ad49Uj4+LCBk9dfbQF7xUG11Ioc6lpRUfPL8py3Cz9+pj1R6z70RJVhaDrFe6Hd0i7q52s
	C1HllXnfRZ7JVhPSgczNhTLmAt7XADI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762268285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef94CcKkJE3LbBov/USUDx0TsKmvean7QfBbRPRwTAk=;
	b=iSZ6QRxWr/RU+VZJ2saBVbLDfiU29dxae89/TaMupgMg04XOMNKi1HBS9JRpj9+YJL16L+
	0wiD144+wRPGrOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83785139A9;
	Tue,  4 Nov 2025 14:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a6RmH30UCmktawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 14:58:05 +0000
Message-ID: <a93cee4e-dd6b-4696-bced-d00365f93271@suse.de>
Date: Tue, 4 Nov 2025 15:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv4 4/6] nvme-multipath: add debugfs attribute
 adaptive_ewma_shift
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, dwagner@suse.de,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20251104104533.138481-1-nilay@linux.ibm.com>
 <20251104104533.138481-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104104533.138481-5-nilay@linux.ibm.com>
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
X-CRM114-CacheID: sfid-20251104_065808_740039_24711EB1 
X-CRM114-Status: GOOD (  13.82  )
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
> By default, the EWMA (Exponentially Weighted Moving Average) shift
> value, used for storing latency samples for adaptive iopolicy, is set
> to 3. The EWMA is calculated using the following formula:
> 
>      ewma = (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;
> 
> The default value of 3 assigns ~87.5% weight to the existing EWMA value
> and ~12.5% weight to the new latency sample. This provides a stable
> average that smooths out short-term variations.
> 
> However, different workloads may require faster or slower adaptation to
> changing conditions. This commit introduces a new debugfs attribute,
> adaptive_ewma_shift, allowing users to tune the weighting factor.
> 
> For example:
>    - adaptive_ewma_shift = 2 => 75% old, 25% new
>    - adaptive_ewma_shift = 1 => 50% old, 50% new
>    - adaptive_ewma_shift = 0 => 0% old, 100% new
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  3 +++
>   drivers/nvme/host/debugfs.c   | 46 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/multipath.c |  8 +++---
>   drivers/nvme/host/nvme.h      |  1 +
>   4 files changed, 54 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

