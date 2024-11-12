Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62276D42BAA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=; b=ZnK9Cefo7L3jKShVTNqJ+bPATA
	ut6mSzdjpTVw8T59GET187u3ot4RVZl7/mDwP+droOr6neimzO1UTgdYv/QslvNNNeu9bO2M2pPSu
	BFtP8Xdtfh1CumZf0jl1jwTZKpbrjNe9y/5ljWEra8tdQ925ylVSlEAMsyNhHNzeiXALF1M442/Uy
	x0bjq30o4KLMc6Nlc38FWET8kIp6P8T5COGoDbuaRNIyo9vlenk9lDbYOewe1QLHYFnWpEyNt/Sb6
	bnyZrSIkAgIGrDU30IE+h4E+p/4614hkH8DXOUzGkPtfE3jeMguv38jjor3rUEGjrv06gqpx9qPjt
	H8yMqvcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAtlN-0000000490v-2M9F;
	Tue, 12 Nov 2024 16:29:09 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAtYD-000000046Vh-2tHF
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 16:15:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CFB61F451;
	Tue, 12 Nov 2024 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731428132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=u3cWQ+wMMzAJP2k50djmt7ul83n2pp3ULngZXQJrgOPferHT/zAjDf5sKR3BKNgjqIlg3S
	M+lBeQTR6jkT80Vd1vaHM/5KjtEAa/DIdsKeTWkfvO7r/SmCcvpWJeuvLDh4X40hUYmW/2
	/z8wG0vkcNSLPHUK9NJK8pfwjA4ZmVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731428132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=Vq25pLCB8TEXXhq7TDInKAnh0I12FTfGKkf/m4FzXhXeiANtYeVEJWqoJIux3sK73MS32c
	LrbEGMqGoC+sh8Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u3cWQ+wM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vq25pLCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731428132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=u3cWQ+wMMzAJP2k50djmt7ul83n2pp3ULngZXQJrgOPferHT/zAjDf5sKR3BKNgjqIlg3S
	M+lBeQTR6jkT80Vd1vaHM/5KjtEAa/DIdsKeTWkfvO7r/SmCcvpWJeuvLDh4X40hUYmW/2
	/z8wG0vkcNSLPHUK9NJK8pfwjA4ZmVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731428132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=Vq25pLCB8TEXXhq7TDInKAnh0I12FTfGKkf/m4FzXhXeiANtYeVEJWqoJIux3sK73MS32c
	LrbEGMqGoC+sh8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC27013721;
	Tue, 12 Nov 2024 16:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JJNjMyN/M2eAHAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 16:15:31 +0000
Date: Tue, 12 Nov 2024 17:15:31 +0100
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
Message-ID: <5967d256-037e-4ac8-a509-c6955b03db05@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
 <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
 <2024111215-jury-unlighted-3953@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111215-jury-unlighted-3953@gregkh>
X-Rspamd-Queue-Id: 0CFB61F451
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
X-CRM114-CacheID: sfid-20241112_081534_050392_9518A260 
X-CRM114-Status: GOOD (  21.77  )
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

On Tue, Nov 12, 2024 at 04:42:40PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 12, 2024 at 04:33:09PM +0100, Daniel Wagner wrote:
> > On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > > > +			    struct device *dev, unsigned int offset)
> > > > +
> > > > +{
> > > > +	const struct cpumask *mask;
> > > > +	unsigned int queue, cpu;
> > > > +
> > > > +	if (!dev->bus->irq_get_affinity)
> > > > +		goto fallback;
> > > 
> > > I think this is better than hard-coding it, but are you sure that the
> > > bus will always be bound to the device here so that you have a valid
> > > bus-> pointer?
> > 
> > No, I just assumed the bus pointer is always valid. If it is possible to
> > have a device without a bus, than I'll better extend the condition to
> > 
> > 	if (!dev->bus || !dev->bus->irq_get_affinity)
> >         	goto fallback;
> 
> I don't know if it's possible as I don't know what codepaths are calling
> this, it was hard to unwind.  But you should check "just to be safe" :)

The main path to map_queues is via the probe functions. There are some
more paths like when updating a tagset after the number of queues but
that is all after the probe function.

nvme_probe
  nvme_alloc_admin_tag_set
    blk_mq_alloc_tag_set
       blk_mq_update_queue_map
          set->ops->map_queues
	     blk_mq_htcx_map_queues
  nvme_alloc_io_tag_set
    blk_mq_alloc_tag_set
      blk_mq_update_queue_map
        set->ops->map_queues
          blk_mq_htcx_map_queues

virtscsi_probe, hisi_sas_v3_probe, ...
  scsi_add_host
    scsi_add_host_with_dma
      scsi_mq_setup_tags
         blk_mq_alloc_tag_set
           blk_mq_update_queue_map
             set->ops->map_queues
               blk_mq_htcx_map_queues

virtblk_probe
  blk_mq_alloc_tag_set
    blk_mq_update_queue_map
      set->ops->map_queues
        blk_mq_htcx_map_queues

Does this help?

