Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEC8C2BB85
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XI3w5JE8nUss82JXbM0IMAdRMptSmIQ6B6J/AdsEAg0=; b=lNsZJD9G1YvzMBidOARLFLbU1g
	Lfz9xmRAhqIlNwmlJm3weihWXeO6pGdWKIwOhNMG8e6JpF7MQKCE9ZHjg0tor7SuaevyI60Bp777N
	xpd/vY7O0v+7W+Jgy18bTsYAj48ECCJk/xcR2y1bbxbyHH2gO8ou3TiD0oqv75mJPWcIQ8YLHAG04
	iaVxf2GLICRuPCxaHS78wmdln6S7BnnDKoUX3ObQI4MJZWuDvwzA7G3L6DrrHshMO57viKN0rHzZD
	wIe1IgXX4TtLY7fsGnF0URkfsGyB153VgfCydIcYrQlTh7IiQ0GWLM4xvmnICXp0P34yUdDM5mfon
	t9sSZzNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXrm-00000007zCZ-1HeW;
	Fri, 21 Jun 2024 06:35:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXT4-00000007sIM-1BC0
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 06:09:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FFA121A2D;
	Fri, 21 Jun 2024 06:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718950188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI3w5JE8nUss82JXbM0IMAdRMptSmIQ6B6J/AdsEAg0=;
	b=s07WWul/CjJ2d6uhpM+qZIm3J/Vok23QwTF5r1v56lQUOUVpx/T+L9bu7a0G8/iQWC6gWz
	7Ya2vGmVJD7yVUWyCP4Zm2Q43bmWakS7my3xNkDee5hu4x0FQIjoOs+u6pqfmPRmwIBy5c
	+l5N6JuMnj8eRViPiJLoLzrPPCAI9rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718950188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI3w5JE8nUss82JXbM0IMAdRMptSmIQ6B6J/AdsEAg0=;
	b=Ms6fmZMoMwlVCzXrdAfijlWUjuwA7oJsAaeAhNx04tYVJpBMNnx38BWvZFAiaGwB7gLnQp
	vKaj9GEpmUmS8UDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="s07WWul/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ms6fmZMo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718950188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI3w5JE8nUss82JXbM0IMAdRMptSmIQ6B6J/AdsEAg0=;
	b=s07WWul/CjJ2d6uhpM+qZIm3J/Vok23QwTF5r1v56lQUOUVpx/T+L9bu7a0G8/iQWC6gWz
	7Ya2vGmVJD7yVUWyCP4Zm2Q43bmWakS7my3xNkDee5hu4x0FQIjoOs+u6pqfmPRmwIBy5c
	+l5N6JuMnj8eRViPiJLoLzrPPCAI9rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718950188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI3w5JE8nUss82JXbM0IMAdRMptSmIQ6B6J/AdsEAg0=;
	b=Ms6fmZMoMwlVCzXrdAfijlWUjuwA7oJsAaeAhNx04tYVJpBMNnx38BWvZFAiaGwB7gLnQp
	vKaj9GEpmUmS8UDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50E1313ABD;
	Fri, 21 Jun 2024 06:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o0rjDisZdWbEewAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Jun 2024 06:09:47 +0000
Message-ID: <222b6963-4728-4005-871f-40d761e133bd@suse.de>
Date: Fri, 21 Jun 2024 08:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 05/10] block: Add core atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 dchinner@redhat.com, jack@suse.cz
Cc: djwong@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com,
 ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
 Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-6-john.g.garry@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240620125359.2684798-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FFA121A2D
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,mit.edu,google.com,linux.ibm.com,kvack.org,gmail.com,infradead.org,redhat.com,lists.linux.dev,oracle.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL7q43nzpr7is614unuocxbefr)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_230950_501256_267760ED 
X-CRM114-Status: GOOD (  12.98  )
X-Mailman-Approved-At: Thu, 20 Jun 2024 23:35:15 -0700
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

On 6/20/24 14:53, John Garry wrote:
[ .. ]
> +/*
> + * Returns max guaranteed bytes which we can fit in a bio.
> + *
> + * We request that an atomic_write is ITER_UBUF iov_iter (so a single vector),
> + * so we assume that we can fit in at least PAGE_SIZE in a segment, apart from
> + * the first and last segments.
> + */
> +static
> +unsigned int blk_queue_max_guaranteed_bio(struct queue_limits *lim)
> +{
> +	unsigned int max_segments = min(BIO_MAX_VECS, lim->max_segments);
> +	unsigned int length;
> +
> +	length = min(max_segments, 2) * lim->logical_block_size;
> +	if (max_segments > 2)
> +		length += (max_segments - 2) * PAGE_SIZE;
> +
> +	return length;
> +}
> +
Now you got me confused.

Why is the length of an atomic write two times the logical block size?
And even if it does, shouldn't an atomic write be aligned to the logical 
block size, so why would you need to add two additional PAGE_SIZE worth
of length?
And even if _that_ would be okay, why PAGE_SIZE? We're trying really 
hard to get away from implicit PAGE_SIZE assumptions when doing I/O ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


