Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28675C02187
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2025 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hk3TAm3KuJF1wWNhcwjdPo+b1BCvU/jsmXrNHxfsCJo=; b=yyE87IgAzfscFyieItdVFwC+iQ
	YNUzBhQq7Na+5VSiVbdUicoZm0Xks8WtuvKouSsdh6wEPgijvsm0IhFPEGkQ11uV12xYY5vQL6NzG
	+zeQzJKQxKq29SJk83I8ZXEjdKDVxPg0Cxpb7qlJQJZctUw6f5HJvj0YEAaPVYYUoV6OB84/6wTlf
	KkxDsOJD3XITe5/rKeNk9mQjsd/WYdpbzR5VGPzWEaFmA25aEgdZ/pCzOyN1JoYKYkqqEkpk/THHz
	IlkLakLWMvKfL9fgAocSvGGjk+GIcVXhmYJiXMB7BkBhUN6XZjWt7hTLyJrEzVsJnPn+NIN0+VIxX
	ZBs9hpNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXjMs-00000008xBv-0DoK;
	Tue, 14 Jan 2025 16:02:14 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXKLd-00000005Dpn-35qx
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 13:19:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D13341F37C;
	Mon, 13 Jan 2025 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736774354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk3TAm3KuJF1wWNhcwjdPo+b1BCvU/jsmXrNHxfsCJo=;
	b=AzCXjj0IB7HJ0lRlZfkhGJ9yptYRAVmDHjPpl+PAX0axC4BEMgZeFboZGM8lsV7e6EYv5x
	tsKp7ZOGlY7/IxbVIonpm7mnDaK0GsYpfZa6t1AElG3Ij+7pB2WKPpr3NkRJhUb6OMBT7H
	yN9dBqxGdUBcuJj2PEr+LgNz5bzMULM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736774354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk3TAm3KuJF1wWNhcwjdPo+b1BCvU/jsmXrNHxfsCJo=;
	b=Y6Nf78CCmw1r042Y0Fgj387JxecUE5Atb8GuuYI7GkCPF14NwtorxBu6pdKNojRAL0FQvz
	QpqHePj1TvHsQTDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736774354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk3TAm3KuJF1wWNhcwjdPo+b1BCvU/jsmXrNHxfsCJo=;
	b=AzCXjj0IB7HJ0lRlZfkhGJ9yptYRAVmDHjPpl+PAX0axC4BEMgZeFboZGM8lsV7e6EYv5x
	tsKp7ZOGlY7/IxbVIonpm7mnDaK0GsYpfZa6t1AElG3Ij+7pB2WKPpr3NkRJhUb6OMBT7H
	yN9dBqxGdUBcuJj2PEr+LgNz5bzMULM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736774354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk3TAm3KuJF1wWNhcwjdPo+b1BCvU/jsmXrNHxfsCJo=;
	b=Y6Nf78CCmw1r042Y0Fgj387JxecUE5Atb8GuuYI7GkCPF14NwtorxBu6pdKNojRAL0FQvz
	QpqHePj1TvHsQTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC67B13A6F;
	Mon, 13 Jan 2025 13:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nbj4LdIShWc1IgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 13 Jan 2025 13:19:14 +0000
Date: Mon, 13 Jan 2025 14:19:14 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Don Brace <don.brace@microchip.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, storagedev@microchip.com, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 8/9] blk-mq: use hk cpus only when
 isolcpus=managed_irq is enabled
Message-ID: <4047eb51-ee6b-46ae-a67b-ce74c54c41e7@flourine.local>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-8-5d355fbb1e14@kernel.org>
 <Z2PlbL0XYTQ_LxTw@fedora>
 <cc5e44dd-e1dc-4f24-88d9-ce45a8b0794f@flourine.local>
 <Z2UwvQoDM3f4zAxG@fedora>
 <ae9abe4c-010a-41ff-be44-1d52a331eb11@flourine.local>
 <Z4Hl_oQhJ2u6g2B3@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Hl_oQhJ2u6g2B3@fedora>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,oracle.com,marvell.com,microchip.com,redhat.com,linux.alibaba.com,linux-foundation.org,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtq7xx1p6rx585ucya5i3u39z)]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_051917_921939_B7D17EF8 
X-CRM114-Status: GOOD (  30.78  )
X-Mailman-Approved-At: Tue, 14 Jan 2025 08:01:04 -0800
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

Hi Ming,

On Sat, Jan 11, 2025 at 11:31:10AM +0800, Ming Lei wrote:
> > What about a commit message like:
> > 
> >   When isolcpus=managed_irq is enabled, and the last housekeeping CPU for
> >   a given hardware context goes offline, there is no CPU left which
> >   handles the IOs anymore. If isolated CPUs mapped to this hardware
> >   context are online and an application running on these isolated CPUs
> >   issue an IO this will lead to stalls.
> 
> It isn't correct, the in-tree code doesn't have such stall, no matter if
> IO is issued from HK or isolated CPUs since the managed irq is guaranteed to
> live if any mapped CPU is online.

Yes, it has different properties.

> Please see irq_do_set_affinity():
> 
>         if (irqd_affinity_is_managed(data) &&
>               housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
>                   const struct cpumask *hk_mask;
> 
>                   hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
> 
>                   cpumask_and(&tmp_mask, mask, hk_mask);
>                   if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
>                           prog_mask = mask;
>                   else
>                           prog_mask = &tmp_mask;
>           } else {
>                   prog_mask = mask;
> 
> The whole mask which may include isolated CPUs is only programmed to
> hardware if there isn't any online CPU in `irq_mask & hk_mask`.

This is not what I try to achieve here. The main motivation with this
series is that isolated CPUs are never serving IRQs.

> > I was talking about implementing the feature which would remap the
> > isolated CPUs to online hardware context when the current hardware
> > context goes offline. I didn't find a solution which I think would be
> > worth presenting. All involved some sort of locking/refcounting in the
> > hotpath, which I think we should just avoid.
> 
> I understand the trouble, but it is still one improvement from user
> viewpoint instead of feature since the interface of 'isolcpus=manage_irq'
> isn't changed.

Ah, I understood you wrong. I didn't want to upset you. I thought you
were fine by changing how managed_irq works.

> > Indeed, I forgot to update the documentation. I'll update it accordingly.
> 
> It isn't documentation thing, it breaks the no-regression policy, which crosses
> our red-line.
> 
> If you really want to move on, please add one new kernel command
> line with documenting the new usage which requires applications to
> offline CPU in order.

Sure, I'll bring the separate command line option back.

Thanks,
Daniel

