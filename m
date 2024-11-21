Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE69D75BC8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 06:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2635gp0iRI82xRhEMM9pjliL540i/eiJKC1io2OpoME=; b=TAZ1sWIZlRZeNVAnrtPQEYUE0V
	9vJBnkIJgZnnjUdSqNzV0EWGREsHX6pFKhJ99h8fFPO0pKHicL+I56WwxZ419122Xnfzh4xoVWoxs
	2XLoEubfw18B0cp0IcbVLzatk4vE/Tw7fWXbPXoqEGdUgXNl9JYm9n/LRgXOuuyNpX/tKvXFd+Hp4
	3Fw5xh0PhwFtgF5W+i+Tl6p6bcZ0VZ9eFivXLj+xXeqSimeDoPvITlN5leFQNKUJWv5bvPpbOd+Lu
	vGacDHH3+oPEh668tu6xFRTlUwAJKAA6JXTSxGzb0MMe7FXQnsgpqOlwSjNQkaTOL1T2xZkP3Qs5E
	8fisG1Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE154-0000000Gxbj-2mvg;
	Thu, 21 Nov 2024 06:54:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE152-0000000Gxb8-2oyC
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 06:54:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D51AB68AFE; Thu, 21 Nov 2024 07:54:13 +0100 (CET)
Date: Thu, 21 Nov 2024 07:54:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241121065413.GA22464@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de> <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com> <ZzeNEcpSKFemO30g@casper.infradead.org> <20241120173517.GQ9425@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120173517.GQ9425@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_225420_857935_0120978F 
X-CRM114-Status: GOOD (  17.33  )
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

On Wed, Nov 20, 2024 at 09:35:17AM -0800, Darrick J. Wong wrote:
> I like willy's suggestion -- what's the difficulty in having a SQE flag
> that says "...and keep going into the next SQE"?  I guess that
> introduces the problem that you can no longer react to the observation
> of 4 new SQEs by creating 4 new contexts to process those SQEs and throw
> all 4 of them at background threads, since you don't know how many IOs
> are there.

Which is why everyone hates the nvme fused commands with passion, and no
one but vmware actually uses them, and no other fused command pair
except for compare and write ever materialized.

> That said, depending on the size of the PI metadata, it might be more
> convenient for the app programmer to supply one pointer to a single
> array of PI information for the entire IO request, packed in whatever
> format the underlying device wants.
> 
> Thinking with my xfs(progs) hat on, if we ever wanted to run xfs_buf(fer
> cache) IOs through io_uring with PI metadata, we'd probably want a
> vectored io submission interface (xfs_buffers can map to discontiguous
> LBA ranges on disk), but we'd probably have a single memory object to
> hold all the PI information.

Agreed.  And unless I'm misremembering something, all proposals so far
had a single PI buffer for vectored read/writes.


