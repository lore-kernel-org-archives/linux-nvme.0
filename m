Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6795FFF8873
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Aa3+xJkIiFQ/HkoTGqknWirRkC4uQdhQ2e/brY0CSM=; b=yAsLJghNa0X98bHo7V667kV1pP
	GtlaDYt3LyH8CP+pr64AkQvwSyoyArd8aU7Pw6uRv7ApncHzu/HaG2D6fuIj4JFGcfXxzpb99xUMH
	a73mpwLy+kZ3sZ9ThJTPT26k+cS40URaq+W9d1RVOB20FU2kMFYBvgN9EBIFrLdj1V+X3C8ft83pU
	v+kRg/FzLR8pXfx4QhEvqcfwwysM9/fnThmgfuqqgruOXl7QBAScq/O6KqTKcv/7mMaN90sPqv/jw
	iH8JccG0kKGoZAexoFK9VrtP0Bn4Kz7IBeRbHil9XKjTVbVh6Giw6E1KgDKoICtBSC+djQ+cq3eXc
	1dvNJoTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIT84-00000005ckA-2kX8;
	Thu, 30 Apr 2026 15:16:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIQCr-00000005Qtn-3pgZ
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 12:09:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ED296A803;
	Thu, 30 Apr 2026 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777550962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Aa3+xJkIiFQ/HkoTGqknWirRkC4uQdhQ2e/brY0CSM=;
	b=TNcm5UCpbnw+2gGvqCAGRfeD0cH38QV5yL+LXYPlsOtSG+xaNAl9iwMmKZe60OkiyvTzUE
	MPbrMpilr3x+K1Xnw2Noo3Eu23pmJB+LSg7C87OfPc92b/oWN7iW89zIzEWGRKdFS2t+9b
	KTms3z8JnAJNtr2spG8c3noa/cxyCZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777550962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Aa3+xJkIiFQ/HkoTGqknWirRkC4uQdhQ2e/brY0CSM=;
	b=4IM0G4gRSzs4S7cZnW/tdU+quLXd8KPax9Zb9UyDXvquAiRwRIJd8/TZe8+HHRgQ/h/VcI
	nObOSROkCj2SocCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TNcm5UCp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4IM0G4gR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777550962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Aa3+xJkIiFQ/HkoTGqknWirRkC4uQdhQ2e/brY0CSM=;
	b=TNcm5UCpbnw+2gGvqCAGRfeD0cH38QV5yL+LXYPlsOtSG+xaNAl9iwMmKZe60OkiyvTzUE
	MPbrMpilr3x+K1Xnw2Noo3Eu23pmJB+LSg7C87OfPc92b/oWN7iW89zIzEWGRKdFS2t+9b
	KTms3z8JnAJNtr2spG8c3noa/cxyCZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777550962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Aa3+xJkIiFQ/HkoTGqknWirRkC4uQdhQ2e/brY0CSM=;
	b=4IM0G4gRSzs4S7cZnW/tdU+quLXd8KPax9Zb9UyDXvquAiRwRIJd8/TZe8+HHRgQ/h/VcI
	nObOSROkCj2SocCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63645593B0;
	Thu, 30 Apr 2026 12:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /0o+GHJG82kjZQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 30 Apr 2026 12:09:22 +0000
Date: Thu, 30 Apr 2026 14:09:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, 
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	maz@kernel.org, ruanjinjie@huawei.com, bigeasy@linutronix.de, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, longman@redhat.com, 
	chenridong@huawei.com, hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, 
	tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v12 00/13] blk: honor isolcpus configuration
Message-ID: <8c074639-bb75-40be-a338-e80b93123477@flourine.local>
References: <20260422185215.100929-1-atomlin@atomlin.com>
 <e350389a5a635660267a7a13f06529da102a95d8.camel@siemens.com>
 <2d61b1f7-fc06-4fe1-8a6f-cc3a2f114ae1@flourine.local>
 <85415539137c61cdec145ac0ee299dbea7cdd2a1.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85415539137c61cdec145ac0ee299dbea7cdd2a1.camel@siemens.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_CC(0.00)[atomlin.com,kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,microsemi.com,hansenpartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,linutronix.de,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,siemens.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLip3qrwmtdyuwmp1ydoxr43fi)];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 7ED296A803
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_050926_121894_7217A215 
X-CRM114-Status: GOOD (  14.50  )
X-Mailman-Approved-At: Thu, 30 Apr 2026 08:16:38 -0700
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

On Wed, Apr 29, 2026 at 11:01:33PM +0200, Florian Bezdeka wrote:
> > Which use case are you actually aiming to support? While dynamic
> > reconfiguration would be ideal, the amount of work to get there is
> > significant. I won't be signing up for it.
> 
> The use case at hand is a RT enabled platform where the concrete RT
> workload is not known at boot time. RT applications are deployed "on-
> the-fly", nowadays using the existing container runtimes with some
> extended resource management on top.
> 
> Applications can request certain resources like isolated CPU cores,
> special IRQ affinities, PCI devices to pass through, ...,  so that the
> resource management on the system can take care of proper system
> configuration.


This is where I really question this use case. Currently, it takes quite
a lot of time to tune a system to work properly for RT workloads.
Between memory channel interference, GPU interference, and shared
transports everywhere, you end up with a fixed split: a set of CPUs
suitable for RT work and a set for housekeeping. This partitioning
generally does not change during runtime, even if the way you utilize
those two sets remains dynamic.

Furthermore, reconfiguring a system while running an active RT workload
is asking for trouble. I wouldn't be surprised if doing so triggered a
wide range of unpredictable side effects.

