Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0A4CDB471
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 07:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmUDOsC8kD3Z6yHbBaaaRCM7jfIjNgi4sYLvM9X6AmI=; b=VKsqx3t8zM0tJuQSPRbXJtHxjq
	02eMarQsvHhb5xYNyToUIyRfFvz6jvUCS3uMkEoYQ3cMUWOWvar3JJvQT+iGAjhiPRSsVbRnvSayG
	IJ0unCbR9gqzxqY7cNH8TEtfK/mxVR4lN0ZgKHtGph/ByF3GKPBohgcFCqQCyUG1eDuoiSSi2b2A9
	mccG6wUZTSIbISjXXklys1/ftDVbFy1xPfZz0F/ERv0xOQinTGWDjZgTxBFECOeJEdAS8VQLX5Hrx
	vtHfDJwoGBpvikZHgCn9TBAvfrN9xRPgNSQfotka/B0gjn4k+qVziI7KeWXC6hDvoqteZ9XHeObew
	Rj+dry6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbZQF-00000004ZUg-3lNw;
	Mon, 22 Jun 2026 07:50:23 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbZQD-00000004ZTw-1tII
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 07:50:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B17A8703DD;
	Mon, 22 Jun 2026 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782114617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmUDOsC8kD3Z6yHbBaaaRCM7jfIjNgi4sYLvM9X6AmI=;
	b=QXCWmdkRm8s1PQ6xmdsVIQvFDSsC+apJR73RgQnkJd74/Aqx5c3CSQTQIIhFIywnmmNB65
	HxOjUTlgVfBcgfS0HwY02Pk0DACFAAUlc/iiWLyJhncg47AtztG2tU2vlYII55gz/qIO7m
	QERAJDTjwMJT+Cf+ThAmpg+XBNHF7XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782114617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmUDOsC8kD3Z6yHbBaaaRCM7jfIjNgi4sYLvM9X6AmI=;
	b=KdVHyPL+cRyl7zRjf0KdqK32MnlJBEJvsAnUERTWbaPZaI/pHBQwt4u0DqYg8/Gcf2TDvQ
	FP3kJKoGpxfminCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782114617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmUDOsC8kD3Z6yHbBaaaRCM7jfIjNgi4sYLvM9X6AmI=;
	b=QXCWmdkRm8s1PQ6xmdsVIQvFDSsC+apJR73RgQnkJd74/Aqx5c3CSQTQIIhFIywnmmNB65
	HxOjUTlgVfBcgfS0HwY02Pk0DACFAAUlc/iiWLyJhncg47AtztG2tU2vlYII55gz/qIO7m
	QERAJDTjwMJT+Cf+ThAmpg+XBNHF7XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782114617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmUDOsC8kD3Z6yHbBaaaRCM7jfIjNgi4sYLvM9X6AmI=;
	b=KdVHyPL+cRyl7zRjf0KdqK32MnlJBEJvsAnUERTWbaPZaI/pHBQwt4u0DqYg8/Gcf2TDvQ
	FP3kJKoGpxfminCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D01B779A8;
	Mon, 22 Jun 2026 07:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WWKnJDnpOGoaVQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Jun 2026 07:50:17 +0000
Date: Mon, 22 Jun 2026 09:50:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: expose path_state via sysfs
Message-ID: <4b1f2cbe-2d94-42be-8a5c-4d1263df5659@flourine.local>
References: <20260617121543.2291455-1-kanie@linux.alibaba.com>
 <498d2a2f-8545-470e-b42a-dd47e26a948a@flourine.local>
 <f4488a80-2e8c-4782-af48-40e5806929d9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4488a80-2e8c-4782-af48-40e5806929d9@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_005021_669118_AB0A915C 
X-CRM114-Status: GOOD (  14.39  )
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

On Mon, Jun 22, 2026 at 10:02:48AM +0800, Guixin Liu wrote:
> > The ctrl state is already exposed to the sysfs. What's the use case for
> > this sysfs entry?
> 1. A controller being live only indicates that the transport connection is
> healthy.
> However, due to ANA, a path through that controller may be inaccessible or
> non-optimized.
> The ctrl state simply cannot express this.

Ah, I thought this info is already in the sysfs but it's just the ns
head one. Though I think it would be better to expose the complete state
not the filtered one via nvme_path_is_disabled().

