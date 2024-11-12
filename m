Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E6D42B9B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=; b=YN6IxoZ/cIEDvtj+R5DfA7N9FI
	HkL8ZpjtS0CTLT/nY4C8EhJXL/zBvdrfV+bKCa3qXlecTuTfdUCuvno++3hECWSepf004qGYt7tzZ
	DY6CNBwsl2C2KhhGPoD8PbpZyZP2Ln7Ysj9kusjKbvlU2aUeMFcrIy4D2aRvirFM3C8PSEejVA8rn
	t1k1PSsckL3r2xaMrjcoPgji8z4LzHbUf0M4d0lBONLsvwvXOcp4Y5EYIwjTdKbU7MdUEpJKLK70m
	Yom+yWizg4n3gR/iyOUXcPn5BiGy4w6n+W1G5js9n4wGt69sD4Ui4BXom7nMPtYhquuE6Y/kuUUcg
	X/RwC0Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAstL-00000003y26-2NXL;
	Tue, 12 Nov 2024 15:33:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAstG-00000003y0W-3FA4
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 15:33:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00C0921264;
	Tue, 12 Nov 2024 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731425591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=f0NvnLrErEahw7ahsZfdQmC0GiVV6+LO6vqelxZ2ftKRu4seUqwwytgh+726l9TRHxawpT
	eKIG/aWwB6ykIrTRAgGtlpPUwjqOhsNzwu4Qdj6+r8EWofdMiPUcSxmn8zBTf5r7hTNYLE
	p1cmx8GdJrEvVHEKAdaaB6iPVNB0NQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731425591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=1JvtkDuTeB8JxyYw5xAbPBD8guJ57YeS4OP4m7MaJlOzvDND3TKg6kkuRr59Kw1Xbkp/x8
	Sbln7Dt7KyEdcPAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hpDFdJxD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BZoZbY2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731425590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=hpDFdJxDsY9GHAjOmLZ3Mh2dcdth54QmUx8ReB0Ae+cAqlwaeCXAt055ts540wFiRElTpR
	Y4EljyxN4WfvzvedkyoH29w4QyNptZJvdzijQ5NoUFSuJoMCqBIuJFniui4bvOmkIltP6F
	6FH5DBdmzhWZFxia44Ij/gzycUFJeQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731425590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=BZoZbY2JFZQS5LyKsdVgHYuDFwbOupwlWTBgqTt3e5qtvOouK8CG6uCfjFtedZHe98aV73
	nVu7m6+LWmkDt7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D264813721;
	Tue, 12 Nov 2024 15:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uT4wMTV1M2ddEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 15:33:09 +0000
Date: Tue, 12 Nov 2024 16:33:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111202-parish-prowess-78bc@gregkh>
X-Rspamd-Queue-Id: 00C0921264
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_073314_995383_46CB039F 
X-CRM114-Status: GOOD (  15.45  )
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

On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > +			    struct device *dev, unsigned int offset)
> > +
> > +{
> > +	const struct cpumask *mask;
> > +	unsigned int queue, cpu;
> > +
> > +	if (!dev->bus->irq_get_affinity)
> > +		goto fallback;
> 
> I think this is better than hard-coding it, but are you sure that the
> bus will always be bound to the device here so that you have a valid
> bus-> pointer?

No, I just assumed the bus pointer is always valid. If it is possible to
have a device without a bus, than I'll better extend the condition to

	if (!dev->bus || !dev->bus->irq_get_affinity)
        	goto fallback;

