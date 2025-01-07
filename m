Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD8BE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g+kgv40Nv3jmk18aQH5jxbGFwIkI3jfpro4OOu8qIeE=; b=UIuS9BIdpNcFFyO3qMZcAhSkvd
	hwppDgZ/rzS6d072dGhw+TfkNJqgr7GvPo1igtH2fPrOypbP2hrE4DkOS/xuM1OI+pM130R/Omo5E
	SHg5JV1jusAoDltXcx9xJ4ntL1t4SNXAGFP35f+R6nFWmCoM1uQF1zjVsP2sulzsxEaB0zu/Z6XNH
	4Ey2w5uh0NmtyHi6MTdoOazglU2F91O1O2g+E3ScHjgmMifMJWwWEWQ6/Jw/wE4TP3FVgJIaFWBKZ
	qleTt6QfuTcErPXhUg3ncASxcL6avo2U13VF3WpKsjSntPemtgMQSh5LIMgRMOY+5m1CkIufu+/LV
	NlfkVTOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6sp-00000004Mbf-35gR;
	Tue, 07 Jan 2025 10:32:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6mK-00000004Kik-1tF2
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 10:25:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736245539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+kgv40Nv3jmk18aQH5jxbGFwIkI3jfpro4OOu8qIeE=;
	b=QwGzK0qcfSUl+FIR3c9wA4D+1ZgGhpqQnszaxcsUt/ToQmBUFmzHgXN6N0W7tSE00jbL2M
	VfdA4b3lOLMnN9TQ+xd6v9zq2UgLWsOQpEMbKS5IJT/kVUEG2Z82oQpHBT4CXziK1bxL36
	qpJJ3+Um7rDUpt72P6nGLyoT1HA/LjI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-w5dnKRt2PPm84kKWsCv9qg-1; Tue,
 07 Jan 2025 05:25:36 -0500
X-MC-Unique: w5dnKRt2PPm84kKWsCv9qg-1
X-Mimecast-MFC-AGG-ID: w5dnKRt2PPm84kKWsCv9qg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A16BB19560A3;
	Tue,  7 Jan 2025 10:25:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.66])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 318F5195605F;
	Tue,  7 Jan 2025 10:25:25 +0000 (UTC)
Date: Tue, 7 Jan 2025 18:25:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs entries
Message-ID: <Z30AsQq89_lcstNl@fedora>
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-5-hch@lst.de>
 <Z3zXANbFk6GBZg_z@fedora>
 <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_022540_558833_8BD47464 
X-CRM114-Status: GOOD (  21.05  )
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

On Tue, Jan 07, 2025 at 01:21:14PM +0530, Nilay Shroff wrote:
> 
> 
> On 1/7/25 12:55 PM, Ming Lei wrote:
> > On Tue, Jan 07, 2025 at 07:30:36AM +0100, Christoph Hellwig wrote:
> >> De-duplicate the code for updating queue limits by adding a store_limit
> >> method that allows having common code handle the actual queue limits
> >> update.
> >>
> >> Note that this is a pure refactoring patch and does not address the
> >> existing freeze vs limits lock order problem in the refactored code,
> >> which will be addressed next.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> > Order between freeze and ->sysfs_lock is changed, and it may cause new
> > lockdep warning because we may freeze queue first before acquiring
> > ->sysfs_lock in del_gendisk().
> > 
> On contrary, in elevator_disable() and elevator_switch() we acquire 
> ->sysfs_lock first before freezing the queue. I think this is a mess and 
> we need to fix ordering. We need to decide ordering rules. IMO, the 
> correct order should be to acquire ->sysfs_lock before freezing queue. 
> Likewise with this patch now we acquire ->limits_lock before freezing the 
> queue.

__blk_mq_update_nr_hw_queues() freezes queue before acquiring ->syfs_lock too.

So yes, it is a mess wrt. order between ->sysfs_lock and freezing queue.


Thanks,
Ming


