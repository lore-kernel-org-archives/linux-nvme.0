Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BAAC83F12
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubhxOKVUHL8/5bm3fUBH0jxyHNpaixPV0ONYDl+ytLo=; b=jy8fHMJ3uoCsUvYT6grkchqwby
	WZslGzrqRFBorw+LV+T5C9xEQfwQfT1Bf+kyNuLll55XJqGJnK6y/czO2ijiLZwb67E2AejFNUP8M
	33Dk6i9OJCOwfoZiiCP2M/EXuh9T5Fx1A1ASPesnwBGL8kpdHpeyujvT0T5J50Lf9M+/PprFWtYhH
	5Nw7l5mLhXMi/XgXVde04ZmaLCtZPds5AVZfk8ocYtYyTMwDCp9fjJaz/ncnFC3sNTxHEbcPHkLbV
	QOgz7Uuwvv+7PWKZwdxiffA8vRZnN3jn3tCuHuTsN0/3c1v8jPmj6PdezOtQ3SMEXIcb51gOfRM5K
	Epg6/OWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qab5P-009XQl-04;
	Mon, 28 Aug 2023 12:11:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qab3z-009XEn-35;
	Mon, 28 Aug 2023 12:09:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFEA56732A; Mon, 28 Aug 2023 14:09:40 +0200 (CEST)
Date: Mon, 28 Aug 2023 14:09:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
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
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/30] block: also call ->open for incremental
 partition opens
Message-ID: <20230828120940.GB10552@lst.de>
References: <20230608110258.189493-1-hch@lst.de> <20230608110258.189493-2-hch@lst.de> <20230825024457.GD95084@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825024457.GD95084@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_050948_161263_507EAC56 
X-CRM114-Status: GOOD (  14.18  )
X-Mailman-Approved-At: Mon, 28 Aug 2023 05:11:10 -0700
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

On Fri, Aug 25, 2023 at 03:44:57AM +0100, Al Viro wrote:
> That got me curious about the ->bd_openers - do we need it atomic?
> Most of the users (and all places that do modifications) are
> under ->open_mutex; the only exceptions are
> 	* early sync logics in blkdev_put(); it's explicitly racy -
> see the comment there.
> 	* callers of disk_openers() in loop and nbd (the ones in
> zram are under ->open_mutex).  There's driver-private exclusion
> around those, but in any case - READ_ONCE() is no worse than
> atomic_read() in those cases.
> 
> Is there something subtle I'm missing here?

No.  When I had to add unlocked readers I did the READ_ONCE initially,
but reviewers though the atomic_t would be better.  I didn't really feel
like arguing so went with this version.

