Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B4C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iEOPcjucFIURaJhj/gkoJRZskUOW+MNWkZ0s3Hk6b+k=; b=iu5k0QVmI8CKuxh+F/h2LRNDOW
	UMXCeliX1qVJHZubn3kVvXcM1FPvd9GXyai9enhkoXIB2GbNrUj8hcuJX2EHtKbOoOYljYlINp+Hg
	wF+zf7VaJg8FtQnzR/vrqaXBeboNTo1C8ACxRiunZfut8NO8gch7ZQoNM4H5iSnA1A/DfYoUBBPe7
	wiE5EdwCZCl2oINtFodjkXE8crzub5KFHrUb8LquyaUxUNd1xRFmemkufLtp9lcuQM+zNiMXMWCGk
	Ton/sgsJasBhkJnyYn6REQfjXrFtTbcZrrc8IkzLAw3pTGUuBbBY6PooF3l2SjGt8Fo5SkWAPoBIU
	z2fW53Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKwa-0000000BQez-1uUi;
	Mon, 29 Jan 2024 06:16:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKwX-0000000BQdP-23oh
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:16:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBDDC68B05; Mon, 29 Jan 2024 07:16:26 +0100 (CET)
Date: Mon, 29 Jan 2024 07:16:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 02/14] block: refactor disk_update_readahead
Message-ID: <20240129061626.GB19581@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-3-hch@lst.de> <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_221629_715536_FB522F9F 
X-CRM114-Status: GOOD (  15.11  )
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

On Sun, Jan 28, 2024 at 06:59:31PM -0800, Bart Van Assche wrote:
>> +	/*
>> +	 * For read-ahead of large files to be effective, we need to read ahead
>> +	 * at least twice the optimal I/O size.
>> +	 */
>> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
>> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
>> +}
>
> Would this be a good opportunity to change (PAGE_SHIFT - 9) into
> PAGE_SECTORS_SHIFT?

If I have to respin for some reason I'll include it.  Otherwise feel
free to send a trivial follow on patch.


