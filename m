Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B163C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsyfQQduR2Jn1DAzSOXXDDe8TUGpranIznSTRIbm65o=; b=Hv7CCR0aMWcg9ab/KvtRrCqiX3
	12PgOlc7mFF/4wIOIQaByhGIJvzmk8oHOk8DFn6fICOPInK16609waUYGRnBm1YK5vsVXiF0hkpfZ
	Nyt2jIpYZ7w93bli+5GnNymTF6mqJ2EmcKdJf/+9iYZYHOdR+DoIJ8EUKskmfwzstQybw1DgrQhMo
	1XhMMT8U2f4jmdirPqlQxcup/fwi2CmutQzZu4r+JB813utsSiRNUJxFXKPnb6FO0Zb7VYqNhZihs
	E/n1uhawuPG0H971/A5Z/GxVKlaEWT/jdD//JpA6nBYI8yK3yrniETYj9RbVo597HjNJhqEV5X3IR
	yZUat/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phAh5-00EqH3-27;
	Tue, 28 Mar 2023 14:53:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phAh0-00EqFe-1T
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 14:53:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CD52861828;
	Tue, 28 Mar 2023 14:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81706C4339B;
	Tue, 28 Mar 2023 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680015177;
	bh=WoO6PtuXAgnsaZpuL2RMkjnPmQYDohpfLo07J0iy+ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIfP4LEInyloxi8XloSlWkjhcXAOjSK4wIGxLuKSTu88V6vS5egyeO/L19c0CFQv6
	 liK7kjOPvyxV+fn6I6/Q3JdywxBVVSjXcRDmO0hsMCYIxOv95k4CO3oULGKeQ2pGQ1
	 NfVTMP3WqnIb0ONg1TvDFJKB0bOgn+VgkbCo0vcM5qyPETFAv1jn4wPFc9QKUJ9OrF
	 KBgJEX6UdoSeX2RjH8SL8Cd7NIyOnlsULmwUdMPAN855rrSvbyQ3NqwLLOpGsCLhJx
	 qndmXmpskXXO2dDMcAWo2a/O/txp0g1LOzZ8fSfk3BP6yHqk4RRwOddgq27wHkL1kg
	 EM5vvcE4M/gsA==
Date: Tue, 28 Mar 2023 08:52:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
 <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
 <20230328074939.GA2800@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328074939.GA2800@green5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_075258_573874_29887225 
X-CRM114-Status: GOOD (  32.49  )
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

On Tue, Mar 28, 2023 at 01:19:39PM +0530, Kanchan Joshi wrote:
> On Mon, Mar 27, 2023 at 06:48:30PM -0600, Keith Busch wrote:
> > On Mon, Mar 27, 2023 at 10:50:47PM +0530, Kanchan Joshi wrote:
> > > On Mon, Mar 27, 2023 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
> > > > > >     rcu_read_lock();
> > > > > > -   bio = READ_ONCE(ioucmd->cookie);
> > > > > > -   ns = container_of(file_inode(ioucmd->file)->i_cdev,
> > > > > > -                   struct nvme_ns, cdev);
> > > > > > -   q = ns->queue;
> > > > > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
> > > > > > -           ret = bio_poll(bio, iob, poll_flags);
> > > > > > +   req = READ_ONCE(ioucmd->cookie);
> > > > > > +   if (req) {
> > > > >
> > > > > This is risky. We are not sure if the cookie is actually "req" at this
> > > > > moment.
> > > >
> > > > What else could it be? It's either a real request from a polled hctx tag, or
> > > > NULL at this point.
> > > 
> > > It can also be a function pointer that gets assigned on irq-driven completion.
> > > See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
> > > and task_work_cb share the storage.
> > > 
> > > > It's safe to check the cookie like this and rely on its contents.
> > > Hence not safe. Please try running this without poll-queues (at nvme
> > > level), you'll see failures.
> > 
> > Okay, you have a iouring polling instance used with a file that has poll
> > capabilities, but doesn't have any polling hctx's. It would be nice to exclude
> > these from io_uring's polling since they're wasting CPU time, but that doesn't
> > look easily done.
> 
> Do you mean having the ring with IOPOLL set, and yet skip the attempt of
> actively reaping the completion for certain IOs?

Yes, exactly. It'd be great if non-polled requests don't get added to the
ctx->iopoll_list in the first place.
 
> > This simple patch atop should work though.
> > 
> > ---
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 369e8519b87a2..e3ff019404816 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -612,6 +612,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > 
> > 	if (blk_rq_is_poll(req))
> > 		WRITE_ONCE(ioucmd->cookie, req);
> > +	else if (issue_flags & IO_URING_F_IOPOLL)
> > +		ioucmd->flags |= IORING_URING_CMD_NOPOLL;
> 
> If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags", we
> could have just cleared that here. That would avoid the need of NOPOLL flag.
> That said, I don't feel strongly about new flag too. You decide.

IO_URING_F_IOPOLL, while named in an enum that sounds suspiciouly like it is
part of ioucmd->flags, is actually ctx flags, so a little confusing. And we
need to be a litle careful here: the existing ioucmd->flags is used with uapi
flags.

