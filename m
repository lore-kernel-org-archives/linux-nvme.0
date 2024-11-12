Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D1BD41D5F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=; b=MP9UfPsrlgOzX5qluyzhF3qApT
	0KcKd+4kasKhENrRs8w3jYHfqEJ+Xa6s6+vREDwdcL0n9lMrHfKrYxHSJKHIKFRcyjmWOq5VHqwX1
	9uwEuuYeWs1jvH+zaeQtSbKi0vu/k5yPt1M6MiEyFnpV2AYXxBwpowhAYwNLHCokEfa1WweZVd6wG
	gzbTCq+J3VurLzkNjQKlZBr09TCL4rmKv19+mZ9nNYV3uHT/aWHmINcH8zpw5rHcvA18t7Lom25Bq
	Mr0JLp0qf05UdbcnmtM9ZKKl5lT0K+Gooh+Be7TDZXPpSJt3KC5TvqozzjcMvq82nfPu7FgVY23+s
	yegkePtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAl4s-00000002QiR-149W;
	Tue, 12 Nov 2024 07:12:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAl0r-00000002Q2Y-38yJ
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 07:08:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60AA91F392;
	Tue, 12 Nov 2024 07:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731395311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=sbMKW/ZZt9DlH5SA+y/EXiSb5IMFILZ160su4hZf18CA0gzi77/hYrwEn0Bkt/MM2Hi5jC
	dLWyfclPAPs+zHVAxEmnMUvTND+9YH4vIyvjm9b8qbDE/I2JY2gVe7H+diSd/yNyztF+tA
	hX3RfYk35x+0KwAlTtmiJD6SbwKByY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731395311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=CekAcoEJOUJ9J7pCi6NFhTQ/VeSvse/ODooMi1PugFpm2y4rQkrXI7Ong18HECFFbWoYWJ
	gkqyJ76PrFfcOyCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sbMKW/ZZ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CekAcoEJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731395311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=sbMKW/ZZt9DlH5SA+y/EXiSb5IMFILZ160su4hZf18CA0gzi77/hYrwEn0Bkt/MM2Hi5jC
	dLWyfclPAPs+zHVAxEmnMUvTND+9YH4vIyvjm9b8qbDE/I2JY2gVe7H+diSd/yNyztF+tA
	hX3RfYk35x+0KwAlTtmiJD6SbwKByY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731395311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=CekAcoEJOUJ9J7pCi6NFhTQ/VeSvse/ODooMi1PugFpm2y4rQkrXI7Ong18HECFFbWoYWJ
	gkqyJ76PrFfcOyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C7C013301;
	Tue, 12 Nov 2024 07:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dpcTDO/+MmdYcAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 07:08:31 +0000
Date: Tue, 12 Nov 2024 08:08:30 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <54e689a5-cb34-4039-a79e-92034ec8e2d7@flourine.local>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
 <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
 <20241112044736.GA8883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112044736.GA8883@lst.de>
X-Rspamd-Queue-Id: 60AA91F392
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_230834_109108_B44B0813 
X-CRM114-Status: GOOD (  24.18  )
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

On Tue, Nov 12, 2024 at 05:47:36AM +0100, Christoph Hellwig wrote:
> This seems to mix up a few different things:
> 
>  1) adding a new bus operation
>  2) implementations of that operation for PCI and virtio
>  3) a block layer consumer of the operation
> 
> all these really should be separate per-subsystem patches.
> 
> You'll also need to Cc the driver model maintainers.

Ok, will do.

> > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > +			    struct device *dev, unsigned int offset,
> > +			    get_queue_affinity_fn *get_irq_affinity)
> > +{
> > +	const struct cpumask *mask = NULL;
> > +	unsigned int queue, cpu;
> > +
> > +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> > +		if (get_irq_affinity)
> > +			mask = get_irq_affinity(dev, queue + offset);
> > +		else if (dev->bus->irq_get_affinity)
> > +			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> > +
> > +		if (!mask)
> > +			goto fallback;
> > +
> > +		for_each_cpu(cpu, mask)
> > +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > +	}
> 
> This does different things with a NULL argument vs not.  Please split it
> into two separate helpers.  The non-NULL case is only uses in hisi_sas,
> so it might be worth just open coding it there as well.

I'd like to avoid the open coding case, because this will make the
following patches to support the isolated cpu  patches more complex.
Having a central place where the all the mask operation are, makes it a
bit simpler streamlined. But then I could open code that part as well.

> > +static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
> > +					unsigned int irq_vec)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	return pci_irq_get_affinity(pdev, irq_vec);
> 
> Nit: this could be shortened to:
> 
> 	return pci_irq_get_affinity(to_pci_dev(dev), irq_vec);

Ok.

Thanks,
Daniel

