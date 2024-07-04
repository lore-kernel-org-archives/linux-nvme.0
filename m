Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3D6C3065C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 06:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUZr96xMOSfv7Vj5yUshaHHzKxbkwsjS/SyK6oVOOqs=; b=I6LPpLEM4cUPoHIRFlFRmyfs/m
	3HmeAyvtBle6MBHiy8jBGpSU+TaMJ2FjgroInktKAoZleu8fmCZMQkrxRS+jKLPI8x7vUGBWbcWvt
	w7ghxKAMkVUGVyWdk0hJxiWYmyZTkU6okg72AVUzSJNLojJb3WlZ10SpXPxuRxWRPcdaQpI+QSvY4
	DbvqW43J2MX6HC2Aj2eXpAxBKs6TG+8ntyIZQ36zjaKj3IH4kGMlADGNueBqvNgsWIqOp84eMACLH
	I7R+MyL5PD/mtIf7MpnA5yH4nMZhsVc6QiI6bTt4tvowuvGQVY3SyUGSEnx0upResmHcY/Cf5du+7
	/vOqt6Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFZm-0000000CI0Z-32bF;
	Thu, 04 Jul 2024 06:04:14 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFZh-0000000CHy1-1OWd
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 06:04:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAB371F79B;
	Thu,  4 Jul 2024 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720073047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUZr96xMOSfv7Vj5yUshaHHzKxbkwsjS/SyK6oVOOqs=;
	b=Ujtu5344Vbej/SiIeN9bUEEXbu/pV52hhpbn10pxKV+xlwEQWrgIPK1eyVVRTNZf39VF7S
	mhxKZu58XLuecUVxWmrnR+vfN2jyir/IA2oEBK8l+gjFv+HqLHnAMOqF+aeu0PihcmEvfM
	nkgdr8VNN3SAyB7SGaIs9hiKgsA5FIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720073047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUZr96xMOSfv7Vj5yUshaHHzKxbkwsjS/SyK6oVOOqs=;
	b=/w6/rq8dEenXIrdd/2pv8XzuzTkcNAkQaORNIsoUcTVTuTAM/tk60o4gpcMReUTjKXbkyu
	MTf8IQVFXof3nHCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720073047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUZr96xMOSfv7Vj5yUshaHHzKxbkwsjS/SyK6oVOOqs=;
	b=Ujtu5344Vbej/SiIeN9bUEEXbu/pV52hhpbn10pxKV+xlwEQWrgIPK1eyVVRTNZf39VF7S
	mhxKZu58XLuecUVxWmrnR+vfN2jyir/IA2oEBK8l+gjFv+HqLHnAMOqF+aeu0PihcmEvfM
	nkgdr8VNN3SAyB7SGaIs9hiKgsA5FIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720073047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUZr96xMOSfv7Vj5yUshaHHzKxbkwsjS/SyK6oVOOqs=;
	b=/w6/rq8dEenXIrdd/2pv8XzuzTkcNAkQaORNIsoUcTVTuTAM/tk60o4gpcMReUTjKXbkyu
	MTf8IQVFXof3nHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83E871369F;
	Thu,  4 Jul 2024 06:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AGsAHlc7hmaCIAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 04 Jul 2024 06:04:07 +0000
Message-ID: <2d2a27e2-4f73-48ae-9433-14c765c2b587@suse.de>
Date: Thu, 4 Jul 2024 08:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] workqueue: introduce helper
 workqueue_unbound_affinity_scope()
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-4-hare@kernel.org> <ZoWLDOEvoY0MfNHt@slm.duckdns.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoWLDOEvoY0MfNHt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_230409_551833_0920323F 
X-CRM114-Status: GOOD (  17.51  )
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

On 7/3/24 19:31, Tejun Heo wrote:
> Hello, Hannes.
> 
> On Wed, Jul 03, 2024 at 03:50:20PM +0200, Hannes Reinecke wrote:
>> For drivers creating their own workqueue it might be useful to
>> switch to the 'cpu' unbound affinity scope to keep the locality
>> and reduce contention. As it's cumbersome to instruct the user
>> how to switch to affinity scope from userland introduce a helper
>> workqueue_unbound_affinity_scope() to let the driver set the
>> affinity scope directly.
> 
> So, there's already apply_workqueue_attrs() to change the unbound workqueue
> attributes including affinity scope. It's cumbersome to use because the
> attribute structure has to be allocated and then freed. The alloc/free is
> for the cpumasks, so if the API is too cumbersome, maybe we can just make
> the cpumask part optional? ie. Allow using workqueue_attrs without going
> through alloc if cpumasks don't need to be modified. There probably should
> be a function to read attrs from a workqueue too.
> 
Sure; it would be ideal if one could allocate the attributes on stack, 
and then just call 'apply_workqueue_attrs()'.
And if the attrs don't include a cpumask then just leave it unchanged.
Let me see...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


