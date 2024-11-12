Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F4D42BBF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=; b=FwLanAFDsP75QLp6KisDuBqVdh
	mxQAzPSqyhcMPTea2Umd0cuC49Czy3tol6SCdOAfoFTAVoOZXWVJnzrITflF0yjT0jV+uwKjcFUlV
	DY4fQGwF3h1p8uA2gIQ6vR35ZhlaQKAA34fvsjafWaAJeA3gs30ZXIueifafjiYoYUa2F9YPxFuhg
	JUHdV6ll8hvUvPC4u3obP5V6VtrulKWoePtkvsRl7ipEG7zWpTsZK4xlQ+O04tyS7PnC1MGRtUiYI
	GgFaqBuaW4csYeT6Cq4OBxUoPffBap7F9RwIWndbJ6HgXAC0FEr3sKyLRUc+lpbcBZMa85/AdOwBF
	zId4f0FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAvaI-00000004YHw-0TQB;
	Tue, 12 Nov 2024 18:25:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAvaC-00000004YHL-2fOd
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 18:25:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E13B11F74A;
	Tue, 12 Nov 2024 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731435942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=elNpQcgXmLRkPqJA301k3uLorPvi2Xxojc5xDYob+0TUKXa9+5i9pXw7v9f9Zz424NDXq9
	5i4DovSowO0VFzLB7DDPd6uOeS1ljK89W2FM8wH3lhL0ZmdrTinvQdKY91T5UzbYV9P5bd
	IeJm7qrejOX9KQo1Ppaho3NMP9MRJy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731435942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=upHQI7DtYNeYGXVigZl7tWevH/muN1LRM9QDvL7HEu2k4yEALj0/HYUSUECpBe7xXJ6LZJ
	XLXEwCmwQNtyUuBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731435942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=elNpQcgXmLRkPqJA301k3uLorPvi2Xxojc5xDYob+0TUKXa9+5i9pXw7v9f9Zz424NDXq9
	5i4DovSowO0VFzLB7DDPd6uOeS1ljK89W2FM8wH3lhL0ZmdrTinvQdKY91T5UzbYV9P5bd
	IeJm7qrejOX9KQo1Ppaho3NMP9MRJy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731435942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=upHQI7DtYNeYGXVigZl7tWevH/muN1LRM9QDvL7HEu2k4yEALj0/HYUSUECpBe7xXJ6LZJ
	XLXEwCmwQNtyUuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B355613301;
	Tue, 12 Nov 2024 18:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYx9KaadM2dmQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 18:25:42 +0000
Date: Tue, 12 Nov 2024 19:25:42 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <07662901-1100-4d03-9033-26ea16cfc54e@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_102544_845866_F9DA3FA0 
X-CRM114-Status: UNSURE (   7.62  )
X-CRM114-Notice: Please train this message.
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

The subject prefix has obviously a typo, should start with 'blk-mq:'

