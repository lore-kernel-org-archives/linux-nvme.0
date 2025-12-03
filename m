Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A84D1BDFC
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 21:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08QPltQjjVweN7ZFDco1IWhSRigw67mEXxD2xucsKo0=; b=ui+gOqD1BVOVCC4+zf7so5IRS6
	mxPipbqYExtYshc3XFdZMFj2VA6+dNJqwn/oEjFg0waWSVnPQtQ614ynYL2Jr0A6frROsLVdUYvDT
	z3cwrajJZxhuGrlkYibnJ3wt58Kov+CQCbbhpKgQ2UK/Ch2EpYsLCrNIFGAoEExl4f3kTtX20166h
	EeFOa9PMX/su9twcTGQvzP4DoFHsQjnl9Ij6LjUV88CWCjfn8hsqB3DNr465djmVRmesbL0mOwiPg
	xQ20Og71TEyQ1Z3xjWApQ16G2ugBBDCYsRqzlpNh91YdFbsxBSqFe2MegivQBp+LQRAXMXaMIqHLT
	Akh+GzWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQumb-00000007BrD-0vs4;
	Wed, 03 Dec 2025 21:53:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQuma-00000007Bqs-05dB
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 21:53:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 180686017E;
	Wed,  3 Dec 2025 21:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF8C4CEF5;
	Wed,  3 Dec 2025 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764798786;
	bh=FFk0BICWZ0s9eg+EWRAL/A8moz5Z/8tPM+4OoOw4t0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VeYW0UkyuCwbiBS6GRQIS4qLICBiVyT5vCPL9NSbIU2AsyhMfKJ0O6UOsBhbWt6Gy
	 t7OG96Mx+yOrltCQyVBwsFqX+YaPUVrJ+vWUeSd+WVBPXhyAB9Hggez6ODy6dFYYui
	 ZpaMIqHYB5Eiv2d9dM4l3tiqJxDj5tDxZNo23QAaoGlwyhvON5tTsqIKBIM+SYJAbL
	 WpzHUkIUck112Sr4cYs5KtgpwZcOFe8HykPGjTzRMFJWOF8SMIVxOrnf6S6gAUF/L0
	 53SEym27LIuvDbTfdtDbyEw2FZA2ECa7B7byH54yqXJ5EbCTxX5aWDGUhcWEpmAOnq
	 yvG5vq/6EsOOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59AA3AA9A81;
	Wed,  3 Dec 2025 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
From: patchwork-bot+f2fs@kernel.org
Message-Id: <176479860568.93351.11152980224844433705.git-patchwork-notify@kernel.org>
Date: Wed, 03 Dec 2025 21:50:05 +0000
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
by Jaegeuk Kim <jaegeuk@kernel.org>:

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
    (no matching commit)
  - [f2fs-dev,V3,2/6] md: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,3/6] dm: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,4/6] nvmet: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,5/6] f2fs: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/807e755c468a
  - [f2fs-dev,V3,6/6] xfs: ignore discard return value
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



