Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CB7CCF2E3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCjmpspcPpS38WYBBQYovAwzUdEJHovl54RGs3q/tTo=; b=VmzC+cM2p/TZPCoPPtptzVJ0c/
	qG0v3HGLIMSfFkVbDKzQsFBiHXneu//RrMHKeTlaDm5h1yTBgnN0ZY+naZDueuLx1fF1fBMq4xNrP
	RAFxscVV2Kfp7Q9nR8x59b+oZNAo4gHXHbkPzz46/WyQDUGUwvg1qVaqJSrinA50VKK4kl16Vvorb
	1D1gf+zONWucomFRhlvT2DyazE+f70kmYL5RlBNIR7PHd0p/SfQgV61S6EYXAb7CKRCv/RbSqGk/x
	mrDB/c7VGhTu4UCmx/rqGv9wmipnnASmgkRM1YKv8BuCxcYpoJNGgVqy+YWUk2oRY69bFnOSC5Ebx
	gWPgqUCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInbg-00000007XMN-1Qgl;
	Mon, 19 Oct 2026 13:40:52 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInbb-00000007XKT-3kBK
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 13:40:50 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-157fe9d771bso706213c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792417247; x=1793022047; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCjmpspcPpS38WYBBQYovAwzUdEJHovl54RGs3q/tTo=;
        b=RCehLN0lQIr6m9mKJNNKNWHxcOxwbf2R8oDF51MbJnyb1XdxZY+ChhZKX+Vj50oCEg
         0e6CToI3wwhnIEfF6u3lDTcZAhOXWYp/0JIcndlZGZS7VlcWhMiuetIT6yfE5yS4hwDj
         lu6AD1WWA3SqOPg5YUsJhwNmH6jv0UPdb/aRrSpg1H6sdYtn8wW8BuEY+A8LjAI21YK2
         W1ynJAEtczl7r64c2LcgZfckHbXT3jsbVogcrYKFi7/yDkmTEZihH+5EiST27AF6+bA5
         oRpGl7w6GHg9pEKTQgFkS/hhIP4ZnyBBPAAAMJIBMKIZtrq3KF4auyAIVPp1rYAKabto
         rzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417247; x=1793022047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCjmpspcPpS38WYBBQYovAwzUdEJHovl54RGs3q/tTo=;
        b=TaVWBcgXv1mxWuwBOrWRIiTCBBULs7ty+wOsrKr+Ko5easJxzBd91EWzJ0Q+Vs555y
         6t1v5twPk3hkJW1/tFxn7nNWoBzVvkGkJx0A+Ix1/xpdfLfTB9gAYFUSqtU7xpCTuvYA
         3nxT6hM5e0/vU0M6AtNNPqdrS5o/qQKBZn+yS8o+WcqWJjQvQoORjRVDfGCwv5aEZjeu
         70DXiDN/B/9HS3UL6CciVamRicu+HTnqjLxIlClk/5FNvxh9+w+EDKNqPr++st39uhq2
         4SS0v8QT3LNTiFDk7JDF2E03ljZPQtQxglGQlNJGPISH0FG2yhuQRisU2qlfwh44Z0kq
         /PQA==
X-Forwarded-Encrypted: i=1; AKwUvBw0Dhk4sD2nkT91APHJD5ZFWlyvEgJLDjImXCZcLc6ymapFyX1v8bhyS805DLqkKPOJraIR1SrJ3050@lists.infradead.org
X-Gm-Message-State: AFq9FYKLDdgYLfpY+B84bCQ9dwVDYbMabxSpBTzRvcLjt2yJfaT3pOC7
	684eCvDocJ0znJ2jYdD2hTF4wcsM+xxhp6swjcjT1Ted9j/gdeXaF00=
X-Gm-Gg: AYBFou0GK3IInCe6xUQ6vt6D61vQ9tPNkaTuiANlWPgLcvT0hR/YdBEQ3zRWEtOBe3k
	LiP2IMXj2gojlQmlwvenv2wDTSbUEXQpsx7+AKUqIMGi6Suj88ym0YMmVoq3XhhGnoMCRvwPhSA
	3BEazyIzDMuw0rjOiKpZ/AkEdBK485jdu1X+mhhrx8AVtdHczwB3vt7pdkwjDHjIeWfrZsjIDsV
	ak43HlzNJle44AnuXhElCcN3RUa3vlRlnGrx99luJ7XmhduR6KlbPsg8tS/FMvmq5UjVwUgdjL7
	+bJXEFDAHnXmLaXXAoJ/8xxVK9Pt6J+Djd3aEuW0yvcN6gbKrPWmUC6CuMSVveQby/19c6GaEBz
	t/6z21TNROORZ/CbUeY8ipdwOZi2w3FPs24Dd2jy6agixATDbiPsWe6qt0Hb5E1PRaJPEStxZ6U
	pHFnRpSChuUAvFrf/eZK+XrCOV1LGanBvohuB9v9jgU3umzdoDX7RD/a576N8dbdBZOkMgZqhYM
	+GploVyDhYYQdAZeKw/QjrfRFZdNz3qgWdlybQof3KpwfqC
X-Received: by 2002:a05:7022:170d:b0:143:3617:c595 with SMTP id a92af1059eb24-1850c223bb9mr10480854c88.1.1792417231454;
        Mon, 19 Oct 2026 06:40:31 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:e55a:9f78:eb3b:17e1:f1b6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm29078300c88.17.2026.10.19.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:40:30 -0700 (PDT)
Date: Mon, 19 Oct 2026 19:10:22 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, 
	joshi.k@samsung.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	io-uring@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
Message-ID: <vx4ugjq6wol6elipmwkuhtpk3qnanpwou6g73dxrjona3nepd4@pvetkgijfsx5>
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
 <79627452-98d3-4e8d-9c37-ceda0796d59c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79627452-98d3-4e8d-9c37-ceda0796d59c@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_064047_933113_A13CF465 
X-CRM114-Status: GOOD (  20.34  )
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

On Sun, Oct 18, 2026 at 11:06:16PM +0100, Pavel Begunkov wrote:
> On 10/16/26 11:34, Anuj Gupta wrote:
> > From: Anuj Gupta <anuj20.g@samsung.com>
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 3aa5d2f2dfbb..6343da1f6c05 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -458,6 +458,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> >   			status = blk_status_to_errno(err);
> >   	}
> >   	io_uring_cmd_set_res32(ioucmd, status, result);
> > +	io_uring_cmd_detach_dmabuf(ioucmd);
> 
> It's not great spilling the responsibility for [de,a]ttaching
> between nvme and uring_cmd code. Is there a way to stash it
> all under io_uring?

The natural place would be __io_uring_cmd_done(), but that runs from
task_work, while the ref has to be dropped at hardware completion, like
io_complete_rw() does.

Hooking io_uring_cmd_do_in_task_lazy() would avoid changing the NVMe
call site, but would add a non-obvious side effect to a generic
task_work helper. How about a separate helper that drivers call from
end_io instead? This keeps the dma-buf handling in io_uring while NVMe
only reports that it has finished accessing the data.

Something like this on top of this patch:

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6343da1f6c05..6a7d1cc7b716 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -458,7 +458,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 			status = blk_status_to_errno(err);
 	}
 	io_uring_cmd_set_res32(ioucmd, status, result);
-	io_uring_cmd_detach_dmabuf(ioucmd);
 
 	/*
 	 * For IOPOLL, check if this completion is happening in the context
@@ -473,7 +472,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 			blk_rq_unmap_user(pdu->bio);
 		__io_uring_cmd_done(ioucmd, 0);
 	} else {
-		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
+		io_uring_cmd_hw_done(ioucmd, nvme_uring_task_cb);
 	}
 	return RQ_END_IO_FREE;
 }
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 33e0ebeea5a0..0a89f5faf88c 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -70,7 +70,8 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
-void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd);
+void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+			  io_req_tw_func_t task_work_cb);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -138,7 +139,8 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 	return -EOPNOTSUPP;
 }
 
-static inline void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
+static inline void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+					io_req_tw_func_t task_work_cb)
 {
 }
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 0e0509edec6f..11a8ed1ba03a 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -50,12 +50,6 @@ void io_uring_cmd_cleanup(struct io_kiocb *req)
 	io_req_uring_cleanup(req, 0);
 }
 
-void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
-{
-	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
-}
-EXPORT_SYMBOL_GPL(io_uring_cmd_detach_dmabuf);
-
 bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 				   struct io_uring_task *tctx)
 {
@@ -146,6 +140,18 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
+/*
+ * Queue completion in task context after dropping references that must be
+ * released at hardware completion rather than from task_work.
+ */
+void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+			  io_req_tw_func_t task_work_cb)
+{
+	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_hw_done);
+
 /*
  * Called by consumers of io_uring_cmd, if they originally returned
  * -EIOCBQUEUED upon receiving the command.

