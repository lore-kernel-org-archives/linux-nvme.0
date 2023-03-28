Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13EDC76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFdEnhB5mcfMbHqNUhFqEu3JqOWMB759muW7J70LD30=; b=4GFUM68kTr1r5PYNOuoDow0neb
	Vh//2/c+gCCY3G5JZRr8P1OYEFVtLCK8WHfnxCUr+smNuN0vDJm6wujl4rPjS4PyWqqOOHp7ROngR
	dEIDI656GOmW4/nr2wKk6LxaW//cJLJqAzNCtHD9D1q7mYI61Pq3WSx1r0AuOHRIcTfBcRZlNeyBm
	ky5kqILE5TWDJA4hOZuq6AtwxmvRN0qqk7aZgTNnwumPZJM+w5icBEy5f3DbXdMxCpqbEHIdc2kFR
	smMeCl8jjWbJkXzifFpRfR911FMpCUI/T1F9B7WkrD+hJm77v2WKVHSXVhtGeOxp0Q2YlQpVusHjm
	4RdAQo9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxVw-00Cjvk-04;
	Tue, 28 Mar 2023 00:48:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxVt-00Cjuy-2A
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:48:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EADB86155A;
	Tue, 28 Mar 2023 00:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB0FC433D2;
	Tue, 28 Mar 2023 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679964513;
	bh=0rgESySpV8tmoV70b1vmivA1o41rDzU0AOIJVRQCvyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2FN0XYYjNzuSeDVvTlfWitJr6bKPJj8ZqBCs/wTltg4VC1ZZ5V1l/DsIViLQK5wR
	 SaqrGAiRypCickB8GfeKcuGFY+awOZHXGT2FGrzAvR85YXizRsPfybEQrRfXMV/c31
	 FFEBWIVL4dEZqhPdUWFJVNxVxJtFqWrlTJAAMOXcmZO98khBuMi1q8c5SiWlaqEeY9
	 SXRrLnzfJ92SmQp/YARsDSo45TYBNe05ShGLRq6DHcefPwxnhjfFFSnO1tdJG0f2Fb
	 yVdWoIcIqik8JfryJS/6n9qeg3YR+MLU16e4X01ox8UENWsEme2/Ag8LSNg4IfGEf5
	 nToL+OFGEIPQA==
Date: Mon, 27 Mar 2023 18:48:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_174837_785800_5E905B94 
X-CRM114-Status: GOOD (  25.10  )
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

On Mon, Mar 27, 2023 at 10:50:47PM +0530, Kanchan Joshi wrote:
> On Mon, Mar 27, 2023 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
> > > >     rcu_read_lock();
> > > > -   bio = READ_ONCE(ioucmd->cookie);
> > > > -   ns = container_of(file_inode(ioucmd->file)->i_cdev,
> > > > -                   struct nvme_ns, cdev);
> > > > -   q = ns->queue;
> > > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
> > > > -           ret = bio_poll(bio, iob, poll_flags);
> > > > +   req = READ_ONCE(ioucmd->cookie);
> > > > +   if (req) {
> > >
> > > This is risky. We are not sure if the cookie is actually "req" at this
> > > moment.
> >
> > What else could it be? It's either a real request from a polled hctx tag, or
> > NULL at this point.
> 
> It can also be a function pointer that gets assigned on irq-driven completion.
> See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
> and task_work_cb share the storage.
> 
> > It's safe to check the cookie like this and rely on its contents.
> Hence not safe. Please try running this without poll-queues (at nvme
> level), you'll see failures.

Okay, you have a iouring polling instance used with a file that has poll
capabilities, but doesn't have any polling hctx's. It would be nice to exclude
these from io_uring's polling since they're wasting CPU time, but that doesn't
look easily done. This simple patch atop should work though.

---
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 369e8519b87a2..e3ff019404816 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -612,6 +612,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (blk_rq_is_poll(req))
 		WRITE_ONCE(ioucmd->cookie, req);
+	else if (issue_flags & IO_URING_F_IOPOLL)
+		ioucmd->flags |= IORING_URING_CMD_NOPOLL;
 
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
@@ -774,6 +776,9 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	struct request *req;
 	int ret = 0;
 
+	if (ioucmd->flags & IORING_URING_CMD_NOPOLL)
+		return 0;
+
 	/*
 	 * The rcu lock ensures the 'req' in the command cookie will not be
 	 * freed until after the unlock. The queue must be frozen to free the
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 934e5dd4ccc08..2abf45491b3df 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -22,6 +22,8 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 };
 
+#define IORING_URING_CMD_NOPOLL	(1U << 31)
+
 struct io_uring_cmd {
 	struct file	*file;
 	const void	*cmd;
--

