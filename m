Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8798C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 04:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/JNlfUCWCx/b8aksigP9ODYOJ5nrpqTQVNYPoX6dGSo=; b=SOw44ziwbOavjDAlHS+GhRHiAh
	4Jjw49Etqr0xEJBGFanGhQBrcM+7tYtn0CGRbXN4DnbvJ5L5hrqHrUZYMT35w8iZhKUVVdJPU4xBq
	VE3785hnkbYmbjPtePWfnznkgwEQlAzEzU0a3yAcWoyZwkkviGrCyT3o8wzQ4yqNZRQShEkZZ0FBA
	PMWd2K9G2sKig/McqFA40hkQyXpZTXvCU8c+sVQT30GK2gEftSflFf1gppamUJNjnV5AFRK/BVgKs
	Di0+1CxrN6rcN/scbzd95JP0aP3pU9we2e6FJFMxUoTlPyb6oKobV3lnRNcRrpo/x4HC2NvecN60I
	acW+NusQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAN5s-006DyT-0K;
	Tue, 05 Dec 2023 04:31:36 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAN5o-006DxT-36
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 04:31:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B8EE3CE1279;
	Tue,  5 Dec 2023 04:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672CDC433C7;
	Tue,  5 Dec 2023 04:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701750685;
	bh=lGZYwUIiKu4amlIwXobviw/VD3ZIr0JStDMMtmlRVqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=io/7Mq7rfMew8JjYKie/TIiJ1z8iLJuyykuKr8VbTDZ1TIYZjAcQAVIJHXCDh1/rw
	 gG1UHHis2iF3GTzBKMpWCN0KmHM7EvkvB6hVcXPUCLXq3g8KtHxWJucdK5WaIOEnp0
	 Rum18VZRLXCJbTmQ10iOT4gu1EVs0sNrcOianBMvk812UkWmlbAIznjvWbYqfq4GKZ
	 myfLjudjTWLYgE7VkXwxNk+2hjqIqOO4hACfWOnQQOiBT7WR9S6/AV8P2anKlwPbWp
	 JkRsCqB+ozBBHquMrfJU0K5fTk/n6RmhdD5Pael6TuVoKUjjswpgIGeMxtiLLpfbnO
	 QuERztJk7CvMA==
Date: Mon, 4 Dec 2023 21:31:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW6nmR2ytIBApXE0@kbusch-mbp>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
 <ZW6jjiq9wXHm5d10@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW6jjiq9wXHm5d10@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_203133_245873_DD2B274A 
X-CRM114-Status: GOOD (  25.42  )
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

On Tue, Dec 05, 2023 at 12:14:22PM +0800, Ming Lei wrote:
> On Mon, Dec 04, 2023 at 11:57:55AM -0700, Keith Busch wrote:
> > On Mon, Dec 04, 2023 at 01:40:58PM -0500, Jeff Moyer wrote:
> > > I added a CC: linux-security-module@vger
> > > Keith Busch <kbusch@meta.com> writes:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > >
> > > > The uring_cmd operation is often used for privileged actions, so drivers
> > > > subscribing to this interface check capable() for each command. The
> > > > capable() function is not fast path friendly for many kernel configs,
> > > > and this can really harm performance. Stash the capable sys admin
> > > > attribute in the io_uring context and set a new issue_flag for the
> > > > uring_cmd interface.
> > > 
> > > I have a few questions.  What privileged actions are performance
> > > sensitive? I would hope that anything requiring privileges would not
> > > be in a fast path (but clearly that's not the case).
> > 
> > Protocol specifics that don't have a generic equivalent. For example,
> > NVMe FDP is reachable only through the uring_cmd and ioctl interfaces,
> > but you use it like normal reads and writes so has to be as fast as the
> > generic interfaces.
> 
> But normal read/write pt command doesn't require ADMIN any more since 
> commit 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands"),
> why do you have to pay the cost of checking capable(CAP_SYS_ADMIN)?

Good question. The "capable" check had always been first so even with
the relaxed permissions, it was still paying the price. I have changed
that order in commit staged here (not yet upstream):

  http://git.infradead.org/nvme.git/commitdiff/7be866b1cf0bf1dfa74480fe8097daeceda68622

Note that only prevents the costly capable() check if the inexpensive
checks could make a determination. That's still not solving the problem
long term since we aim for forward compatibility where we have no idea
which opcodes, admin identifications, or vendor specifics could be
deemed "safe" for non-root users in the future, so those conditions
would always fall back to the more expensive check that this patch was
trying to mitigate for admin processes.

