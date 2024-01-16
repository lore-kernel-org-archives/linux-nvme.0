Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7396C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hgro4ShO6AfoEjGIuDUNzyp4EhHJ34Yz7VtiZQtV2d4=; b=ovohzWZP0rD/YL2EjOlrG9jlW4
	HreLJIOilYEmeczeWhApFvtzXRz5gIsAGb7OoWaNsgvEXLuXqgw4xBKxI3LybjASknoLd89K0YkHN
	8SK45Jsav7MR59YG1J/tRSfUbpkSDsoqnE3UKepHnpm6roSjvXdsC/PuIQZKtEEAWu/pMn7trWSxK
	Oop0qX4JCk47UP+qg+saHKvld+onS78cUlLRL2hL6o4JnBgtE387R+/+N1JOc1hwl7UtPIYnqyzuo
	5tahyjFvy9ekuAAp9UI6gvgrmD2xO+ma0YPmrXnmH5IIpWwSnPXLzeviHXYUqT4S0RbpyjfDg1vBD
	1aJpCqZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPoi4-00D52X-3D;
	Tue, 16 Jan 2024 19:02:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPoi2-00D518-0l
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 19:02:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3FC1961354;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCB27C433F1;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431738;
	bh=oxwRyeIL7M3hBA9vL9BEAgyW9LT9u2t413CGMrrBAAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BQlmYwfLboHO4veFxacQLWA1eyijOjOtpvGdOcLB0sJS7z9eyKYF2Kv6ylK8KAJzX
	 udynA+l1fx/Jxo9NUVI+CNFE1qI3OrGTniJeYVSiJ4reRLREBBQL3xHMvrqwwiw/Gu
	 IKzO4vBoMYNROkk2z4d2RP8CjLajJTU237dQ/uqq0sx/B6CYDpjTbzThBUiNq0wnpX
	 X8gNWgdAyEN8wYTXEhaE3JMmp6ZzcwihS2XBvNccMc8QH4mfkSIhbeDlc+owz8aiyj
	 pGCvOM0Ta4kMlmWsLhLO9yha6U0JHDHRCENEuJlyVpAG6ox/Y412LVgVi4G1swMuoJ
	 UFwOnulWFyR1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2AD0D8C987;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/5] virtio_blk: cleanup zoned device probing
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170543173879.30188.5344312872944674652.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:18 +0000
References: <20231217165359.604246-2-hch@lst.de>
In-Reply-To: <20231217165359.604246-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, dm-devel@lists.linux.dev, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
 dlemoal@kernel.org, stefanha@redhat.com, pbonzini@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_110250_337505_B5D64062 
X-CRM114-Status: UNSURE (   9.60  )
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
by Jens Axboe <axboe@kernel.dk>:

On Sun, 17 Dec 2023 17:53:55 +0100 you wrote:
> Move reading and checking the zoned model from virtblk_probe_zoned_device
> into the caller, leaving only the code to perform the actual setup for
> host managed zoned devices in virtblk_probe_zoned_device.
> 
> This allows to share the model reading and sharing between builds with
> and without CONFIG_BLK_DEV_ZONED, and improve it for the
> !CONFIG_BLK_DEV_ZONED case.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] virtio_blk: cleanup zoned device probing
    https://git.kernel.org/jaegeuk/f2fs/c/77360cadaae5
  - [f2fs-dev,2/5] virtio_blk: remove the broken zone revalidation support
    https://git.kernel.org/jaegeuk/f2fs/c/a971ed800211
  - [f2fs-dev,3/5] block: remove support for the host aware zone model
    https://git.kernel.org/jaegeuk/f2fs/c/7437bb73f087
  - [f2fs-dev,4/5] block: simplify disk_set_zoned
    https://git.kernel.org/jaegeuk/f2fs/c/d73e93b4dfab
  - [f2fs-dev,5/5] sd: only call disk_clear_zoned when needed
    https://git.kernel.org/jaegeuk/f2fs/c/5cc99b89785c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



