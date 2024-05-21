Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964AAC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjCHXx3CBeaXcONRmIDGSqTjffbJF2dn/sodP5wZqr4=; b=xy0g6cx1+2raHlO86A8In3WvRl
	c65IOkDcY1WItseMAhlDSIHb6fCrV7dJoHAlc+NQ+miu6K9h8oc5guuf0BGrf7RCM+y7gPmzvzpE+
	MIU0R6TcksIqpmPg32xgFqoaGO2XtFKcvn6NPcWkFMm4bIYgTMe/Om1P7KKES+ZOpEHOCwWjskc3Q
	978WgV99c5PV4W307Vj2l5tlybNJPouRWGSqQBMCwgQqSYo1CUvjzmm5l8wtcTTEfpHaC0xTZiQza
	Ki4Kr2iSSrkPO8Vs4dHWhE6wTe6iu62Qp+yoWx1pUXnqOngk3BR6Zebvv9tbzZngpnO5TCyNBV8WL
	epBmxo8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9PBY-0000000HXGr-15EJ;
	Tue, 21 May 2024 13:05:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9PBT-0000000HXFM-047P
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 13:05:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7EAFECE0FB5;
	Tue, 21 May 2024 13:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E54C32786;
	Tue, 21 May 2024 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296735;
	bh=Rr/GkEedXfncMNSF/dyRDeEza5AsisB/vI8v19rE6Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eG/KfFuEoBcpnCRX8QH0GBE7h95EK2gBtvNobaiURYktE5WUnN3+wo356Q1+ibYm7
	 +lOBnDoAdPdh8Hrpi9rwapEAo9SF2LGGA6CsF6m2QGk5FAmTx7Kjzujv41exStb4W+
	 YqFBAJhWm6KmaU77JY3sLy8XmmYWnatjMJFdi14gZ5UlOQkQDRTF0JnsicMQiiG0P2
	 svdyYUfklf6WYvmT9y01j+ieqYEnLDBlcM9PF0NTNl4RSIErEd2v+eW1Nnrah7sdbj
	 QBVsDMGbGdwWF+UW0raMxxbGq8hBDE3Jb34pQ9U/EITYkCC9SrVULw6mdyxylBIvjB
	 1v8PMbhPbWMLw==
Date: Tue, 21 May 2024 07:05:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: John Meneghini <jmeneghi@redhat.com>, hch@lst.de, sagi@grimberg.me,
	emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZkycHdlWgQtkCVer@kbusch-mbp.dhcp.thefacebook.com>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_060539_273130_C70E588F 
X-CRM114-Status: GOOD (  18.08  )
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

On Tue, May 21, 2024 at 02:18:09PM +0530, Nilay Shroff wrote:
> On 5/21/24 01:50, John Meneghini wrote:
> > @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
> >  {
> >  	struct nvme_ns *ns = rq->q->queuedata;
> >  
> > +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> > +		atomic_dec_if_positive(&ns->ctrl->nr_active);
> > +
> >  	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> >  		return;
> > +
> >  	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> >  			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
> >  			 nvme_req(rq)->start_time);
> > @@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> >  	return found;
> >  }
> >  
> I think you may also want to reset nr_active counter if in case, in-flight nvme request 
> is cancelled. If the request is cancelled then nvme_mpath_end_request() wouldn't be invoked.
> So you may want to reset nr_active counter from nvme_cancel_request() as below:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bf7615cb36ee..4fea7883ce8e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -497,8 +497,9 @@ EXPORT_SYMBOL_GPL(nvme_host_path_error);
>  
>  bool nvme_cancel_request(struct request *req, void *data)
>  {
> -       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> -                               "Cancelling I/O %d", req->tag);
> +       struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
> +
> +       dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
>  
>         /* don't abort one completed or idle request */
>         if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
> @@ -506,6 +507,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>  
>         nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>         nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +       if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +               atomic_dec(&ctrl->nr_active);
>         blk_mq_complete_request(req);
>         return true;
>  }

The io stats wouldn't be right if that happened. And maybe it isn't
right on a failover, but it needs to be. Would it work if
nvme_failover_req() calls nvme_end_req() instead of directly calling
blk_mq_end_req()?

