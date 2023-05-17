Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A19C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u4Pzn0EDKPPv2gfDd8BL9GT8qDela6mTNPyn2wqCFJk=; b=A3bPxGeNRN4JwLAYxUo7PDTvY2
	7uzBpBEtbVrNyZ/fofWC8ErsB7lta5QyBwvQ71lnRIq5duWfU8sipqwlGCp2mPwvpmNjhpucfOKQ5
	YWgEfN+6xazxQp+N/GSUR4e9uW1MFxrHjdE+YhQTnBwSqotTEKZzM1jALUM66XbM6oXDNa3SJv7Qz
	lS8yI0HW3W5PBUOKv9m54UGe/gQhHyIhTqfDbr1BvmONPg9UILSXBzzyNI36CIHS0MwxGlWyN43Js
	QPWurVD6exnefQOmJoKRlt9gF/L9AyicY2GKZjb4fAwdAFXO3tMZRgT9HdEKaPOsbPAIGBmPHFTRq
	UxmtGnww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBVK-008eZ8-18;
	Wed, 17 May 2023 07:23:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBVH-008eXf-2o
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:23:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BDC468C4E; Wed, 17 May 2023 09:23:14 +0200 (CEST)
Date: Wed, 17 May 2023 09:23:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, joshi.k@samsung.com
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Message-ID: <20230517072314.GC27026@lst.de>
References: <cover.1684154817.git.asml.silence@gmail.com> <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_002320_055965_8742FC87 
X-CRM114-Status: GOOD (  10.84  )
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

On Mon, May 15, 2023 at 01:54:43PM +0100, Pavel Begunkov wrote:
> Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
> commands completion. It further delays the execution of task_work for
> DEFER_TASKRUN until there are enough of task_work items queued to meet
> the waiting criteria, which reduces the number of wake ups we issue.

Why wouldn't you just do that unconditionally for
io_uring_cmd_complete_in_task?


