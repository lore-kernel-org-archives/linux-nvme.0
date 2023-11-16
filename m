Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFAAC47071
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 03:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6V+qVKs+IlmLOQ9G25HtgwPuqZqRR9GDN+lvsFC3CU=; b=buB64JT22mg3q3Z7mS1L16+rqX
	pynK3TqZjhHpcZlUc/d69LxbFX+v6AtZzamnvrmM3IjyrQQMByp13JuQP4H5vEJIOAKrs1JaHuYu1
	3QLaV8eCx2WpeJxmiG3bblxfG5ndlxlvLWXmwYCaRZ6XNyTXy1WKPNUgWCgoMOz7FEIYOM9BmvO2P
	I9riA9Q1YpDZ/3FmvWqzWA8Ip3eKZCgulhjq1xxsCbXtAp6sKW06upMt7/gAEcXCZtLXBVYogXXnj
	aZOpmLKaujjdyfjTCxwcchHnlEZbkkeIfnCffjMq4ZcFlb2N5UJtB6u9Idlo8tK/arqio5iiySRJc
	s+csvb/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3TQL-002LIr-2t;
	Thu, 16 Nov 2023 03:52:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3TQI-002LIP-2z
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 03:52:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 39D42618AF;
	Thu, 16 Nov 2023 03:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B67C433C7;
	Thu, 16 Nov 2023 03:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700106729;
	bh=x/tld0bG24HZD0l3o5Zu81h7Zw9qVdRfNBu7baYafKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgW6pXb5S11/zVv3dFiPaQPNAQ7LQzEx0aSYl1R5/drSvRjxLu1sVWMos2Bk23hbh
	 keeTI203WmYd4+Jd35/G7T4vuAt9zGhMfUVgCroU/W3rDKDmipf0FJJPUOnic3DDxd
	 ZyGukv+jU28gNLtaPRelAnF+cVyUEaDNGg7jEx/DFzbVdJUPHDbzyN9cJmDRPhNj8X
	 eyIfYhlJZZYs2Q3wXuNjo8Dzq+sqsiwulXJHo8jT/wBnGNt2ep60uTSwViuYbHMyIO
	 PKlBN7xspTwuRoe2dwDdwot81CUjXCjXdrB/Z7kzjn3UDkLaGfW+EZqU+7x1zNAstp
	 YC12tJ/2xW7ww==
Date: Wed, 15 Nov 2023 22:52:01 -0500
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_195211_009335_8F3FC804 
X-CRM114-Status: GOOD (  19.38  )
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

On Wed, Nov 15, 2023 at 02:44:04PM -0800, Yuanyuan Zhong wrote:
> On Wed, Nov 15, 2023 at 11:55 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> > > On Wed, Nov 15, 2023 at 11:02 AM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > Do you mean something like this? If not, can you please elaborate
> > > "when we need"?
> > > -               struct nvme_effects_log *cel = xa_load(&ctrl->cels, ns->head->ids.csi);
> > > +               struct nvme_effects_log *cel = (ns->head->ids.csi == NVME_CSI_NVM) ?
> > > +                       ctrl->effects : xa_load(&ctrl->cels, ns->head->ids.csi);
> > > Will it be good to change ctrl->effects to ctrl->effects[3] for
> > > already defined CSI?
> >
> > I suggest either re-assign the cached head->effects to one from a still
> > live controller when current path is removed, or move the saved effects
> > to the subsystem instead of the controller. All controllers in the
> > subsystem should be reporting the same effects log anyway, so
> Is it specified in spec that all controllers in the subsystem
> should be reporting the same effects log?

Yes, in section 5.16.1.6, "Commands Supported and Effects":

  This log page is used to describe the commands that the controller
  supports and the effects of those commands on the state of the NVM
  subsystem.

Oddly enough, Figure 202 says the scope of the log page is "Controller"
rather than "Subsystem". Sounds like ECN potential. You can memcmp the
effects log from each controller for a sanity check if you think some
subsystem controllers messed that up.

