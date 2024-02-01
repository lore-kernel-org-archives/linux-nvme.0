Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A946DC47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 03:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3h5b05tR228P/1DdbjST3N+v0o21dfIjKISktnR6r58=; b=me5GbYmSHCyk0es0GAoyKKaIVw
	o1Wa5CQQ++6F6XqSKLXiKJW6pTWnvS+Sk1xddJc+UJeYFeBtOh+y0/nV+4Gz17VcjjsXeI/FnzSHz
	B9xHd/nmhkqmqRI8JOwxgw2UWFwcfXk2dIg9EIaenVn57HULWZNCOSiU4Lnbe5bQvspk94jh5uvWF
	u93MHUXGVitAvU+g1Zns7fmMY8N3xO4N1wS4bjQwgmGbqLq6p9S2xl3UeP3rVh1Ljlmau227oy1eR
	ksNMbLwznaxxpz4CY+zqMzMa6vXrfxQJ5MGSYn1wObByo4Z/4hRKPKN+jwqUtgB8kPvcN4+1YaSfa
	H6iwidxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVNgo-00000006Nwm-1ZVx;
	Thu, 01 Feb 2024 03:24:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVNgl-00000006NvG-3b1g
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 03:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706757867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3h5b05tR228P/1DdbjST3N+v0o21dfIjKISktnR6r58=;
	b=bcfGo1AsqFlfqz2PozmanFx7Sa9IVyU5ayGgg9DSSjiYDnvpbJD5UgEgGxdHg9Xs65rxeQ
	hnh5VB2p5UshvL5vCBorIfttDY7KWcVdah5Ixl1U/U+J+AVoty2q2y09DDVcvvspr30W4U
	fEH65RyE2zaxqiWnc6q2SELr3mZZGmo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-hNOuQwU4MwO5XVe8YFip3g-1; Wed, 31 Jan 2024 22:24:20 -0500
X-MC-Unique: hNOuQwU4MwO5XVe8YFip3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52615845E61;
	Thu,  1 Feb 2024 03:24:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.107])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AAA53C2E;
	Thu,  1 Feb 2024 03:24:10 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:24:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <ZbsO1wOD03NVD/9S@fedora>
References: <20240131130400.625836-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_192431_983681_355AB74A 
X-CRM114-Status: GOOD (  24.72  )
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

On Wed, Jan 31, 2024 at 02:03:46PM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> currently queue limits updates are a mess in that they are updated one
> limit at a time, which makes both cross-checking them against other
> limits hard, and also makes it hard to provide atomicy.
> 
> This series tries to change this by updating the whole set of queue
> limits atomically.   This in done in two ways:
> 
>  - for the initial setup the queue_limits structure is simply passed to
>    the queue/disk allocation helpers and applies there after validation.
>  - for the (relatively few) cases that update limits at runtime a pair
>    of helpers to take a snapshot of the current limits and to commit it
>    after picking up the callers changes are provided.
> 
> As the series is big enough it only converts two drivers - virtio_blk as
> a heavily used driver in virtualized setups, and loop as one that actually
> does runtime updates while being fairly simple.  I plan to update most
> drivers for this merge window, although SCSI will probably have to wait
> for the next one given that it will need extensive API changes in the
> LLDD and ULD interfaces.
> 
> Chances since v2:
>  - fix the physical block size default
>  - use PAGE_SECTORS_SHIFT more 
> 
> Chances since v1:
>  - remove a spurious NULL return in blk_alloc_queue
>  - keep the existing max_discard_sectors == 0 behavior
>  - drop the patch nvme discard limit update hack - it will go into
>    the series updating nvme instead
>  - drop a chunk_sector check
>  - use PAGE_SECTORS in a few places
>  - document the checks and defaults in blk_validate_limits
>  - various spelling fixes

For the whole series:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


