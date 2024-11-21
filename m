Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE134D63959
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=; b=D1sqR8+bMRJtdhH7TlC4eB/do5
	KucRQ1WdRQZtrTCk23RAqAwwRB0IeHznrrVaLRbgTW+47MNBITOLZoVRe73kYm9fouuTKh2j46I8D
	5gV8tRL9MDJI4IEzFV+Z4UrUYTqyfEiiPhZ/kEoHirHFVFbCSAWHVChDbbj0rcH4nwbzSV5ey2KqQ
	GbNOrWxZIRt+4qybg/lMtNw5E1Pa5AhmJOWrxzbx16FRXVjYJnogbaRHgUR4DP8w1km3zrGYQdGib
	eeZrW2s8OouQ4IogPhOanzAgq8FW5ohUoCHFCR+t4jaLIO7UCITGKy14r1VRIidt/qoc3yaLhkooN
	W06/RuYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE3js-0000000HGwD-1lpq;
	Thu, 21 Nov 2024 09:44:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE3jp-0000000HGvP-1OdQ
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 09:44:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB6DA211CA;
	Thu, 21 Nov 2024 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732182274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=hiJpjGUm8ogVrODQNPmQIO5MB3ah7hl2QrKIV86gMUAbYwhKDQyYipSUm1C/SmkrBxrHAR
	KAYw1tNwQJ3QjttQOuzGyHR2RRwL7+OmkVHQUldV/2FvXCgSau+/TCasp45nlJX7lUwDUk
	f4DpIGpHzi03I0eod6QBIJvg8J3+1EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732182274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=p09axkX1mUAAWJ72FOOLxepeR/y01fTuv2w3A7qiqBL6qN0WuKtMgpGIdbfu0u+qYD7t7H
	J1SmAKMd84rsJIAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=deNrSzzs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ylzFtLw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732182272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=deNrSzzszLXj7e2zlJNVCUm8l0E5oaKmQiZWmlo4h3ADER+hm8NpTcv514HN50obLbFUnb
	yA7OMixvGzU69SI3zoJGcdhJOGJ8ytzV4aDaurv6V2ckSDwrJoSxlYPnfIYM1xKW2LOAiz
	5468b3aUrdAn7GlH9Fp3KEWiHsSBRCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732182272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=4ylzFtLwSW2Q2dhX0IypXlzfPNdeRVmQ85OClmNaqdRg6RC+vW+g0fNc9MSyAs6sAQyYGu
	4XdPA31qqKF9zCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B74DC13927;
	Thu, 21 Nov 2024 09:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +eS3LAABP2e5XQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Nov 2024 09:44:32 +0000
Date: Thu, 21 Nov 2024 10:44:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 3/8] virtio: hookup irq_get_affinity callback
Message-ID: <ffe464b8-5991-49f0-9053-4f0a52af4fe7@flourine.local>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-3-c472afd84d9f@kernel.org>
 <eae15480-403a-45c8-a8d0-4a34339d6b36@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae15480-403a-45c8-a8d0-4a34339d6b36@oracle.com>
X-Rspamd-Queue-Id: DB6DA211CA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_014437_519382_06B22D57 
X-CRM114-Status: GOOD (  12.18  )
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

On Thu, Nov 21, 2024 at 09:01:49AM +0000, John Garry wrote:
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
> >   	of_node_put(dev->dev.of_node);
> >   }
> > +/**
> 
> nit: does this really need to be kerneldoc, as it is static?

No, it's not necessary, I didn't know what the rules for static
functions are. I'll update it accordingly.

