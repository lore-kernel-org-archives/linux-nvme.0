Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F157BD5B87A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kEJavqY1mBEfdwv59R72G6zSa0yG9WCeejTYFd6hGT8=; b=DWLLcBD6PTWY0l4EIt+srHk0B5
	HViBj7YJ5NLnILjX6PXtB7Sz18xn+/Pc0AxttqGd0vnN05iMDb1kop8rNDzL5MIoxkS90KBv+cCwS
	R4LfjZiZJ6B7DphNrYpPfJX3PcpoX61P/uvvxNqO5KntUOkzOS52FiH/BGISHjhOZtL+8OvhtxOm1
	5Z+z2MptDk5FQJR0XqzQCzmQlFIUAP8AVdeRImJplC3ukvySup70NXNBEt6eVe2sqH6Iy8gF1sFd5
	CUnM8/Z0fSb4mpHEvLvAK9Ogfgc08AoseCqOnCv302MIIrorHXR8EJqUN5SdH+Ve2PVL9MGyUu+vO
	h6OXQ88g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVJKB-00000004Sx8-2qaJ;
	Tue, 16 Dec 2025 00:53:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVJK8-00000004Swk-408n
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 00:53:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2221F44158;
	Tue, 16 Dec 2025 00:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73A2C4CEF5;
	Tue, 16 Dec 2025 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765846434;
	bh=KVybdq2V+565NkdvIZa4ZXWTv3pqp1aoH6+zdj49hO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZff/+3lrh30ypg/VcLwZ8dRm0LNcxTDJ/Mx1GXevfJSAU6NFwEpZdQTp2J6ONVPd
	 +AdQwfUX76x71Y4SSX4BrmlVOasK87yGpCFZvB1HBuGm/PeH/V5Btry53nccgykKoy
	 cKJIgtKxyNg36L/XJwFtJVik0BkDLCKZZsThmyoAh69+GI3eGTSaNGgT4AHRavSmvs
	 e1OsiNZlUvbzr8wq30dL8qzKmfmUNRbLCypjy/Au26sc+kebX+Vx41y8he60N8SSKU
	 WSgGgtuAnEq0r69RkNJjQF2xDDdsmEzO9kJeBl5zFdG0TBSXZiEjaJMFdUgIjABEwy
	 snfQFZiawb5Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6D0380AAFA;
	Tue, 16 Dec 2025 00:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
From: patchwork-bot+f2fs@kernel.org
Message-Id: <176584624503.387072.9496719293644511831.git-patchwork-notify@kernel.org>
Date: Tue, 16 Dec 2025 00:50:45 +0000
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
X-CRM114-CacheID: sfid-20251215_165357_038718_054BB333 
X-CRM114-Status: GOOD (  11.04  )
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
by Mikulas Patocka <mpatocka@redhat.com>:

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
    https://git.kernel.org/jaegeuk/f2fs/c/f4412c7d5a5a
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



