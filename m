Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FCFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=npPu7v4PVxjYw5k81v34byZcxUoLWsQ8uewcVPzgU3Y=; b=sXyrqDm147vamUktJuzpG+eGiD
	t+mr9mWsidPvCQg1cOOgLvUQdSVwr46dzcmOYEnzhvff4q03kJpsys1XjIgnjMCp/3V8h55xxUoWq
	B5wyW3wcnaoupptsmUaXU/1tyny+z6EeFIL9fnfOC5uts/npnHkZ2yJczvgttd9GK6HGGxmYV3O3S
	+6q3CwC9bu2B1TLk+mEkEQVXZe0uY9VSOHnYMIgbdVmb/YTKOjxleGGZZc2OmQUk4fUeS4wDvzXcu
	LblhoMN/13LlnOcKGXHIewMU5uoe2k+iaPzatOXeKCNZKhOr7rtcjFR3CjdjM6asqdWoPSrHGdVKL
	pWcnlAFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmMOj-00Cm1X-MC; Wed, 04 May 2022 21:19:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmMOf-00ClyD-37
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 21:18:59 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BABED210E5;
 Wed,  4 May 2022 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651699132;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npPu7v4PVxjYw5k81v34byZcxUoLWsQ8uewcVPzgU3Y=;
 b=tM1dspGpfMipCiAbW0HO2dZVPEAgyrff0KMavj6bZk8T37R9hRgCKrWvzwgeAGT0wBlOIm
 ubeLZ7ieBvBdZyh1MDcuOhs1j09imPderIadxrCmq/Rsm19BAfVTGh1hT5vsADF9X2YLOS
 su7DARpA5vqfoa0MkPB71ULlFqjV3/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651699132;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npPu7v4PVxjYw5k81v34byZcxUoLWsQ8uewcVPzgU3Y=;
 b=vS6Y/NRPgUhS2xB+r59V5ZgrZyl8A56t3CcwGyemIqz6M8o7VVvzu6uPNAFvfQz1MtnccG
 5x8uPy6F8/V4gpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B60DD131BD;
 Wed,  4 May 2022 21:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ptTKKrvtcmJMMQAAMHmgww
 (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 21:18:51 +0000
Date: Wed, 4 May 2022 23:14:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
 Naohiro Aota <Naohiro.Aota@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "clm@fb.com" <clm@fb.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "chao@kernel.org" <chao@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, 
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
 "agk@redhat.com" <agk@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "kch@nvidia.com" <kch@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 00/16] support non power of 2 zoned devices
Message-ID: <20220504211440.GU18596@suse.cz>
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
 Naohiro Aota <Naohiro.Aota@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "clm@fb.com" <clm@fb.com>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>,
 "chao@kernel.org" <chao@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, 
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
 "agk@redhat.com" <agk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "kch@nvidia.com" <kch@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <CGME20220427160256eucas1p2db2b58792ffc93026d870c260767da14@eucas1p2.samsung.com>
 <20220427160255.300418-1-p.raghav@samsung.com>
 <PH0PR04MB74167FC8BA634A3DA09586489BC19@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a702c7f7-9719-9f3e-63de-1e96f2912432@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a702c7f7-9719-9f3e-63de-1e96f2912432@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_141857_463436_84F25A5F 
X-CRM114-Status: GOOD (  19.44  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 03, 2022 at 11:12:04AM +0200, Pankaj Raghav wrote:
> Hi Johannes,
> On 2022-05-03 00:07, Johannes Thumshirn wrote:
> >> There was an effort previously [1] to add support to non po2 devices via
> >> device level emulation but that was rejected with a final conclusion
> >> to add support for non po2 zoned device in the complete stack[2].
> > 
> > Hey Pankaj,
> > 
> > One thing I'm concerned with this patches is, once we have npo2 zones (or to be precise 
> > not fs_info->sectorsize aligned zones) we have to check on every allocation if we still 
> > have at least have fs_info->sectorsize bytes left in a zone. If not we need to 
> > explicitly finish the zone, otherwise we'll run out of max active zones. 
> > 
> This commit: `btrfs: zoned: relax the alignment constraint for zoned
> devices` makes sure the zone size is BTRFS_STRIPE_LEN aligned (64K). So
> even the npo2 zoned device should be aligned to `fs_info->sectorsize`,
> which is typically 4k.
> 
> This was one of the comment that came from David Sterba:
> https://lore.kernel.org/all/20220315142740.GU12643@twin.jikos.cz/
> where he suggested to have some sane alignment for the zone sizes.

My idea of 'sane' value would be 1M, that we have 4K for sectors is
because of the 1:1 mapping to pages, but RAM sizes are on a different
scale than storage devices. The 4K is absolute minimum but if the page
size is taken as a basic constraint, ARM has 64K and there are some 256K
arches.

