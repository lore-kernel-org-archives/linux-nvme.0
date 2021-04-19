Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA1C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 15:15:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FFE61007
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 15:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FFE61007
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Taq13bRC97L4uT1J5EOB80eqdP3vS5gUEs+sty2TbxI=; b=E04BSvI6UDSHxc18BG+FmN5UE
	yuQHzl014y+T6GKRdUrkSsuQy4nGhs93JsLOiG7qSwSpt5jqHQQQDWuxwStpeYldAUnBVRrEI5eWf
	BNgYPdnj6NjJnRye+Ni/Mkh+V2v/JXXYtSdUiJSubUFWH2F/uyJaP0om8Xq+edHpD9jbbzxON+7Ah
	VwNzl111UrWVs/v7ey0n0hC6rxPG6V0+2tJvKKcr2rIbC3yVXiiCT30xJ8eStUS1Nd16OhoUHyIoP
	hZ16cobXbLshm4/yia8yjamCPRfWJ5ANdq7y4F/MSNk19pvyxnZgtfT8Xs0lbjw/s+x+EOV6QcGD6
	QopU46s6g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYVbs-00AATz-KN; Mon, 19 Apr 2021 15:14:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYVbq-00AATr-RA
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 15:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=f+tHQk4iMfaZX9xaJ3lvlGT+WJQwneTwpm9SPhQiEFA=; b=J3jWfEVEwJA98phzhIXRO8QQca
 CgD9P0KtGPsOtCsBd0YO9LqqYSlwcR4+FS2WUyxXMIqPoSHv2HqqO9njij3dhh4qHt4a4xIhGNa85
 vd1cddE6ylH1Ajd8j+gmheRxx8YOWAWK4pbMhC+J7zvtES+eKweWZiUSKqy20na3UHpTY7l6peehc
 JDopG1rprGewZz47sqYevUFy0bcf7f4mdRc04Az3Q+iNoE8OBJhSFJF3y4CC+DOMKOvA0riW7jFgF
 1EcwR0tBUrIBFi49bc4jNWVA6ttSWaHOt05gZ+NzmU+R9tMVGr+zcZoRZCGSO0pYMDm1vMeertFCd
 KG5k6CQQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYVbo-00BTkw-Fs
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 15:14:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC3A6113C;
 Mon, 19 Apr 2021 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618845283;
 bh=LrNpik8Y2ml8d+eZ/R4YPtQ3IQkIX/0PFipEgNZK50I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mWnDWAAbh+G1F4FOukkgenPnQVbzS/40e9ufPYW6VW7SNxTZpHdJJBlS+YG4k/xYp
 HpH+TEtNiFyibpFhB5QRrDZOKmh1H/EA09LvUmc9sPY5dVWFnPZh0XmRqsJ8B59siT
 m3KuhgF22gx8pQhtXyGMtqqyRBEsnhdt3rLtQFUJ7gBossoofA1VVgvYqdZtb30YbV
 5kZvrfiRLY7bjqgPcxqSuFWe0h+ow7LsCrInBoLYXMdZai+M3McnU6qt0f6PB39bxc
 miy1sLzABtalncB6PKiFzgEI+z4r7fsYvzVGxdU/KAwm21ucp3s4eKHs/SdjPPGniO
 Ay+YC4ZRYe/Yw==
Date: Tue, 20 Apr 2021 00:14:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
 <20210419071605.GA19658@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419071605.GA19658@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_081444_591693_40CD893C 
X-CRM114-Status: GOOD (  16.87  )
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

On Mon, Apr 19, 2021 at 09:16:05AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > >         if (poll)
> > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> > 
> > Why? Those callers already provide their own callback that directly get
> > the error.
> > 
> > > How to get error ret from polled rq?
> > 
> > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > It already has the error.
> 
> But it never looks at it..

The question was how to get ret. I didn't mean to imply the example was
actually using it. :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
