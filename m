Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FECE9A04C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 21:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScMEDmB076+hqZ+ps1vGqxbfDfH+movYOrW9hNYmRkI=; b=xniC2cg7+1+rO50nLb+9fRJEFh
	9s+8pCef28g5yQItRhHrhdb9hqwaBrbhFYs/JGuTERVgrxGSXXTqAg8MiYCW14XChakQt8QfwvTpA
	rqzF6kTxTgMYudk1eKgZmMae+JEqb0jUjAsTrVUZJsllaRHMGmiBAvN1uqUby2z9BDn5/8qiLC2rD
	YOPyDtXGlz5Ci6qSR18WKNhJs2Gva242MK1ecSbZgRRp3qqdgB4BPg/yCRkCdmNcSiNdn/T6cClSU
	mm1HYm6aNKqzZDx9VI7rni7d47ARbQTPStHKD0YXFRRn7OSw2IQQuO8Kt/lf1qYkVSya6ldxp+/AH
	RuJ5e7Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsSP0-00000008tCY-1bUW;
	Tue, 17 Feb 2026 21:14:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsSOy-00000008tC3-2P2r
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 21:14:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CFE9444EF;
	Tue, 17 Feb 2026 21:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0374CC4CEF7;
	Tue, 17 Feb 2026 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771362875;
	bh=rF0onOkRJ1MrR79ZRlAH0saur24ktYQyPGIU00QVPCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=obNAHU30KeK7e4E+sJrNxIjHjieqmvasFe6OLCrFOzjIJ/x/ojJyR0JO/ZkJX3uKX
	 tbWWtrc5dHY8LwitoshVEtU/1kxURSuzZIjO8r6uOdGHN18+12Urb+dFuH67HYbwhT
	 DI/Yw/Kr77gPExDFVz6ed7SpTm8irFrx3L9YGbh4TpucAbeBjCbzUo8hygal10yJRL
	 xBSwgaiQww96d3ZVpu08zOJmu+zi9YB6vCrQNEcrYCrJQasyYZ2peWj5ctsXwB1q7s
	 4MajCpqM0F2EM1gDpyQG2Glw6Qc+6LCZgMx4vt+uN6/sO5VpYO1WkvlgkjKbwgyU8D
	 SJBJRAHiqaIeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0D13806667;
	Tue, 17 Feb 2026 21:14:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
From: patchwork-bot+f2fs@kernel.org
Message-Id: <177136286684.643511.2911265753074075940.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:26 +0000
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
X-CRM114-CacheID: sfid-20260217_131436_634474_5A292DB5 
X-CRM114-Status: GOOD (  11.61  )
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
by Carlos Maiolino <cem@kernel.org>:

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
    https://git.kernel.org/jaegeuk/f2fs/c/699fcfb6cb80
  - [f2fs-dev,V3,3/6] dm: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,4/6] nvmet: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/38d12f15c477
  - [f2fs-dev,V3,5/6] f2fs: ignore discard return value
    (no matching commit)
  - [f2fs-dev,V3,6/6] xfs: ignore discard return value
    https://git.kernel.org/jaegeuk/f2fs/c/2145f447b79a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



