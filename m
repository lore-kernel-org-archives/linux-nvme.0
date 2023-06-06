Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620B9C7EE31
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcRxDdb3Mc4cvqAtyQu/VMBqgakZKB2/wbXVOO8uQ1A=; b=dYtD2b+1xvJovTO3Vbc1NVkQXD
	Ip6o+IyXUgTAd45mESVtDc6FtjU9tiASV+YKXC2ZaXoqGQ+lpVxB6y1B7jlybnx/tcrj+A1GsS2aj
	+ijeTmCSNh73p0Hv8fdJ4WJWCEZw1kT9mAc8uTHSJTddvH48EEMwUCCRAY71iEaQHO5YjOMqlddQA
	Uzo7Oos68bFK3toHicD3bpEqpeWA7roI5Etwttv4hsiZQp/v/aCDyUWeg5WzBTGHjBGXCVPYxaizL
	RpcWZIETfqigbOxrJYnfQvkMFEUv0hc6ON/lPxK8arJYinSG7SSL9Ic5WA4SK8AJRguXwKIOeDF/A
	JDVhU3Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6SFI-000qA4-29;
	Tue, 06 Jun 2023 08:40:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6SFE-000q8Q-2K;
	Tue, 06 Jun 2023 08:40:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EBBF67373; Tue,  6 Jun 2023 10:40:42 +0200 (CEST)
Date: Tue, 6 Jun 2023 10:40:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
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
Subject: Re: decouple block open flags from fmode_t
Message-ID: <20230606084042.GA30379@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606-raumtemperatur-languste-045c5472f6a0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-raumtemperatur-languste-045c5472f6a0@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_014048_927512_ADEEA5FB 
X-CRM114-Status: GOOD (  14.41  )
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

On Tue, Jun 06, 2023 at 10:27:14AM +0200, Christian Brauner wrote:
> On Tue, Jun 06, 2023 at 09:39:19AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds a new blk_mode_t for block open flags instead of abusing
> 
> Trying to look at this series applied but doesn't apply cleanly for
> anything v6.4-rc* related. What tree is this on?

Jens' for-6.5/block tree.

I also have a git tree here:

    git://git.infradead.org/users/hch/block.git blk-open-release

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-open-release

