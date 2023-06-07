Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E51DC83003
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXb/uaqR0x5/NbgjksTcXwSkQHw+GeMJrx4xaN4v7MY=; b=p2qkt+rSuXC/Qcs53IBhAa9jL8
	TvuJVkGnoVOVZxepltlo7JK95EtUPCXUljwgaCLiefJAca0lRSAeSd0gknU4hb8xNXCe0J4JUlu+K
	K208id6TNGb2vwgmJnL/wBonp2eOXoLBLzMS80scuk7QxdyqUHurG51700dqyHE9g5zBucLV34QLc
	rVegg/eLDaootTXqcOib3UZJ1ppLnccxi6KFs1vvML1AXOYy9FYfhB2Eb3igMD7zP8Dw3fup2O5uG
	hVNTdEUCPaMbyhsZpOkvzJUH4WubeiIeFQRA8R5zh94aTCFLysbWSqucrLtHAvTMj06QQg2HSTWC2
	ndjWHnEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oLI-004uev-2n;
	Wed, 07 Jun 2023 08:16:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oLF-004udr-27;
	Wed, 07 Jun 2023 08:16:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 326BC6397D;
	Wed,  7 Jun 2023 08:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DCEC433EF;
	Wed,  7 Jun 2023 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686125788;
	bh=RXb/uaqR0x5/NbgjksTcXwSkQHw+GeMJrx4xaN4v7MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7HLq/BSC9BMU8P4kJMjo5MRJvyXbwS4/2PvvwAgM8ZW1dL92Hwr6Zk7SS4cudd43
	 YqaP0WroUvYa+J2A0NcRIinvLRsnSH3+zo1FaTyPgQ4GnhYB7qgc3d/Go72HNsVxQF
	 2VnZeMObpLaXQgi8iTif/MccBCn6vLk1nxwqHzPzuxFsvOp3CDpoMGoMBUNPzKqJ+9
	 MDPrw2poPrPBCR3aAKE82p3/3e6I3qqlouz4S7jup9ehDAbiUr/4WJT37Mf7snmVlY
	 xWYx9JWoneLZBkWhVBZeWvh/L+gD953X7yEXsyewcrazZ0kGnjene02lhM27pPq0WM
	 4vEu4pR4sz/Jw==
Date: Wed, 7 Jun 2023 10:16:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/31] cdrom: remove the unused bdev argument to
 cdrom_open
Message-ID: <20230607-fahrdienst-leidwesen-f4192e429765@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_011629_735275_69B15881 
X-CRM114-Status: GOOD (  10.33  )
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

On Tue, Jun 06, 2023 at 09:39:21AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

lgtm,
Acked-by: Christian Brauner <brauner@kernel.org>

