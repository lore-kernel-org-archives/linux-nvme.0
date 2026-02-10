Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525A4EB26E1
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=; b=2gUaLWfYp1KXJ0FIJi0RlrZYg6
	7ACQkGm1pOxr9AIVUu06OailFcs1iqT9J2FGfQ3JzGo8QWi79HiOjY+WekZOSfq8gwC4/QsGL7WGj
	QCCtHyCI1FB2yEW0vzLjpF98T6hDt9ESUOQB2Z6UgYkyMAiWWByHh6Frzt9kj/1pZqF7Wg1c7J0C4
	HWr543D7ne7Wj0MoTz+IHIq4NBqQ8L7WrbUb/1TaHY6Fa+E+uayFXbhAQHOgbgbUr9RU1jXQ10Wvl
	Fj8NAmvtgogAapn++oyPo9+N71DEsWsjVb+o6pj7l9fM3NpB1MidMABKIsTybr6zf91lkKFuAl7+r
	EPp2qwJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqaz-0000000HEaK-2oak;
	Tue, 10 Feb 2026 16:28:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqaw-0000000HEZZ-2mj8
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 16:28:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EA0E3E712;
	Tue, 10 Feb 2026 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770740887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=ugm4qDQznhpOWKcyUIGTZHtVYaZM8SCUGsqKfy9U/oNutiefPjZuYeJJXouvdFS1PIC5dp
	VG1duQEusSsTFBYwaCgQ8LXedBEGI7GyrQ6CIQzkqp7oRXVY7UXfSITUO7KYjAMOc7OKRQ
	QtWWzB7mD7098ykplzK4zz4LJmSIJ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770740887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=b7YKrMfvHozmd7LuRgInoCwFe/lFsljMEz8EVUYTaWY88c//gKTkKWgSfxZROXObFqB/MQ
	2EOa+bGorSnHLYAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ugm4qDQz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b7YKrMfv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770740887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=ugm4qDQznhpOWKcyUIGTZHtVYaZM8SCUGsqKfy9U/oNutiefPjZuYeJJXouvdFS1PIC5dp
	VG1duQEusSsTFBYwaCgQ8LXedBEGI7GyrQ6CIQzkqp7oRXVY7UXfSITUO7KYjAMOc7OKRQ
	QtWWzB7mD7098ykplzK4zz4LJmSIJ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770740887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=b7YKrMfvHozmd7LuRgInoCwFe/lFsljMEz8EVUYTaWY88c//gKTkKWgSfxZROXObFqB/MQ
	2EOa+bGorSnHLYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352B73EA62;
	Tue, 10 Feb 2026 16:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WTtZDJdci2nYdwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 10 Feb 2026 16:28:07 +0000
Date: Tue, 10 Feb 2026 17:28:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fnnas.com>, 
	axboe@kernel.dk, sagi@grimberg.me, sven@kernel.org, j@jannau.net, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, tj@kernel.org, 
	nilay@linux.ibm.com, ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <f3451ddd-96b6-4bc1-9d4c-964e361d56fc@flourine.local>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
 <aYtKFNm-wRKn6l66@kbusch-mbp>
 <20260210154108.GB2484@lst.de>
 <aYtWSscg6L9xxlzc@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtWSscg6L9xxlzc@kbusch-mbp>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4EA0E3E712
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_082810_847786_493989BA 
X-CRM114-Status: GOOD (  20.68  )
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

On Tue, Feb 10, 2026 at 09:01:14AM -0700, Keith Busch wrote:
> On Tue, Feb 10, 2026 at 04:41:08PM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 10, 2026 at 08:09:08AM -0700, Keith Busch wrote:
> > > If you leave the queue quiesced, pending IO will form requests that are
> > > entered and waiting in the block layer. You can't freeze a queue with
> > > entered requests.
> > > 
> > > We unquiesce first to flush any pending IO that had entered during the
> > > prior reset. It's not the best way to handle this situation. It would be
> > > smarter to steal the bio's from all the entered requests, then end those
> > > requests, then resubmit the bios after the hw queues are initialized. We
> > > don't do that because no one's really complained, probably because the
> > > queue counts don't usually change after a reset.
> > 
> > FYI, Daniel Wagner had been thinking about doing this reinsert for
> > something (I forgot what exactly),

This feature would solve a tricky problem with isolation patches:

https://lore.kernel.org/linux-nvme/87cy7vrbc4.ffs@tglx/

Currently, it's not possible to take the cpu hotplug lock which would
prevent races in the cpu-queue mapping. The current logic depends on
making progress in the error case. If it would be possible to fail the
in-flight request in the error handler and reinsert them in the block
layer, progress could be guaranteed when holding the cpu hotplug lock.

Unfortunatly, haven't found time to implement and test this idea so far.
Sorry.

