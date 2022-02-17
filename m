Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69285C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ckybct3FPMLo0xdtJt/GmtfVHGW/Fz7SoVWRuRzIWI=; b=lDy97PZdZUTIKaiZpYY9RETxFw
	CxY7yXg21KP+5KDrH8eVdFPSXYDXrtyvlsqtDm2FUkyz5ryvDd0/M6FgfLOLNyfXiB2v+c2EEN0f+
	0OgWWCtYD3Tm+RBeMqOFmzyL+0VY+QYN5D4BNZ+JFCtPo5EL/64aX85zQHsGYcGYtpLiKKu+db+XS
	SS+kvrbaco7pr0Yb2mwjsiuNWdnHD/6XUKvmXIyRzut9Rsoe4I5WzzMrbhcJ/9IeC7Daq0JyDAKq9
	tTIz4HW5xMu2OFblJDPsw6j0mMfJ1XlIyIdumWPBDzQXd+YkmEaL2A3Pgr35iJ8aaIjrlRkJkU+so
	3vobKn1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKl1C-00BeW9-Q9; Thu, 17 Feb 2022 17:56:38 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nKl1B-00BeVy-81; Thu, 17 Feb 2022 17:56:37 +0000
Date: Thu, 17 Feb 2022 09:56:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>
Subject: Re: [RFC 01/13] io_uring: add infra for uring_cmd completion in
 submitter-task
Message-ID: <Yg6MVe2Qpy92CsNF@bombadil.infradead.org>
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142228epcas5p2978d92d38f2015148d5f72913d6dbc3e@epcas5p2.samsung.com>
 <20211220141734.12206-2-joshi.k@samsung.com>
 <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
 <CA+1E3rLpKp0h2x7CoFPXwsYOc4ZYg_sqQQ+ed8cJhq77ESOAjg@mail.gmail.com>
 <b11ede2b-b737-f99a-7b31-20d6b4eccb42@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11ede2b-b737-f99a-7b31-20d6b4eccb42@kernel.dk>
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

On Thu, Feb 17, 2022 at 08:50:59AM -0700, Jens Axboe wrote:
> On 2/17/22 8:39 AM, Kanchan Joshi wrote:
> > On Thu, Feb 17, 2022 at 7:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >> On Mon, Dec 20, 2021 at 07:47:22PM +0530, Kanchan Joshi wrote:
> >>> Completion of a uring_cmd ioctl may involve referencing certain
> >>> ioctl-specific fields, requiring original submitter context.
> >>> Export an API that driver can use for this purpose.
> >>> The API facilitates reusing task-work infra of io_uring, while driver
> >>> gets to implement cmd-specific handling in a callback.
> >>>
> >>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> >>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> >>> ---
> >>>  fs/io_uring.c            | 16 ++++++++++++++++
> >>>  include/linux/io_uring.h |  8 ++++++++
> >>>  2 files changed, 24 insertions(+)
> >>>
> >>> diff --git a/fs/io_uring.c b/fs/io_uring.c
> >>> index e96ed3d0385e..246f1085404d 100644
> >>> --- a/fs/io_uring.c
> >>> +++ b/fs/io_uring.c
> >>> @@ -2450,6 +2450,22 @@ static void io_req_task_submit(struct io_kiocb *req, bool *locked)
> >>>               io_req_complete_failed(req, -EFAULT);
> >>>  }
> >>>
> >>> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
> >>> +{
> >>> +     req->uring_cmd.driver_cb(&req->uring_cmd);
> >>
> >> If the callback memory area is gone, boom.
> > 
> > Why will the memory area be gone?
> > Module removal is protected because try_module_get is done anyway when
> > the namespace was opened.
> 
> And the req isn't going away before it's completed.

Groovy, it would be nice to add a little /* comment */ to just remind
the reader?

> >>> +{
> >>> +     struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> >>> +
> >>> +     req->uring_cmd.driver_cb = driver_cb;
> >>> +     req->io_task_work.func = io_uring_cmd_work;
> >>> +     io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
> >>
> >> This can schedules, and so the callback may go fishing in the meantime.
> > 
> > io_req_task_work_add is safe to be called in atomic context. FWIW,
> > io_uring uses this for regular (i.e. direct block) io completion too.
> 
> Correct, it doesn't schedule and is safe from irq context as long as the
> task is pinned (which it is, via the req itself).

Great, a kdoc explaining the routine and that it can be called from
atomic context and the rationale would be very useful to users. And ..
so the callback *must* be safe in atomic context too or can it sleep?

  Luis

