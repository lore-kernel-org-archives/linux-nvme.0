Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA133C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 17:16:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C25C61042
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 17:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C25C61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hk76iDFVKjQ6XjLiv39ApYGFn9xVJ5E5F++OHolmv7Y=; b=QEzDZHWiHqCNX74poBBBgcDCm
	yoo9FSeisPHmG5bWHqjKk/M5tGTOOdD4ri88lh8mkDxwFph3OlKRcewa6Tm8GKOCrvEmGeoY3WlOX
	pI9Dpm9zt7MyYcJ2RlTMXQLwzmSJhx8AjFcoz4k1K6rDduUostfKIJB8kjkVYq8TWE/Lx4cb+WZmt
	CJd2XtC9A2QnhHnwyPxRmxiUKnTfv3ysbyL/D/yYlaYSuBKa7wZhrZy7SKa5uLseaIJbAcEq0mgPE
	fjwTHCix9DwuNfzmhfw+KHvHgjq2m6oPzpiSJTT3Jqbv9XjPyEZzftDp1WfKO8mPVBlKuzblZMrl8
	lee3dWFcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb4qC-0089LX-JG; Mon, 26 Apr 2021 17:16:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb4q8-0089KV-Ad
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 17:16:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C35E761042;
 Mon, 26 Apr 2021 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619457332;
 bh=p+q7TkEFrJhq35tq5j0hlE1Ruxcv/DpvcnsFTIwgtvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VOuArXOa4U0VE3VWVFERC4Ul58+revaMkdQOLLr1nKK+FCrMvzO4GHixj9O5whRR0
 KJoBjyTgt/qiJ79zUgUzr+NJE0XLJ67oBwhSeMoe7mXDKbDYlK4RkRYurFLTaHwhc5
 pSqdXkgXGvmlJvzDadiLa3a+8CazHBouE7X4Zrhry+pQoKRjonYexBzhUrXXBBeNWK
 JrhkRyDlo6UY9Kjd64TPCHn+cQcPQHs/GfsT65KVJ298Xu4hPk2ygrVD0lu7nj2/61
 7poEomUsV845cRqr/yvFuXplVig8FSvhmJMdGfuUqlFOBNR5upFOKEDUYccrioIBEi
 GkzXM2ptTaP4A==
Date: Tue, 27 Apr 2021 02:15:25 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
 linux-block@vger.kernel.org, Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
Message-ID: <20210426171525.GA13018@redsun51.ssa.fujisawa.hgst.com>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-5-kbusch@kernel.org>
 <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_181608_566195_9B82F6CC 
X-CRM114-Status: GOOD (  22.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 26, 2021 at 10:10:09AM -0700, Yuanyuan Zhong wrote:
> On Fri, Apr 23, 2021 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > We don't have an nvme status to report if the driver's .queue_rq()
> > returns an error without dispatching the requested nvme command. Use the
> > return value from blk_execute_rq() for all passthrough commands so the
> > caller may know their command was not successful.
> >
> > If the command is from the target passthrough interface and fails to
> > dispatch, synthesize the response back to the host as a internal target
> > error.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/core.c       | 16 ++++++++++++----
> >  drivers/nvme/host/ioctl.c      |  6 +-----
> >  drivers/nvme/host/nvme.h       |  2 +-
> >  drivers/nvme/target/passthru.c |  8 ++++----
> >  4 files changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 10bb8406e067..62af5fe7a0ce 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> >                         goto out;
> >         }
> >
> > -       blk_execute_rq(NULL, req, at_head);
> > +       ret = blk_execute_rq(NULL, req, at_head);
> >         if (result)
> >                 *result = nvme_req(req)->result;
> >         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> >                 ret = -EINTR;
> > -       else
> > +       else if (nvme_req(req)->status)
> 
> Since nvme_req(req)->status is uninitialized for a command failed to dispatch,
> it's valid only if ret from blk_execute_rq() is 0.

That's not quite right. If queue_rq() succeeds, but the SSD returns an
error, blk_execute_rq() returns a non-zero value with a valid nvme_req
status.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
