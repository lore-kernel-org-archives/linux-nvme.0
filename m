Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B12C0218A
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KUkmntvHoS6n8Lk0gT+aRCCufnirD/G0kTfkHPtfTu4=; b=1Cw3QgUw5ug7Olr+L+dtJIV92k
	BKKXwfsbx2i118VeFmmX36yckmbK9meg2rfX0PgVWISoZFO9PrSuUmlwbNS+sbvpQKUZDh/5w4mr9
	rWcdDrMrvxfKv6Ovn/4KQa9gR+92O0AST/mipSR+uvju3SKsIWcBNC+NOcsjIXNlwmMLO/MITbDXH
	syB0PZGDw5Yo8PsiXmbwx5Ew7ZfGuPpHoxPG2RMb50Da+L4DW+opgX6kSpqrTRYn+WeJTeW+Ul+Iu
	nOBhx8H/gaAIiPNuhN9eX5PStSQTBwCntYI08PeXCglSnKS2qmdCQtrSVM3YWnLBVaz3aRCyy8A3d
	k1amen+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcwOE-000000067TH-29pN;
	Wed, 29 Jan 2025 00:57:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcwMu-000000067Gb-2Fs1
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 00:55:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EA802A41649;
	Wed, 29 Jan 2025 00:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C85C4CEE5;
	Wed, 29 Jan 2025 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738112147;
	bh=fHQX4W65GyKIvsAVa0l454mFXY3/JQdzf77DNqOzYQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WcPJm0KXqHafFE1N+jb6xqiTvr74okKHA28WzssL52oxG/LC1LQO5KR4skEsgOAWN
	 sKn32sh2JY6iNqf5toA92jV2pp11kNk9cXQELTQqxPieLFLwtHe8b3h2DRZ7OIcTIl
	 zWiKBHsZKfWSDEnFH79jrsY3EwHWTVH+Bo+KXuBFsMoQmcXRJW14nYoW7HYTec0AO/
	 i77R6S6DU72BKytNFatgDTvqHIOuvqrMv8TcOeuq6hGPgVYr1GtHiDWlUCb24aPL/D
	 YsXMhFt21eqwkrFYGxnmofh1sO+IShmJK0mtg1ryUFFLXrSD1GK4cyRANoZjDSF1M6
	 x2QMIAS3zsBmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9B380AA66;
	Wed, 29 Jan 2025 00:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5 0/5] data placement hints and FDP
From: patchwork-bot+f2fs@kernel.org
Message-Id: <173811217323.3973351.17971976914892259618.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 00:56:13 +0000
References: <20240910150200.6589-1-joshi.k@samsung.com>
In-Reply-To: <20240910150200.6589-1-joshi.k@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
 bvanassche@acm.org, vishak.g@samsung.com, linux-scsi@vger.kernel.org,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, javier.gonz@samsung.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_165548_642156_01F312B9 
X-CRM114-Status: UNSURE (   8.41  )
X-CRM114-Notice: Please train this message.
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
by David Sterba <dsterba@suse.com>:

On Tue, 10 Sep 2024 20:31:55 +0530 you wrote:
> Current write-hint infrastructure supports 6 temperature-based data
> lifetime hints.
> The series extends the infrastructure with a new temperature-agnostic
> placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
> send the hint type/value on file. See patch #3 commit description and
> interface example below [*].
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/5] fs, block: refactor enum rw_hint
    (no matching commit)
  - [f2fs-dev,v5,2/5] fcntl: rename rw_hint_* to rw_lifetime_hint_*
    (no matching commit)
  - [f2fs-dev,v5,3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
    (no matching commit)
  - [f2fs-dev,v5,4/5] sd: limit to use write life hints
    (no matching commit)
  - [f2fs-dev,v5,5/5] nvme: enable FDP support
    https://git.kernel.org/jaegeuk/f2fs/c/2fa07d7a0f00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



