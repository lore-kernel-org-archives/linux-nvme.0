Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B6FA3741
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqFxr1yolRVLq57ZwOvjUBErUp6zpZYKS68VdpssVnA=; b=VDd3sgWz29ntNlRcB1x6xgi2Uj
	KXO6b9s1VUzQrvwhcY5ao8lrOjeksJhGzs/pPYzz4MBJ09Cxy0yDK4xeOMHAxvbLzrMb8ObX9h7X3
	lV5xSTWYKPgCVQ07/giI5/YldeYcxAf5zyD5MwpBd/0/qTULHjP4jLRoaIhKCdX0RJjb8krj7wGix
	yG5wajWoUY33nCtBQ8VVg9Cvb6nlfs0rPpl8q5pBO5xVlj3j6FKEnz7+xTVk8+uzSPxDSxDoqMpt4
	KIPqK0lH4HLYcyGFsYZ3Ck79Dogwh6/cIr5aNjuhLLlxFIQtgOSvLTEm5gwHv/nh3TqI0yosBYN1R
	u907bOsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4NB-00DwPL-Co; Thu, 27 Oct 2022 15:00:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4Mj-00Dw73-Jx
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 15:00:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43CCE6237A;
	Thu, 27 Oct 2022 15:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA0CC433D6;
	Thu, 27 Oct 2022 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666882815;
	bh=fqZtKENqGYOHn9YMPFjx71HALw3QOHwD7LlwcBRMUls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cavjTKIZEBGfreL+vIaD4bnrRQuc5zEKz0ypwUKbhy9HHh0rRQq4JUx17wmmCMryM
	 7tKkbDIe4R8yJyPUeVz5TvoQXRzEr3M62vuN6G7Bg9ec8v04DXgQ1Y9KDQtO6cdF4h
	 rZ24nGpvv92e3aCgdseV/EbaRUJeq3NK7kLXYtYdAVuva5h0Ga08/M9ZVwRfZBmwRI
	 Nw2T0CsFVGiBMW9qRK5bADB9d2kCC6THWJ3mqpzk/AaSspFh5qdBvIRfSBaYo1mGCU
	 C1JrTIv5QTT5ZphTzkylZ92IhZTpTXpiUtkZiNdTk4q+JHV8Hk4X7JZ1M4V+ydn2oy
	 oaB0oI8qb1Ehw==
Date: Thu, 27 Oct 2022 09:00:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Daniel Wagner <dwagner@suse.de>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Message-ID: <Y1qc/IyQzLUxYWTC@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20221026171201epcas5p1f6333717c7f12b5a8fe362cf09c5447d@epcas5p1.samsung.com>
 <20221026170715.2657664-1-kbusch@meta.com>
 <20221027054136.GA5939@test-zns>
 <f49bd086-fe3a-670c-13ce-80f06a855166@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f49bd086-fe3a-670c-13ce-80f06a855166@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_080017_744661_48C3DEA7 
X-CRM114-Status: GOOD (  23.43  )
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

On Thu, Oct 27, 2022 at 07:17:48AM -0600, Jens Axboe wrote:
> On 10/26/22 11:41 PM, Kanchan Joshi wrote:
> > On Wed, Oct 26, 2022 at 10:07:15AM -0700, Keith Busch wrote:
> >> From: Keith Busch <kbusch@kernel.org>
> >>
> >> The driver is spamming the kernel logs for entirely harmless errors from
> >> user space submitting unsupported commmands. Just silence the errors.
> >> The application has direct access to command status, so there's no need
> >> to log these.
> >>
> >> Cc: Daniel Wagner <dwagner@suse.de>
> >> Cc: Alan Adamson <alan.adamson@oracle.com>
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >> ---
> >> drivers/nvme/host/core.c | 1 +
> >> 1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index 686c55cb5d1a..da874172a31d 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -1156,6 +1156,7 @@ int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
> >>     struct nvme_ns *ns = rq->q->queuedata;
> >>
> >>     *effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> >> +    rq->rq_flags |= RQF_QUIET;
> >>     return nvme_execute_rq(rq, false);
> >> }
> > 
> > Can we do this for uring-passthrough path too? Like below patch -
> > 
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 81f5550b670d..a91cefc38506 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -556,6 +556,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> >        } else {
> >                req->end_io = nvme_uring_cmd_end_io;
> >        }
> > +       req->rq_flags |= RQF_QUIET;
> >        blk_execute_rq_nowait(req, false);
> >        return -EIOCBQUEUED;
> > }
> > 
> > Looks good otherwise.
> > Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> Agree, we should do it for this path too.

Okay, that would make 4 places the driver is setting the QUIET flag,
which is all of the passthrough requests. Instead of doing them
individually, I'll just move the setting to their common helper:
nvme_init_command().

