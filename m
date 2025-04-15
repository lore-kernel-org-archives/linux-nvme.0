Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911FBC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NTuLiSMEW2BjRaiBY0kxfEuXdydZL3bQoaweUjYlfI=; b=OTV/vVR7lb0i6NrZUrIM8FBS7R
	GxYFtjkgB0lzJ2JkltCcleLYlcjGvLpjMfrYsPx54VXxbXXjOwG117ZaRV1BXnL6m30euIiRFzfZR
	Sjm4xHt95PUtYte8pdd7VW1fs1H1Jw4yc85CmVaVmvru4g4lI3YJIbaj570oJ9/88QGPDQpb4jva9
	8NPYLYdIydtaWtqHx8JeIgBLpydQgIqxSXOHG4ni40rtE1d3wCaK3Dejr+hwolWeryBHdt9ODS083
	TnD4I2QXh9TlkEN7ZdNWLW+BdL5z3OquAEHt0l81tsx0DPTvKYVywKI2P/UNr/S+Hki2lytk2DwIp
	ngjsMPgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nom-00000007BKp-0KbA;
	Tue, 15 Apr 2025 21:27:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nnM-00000007BBo-2B9q
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:26:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8E4045C2B7F;
	Tue, 15 Apr 2025 21:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFCEC4CEE9;
	Tue, 15 Apr 2025 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744752375;
	bh=aDy4IVi60hlLhXkcLHBk1XqSiXrmqTbe31nclpiwKrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7Vl62gVYb46fRPugTDd+OXLA3n8dd/1nArCPXLCaZNauacNs7JCIU9fce1bhWZ04
	 HWR8MG2LrpmfCJgRyHY1bKBn9CxqHxH+RdTnx7yqWdtbHYRvAOMNSI82i+QVTHwXmr
	 dBvjK0Cuv/L87my1CmRNUgKXW6NpEl1ECxDormVZnZAwzZ8jXUCyceLRYjyuG1Nvav
	 HmkptCngX4IGEWOBzAx7UWdTatfhBQFR/C78L1YQ7wYVkDfxfuSIb92KI7S9rQz0oZ
	 u3K2wlp82tuII9mxoC1QQ/EfDucpxdsd5ZxuOTU0slv9atKlDr4nwgQK0lIE8rT9yJ
	 WDBGdzfwBnqxQ==
Date: Tue, 15 Apr 2025 15:26:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: nvme-cli connect regression
Message-ID: <Z_7O9EHl3LdhS7mn@kbusch-mbp.dhcp.thefacebook.com>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_142616_598030_C1647662 
X-CRM114-Status: GOOD (  15.56  )
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

On Wed, Apr 16, 2025 at 12:14:28AM +0300, Sagi Grimberg wrote:
> 
> 
> On 15/04/2025 12:01, Daniel Wagner wrote:
> > On Mon, Apr 14, 2025 at 01:29:42AM +0300, Sagi Grimberg wrote:
> > > Was this resolved?
> > I've added a retry loop in libnvme when the write to /dev/nvme-fabrics
> > returns EINTR. It takes a few days until the newly version hits the test
> > frameworks and we know for sure that is handled.
> > 
> > > Couldn't follow where the issue was - kernel/userspace?
> >    [ 10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4
> > 
> > Stable kernels started to return EINTR and one change which touches
> > this area is:
> > 
> >    578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")
> > 
> > Unfortunately, it's not easy for Luca to build a test kernel. If we
> > provide one for his distro, he would be willing to tests.
> 
> Its not great that we now get sporadic EINTR errors. I am wandering what is
> triggering this?

The only EINTR return value I can find in this path is from
sock_intr_errno(). So something is signalling the nvme process, which
could be anything.

