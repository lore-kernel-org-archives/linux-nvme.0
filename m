Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9AC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 17:48:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D306113C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 17:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D306113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BaX+0la1I+S88XLwARhRlspe6ZGG1esWMljEm5O/eCM=; b=fl5y9vkJukDOixFdICHT72Q8x
	r9QYGlHxA2JJ9Rhp7G7b5bYkMVZrUmL7TxH280WeKgOk0U4f+EMXH0Lm6+Ud2ffpJbOb+Z7oq4LAa
	vy4Ei5Ill4NHi9zEKLZ22DoG4X1b+nGwR8/o5HnnrptzZpY7jNddakIqvJEArIs0x33eMpdAzqFqr
	aVLy3g6J2pToC/cb0BKG3m0q9KLe7d8pnvwKKUZBVZyVkZG9lEhyAnB375ao7gkfT2hcvGF7vdEvX
	mj2cOahMhLCLKh+NcpwXd2zz1jBDjLWbntXa3IUEXLgJu5PdeYmpdqQ7fRUFx9LmROfEXiG8vBtZm
	UaXA4q9jA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYY0G-00AN7N-LX; Mon, 19 Apr 2021 17:48:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYY0E-00AN6y-Mi
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 17:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mypdSj/FJSCCB7LKO7drzB+z43pvONxfZ9bou/nIG+g=; b=ZzScZvUFdQ94uzfHl3XhMyBbCi
 x3O2roMBhbQpJBppG/sWzBhI3Uq4Yz4/uuke/EpgvZyr+yc9faIW2P1BBX8O7NNfbP90HhAei4Lf1
 gBlULzZd3awaamq3Xl7iSdOWMmgPEyug32aDw3pxUAWNu+Q6pmtE/u4JzKUCR5aOIe5AZRWPK+BSX
 +u9RzRWYtPUB4XLSsPzrhDMKyl+mwVFsETHt2lKmARuZWRUHbDBD9uxls1thLIR7d8N6QM6uFFn9b
 xhkx0kRUutcWkyWHcfBf9CtItkjaTnN2zheDhXBVkUXsdzevaxGR+z1yhi24F+X7u90WEWMn+o77H
 fwtM0SLA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYY0B-00BZIp-7O
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 17:48:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A1C56108B;
 Mon, 19 Apr 2021 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618854482;
 bh=hxK01/A4rWtVqKpx4rBzUpeIgw//lhzxcoo2hVMsxTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Be2XZAZvwKmaAIw+F4p8L7rOmcDVKnwP2++yMyE3S72EMJK0UWgH3c1yxAxocL+G7
 9tNsd88EteuzvxuQOx3zT8PQ00dHrpMNca9nLO1SbRgGmfqwcSwrzPUHju+1aALfCI
 1zQrGFjgP4tpuKPwgdEcyxlVuhQMFa9tqmxdgTNBViD3WDhTywT20J+G590ANEVIoG
 G/Xeu32tTQhBmCZx/8s5IdJP+gqJvv/exRWB4rOfgFDbAnpfqquPAjivjErQYr8ejo
 B92IKV7Yge8cBrluo39UvECQmSUhWWrV4jm2/rJ5vkQTpcwA4u4JSmNANMXmkspWjp
 UbBYsX8lr/Fzw==
Date: Mon, 19 Apr 2021 10:48:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210419174800.GA3130441@dhcp-10-100-145-180.wdc.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
 <20210419071605.GA19658@lst.de>
 <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
 <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_104803_323253_F739DD1A 
X-CRM114-Status: GOOD (  25.31  )
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

On Mon, Apr 19, 2021 at 10:27:42AM -0700, Yuanyuan Zhong wrote:
> On Mon, Apr 19, 2021 at 8:14 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Mon, Apr 19, 2021 at 09:16:05AM +0200, Christoph Hellwig wrote:
> > > On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> > > > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > > > >         if (poll)
> > > > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> > > >
> > > > Why? Those callers already provide their own callback that directly get
> > > > the error.
> 
> See below clarification. I was wondering whether the way you were going to
> propose for nvme_end_sync_rq() would establish new convention for other
> blk_execute_rq_nowait() completion handlers implementation.

I'm not sure it can be turned into a common pattern. The callbacks are
implementation specific.
 
> > > >
> > > > > How to get error ret from polled rq?
> > > >
> > > > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > > > It already has the error.
> > >
> > > But it never looks at it..
> >
> > The question was how to get ret. I didn't mean to imply the example was
> > actually using it. :)
> 
> The question was how to let nvme_end_sync_rq() propagate the blk_status_t
> error to the ret for __nvme_submit_sync_cmd(). That's part of the problem
> here: __nvme_submit_sync_cmd() may return success for a command that
> failed submission.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b57157106cac..a0fb9ad132af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -949,6 +949,9 @@ static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
 	struct completion *waiting = rq->end_io_data;
 
 	rq->end_io_data = NULL;
+	if (error && !nvme_req(rq)->status)
+		nvme_req(rq)->status = blk_status_to_errno(error);
 	complete(waiting);
 }
 
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
