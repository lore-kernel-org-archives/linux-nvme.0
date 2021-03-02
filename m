Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E036EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:07:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BBF64ED0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BBF64ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UZmeKPgy+UZDOIGN0iZN/7mxsIG+AiJR2StZs1Xf3h4=; b=re5/OH4wlwGB5YMaGrH7PA7F0
	NarOo/o8hHUeflQI2g52EMsRAprBxzwSiYvERyTvh4HK/9HUeYBozd8xZ1wfhTOra0tf4ooyCzBDl
	xD9XnH7FGm0D9p3r0XJkF/sDmRshb+e3aBOGI+icc8sOmrl9CLD9RCMj1JdHrhKE6pP6NxTZZ2iFw
	PjpNJtglOzJer1sh6TG4WQcK7ef607dn1jxbnAQtxvoypKSKF0q8+IVL7WPPRQgSotJiylGEedpOF
	964cHDkdl9zKekFuFxD0kH+O2Od2eg8Na8K+L4B3jubnyHp4tDKx27gzlfnDiNzraGLi65ZWcNFsV
	ZVoTK/p7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHUxy-005jMU-Ui; Wed, 03 Mar 2021 17:07:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSsq-005Eqi-Ia
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sKU5AFzHhtZMSimpSXAAzJWrvCsPSiftOBf8Z6tSsPI=; b=JcxXEYPTjR6IG1lV6RPA1cyzcs
 lcOEqPYdIS1lPmhr6YucuuzO4hpm2qSmZ6ZWZCDlQcZridpO1ehWBFph5x/DDkVRa1TvI71ddwfSu
 31y79oGkWQiZrbE24S47OIZwkFvZUpW/K1w9yiwdn8iBTSJWfExSrLWL1NZBFDMCXHNqN0lXfALO1
 abCAtUX9hsWRgmDU4XlnuXb2n/1tuLIWn0ThzqOr8dMybZDKQblRkV+8T1JPIpla0yjy5/aAinR9M
 FED9Mbsi7qLcspICJi42TBNz4ycLf3MO/w8OLlff5fNze5frVQNi/0NOiuzh/aJ1NYgY6Z6OJWkTv
 yc01ZBlw==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHA1b-0005bY-8p
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 18:45:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0708964F1F;
 Tue,  2 Mar 2021 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614710735;
 bh=rOJuCq9EBX9j5Ht1Yizu1nHFQnKPSkAX4k72DB1+878=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fFxFTp30aKkqdvNa1plL/o97/t4rjtjonq4cDzi/u+sLYrtzrL5DTdf0c9JS/wNLk
 JejL1P/QwPlv3uUPi4wFGz/7yXNBOtsc3Hfe+C06/uQdzHwCBdDxK+zQu/dj6lZzf9
 pbdvx8Uqmda7eyaCq+2MUZevoOofKZcVwNUK8K0ThwV9qKkVW9BVszL7A0YXf6oMSx
 LTa/ImrHs90ZE6xz+Nk6AzX+ikR+TR9ihewAmhT7DN7mqjFFQRCNiuUvLblMvOhIzQ
 ixUmh1F+QhjB3LBTMycqDkP3sN8mxe3WXkmdi11LFYnmaxO9Q0vEsV4FgP1vBk3Rj0
 40gjJnRFDeDfQ==
Date: Wed, 3 Mar 2021 03:45:29 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210302184529.GB22346@redsun51.ssa.fujisawa.hgst.com>
References: <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
 <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
 <20210301205944.GE17228@redsun51.ssa.fujisawa.hgst.com>
 <8eb26510-03e1-7923-0f47-2a8d3d539963@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8eb26510-03e1-7923-0f47-2a8d3d539963@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_184541_019261_511F1D46 
X-CRM114-Status: GOOD (  30.08  )
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

On Tue, Mar 02, 2021 at 08:18:40AM +0100, Hannes Reinecke wrote:
> On 3/1/21 9:59 PM, Keith Busch wrote:
> > On Mon, Mar 01, 2021 at 05:53:25PM +0100, Hannes Reinecke wrote:
> >> On 3/1/21 5:05 PM, Keith Busch wrote:
> >>> On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
> >>>> On 3/1/21 2:26 PM, Daniel Wagner wrote:
> >>>>> On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
> >>>>>> Crashing is bad, silent data corruption is worse. Is there truly no
> >>>>>> defense against that? If not, why should anyone rely on this?
> >>>>>
> >>>>> If we receive an response for which we don't have a started request, we
> >>>>> know that something is wrong. Couldn't we in just reset the connection
> >>>>> in this case? We don't have to pretend nothing has happened and
> >>>>> continuing normally. This would avoid a host crash and would not create
> >>>>> (more) data corruption. Or I am just too naive?
> >>>>>
> >>>> This is actually a sensible solution.
> >>>> Please send a patch for that.
> >>>
> >>> Is a bad frame a problem that can be resolved with a reset?
> >>>
> >>> Even if so, the reset doesn't indicate to the user if previous commands
> >>> completed with bad data, so it still seems unreliable.
> >>>
> >> We need to distinguish two cases here.
> >> The one is use receiving a frame with an invalid tag, leading to a crash.
> >> This can be easily resolved by issuing a reset, as clearly the command was
> >> garbage and we need to invoke error handling (which is reset).
> >>
> >> The other case is us receiving a frame with a _duplicate_ tag, ie a tag
> >> which is _currently_ valid. This is a case which will fail _even now_, as we
> >> have simply no way of detecting this.
> >>
> >> So what again do we miss by fixing the first case?
> >> Apart from a system which does _not_ crash?
> > 
> > I'm just saying each case is a symptom of the same problem. The only
> > difference from observing one vs the other is a race with the host's
> > dispatch. And since you're proposing this patch, it sounds like this
> > condition does happen on tcp compared to other transports where we don't
> > observe it. I just thought the implication that data corruption happens
> > is a alarming.
> > 
> Oh yes, it is.
> But sadly TCP inherently suffers from this, as literally anyone can
> spoof frames on the network.
> Other transports like RDMA or FC do not suffer to that extend as
> spoofing frames there is far more elaborate, and not really possible
> without dedicated hardware equipment.
> 
> That's why there is header and data digest; that will protect you
> against accidental frame corruption (as this case clearly is; the
> remainder of the frame is filled with zeroes).
> It would not protect you against deliberate frame corruption; that's why
> there is TPAR 8010 (TLS encryption for NVMe-TCP).
> 
> Be it as it may, none of these methods are in use here, and none of
> these methods can be made mandatory. So we need to deal with the case at
> hand.
> 
> And in my opinion crashing is the _worst_ options of all.
> Tear the connection down, reset the thing, whatever.
> 
> But do not crash.
> Customers tend to have a very dim view on crashing machines, and have a
> very limited capacity for being susceptible to our reasoning in these cases.

I was pushing the data corruption angle because fixing that should
address both cases. If there's really nothing you can do about
corruption, your approach here makes sense, and I defer to Sagi and
Christoph for inclusion.

I still wouldn't trust my data to storage behaving this way, though. :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
