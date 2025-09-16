Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243EACAC599
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=; b=RJaRICQ038vTlxiy8hCLODmjeQ
	rIoE31/ImQj3LKYlHwfwV6hBVIjEdAKK85g+oGKNthBfJMxDwN25qvZiIQz6A4EdPTlCddKGO8QGT
	IEPtcnzdibWcO+nkjemReGA8sNTlNvIFlw2tk/clLv5HV1p0j8STJIVBhMzyWI0f+k7VUH03uiJo6
	ikjE9f5+MY5L98dtAovQxVa5Wl8IxGI6z8qHHuYeB8OwwF19366qIgbFnGxl8wk8ndtxlqZ9SbOzU
	OalS6Z7nS8aPmc4DLZo8m0IEfXOBsxKgOhABjmmyXMh1/p61V8uoPTJsV53sZvJbEfg0YhqdlOjcM
	lURifriA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTrU-00000007fQo-29do;
	Tue, 16 Sep 2025 11:28:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTrO-00000007fQO-2LQy
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 11:28:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CE0221E2A;
	Tue, 16 Sep 2025 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758022112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=iRsl15wPBs+dpd5s3bWELQcCCYZvA4kVggDx5MyyLfYHvMUo8/E2nULZx4lM5y0ZBuXSyU
	6ldC+EHot2bA+mh1u6AXEJtFQJk8Xb5rBSt79e+uJ4xw8c12XJTbo1uVjwBCTA3DbYZyBM
	FdEnK3a44FLYoX5QVd/5BwThhZvurYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758022112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=QVJuz3Oz116B1y/b/5jqbhtvr1Mu3RUlMpdnnaKv+thZTJrM4Oq7iUxsXCeiKcQe6nvIM7
	Kukzafq15n4Cc5Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iRsl15wP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QVJuz3Oz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758022112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=iRsl15wPBs+dpd5s3bWELQcCCYZvA4kVggDx5MyyLfYHvMUo8/E2nULZx4lM5y0ZBuXSyU
	6ldC+EHot2bA+mh1u6AXEJtFQJk8Xb5rBSt79e+uJ4xw8c12XJTbo1uVjwBCTA3DbYZyBM
	FdEnK3a44FLYoX5QVd/5BwThhZvurYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758022112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=QVJuz3Oz116B1y/b/5jqbhtvr1Mu3RUlMpdnnaKv+thZTJrM4Oq7iUxsXCeiKcQe6nvIM7
	Kukzafq15n4Cc5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB93513ACD;
	Tue, 16 Sep 2025 11:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+4DMd9JyWgTZAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Sep 2025 11:28:31 +0000
Message-ID: <40c707d6-db49-40a8-8372-7c3a91c2ff5f@suse.de>
Date: Tue, 16 Sep 2025 13:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
To: Jakub Kicinski <kuba@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>,
 Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, neil@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com, horms@kernel.org
References: <20250731180058.4669-1-okorniev@redhat.com>
 <20250731180058.4669-4-okorniev@redhat.com>
 <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
 <aMg0jDkXOd8E7Ihj@kbusch-mbp> <20250915144651.7bec7ad4@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250915144651.7bec7ad4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[22];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0CE0221E2A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_042834_896820_930FDD32 
X-CRM114-Status: GOOD (  13.00  )
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

On 9/15/25 23:46, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 09:45:16 -0600 Keith Busch wrote:
>> On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
>>> Dear NvME maintainers,
>>>
>>> Are there objections to this patch? What's the path forward to
>>> including it in the nvme code.
>>
>> Sorry for the delay here. This series is mostly outside the nvme driver,
>> so we need at least need an Ack from the networking folks if we're going
>> to take this through the nvme tree.
> 
> In case you decide to take it, LGTM:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks!
> 
Okay, after further thinking I would vote for the
NVMe tree after all. There are more patches queued
up which will require these changes, and life will
be easier if we had just one branch where we could
base them on.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

