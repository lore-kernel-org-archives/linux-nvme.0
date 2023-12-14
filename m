Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90020C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U3kF78ThuAxVfL4gt7QMgAUP14WPCtF13sAnc7Ibfc8=; b=pk+uGQX0VPAbAsBMF8wlpVJZJn
	eS6TBBX20OxEtNjgHgAdQbW+3wQoIq3DHI4D7qgY/I0OA9noCQFLh16WuYY9umgdpy37SPVzCrJH3
	klBotZmuIUpHQ/5VEP4orRCWN95BRMujMcfHcFuOe3SqGjrlR7is6mEXQbA4xBRnmMUdDV1HK+ToV
	6Nks7OvV70OooPCJUyjcFUvi5MFxRvW1DxU9wNd9efK31osc6vaZl2ZiDmoFzO+6ynmhv9SRugENH
	cvUvZ55VSSYYWdZ4hKQNmvAPYy1e32t/OnA2PtjXDxsziLgGikIeofXYjgLgs/gcBoXERr8nstKn9
	o8KBhQ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDoK6-000la4-2h;
	Thu, 14 Dec 2023 16:12:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDoK4-000lZS-1I
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 16:12:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F71968AFE; Thu, 14 Dec 2023 17:12:23 +0100 (CET)
Date: Thu, 14 Dec 2023 17:12:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	jaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231214161223.GA12810@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212110844.19698-2-john.g.garry@oracle.com> <ZXkIEnQld577uHqu@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXkIEnQld577uHqu@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_081228_583076_DD69AF81 
X-CRM114-Status: GOOD (  14.81  )
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

On Wed, Dec 13, 2023 at 09:25:38AM +0800, Ming Lei wrote:

<full quote deleted, please only quote what is relevant.


> >  	lim->dma_alignment = 511;
> > +	lim->atomic_write_unit_min_sectors = 0;
> > +	lim->atomic_write_unit_max_sectors = 0;
> > +	lim->atomic_write_max_sectors = 0;
> > +	lim->atomic_write_boundary_sectors = 0;
> 
> Can we move the four into single structure and setup them in single
> API? Then cross-validation can be done in this API.

Please don't be arbitrarily different from all the other limits.  What
we really should be doing is an API that updates all limits at the
same time, and I actually have code for that, I'll just need to finish
it.  I do not want to block this series for it, though.


