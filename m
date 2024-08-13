Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA93C531DC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FE5no6wq38CpWswWx2uoo4/gsjYvCTGI7gMAOBb4YS8=; b=kg3qsXhJUly9RQyY9QnzpNdSVU
	4iObl5377Ic8SmpqHCm6VTrmJyZo4gp6iKowT+QW8dFvHl+4LsSK4f6h64g1sP2hS4TZel4TotF0D
	zk1FKTCQvMqPHV8OQM0hyOizowXCIi+4zbqlnD97CTCS+jq6/k5jXYou1xmkFP1K5Rh+ZzMVKQF/q
	mwH7TZtAKjxDfNH2Oykh8FEUr97at4Egx8HpMs/rpAXQe8CUvSAJbR+Yv3AWD2ANrsS8X9CGaRL8J
	wyJggLmBFj12nuW/NbANrv2hRDv4wicVSI5mV97Qi1NxJGpp2JiLMVw/MGd/4+Aa1Bnmlo8cJMaNx
	yzKncVHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdt22-000000047Ui-3XMW;
	Tue, 13 Aug 2024 15:01:54 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdo2S-00000003Ai5-0wVV
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 09:42:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5E082272C;
	Tue, 13 Aug 2024 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723542118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FE5no6wq38CpWswWx2uoo4/gsjYvCTGI7gMAOBb4YS8=;
	b=ifiMyxZsOkp+pjyu2jCxMc1kcA1fuJtRpzCKtdkwDndw5N/XHk95hgiV+0Ud/MDhXxyB/C
	3oYudBYpKM3X++RgFYZ+8/TXpccriQsYJ6PzFtnycSSCuLK8O3WEFwpoY8Vo+27ZpybE5u
	C29l2hFLcd3Ovqd/VHEzut4Ck9aKE4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723542118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FE5no6wq38CpWswWx2uoo4/gsjYvCTGI7gMAOBb4YS8=;
	b=y8ZsKrMtpi6Rs3i2ujWlOwlVrIu/gtEuF1KEMC6tVQmjUT/bMVFXpTxFrMIgTE2KcdmukZ
	8+8zBHeaMzq7PYAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ifiMyxZs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y8ZsKrMt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723542118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FE5no6wq38CpWswWx2uoo4/gsjYvCTGI7gMAOBb4YS8=;
	b=ifiMyxZsOkp+pjyu2jCxMc1kcA1fuJtRpzCKtdkwDndw5N/XHk95hgiV+0Ud/MDhXxyB/C
	3oYudBYpKM3X++RgFYZ+8/TXpccriQsYJ6PzFtnycSSCuLK8O3WEFwpoY8Vo+27ZpybE5u
	C29l2hFLcd3Ovqd/VHEzut4Ck9aKE4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723542118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FE5no6wq38CpWswWx2uoo4/gsjYvCTGI7gMAOBb4YS8=;
	b=y8ZsKrMtpi6Rs3i2ujWlOwlVrIu/gtEuF1KEMC6tVQmjUT/bMVFXpTxFrMIgTE2KcdmukZ
	8+8zBHeaMzq7PYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CFF913ABD;
	Tue, 13 Aug 2024 09:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NYNnImYqu2bxSwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 13 Aug 2024 09:41:58 +0000
Date: Tue, 13 Aug 2024 11:41:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
	Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <frederic@kernel.org>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, virtualization@lists.linux.dev, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 07/15] blk-mq: remove unused queue mapping helpers
Message-ID: <12ba2ff0-b8c9-46b3-bea0-56304cf7a7dc@flourine.local>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
 <20240806-isolcpus-io-queues-v3-7-da0eecfeaf8b@suse.de>
 <20240812090848.GH5497@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812090848.GH5497@lst.de>
X-Rspamd-Queue-Id: A5E082272C
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,oracle.com,redhat.com,broadcom.com,marvell.com,lwn.net,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,microchip.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLbomrtoisjzkgzhj6iko5ju7u)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_024200_434239_3379876B 
X-CRM114-Status: GOOD (  15.63  )
X-Mailman-Approved-At: Tue, 13 Aug 2024 08:01:52 -0700
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

On Mon, Aug 12, 2024 at 11:08:48AM GMT, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 02:06:39PM +0200, Daniel Wagner wrote:
> >   * Copyright (c) 2016 Christoph Hellwig.
> 
> None of my code left at this point :)

I do my best to reduce code :)

> >  /**
> >   * blk_mq_pci_get_queue_affinity - get affinity mask queue mapping for PCI device
> >   * @dev_data:	Pointer to struct pci_dev.
> 
> But on to something more substancial:  thes get_queue_affinity
> wrappers have nothing specific in them.  So maybe move them into
> the PCI and virtio subsystems instead and kill off these files
> entirely.

Make sense!

