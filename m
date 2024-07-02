Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D946C30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPQrY/R+c1/dpFbHCsxL7vA916P/QbttkVplMgYUQDA=; b=F4RKabAYOhPdZlVUu9CKgpeIh3
	TB6v3KZLl2Zwu390mcYgh/UUhPegLpKFpWpIGDRgIFPh3DpG4TaxQhFH0Nr+/bF5CcholTOvTHGFT
	tiOsLRk8h0cJRNJbui5OhskvIDb4hfH/ATeS9oSvePRwoXs1RlOfPmur/my//5t82+zwGv9zvRB+k
	jJqoCyG2F+2b5ZQ+1lx8FzE7f1QvIP05o3leXJfNNvT7mlwX7mKC5xrYIB87J+/Nytkuy+KI/SnyK
	C9AMjOc8+kOm4z6Ooo5v0UCqipCekULEWuYaU19C+kbpaeveBpSAtjpDNw8bUVVlja3l7YFtImArj
	wpH0+Gsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOgMl-00000007NQx-0J1t;
	Tue, 02 Jul 2024 16:28:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOgMf-00000007NOp-30v1
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 16:28:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BAAA1FBB0;
	Tue,  2 Jul 2024 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719937700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPQrY/R+c1/dpFbHCsxL7vA916P/QbttkVplMgYUQDA=;
	b=Ta07kawNLSoOU9iudB6JwHsC2K+tJgCT6ht8shUpRQzMJe5vUKvp8VwEG9SxkVxpUIez6M
	z5OM0m1jNuqXMCXSBYKFb/a1yPdvLTVGsSoH8/nriZ6L56w+OtBW04CUzFeWyCsb7/Yso8
	EgcQpdK8MOtPz9NrPN2c0Kb33gcV7XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719937700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPQrY/R+c1/dpFbHCsxL7vA916P/QbttkVplMgYUQDA=;
	b=1v+AXUJUrl3jmCWfRQXzwk1nCm+UhXG4vFLBhNDCgmYq7iY2t+JSoxWS4zUV4PqSQ9zH2Y
	pVnNvI12vBlhQfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719937700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPQrY/R+c1/dpFbHCsxL7vA916P/QbttkVplMgYUQDA=;
	b=Ta07kawNLSoOU9iudB6JwHsC2K+tJgCT6ht8shUpRQzMJe5vUKvp8VwEG9SxkVxpUIez6M
	z5OM0m1jNuqXMCXSBYKFb/a1yPdvLTVGsSoH8/nriZ6L56w+OtBW04CUzFeWyCsb7/Yso8
	EgcQpdK8MOtPz9NrPN2c0Kb33gcV7XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719937700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPQrY/R+c1/dpFbHCsxL7vA916P/QbttkVplMgYUQDA=;
	b=1v+AXUJUrl3jmCWfRQXzwk1nCm+UhXG4vFLBhNDCgmYq7iY2t+JSoxWS4zUV4PqSQ9zH2Y
	pVnNvI12vBlhQfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F113113A9A;
	Tue,  2 Jul 2024 16:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K7PeOaMqhGZUOwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 02 Jul 2024 16:28:19 +0000
Date: Tue, 2 Jul 2024 18:28:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Lawrence Troup <ltroup@cisco.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <hdvvssh5azfwzgymk3olmtfwwpc2fnyzjflqt4pl2jt3pm4s2w@nbek7v47kzcv>
References: <20240702104112.4123810-1-ming.lei@redhat.com>
 <20240702115002.GA16219@lst.de>
 <ZoPum7MPTuA6/t7O@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoPum7MPTuA6/t7O@fedora>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_092822_452396_2DBBD5BF 
X-CRM114-Status: GOOD (  21.57  )
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

On Tue, Jul 02, 2024 at 08:12:11PM GMT, Ming Lei wrote:
> On Tue, Jul 02, 2024 at 01:50:02PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 02, 2024 at 06:41:12PM +0800, Ming Lei wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > People _really_ want to control their interrupt affinity in some
> > > cases, such as Openshift with Performance profile, in which each
> > > irq's affinity is completely specified from userspace. Turns out
> > > that 'isolcpus=managed_irqs' isn't enough.
> > > 
> > > Add module parameter to allow unmanaged interrupts, just as some
> > > SCSI drivers are doing.
> > 
> > Same as before: hell no.  We can't just add hacky global kernel
> > parameters everywhere.  We need the cpu isolation infrastructure to
> > work properly instead of piling hacks of hacks in every relevant driver.
> 
> Per my understanding, here cpu isolation infrastructure can't work for
> Openshift, in which IO workload can be run on applications which are executed
> on isolated CPUs, meantime userspace do expect that interrupts can be
> triggered on user-specified CPU cores only in controllable way.  
> 
> Marcelo and Lawrence may have more input in this area.
> 
> Also irq allocation really belongs to device & driver stuff, how can that be
> hack? We even may not abstract public API in block layer for handling
> irq related thing.

I am confused. I though you told me that my series 'nvme-pci: honor
isolcpus configuration' is not necessary. But you still need this patch
to get the affinity sorted out? Wouldn't it make sense to figure out how
we can make my series working also for your use case? E.g. we could
introduce another HK type (io_queue) to control the affinity. This would
decouple if from the managed_irq option.

