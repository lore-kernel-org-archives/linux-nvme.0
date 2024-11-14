Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660DAD65C53
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fH/J7W9xtRwFNQE/LUMlKXXmvZxw9o++gxI2KFMe4OE=; b=ejhSBHmqU4tp5F6/iF7srxgnCS
	Yzl5fZ1l/YXnFA9+/YvYOTsfAKKHlOzAhquxT5CpdmDzFnasYbYk5HlZv2DXAIX5WP7cxxc1ZduPd
	44ww1ByhOl0eiByrhjmSDe2mOjCxz2jNpmYUJ59UizmFn3a1WBq1vQBepl3mX3Krqn9qqL31Bqk1X
	ZW6oX4lyQRCrq79vg9/DppWhiieeo0sSMbbyf7bH9CvaW6lGmPNKFY4o0cpSGWH3Is7FRuCn6+nKf
	dgzPlz3nfRJr7xC8ymKwJqmQ2skOmrInU3ObEXDO05a8wpNHGWM79K5V5l31L+RFhP/rBwhUWKCU8
	houlUgIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBU2C-000000093eu-3KNj;
	Thu, 14 Nov 2024 07:12:56 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBTxu-000000092hY-4AYh
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 07:08:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5E6B21843;
	Thu, 14 Nov 2024 07:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731568109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fH/J7W9xtRwFNQE/LUMlKXXmvZxw9o++gxI2KFMe4OE=;
	b=ai55etLO0FKw5w7LyU52GCY+AHzLrBBtpPyfNh0CKsE2gih2w2w4BAX/3IoxLPy/uR8Tx3
	C9oueBw3vAzYeYqDdntv138TjcYZHyfh+5peUFZDLpirlAThYiXzqiz4EYP7pN4OFebUMR
	wEvDbC2q9iNxFZflhVQU2G3ZH87I3U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731568109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fH/J7W9xtRwFNQE/LUMlKXXmvZxw9o++gxI2KFMe4OE=;
	b=MrEu63DXOVGz4fm4cZa1w13ddQTMs02dpVVdhoDgzehPBvs3y9wIz4PeUa+kYjoAKfzEvy
	3GGDt+u3Nil67mAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nVVaLUcd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BFHtJys6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731568108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fH/J7W9xtRwFNQE/LUMlKXXmvZxw9o++gxI2KFMe4OE=;
	b=nVVaLUcdCP/xpYRdKAAcdXvEZYgw1pR1GqTz0o2UW+eaqcX+JrasaWh03IPdZclmOsasju
	v2RlDIIgXCpiMTeot9OzMo+5niPevZQauTeNj1JwdOFxQVPNT8iu4tSRYA9nI2iuqnZW+T
	NJEps6aDJVupwz88C67EYJLD98hxD6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731568108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fH/J7W9xtRwFNQE/LUMlKXXmvZxw9o++gxI2KFMe4OE=;
	b=BFHtJys6pFY7mSK1Ix781r9oc8LLrppSLNVx45P+hBpqpZWD71GMrgq9uZvg5TBtAibFNh
	nCTfdZCepww54pCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF9413794;
	Thu, 14 Nov 2024 07:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T9eWIuyhNWdnXQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 14 Nov 2024 07:08:28 +0000
Date: Thu, 14 Nov 2024 08:08:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <helgaas@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hannes Reinecke <hare@suse.de>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 07/10] scsi: hisi_sas: use blk_mq_hctx_map_queues to
 map queues
Message-ID: <395d3187-e87e-43b9-b590-635fde86b435@flourine.local>
References: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
 <202411140822.ZRutrwWP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411140822.ZRutrwWP-lkp@intel.com>
X-Rspamd-Queue-Id: B5E6B21843
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLbomrtoisjzkgzhj6iko5ju7u)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_230831_216234_850FF7CB 
X-CRM114-Status: UNSURE (   8.88  )
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

On Thu, Nov 14, 2024 at 08:36:35AM +0800, kernel test robot wrote:
> >> drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:3375:45: error: use of undeclared identifier 'COQ_IRQ_INDEX'
>     3375 |                 cq->irq_no = hisi_hba->irq_map[queue_no + COQ_IRQ_INDEX];
>          |                                                           ^

Argh, I forgot to fold my fix in...

