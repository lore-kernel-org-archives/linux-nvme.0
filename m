Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E566BC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YAvU/H8ewWgtj8+lNR19xNcK269Z+0oH3wD0bk8ZHoo=; b=Q8e49Zi7SvayOWco6o3mHNhNct
	+VEUwEmSOEg+YjrXD+vOQjx9E+Bul8mwoRD4mVoVU7MHes1bOYePdv1V2tNGrrh2bhET9T/bPGqHo
	n4dySK1bF7r25a/+DuBfQznic+UmpRxQehCLh+w453QBR3V3/BKMa9g7IBnQM5CUK+vSBiStTttbr
	yV2Y2vhYMG7U9lHgQ+jQa1iKO3VwrX6JjvMb2OhFNN0kDkIVktdlQT6zHfZTtrW89nrfLnzH51h6p
	5/hJ1FSroPXTY+/snlNr4FWyomPwzSL3xwBI+hjSCtlE0LQEqOGh/Sc9qddamO40q8xmI/yGnuT3N
	P4W8sIZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r17B9-006dFg-1i;
	Thu, 09 Nov 2023 15:42:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r17B8-006dFT-0o
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Nov 2023 15:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YAvU/H8ewWgtj8+lNR19xNcK269Z+0oH3wD0bk8ZHoo=; b=Rc31F659WDeW93mMNfNBwa+tdF
	uKwVofNS0q2HXkMP46RrMFTXTHha4qswZX/hwdgITzDg3dYgi7sLu7amPuG2nBv0Kf6i3urQ5MnQq
	hJHw22feJPvCysjpzWN9+ZaXes9oAio1bTIDx3bt9xmcKIz5w+UUsXbiM7/6b1JKDDCQfGDogqqg9
	NPb3sreQQcZAF+G2Yc/g1705bZgjnMLJidH45aFxrQMxRAZF20Yd96rPyMngzwmKy0LiGoAQBvlDT
	zK/Vo03uJK1tOnG7QSLRhq0FPmH5tkp/XnKZlIbXSH8owdhmWnwBGsCMqdXlPPCjdcizCHa6+eO4o
	k1pR69pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r17B2-00838t-P7; Thu, 09 Nov 2023 15:42:40 +0000
Date: Thu, 9 Nov 2023 15:42:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <ZUz98KriiLsM8oQd@casper.infradead.org>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <20231109153603.GA2188@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109153603.GA2188@lst.de>
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

On Thu, Nov 09, 2023 at 04:36:03PM +0100, Christoph Hellwig wrote:
> Also I really want a check in the NVMe I/O path that any request
> with the atomic flag set actually adhers to the limits to at least
> partially paper over the annoying lack of a separate write atomic
> command in nvme.

That wasn't the model we had in mind.  In our thinking, it was fine to
send a write that crossed the atomic write limit, but the drive wouldn't
guarantee that it was atomic except at the atomic write boundary.
Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
into a single 80kB write, and if the power failed midway through, the
drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
64-80kB and not the other three.


