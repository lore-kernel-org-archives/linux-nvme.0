Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBC7C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:50:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8740861185
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8740861185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1bQiHSbFDCBrDjs2gOCPVfmgBeGXteHAYj6HyA7aF3o=; b=LyGp47CIly5vj71IB49a8P0ye
	FVyALZaxLDTXNV0179P81LRrYDEDC+0cmi30UFCA2JhQQqiJXngF49fE3VqVegqkieUdfhhzWeOFm
	R7qyxYjRdjricXOfC5yLQ++9B/9rU7jsAXiORhEMTloh8CmcCbBMi3ybgVmgkIYiyPeUfpcfmSoqX
	IHn8l0QnM0D532tv5/Qqwe+Jh+XfYbxRLRZr3e+sYMrRD0BoIa8TSWLiPuzLTwaJtufkKke0IXDZL
	mLJAhF/do+oD+bH8qBvVzUHLMOln89buLC4Fz0lCa5W0ZZmEjIO50unuc2zBZGW0o/R9uYm2tbPcG
	g2Kmff9Ew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1likBP-00G93I-Jb; Mon, 17 May 2021 20:49:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1likAf-00G8zJ-DP
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 20:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sXxEonpTdyskq7fiwLd/8g+pVyHsGiPS8Z3fH2sbyfg=; b=SM79ecQUkWJjFM3tpU2YyIRZpR
 VJfnkDS63jTdhiAXAPSIQWvNSHRqG0aESb9id37Kph3vfKj9Eo0fRXnPKsmdkbkASWpf+Rs5yyK9o
 D9TQ7wLlJcsJ5SHVWNxJxzgOaFkCgWexVnnV/E7JtVOAW8Ek3tT9SU+E7gD577wAuvr71TuXwVhww
 Skyj4xqqaMxI2zaVQ9jnj48XXi0u4Ylf+MHlERdiHxIQJe3x4Wi/wvYOGp6mX7yuJBJoIP8nVO6/S
 BKZ5qhj/It1s131DACf13w5+0aImlH4gyxD/9f5l+CJScXaWE6zxl7aajivVJIGNlICkEex2QSBZi
 WY/GR9RQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1likAc-00E92s-Lg
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 20:49:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A6361185;
 Mon, 17 May 2021 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621284538;
 bh=R/3eP8KWUZo5L4j3wcJ39F/rv3HDG6wIeoyl/EFeiGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BB+C9BkcYim0I3g6THS5ZPVfWHLlw2EcRaf54DhnnIaan6V2Hy3p9DnMNNjd2KD3a
 lo+d8lHVzFhh3QkVs9/A2MmVbKrFpmqAIXDc30Lgi19sXEh3TphNxcgTf6Z4o98unv
 ZEqwnLWbNBQoV7oz9BxSgvctZ03C/SsT9I6XOCpAVH5djLn68yfL22zNS7PniHzxy7
 OcfiSGLWLcJ5UUJx4gLPpAnnlFR3B9my6Rz+FkOTcTUz/Yw0KlbzFofaj2VrDNvd87
 XJEP0IfklTbH4JNlYGjxGmp9HJel9b1lWzSrSOZPTNfLR4/KmD2a6NIH9s0n5s+QNQ
 hK1UMfxShsZtg==
Date: Mon, 17 May 2021 13:48:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210517204855.GB2709569@dhcp-10-100-145-180.wdc.com>
References: <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
 <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
 <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
 <20210511030051.GD1857448@dhcp-10-100-145-180.wdc.com>
 <88879279-fff5-b26c-2c1c-52a700a1c40a@grimberg.me>
 <20210513154819.GB2272284@dhcp-10-100-145-180.wdc.com>
 <68ca75e3-2e0a-c0d6-c6cd-ab4d7467c0ad@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68ca75e3-2e0a-c0d6-c6cd-ab4d7467c0ad@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_134858_770966_D9552372 
X-CRM114-Status: GOOD (  41.38  )
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

On Thu, May 13, 2021 at 12:53:54PM -0700, Sagi Grimberg wrote:
> On 5/13/21 8:48 AM, Keith Busch wrote:
> > On Tue, May 11, 2021 at 10:17:09AM -0700, Sagi Grimberg wrote:
> > > 
> > > > > I may have a theory to this issue. I think that the problem is in
> > > > > cases where we send commands with data to the controller and then in
> > > > > nvme_tcp_send_data between the last successful kernel_sendpage
> > > > > and before nvme_tcp_advance_req, the controller sends back a successful
> > > > > completion.
> > > > > 
> > > > > If that is the case, then the completion path could be triggered,
> > > > > the tag would be reused, triggering a new .queue_rq, setting again
> > > > > the req.iter with the new bio params (all is not taken by the
> > > > > send_mutex) and then the send context would call nvme_tcp_advance_req
> > > > > progressing the req.iter with the former sent bytes... And given that
> > > > > the req.iter is used for reads/writes, it is possible that it can
> > > > > explain both issues.
> > > > > 
> > > > > While this is not easy to trigger, there is nothing I think that
> > > > > can prevent that. The driver used to have a single context that
> > > > > would do both send and recv so this could not have happened, but
> > > > > now that we added the .queue_rq send context, I guess this can
> > > > > indeed confuse the driver.
> > > > 
> > > > Awesome, this is exactly the type of sequence I've been trying to
> > > > capture, but couldn't quite get there. Now that you've described it,
> > > > that flow can certainly explain the observations, including the
> > > > corrupted debug trace event I was trying to add.
> > > > 
> > > > The sequence looks unlikely to happen, which agrees with the difficulty
> > > > in reproducing it. I am betting right now that you got it, but a little
> > > > surprised no one else is reporting a similar problem yet.
> > > 
> > > We had at least one report from Potnuri that I think may have been
> > > triggered by this, this ended up fixed (or rather worked-around
> > > with 5c11f7d9f843).
> > > 
> > > > Your option "1" looks like the best one, IMO. I've requested dropping
> > > > all debug and test patches and using just this one on the current nvme
> > > > baseline for the next test cycle.
> > > 
> > > Cool, waiting to hear back...
> > 
> > This patch has been tested successfully on the initial workloads. There
> > are several more that need to be validated, but each one runs for many
> > hours, so it may be a couple more days before completed. Just wanted to
> > leat you know: so far, so good.
> 
> Encouraging... I'll send a patch for that as soon as you give me the
> final verdict. I'm assuming Narayan would be the reporter and the
> tester?

This tests successfully. There was one timeout issue observed in all the
testing, but does not appear related to the reported problems here, or
your fix, so I will start a new thread on that if I can get more
information on it.

You may use the following tags for the commit log:

Reported-by: Narayan Ayalasomayajula <narayan.ayalasomayajula@wdc.com>
Tested-by: Anil Mishra <anil.mishra@wdc.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
