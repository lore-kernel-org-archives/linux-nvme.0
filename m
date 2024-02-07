Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D3C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 05:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qAkzR/tlhByUbq7uQAk2B5Wrymiypf65KuOiJ3HmVWk=; b=HrUvn2v8Emwavma33zDsDpSb4T
	djSvXKOqPn6m0yqnoMnQyAme7+bfMLcjopZLjMIJ2HUJfuY46l3lMWslhXHnUWow3EbV3VpIIvSfj
	pFJ2a+bBcaUiC02KizslJ5bQ82jhPbczwZyhY+WTlU2atf3kpnrMpX63r7waZn5NA4LTsuJGYTkFH
	W8m4H79gVVn85ZzBAccko4+HWVc8165Xk2uUPpxdNqJwHDn2tdH6QOPq1PP3Vy2f02CIhP4cxkrlN
	3cZrswBRkt3zx1AlkOnzjbowsR5zNZIyJoMAK3R2SWRe9HHXMkuMbi12w/XEzD60hCMFcfdrfrPQb
	9sQ19gfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXarY-00000009m1t-1ejG;
	Wed, 07 Feb 2024 05:52:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXarR-00000009m1S-3Pt5
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 05:52:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0BB77616B5;
	Wed,  7 Feb 2024 05:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81631C433F1;
	Wed,  7 Feb 2024 05:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707285160;
	bh=O4PeTLsXkaYAdP/Wp9otOO/Rt9AX1WOH/UyekYrL5Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emYEGNzu41iHOzjM7rnAiRKx75d7KYVjvrFTUJlU3Aoow3OeLIff/fUdf0WFJ5Ke9
	 mrTig1qQVnnHb1/aNfGE6Rc339ymBouSGzHDMeTYTX4wNEetNDVtuKBEvuMWvl70z6
	 CoJBMeLghpTq7v/QfiMb37j6TUpSUbLdQD1g/b2s0ZpZkxgj1Y1T3d/Qg/GDiYNH1F
	 wZO0T1xYegKz56V4ExqQIY04FLKMnTzplkSkIqKr71o/26HsbaKUnLfumaa0r2RxKm
	 G/n3bf436s88nc8EswGIB5VVHxLn54XVchVM+r03bwJlSH/Br3Kb1sdb4/caX2Ssrm
	 CDkT3zJIAtIjQ==
Date: Tue, 6 Feb 2024 21:52:38 -0800
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Message-ID: <ZcMapgHXFL0nBrL2@kbusch-mbp>
References: <20240205185225.2878642-1-kbusch@meta.com>
 <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
 <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
 <osl4dygp3c76pin62mumm42bs7t4hpooynfvsyqnda4acxxqeo@irad4vxvungc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <osl4dygp3c76pin62mumm42bs7t4hpooynfvsyqnda4acxxqeo@irad4vxvungc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_215241_924401_612A23B8 
X-CRM114-Status: GOOD (  23.66  )
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

On Wed, Feb 07, 2024 at 04:32:02AM +0000, Shinichiro Kawasaki wrote:
> Thanks for the explanations. The issue sounds nasty. IIUC, the motivation to
> add this test case is to catch the device issue early and to not lose
> developer's precious time to debug it again.
> 
> Having said that, this test case will be the first test case to test *devices*,
> and it will extend the role of blktests. So far, all blktests test cases are
> intended to test kernel/driver *code*.
> 
> With this background, I have two questions in my mind:
> 
> Q1) What is the expected action to take when blktests users observe failure of
>     the test case? Report to linux-block or linux-nvme? Or report to the
>     device manufacturer?
> 
> Q2) When a new nvme driver patch needs check before submit, is this test case
>     worth running?
> 
> I guess the answer of Q1 is 'Report to the device manufacturer' and the answer
> of Q2 is 'No'. It would be the better to clarify these points with some more
> descriptions in the comment block of the test case.
> 
> Another idea is to separate the test case from the nvme group to a new group
> called "nvmedev" or "devcompat", which is dedicated to check that the storage
> devices work good with Linux storage stack. It will make it easier for the
> blktests users to understand the action to take, and which test group to run.
> What do you think?

Splitting out device specific sanity tests sounds fine to me. There are
various suites for interop and spec compliance, but I don't know of any
good open source repos providing that.

And instead of end-users running the tests, I imagine vendors could
include a test run ahead of a product release or drive qualification.
Though to be honest, I think this patch is a bit silly to start off that
kind of ambitious project. I'll check with other potential parties to
see if there's interest in collaborating on something more complete.
I'm not sure how well existing device tests could fit in the blktests
framework, but maybe it could work.

