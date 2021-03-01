Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68651C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 21:00:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F81601FC
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 21:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F81601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BnSBNL3pgtkCB2PoZdzDwVC2Sq9Qq+SR4tscgwGBOB4=; b=WOHqPCpADwzsSPhf9TKlnETSH
	t1rouYvHcgR9PX/BunJ6NRtRhxNg2+AxdnVby8hyCuKdakbBupaVGVRoUF1ppBug0NzTxlFf3a7uE
	gEUpQC/Bk4/2J3cwmXrYBsIj7ZytSvE8WPArqUFKtV/3z8mAwSWUXpmLTMHJZsGnk0x1Q6kQloaTe
	hzkVmmx663dmiGJ5B3tMt/hYfOEiQzidYn2yd9buI3ly34MYuWtcji4Ij4SS484SY4duI4PbalBap
	VYAgo2/TcoZZnY/dArb1AJ6OBzGoPXzXEs+so9yCzRfE3IjzlJh/0W80hfVh1a+wMtyTQQjjlfK3k
	RoeZRrKzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGpe1-0002Jb-D9; Mon, 01 Mar 2021 20:59:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGpdx-0002Iu-Jx
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 20:59:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6F85600EF;
 Mon,  1 Mar 2021 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614632391;
 bh=Ghkh2dd6hiVMkZNxCxWJWFZq3rC/o9YjYgqFCm/vzDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=itXczhu+y4heRg+ydiqsvq+I4jSomprxCJjrcOS7v4klsW8MIoEBGS3km3ZINRm0S
 6Kt8HAl+yB08EIBSzgxqIhi224BxavVQQYCoo6p/QvY9gxsg/RL9q8+iSM/kWvh+4D
 UgV0hhWh17eLkhf7+SaZCVbato6oO3WpJrxgJnrYAhp0oq1p0vcn8969jEKhcKIqT3
 OJj+5PKADrRdxxUnkhr8fRaQ1Zi+/rQlhqEMv62M9I1wAS5XD7swldHmzUbg46WlJI
 iZcaSo/+9d2N4djrk4JjnbG4BysjGWXzZ5l992x8g7r3/u6kbTNO+ILVTJ15a+s527
 P6ZTfIB5Om73g==
Date: Tue, 2 Mar 2021 05:59:44 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210301205944.GE17228@redsun51.ssa.fujisawa.hgst.com>
References: <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
 <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_155953_789222_6D492BF7 
X-CRM114-Status: GOOD (  25.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 01, 2021 at 05:53:25PM +0100, Hannes Reinecke wrote:
> On 3/1/21 5:05 PM, Keith Busch wrote:
> > On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
> > > On 3/1/21 2:26 PM, Daniel Wagner wrote:
> > > > On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
> > > > > Crashing is bad, silent data corruption is worse. Is there truly no
> > > > > defense against that? If not, why should anyone rely on this?
> > > > 
> > > > If we receive an response for which we don't have a started request, we
> > > > know that something is wrong. Couldn't we in just reset the connection
> > > > in this case? We don't have to pretend nothing has happened and
> > > > continuing normally. This would avoid a host crash and would not create
> > > > (more) data corruption. Or I am just too naive?
> > > > 
> > > This is actually a sensible solution.
> > > Please send a patch for that.
> > 
> > Is a bad frame a problem that can be resolved with a reset?
> > 
> > Even if so, the reset doesn't indicate to the user if previous commands
> > completed with bad data, so it still seems unreliable.
> > 
> We need to distinguish two cases here.
> The one is use receiving a frame with an invalid tag, leading to a crash.
> This can be easily resolved by issuing a reset, as clearly the command was
> garbage and we need to invoke error handling (which is reset).
> 
> The other case is us receiving a frame with a _duplicate_ tag, ie a tag
> which is _currently_ valid. This is a case which will fail _even now_, as we
> have simply no way of detecting this.
> 
> So what again do we miss by fixing the first case?
> Apart from a system which does _not_ crash?

I'm just saying each case is a symptom of the same problem. The only
difference from observing one vs the other is a race with the host's
dispatch. And since you're proposing this patch, it sounds like this
condition does happen on tcp compared to other transports where we don't
observe it. I just thought the implication that data corruption happens
is a alarming.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
