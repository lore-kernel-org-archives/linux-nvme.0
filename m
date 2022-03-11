Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2899C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NopFJbqdz3k/t/PgQ+v4eLqHiQWYYU5ZglRx8JUL8HA=; b=KTt4QvYqeRjKO8ktbM6OFuqp7p
	5RUTpujaLMB/hm8fZWDxi96Fw7DbK0DvXhtzszHrS/f8fWvhHgmyyOA23/JPmzjmifXCnimTXH9zz
	iGUbliwOw7JL6joXDpYTnPy1+S/HdnlRs/+nCZG7jCg91KR5i9yEbxqgjbQjsXdqS5G7e8CJQl4lM
	FF4/3E3GKQtt7D04oC6L7krVnwboGlwoOF/IAWFo4Bs+Co0o1qLQwSozbM+s1/mMJFqlL+CkhYtuR
	vJcRxRAlvhoOl9zdubJSeF2muUuG/f6oPXu98s9RPZY6EARCLGd9YuMManEWOtqh9JuT9n5ZBeVjb
	Dh3TCz7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSiMR-00HNRv-UA; Fri, 11 Mar 2022 16:43:27 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSiMO-00HNRj-AL; Fri, 11 Mar 2022 16:43:24 +0000
Date: Fri, 11 Mar 2022 08:43:24 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 00/17] io_uring passthru over nvme
Message-ID: <Yit8LFAMK3t0nY/q@bombadil.infradead.org>
References: <CGME20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696@epcas5p1.samsung.com>
 <20220308152105.309618-1-joshi.k@samsung.com>
 <20220310082926.GA26614@lst.de>
 <CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 03:35:02PM +0530, Kanchan Joshi wrote:
> On Thu, Mar 10, 2022 at 1:59 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > What branch is this against?
> Sorry I missed that in the cover.
> Two options -
> (a) https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-big-sqe
> first patch ("128 byte sqe support") is already there.
> (b) for-next (linux-block), series will fit on top of commit 9e9d83faa
> ("io_uring: Remove unneeded test in io_run_task_work_sig")
> 
> > Do you have a git tree available?
> Not at the moment.
> 
> @Jens: Please see if it is possible to move patches to your
> io_uring-big-sqe branch (and maybe rename that to big-sqe-pt.v1).

Since Jens might be busy, I've put up a tree with all this stuff:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20220311-io-uring-cmd

It is based on option (b) mentioned above, I took linux-block for-next
and reset the tree to commit "io_uring: Remove unneeded test in
io_run_task_work_sig" before applying the series.

  Luis

