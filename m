Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7294FC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrmizUHX0HwEegaw8iwnzu4LfBjA5+KdXuscKcv8Bqo=; b=mOwaBMt2h66EPsfGppkOnm9WAH
	shdKR/+vXnc/E3yCqLDvBqbESHunSOfZvPWz8Y+OY1kg/3l9u3nTdElD2j61mLk5xbf5L57Lue3pZ
	ojg7dNkV6f71+u5Lfker98BhA+K0HQ6jVKEYNi47insjpwbLKKnUrZa1CRgGkf9xbGXQuxG/3LFnA
	tXpKrILNXvZ6zsuRUVY8SwohAQLJGbH2Cn6okPDNqhFvRHV/FhlfwyGwGRCfe4jnD46Bn5+uyYjKX
	kKYIoKl6i5D7pudR/XaRdqXejzhSAoiK9DA7ixbqA4pBlg7wrJH6qTBs5acWyltAm+j7OW7fyo860
	MUnO1R8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1FM-0000000AWcr-26id;
	Wed, 03 Jul 2024 14:46:12 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1FH-0000000AWbb-40ar
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 14:46:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74FB61F44F;
	Wed,  3 Jul 2024 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720017964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrmizUHX0HwEegaw8iwnzu4LfBjA5+KdXuscKcv8Bqo=;
	b=AQ1yrOjgLyt9qHeBa9ydpLSMLZo1mOjkC+ASYSLzSPa88WzvixDIIj78kmFrPx/WtXpu0S
	tgUkWdYr403XpIPxR5qSEkQeVTX3uzGuvXUnPrIp400XSbhT9WWytgJZH8NGnQSAJpbF1a
	TVAtei6WzmYkzQT+T4FMRI7qxswEwLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720017964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrmizUHX0HwEegaw8iwnzu4LfBjA5+KdXuscKcv8Bqo=;
	b=bzcw6+npyQgaKVS75RwbYgsMWq4KOTParoljW//7GGzOjlnez0KpNezOfz3IcRr8QDISa1
	ZaIljOquI2JGhxCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="X/e6UQHm";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DhtSgCXh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720017963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrmizUHX0HwEegaw8iwnzu4LfBjA5+KdXuscKcv8Bqo=;
	b=X/e6UQHmB7bgkXpS3ORpcojGgS7DIAdORsNigaqbXYuHEn4eTJjYoL058NnsXMS/6ox/Ak
	SqY8eXTVBxylZkY1COsbwEKzQE9fVUmdC231zm4crA2KaIJcDMl/n3rgwbgZRNjvm+ozhL
	riD6yLb7jNqfRwXn/mewMN7fxzZupuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720017963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrmizUHX0HwEegaw8iwnzu4LfBjA5+KdXuscKcv8Bqo=;
	b=DhtSgCXhwmMP/ZZa0qyyHqJWm93uFj44gusbb8o5gfHrAQgyCuvjsmIcJwrH56ZIW1zP5r
	rhMOzTBTSF0DgEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 327C013889;
	Wed,  3 Jul 2024 14:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B4tlCitkhWbcQwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jul 2024 14:46:03 +0000
Message-ID: <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
Date: Wed, 3 Jul 2024 16:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 74FB61F44F
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_074608_168415_9D9C7D80 
X-CRM114-Status: GOOD (  10.09  )
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

On 7/3/24 16:11, Sagi Grimberg wrote:
> 
> 
> On 03/07/2024 16:50, Hannes Reinecke wrote:
>> Implement per-controller I/O workqueues to reduce workqueue contention
>> during I/O.
> 
> OK, wonder what is the cost here. Is it in ALL conditions better than a 
> single workqueue?

Well, clearly not on memory-limited systems; a workqueue per controller 
takes up more memory that a single one. And it's questionable whether
such a system isn't underprovisioned for nvme anyway.
We will see a higher scheduler interaction as the scheduler needs to 
switch between workqueues, but that was kinda the idea. And I doubt one
can measure it; the overhead between switching workqueues should be 
pretty much identical to the overhead switching between workqueue items.

I could do some measurements, but really I don't think it'll yield any
surprising results.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


