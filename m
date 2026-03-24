Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB59F532FA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TGhT0vGG9zShyLG3Q3lS1r9uFkmvbphTe8QNhsAySo=; b=IRn2pcc3c2u3k5LWCR1GH6CDXI
	SZ+oy7W0Gv/sf0OVC4rtVDW3r2sAIzSi+LXDGREUUfStJ4BDoEO5td6yfA4D6SzWNZcgeeRNZFMtR
	thUHTh2cfCUaHlWdCibk2HyN+If+7ieTo/3hPdLkAnlA3TTDzpWGGzi8PBgoAVPF4NlRhUey5sZH2
	al/n/Icr+om8aeT4s8KsgCYZPQnAnBg5FZL99oqzfwvNb0Rmvoli9Nu9OeyNkmyUCKwguV5kY05d7
	xHpZzgJxDB6tuyTo8gYLdTTMI3u2NAT/NFVPP6YZmuyEiaiiOAKmmyCrJcFGHiXHO3m8n0SXBuUyr
	o6YNYy/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xhV-000000012gv-0uk8;
	Tue, 24 Mar 2026 09:05:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xhT-000000012gO-3Cue
	for linux-nvme@bombadil.infradead.org;
	Tue, 24 Mar 2026 09:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2TGhT0vGG9zShyLG3Q3lS1r9uFkmvbphTe8QNhsAySo=; b=LaVrcB8O+d5AaEin0YL2zHtUsY
	o1pl2zjg0BvyoyoOjpA9Mycyy3PJo8L9zYxnZwRWeY5FrwGffHmx0tL1vDR75QwHoorDpFVTsOIyq
	HpLvR4rY1KsN3+36XWYOUrMdVhCpxkjq5iYJHJ6GRTj1m/RSKXIiQmE7s/J0+wSPMTp25uu2TR9fU
	pk0zd34BBDgkPtvqnCXI/nklMHK71QV6Ccp4gnJYjpTF2XYZbEdjPz+myrayQqu5mtXgLx8fiDFFS
	0RHkA3aLS2YKp3hE2yV6sMvaz/lEStzKbBiQR+gEgzFjAg6E2MNVK+XvVp6B0Qn9asluOQhqQEe65
	7L4Mixyg==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xhC-00000003bOx-2Uru
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 09:05:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3F7F4D1CA;
	Tue, 24 Mar 2026 09:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774343103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TGhT0vGG9zShyLG3Q3lS1r9uFkmvbphTe8QNhsAySo=;
	b=TK4WoH5xzRmnb7HHTbJqg9WSkSCeEaalijLB3/Jy5anRaemQp0UGEaGY3k26XI6AvBJ/5L
	5LX6YWZDc1SnWl5sJ4zh6ON1AeypTZLeayj4S26X0MyZ49xhRBEEJDeEY/iutqbUu5gzjm
	1GzuH07QDyWDkU3NB5GDGpv2w/dsXNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774343103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TGhT0vGG9zShyLG3Q3lS1r9uFkmvbphTe8QNhsAySo=;
	b=uVG2PNyaLw4pn6SRAVY1w6DoWJmAI2Z5G+nbEKaDemja2cuK8vUvrAdKcQF0Bm9A9HISkt
	AysMKtIzUGPMLpBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zDDxaweU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=btTuaXs6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774343101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TGhT0vGG9zShyLG3Q3lS1r9uFkmvbphTe8QNhsAySo=;
	b=zDDxaweULCEE6QYWksFUBwew/YSiQvexB3y6l9CODLJpgSFOucMJQYPSKQ0NdYBsCgyPgS
	3v+VQDulpZmB6v+Dm6Ba6l6lsTX2sJoyxkuNuXjWA2XVI4tvSdJdOiaMMjW/KYb1zNgpEB
	vPV5Xlx8jvZaQ+ZxqXxuIRdyYcBaWHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774343101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TGhT0vGG9zShyLG3Q3lS1r9uFkmvbphTe8QNhsAySo=;
	b=btTuaXs6xTB/lH+9KttbmFYwgdsvcXFC6ZlJkAJT5sRhGdaEgm/9CihY9Af+HAu5VUR6jj
	EtakM2JmwxPDpSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2E5843D66;
	Tue, 24 Mar 2026 09:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsxzKr1TwmlnCQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Mar 2026 09:05:01 +0000
Date: Tue, 24 Mar 2026 10:05:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 4/9] libnvme: add support for retrieving per-path gendisk
 I/O statistics
Message-ID: <1adcb39b-5e88-4ad0-86fb-8d794adc8744@flourine.local>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-5-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321152823.3197870-5-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C3F7F4D1CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_090506_821908_7C701618 
X-CRM114-Status: GOOD (  12.79  )
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

On Sat, Mar 21, 2026 at 08:58:03PM +0530, Nilay Shroff wrote:
> +static int nvme_update_stat(const char *sysfs_stat_path, nvme_stat_t stat)
> +{
> +	int n;
> +	struct timespec ts;
> +	unsigned long rd_ios, rd_merges, wr_ios, wr_merges;
> +	unsigned long dc_ios, dc_merges, fl_ios;
> +	unsigned long long rd_sectors, wr_sectors, dc_sectors;
> +	unsigned int rd_ticks, wr_ticks, dc_ticks, fl_ticks;
> +	unsigned int io_ticks, tot_ticks, inflights;
> +
> +	memset(stat, 0, sizeof(struct nvme_stat));
> +
> +	n = sscanf(sysfs_stat_path,
> +		"%lu %lu %llu %u %lu %lu %llu %u %u %u %u %lu %lu %llu %u %lu %u",
> +		&rd_ios, &rd_merges, &rd_sectors, &rd_ticks,
> +		&wr_ios, &wr_merges, &wr_sectors, &wr_ticks,
> +		&inflights, &io_ticks, &tot_ticks,
> +		&dc_ios, &dc_merges, &dc_sectors, &dc_ticks,
> +		&fl_ios, &fl_ticks);
> +
> +	if (n < 17)
> +		return -1;

return a proper error code, e.g. -EINVAL or whatever matches better.

> +__public int nvme_path_update_stat(nvme_path_t p, int curr)

Do we need to expose 'curr' to the user? I'd prefer not to expose this
implementation detail to the user if possible.

> +{
> +	_cleanup_free_ char *sysfs_stat_path = NULL;
> +	nvme_stat_t stat;
> +
> +	stat = nvme_path_get_stat(p, curr);
> +	if (!stat)
> +		return -1;

return an error code instead -1. same comment for the rest of the patch.

> +__public unsigned int nvme_path_get_io_ticks(nvme_path_t p, int this)
> +{
> +	nvme_stat_t curr, prev;
> +
> +	curr = nvme_path_get_stat(p, this);
> +	prev = nvme_path_get_stat(p, !this);

Do we really need to expose 'this'?


