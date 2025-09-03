Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E89CAC585
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z4dkn1xOtjZMvux09Ypde4SPog5LI5mjRt8sFdLaY4U=; b=as5FM3kaHQiPeA8jUXOwcmcez3
	Hxx45Iwhqx1namDFYyg3qmSP52jqNy7GhVK5+y/fdPNXaPe6Tp5IWmvTXQZIdTrvCLs4QtWDYtJpG
	RhDpCGXcabrWcFjgE+/E7nGFpIx6IM+7fH2JGSYkawyIOjPU803hKYVCnFILBuI+usc2wHtdtQFGw
	rpM1feJd8zlOGI0MOQCQ0hc4KYFHfQHG5C8iZRTFbkcs2sr0vhcWKmTCuf9HB7h3MZpU/FPHYM5BN
	KUBN43u2VMPYET5yQ/DdlmvtN6+VKHQkHl/htjKnorZUSliQJaHZPlGGwZ300a+Z7K/6dhwaPHe2Y
	3cbZYfYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utomT-00000006lMP-36HG;
	Wed, 03 Sep 2025 14:48:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utmj5-00000006PQE-48tR
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 12:36:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53B3A1F453;
	Wed,  3 Sep 2025 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756902994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4dkn1xOtjZMvux09Ypde4SPog5LI5mjRt8sFdLaY4U=;
	b=kVjoFdCgu/5/fm2+jELu+JLMX4XJc08ulrCIWfDshl3SRtjuY50CbL41pdnlV1OKFRuenV
	FPAoq4yhQZqcXvNj3heuoiNr6bzpfxXstXbAkQ7u9kfZU81EfA4D+VFODrDuySMAohMReg
	zzO9RSlJ8LNx3dXJLq2V+Q8WFDVle98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756902994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4dkn1xOtjZMvux09Ypde4SPog5LI5mjRt8sFdLaY4U=;
	b=JC7gL9++1ZpB9YCxnC/6M9nz3W8JxHmybvcmSdFTfEWWWDkcRfZCWClUCvdzzxdxrLUTIf
	yBSx//eaP2+gDMAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kVjoFdCg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JC7gL9++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756902994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4dkn1xOtjZMvux09Ypde4SPog5LI5mjRt8sFdLaY4U=;
	b=kVjoFdCgu/5/fm2+jELu+JLMX4XJc08ulrCIWfDshl3SRtjuY50CbL41pdnlV1OKFRuenV
	FPAoq4yhQZqcXvNj3heuoiNr6bzpfxXstXbAkQ7u9kfZU81EfA4D+VFODrDuySMAohMReg
	zzO9RSlJ8LNx3dXJLq2V+Q8WFDVle98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756902994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4dkn1xOtjZMvux09Ypde4SPog5LI5mjRt8sFdLaY4U=;
	b=JC7gL9++1ZpB9YCxnC/6M9nz3W8JxHmybvcmSdFTfEWWWDkcRfZCWClUCvdzzxdxrLUTIf
	yBSx//eaP2+gDMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4149513A31;
	Wed,  3 Sep 2025 12:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XMvsD1I2uGj2MAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 03 Sep 2025 12:36:34 +0000
Date: Wed, 3 Sep 2025 14:36:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v7 01/10] lib/group_cpus: Add group_masks_cpus_evenly()
Message-ID: <5397286b-bb1f-493b-9d7d-b4168a67efe6@flourine.local>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-1-557aa7eacce4@kernel.org>
 <db0cbbe2-792c-4263-8be9-14b76eb0f7e6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0cbbe2-792c-4263-8be9-14b76eb0f7e6@suse.de>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL71uuc3g3e76oxfn4mu5aogan)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 53B3A1F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_053636_175926_3FB8FC78 
X-CRM114-Status: GOOD (  14.49  )
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

On Thu, Jul 03, 2025 at 08:18:50AM +0200, Hannes Reinecke wrote:
> > +/**
> > + * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> > + * @numgrps: number of groups
> > + * @cpu_mask: CPU to consider for the grouping
> > + * @nummasks: number of initialized cpusmasks
> > + *
> > + * Return: cpumask array if successful, NULL otherwise. And each element
> > + * includes CPUs assigned to this group.
> > + *
> > + * Try to put close CPUs from viewpoint of CPU and NUMA locality into
> > + * same group. Allocate present CPUs on these groups evenly.
> > + */
> 
> Description could be improved. Point is that you do not do any
> calculation here, you just call __group_cpus_evenly() with
> a different mask.

I updated the documentation, it matches with group_cpus_evenly but with
the constrain mask.

