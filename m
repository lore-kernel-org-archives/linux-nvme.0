Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DA4CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RF7Wos6zs59jKbd4D3cP+RlscHQ51IWuhg7tG6r/LEw=; b=YVSq99BygksOM4sukPUlFLEg2Q
	b111cjkwyPV7jVDSQRKbznOYxTBMfLK0PscZy2VKiyhDIy7aVT7SYZ83S1fl/s5pU8csZEGuAfMSQ
	NY7DnECnwbGRKk3k4r2HtzdX6OFD/I4WUcAgmkPc3r/OL5TpeCjUp3OsdMXkHWvLmbWkOuSwPHKCY
	S3wBueBL6ViWwgTdjAh7Rt3kGUHCJFbVdgR47C0OLY8cwXPkkQ65uBJRE4DQUCUzJfjSOKJYfub+h
	CcZVV/76RPI1k3iZLZQVaZ5vybgZRBg5YeSK9h9ECziKsgtpZdY60RVT93sk40atandkrcwss/8hR
	iPA3+X9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFutS-00000009wh9-0pO1;
	Mon, 03 Nov 2025 13:46:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFutO-00000009wgZ-3W2f
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:46:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55C98227AAA; Mon,  3 Nov 2025 14:46:37 +0100 (CET)
Date: Mon, 3 Nov 2025 14:46:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 02/15] block: freeze queue when updating zone
 resources
Message-ID: <20251103134636.GA25126@lst.de>
References: <20251103133123.645038-1-dlemoal@kernel.org> <20251103133123.645038-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103133123.645038-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_054643_042000_649034EF 
X-CRM114-Status: GOOD (  18.41  )
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

On Mon, Nov 03, 2025 at 10:31:10PM +0900, Damien Le Moal wrote:
> Modify disk_update_zone_resources() to freeze the device queue before
> updating the number of zones, zone capacity and other zone related
> resources. The locking order resulting from the call to
> queue_limits_commit_update_frozen() is preserved, that is, the queue
> limits lock is first taken by calling queue_limits_start_update() before
> freezing the queue, and the queue is unfrozen after executing
> queue_limits_commit_update(), which replaces the call to
> queue_limits_commit_update_frozen().
> 
> This change ensures that there are no in-flights I/Os when the zone
> resources are updated due to a zone revalidation. In case of error when
> the limits are applied, directly call disk_free_zone_resources() from
> disk_update_zone_resources() while the disk queue is still frozen to
> avoid needing to freeze & unfreeze the queue again in
> blk_revalidate_disk_zones(), thus simplifying that function code a
> little.
> 
> Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


