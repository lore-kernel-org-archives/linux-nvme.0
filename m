Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D469EC25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FDfev2XRL1yXC5cfA4G95FQrsHO1upVV9pZfbw8Ys+Q=; b=LoJZ2XDrbxfhwtOblNKrBrdWui
	+GLrI/8ULDsQ7kSm1RmjxaJSZI71JpfXcZS1SpPSwMl4zesJTWKUitNDCJ+GAUlTEYPG7zds4f2Tx
	U1oJHp0xwM85UE4xYuz0s6x1Twu2wZ++vhQ4IsbcG4FCUgIkkwgxQW1w/0c430Dp1ssgYCmd98036
	GVWl0+hRjUJhNyMaPLP/ugnp6UU1ZSo6zk+VI6WGjrls76UAnCtVdsxaxmrG8DV8hMNtJG6EHtbBR
	Q3FMxvfPcXP3MvYATpQxWK4zhg+bnSeLRoUIh8lnUmtYnw5Ux3Vh1rXwVSHBaMQfQNtfUOQ6kpSNn
	F3BCe4hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHaJ-0000000C1SC-2qKm;
	Sat, 01 Jun 2024 05:47:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHaF-0000000C1Qq-29wO
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 05:47:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EE1068D17; Sat,  1 Jun 2024 07:47:02 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:47:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Message-ID: <20240601054701.GA5613@lst.de>
References: <CGME20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b@epcas5p3.samsung.com> <20240520102033.9361-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_224715_722822_135E238A 
X-CRM114-Status: GOOD (  15.65  )
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

On Mon, May 20, 2024 at 03:50:13PM +0530, Nitesh Shetty wrote:
> So copy offload works only for request based storage drivers.

I don't think that is actually true.  It just requires a fair amount of
code in a bio based driver to match the bios up.

I'm missing any kind of information on what this patch set as-is
actually helps with.  What operations are sped up, for what operations
does it reduce resource usage?

Part of that might be that the included use case of offloading
copy_file_range doesn't seem particularly useful - on any advance
file system that would be done using reflinks anyway.

Have you considered hooking into dm-kcopyd which would be an
instant win instead?  Or into garbage collection in zoned or other
log structured file systems?  Those would probably really like
multiple source bios, though.

