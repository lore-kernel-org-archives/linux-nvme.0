Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B989C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3liAj1SgCJ1gA9YP24iEqiLHwNLgd2un0xO4DdNzxmU=; b=wBmWeo+rzRxSsqZ1VoVhvpGAux
	yva70qb9sk1qH4rpkTSaxkr48oBPbQWzT1IUjwYeChXXa+bk6ymRektI0yKJ8ulgi94Zg/ZcIQtJ8
	HmrpZTJ2xdxcZn+vVdVCqbWooaMfnxXGKQ/Iu5WuVkO7bvdm41K0cwpcM0yx8/vPGRK0uPdyFNVZG
	kKTd0FiwyzjLRUofGI9+y6GSoZ01uPE69MJc7xaSolTpFGWrUOqumGTk5yL3FIAn6XbsM/a8rlw8Y
	1J5sxVKTbbdtqj5Sri+CpcThSjjuHEHvVLOvGPVPJtM2SjAP5ttVfkOCX69xfjgDas5L+SWxq3Gvz
	DyQCYoBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcKW-00000009YRg-0k3Q;
	Tue, 16 Jul 2024 07:10:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcKP-00000009YQE-0ovO
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:10:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63EBA21B0D;
	Tue, 16 Jul 2024 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721113823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3liAj1SgCJ1gA9YP24iEqiLHwNLgd2un0xO4DdNzxmU=;
	b=ylDiaQnAQz5S3HcYyeYf238Qft/sKH5p2ZVSkrPoUkh9708va1EhexlK9bSR8h1/WL5PT0
	E0CEr29W1Aed7bPYs9ZqTDK3u3Xq4fWNaZ+H561dkOYuljkif7L6XfTXUakoCTlmn2RbF3
	FbEpSw1dUL9G3X3q8xENHG1Eq5jdAso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721113823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3liAj1SgCJ1gA9YP24iEqiLHwNLgd2un0xO4DdNzxmU=;
	b=gkL21zsdeqysXZ41GUtHNgzhqgBCOnkkd0lBipEwiLn/w4lbA3HezwJ4vywxQHshhUud4m
	WRp47W/9Q6uSepAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ylDiaQnA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gkL21zsd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721113823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3liAj1SgCJ1gA9YP24iEqiLHwNLgd2un0xO4DdNzxmU=;
	b=ylDiaQnAQz5S3HcYyeYf238Qft/sKH5p2ZVSkrPoUkh9708va1EhexlK9bSR8h1/WL5PT0
	E0CEr29W1Aed7bPYs9ZqTDK3u3Xq4fWNaZ+H561dkOYuljkif7L6XfTXUakoCTlmn2RbF3
	FbEpSw1dUL9G3X3q8xENHG1Eq5jdAso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721113823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3liAj1SgCJ1gA9YP24iEqiLHwNLgd2un0xO4DdNzxmU=;
	b=gkL21zsdeqysXZ41GUtHNgzhqgBCOnkkd0lBipEwiLn/w4lbA3HezwJ4vywxQHshhUud4m
	WRp47W/9Q6uSepAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29FA713795;
	Tue, 16 Jul 2024 07:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LmunCN8clmbAbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jul 2024 07:10:23 +0000
Message-ID: <025f47be-129d-443c-9672-0eb33db40577@suse.de>
Date: Tue, 16 Jul 2024 09:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] nvme-tcp: improve scalability
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <311fc12c-fc52-4881-9f49-d51780ca4ecb@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <311fc12c-fc52-4881-9f49-d51780ca4ecb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63EBA21B0D
X-Spamd-Result: default: False [-1.50 / 50.00];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_001025_408892_5A26064D 
X-CRM114-Status: GOOD (  12.96  )
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

On 7/16/24 08:31, Sagi Grimberg wrote:
> 
> 
> On 08/07/2024 10:10, Hannes Reinecke wrote:
>> Hi all,
>>
>> for workloads with a lot of controllers we run into workqueue contention,
>> where the single workqueue is not able to service requests fast enough,
>> leading to spurious I/O errors and connect resets during high load.
>> This patchset improves the situation by improve the fairness between
>> rx and tx scheduling, introducing per-controller workqueues,
>> and distribute the load accoring to the blk-mq cpu mapping.
>> With this we reduce the spurious I/O errors and improve the overall
>> performance for highly contended workloads.
>>
>> All performance number are derived from the 'tiobench-example.fio'
>> sample from the fio sources, running on a 96 core machine with one
>> subsystem and two paths, each path exposing 32 queues.
>> Backend is nvmet using an Intel DC P3700 NVMe SSD.
>>
>> Changes to the initial submission:
>> - Make the changes independent from the 'wq_unbound' parameter
>> - Drop changes to the workqueue
>> - Add patch to improve rx/tx fairness
> 
> Hey Hannes, were you able to make progress here?
> Thought I'd ask...

Oh, well. Things are going back and forth, and occasionally sideways.
But I'm having something resembling a patchset; most of it is
actually debugging stuff allowing to analyse latencies.
Currently trying to get some performance numbers, but should be ready
shortly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


