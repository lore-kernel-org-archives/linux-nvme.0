Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713EBD3B985
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpc1/790a/fIVeMUOKaoWtoTbCzKwQ4S6SVyK6PxGUc=; b=cXNh739gGBd7ctuucnc++UB+os
	CleKQQqXQUVqkRkI6Y4e4V51LoAUq2mZ6GgdlkbO+PBM2zDc52Zilw3OOUzogRwKJktsocYMKCuVc
	H1oeRajnQeUc5L+R1y+QBoO0xocrUOb/Rbd4eyPHnBpgpHDOLIOeG9CdgZJxkkch3YAANBUhlUo/c
	48WdC8Z30wlAzym0148tkklICBmchjQVktnamBGUrRLy3KSnFVV6yAvB8vphkNfjYDSCyjRY7khAf
	KLTRw6cqVyr/iIOJK5sawVvs0T/E0Qk/WScTuLxY8/8QLDQSEWdad/QUwOlkcoS/iA9E6Hy9bzlE7
	seGdLw1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1PQ-0000000EaSL-3l92;
	Tue, 09 Dec 2025 17:21:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT1PO-0000000EaRy-2Eyz
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 17:21:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C73FF444D1;
	Tue,  9 Dec 2025 17:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2988C4CEF5;
	Tue,  9 Dec 2025 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765300912;
	bh=4D7MGFxeRJTDY1I7TVqNGOxjKxHrYX8Xu/NQUp33yQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZuUNgvto237oQlEXMdNAwfCle3hrlKfTdWltwxprsJTDwDSOdfrCe6Lc0w70aYteg
	 USDyX2OxNMDGgtWaUvicOUoeIciT2t7tAOw3WDlhOMzTKJeRy4m0i+RWtaUBFa7E/C
	 Fh64065DCj12G8NmPeComkTbsyqVXopIMgdcUxuhBpB7h2CHxjNtePOG2zHBH1ffFn
	 jYf9fNs4YEVS13NGMzinskDsNMCoWsCgmTtfmDYOQcD1Rw43ZeZ7C07/EiBlJbd9QX
	 ILeieRrStbLL0RC69ydyLES/kPMYSQcagtEyRshqmJjUXuvmVrcEofuvPcdhc/bh6r
	 wr318dPlMkLHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AFB3808200;
	Tue,  9 Dec 2025 17:18:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
From: patchwork-bot+f2fs@kernel.org
Message-Id: <176530072781.4018985.3920629164173659180.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:47 +0000
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-xfs@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_092154_619820_0E448F08 
X-CRM114-Status: GOOD (  11.31  )
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

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Mon, 24 Nov 2025 15:48:00 -0800 you wrote:
> Hi,
> 
> __blkdev_issue_discard() only returns value 0, that makes post call
> error checking code dead. This patch series revmoes this dead code at
> all the call sites and adjust the callers.
> 
> Please note that it doesn't change the return type of the function from
> int to void in this series, it will be done once this series gets merged
> smoothly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V3,1/6] block: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/7d09a8e25121
  - [f2fs-dev,V3,2/6] md: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,3/6] dm: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,4/6] nvmet: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,5/6] f2fs: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,6/6] xfs: ignore discard return value
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



