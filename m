Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ABAC54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q13nBugoKjyr9ZoypFV3Yjm3Mx3CjOgHidwT5pFaw/A=; b=3INP7jpnena0vs2nqpKUiX0bY0
	eg/FPM/Kn5JrFhi01NdcYPEP4A2Xa5l3/25eEHBaX65J2O0IYx0PFVhQyuVgH73jqcdD+AS8O0E6U
	1NhMngMl10G0ldp2iPBs3aRRf7qnc912tVZPVE1W2zkmmxPpjOotsGdFyvoP/ilv3FpUVfv6dXIxT
	1j0Hw0+xLKtiuUM6CHy+GGLEc0ABocOuppJxUV2HasEyuk+JyISRWAXwdaV4bXg48oVSh66CukUm5
	Uyygte3hgvYG9xY0X7UJwPr10zpq+ewII1O/smFjXcVry/mbk7q9rL4YTVStVRFEMbYSyOnUllse3
	wARcpZTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmJrf-0000000A4ek-0h3M;
	Mon, 18 Mar 2024 20:45:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmJrT-0000000A4V6-2deL
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 20:45:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D810060CF4;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E0AC43390;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794733;
	bh=RA7YG9SxvBNH0HzRjB4rflPOx+FpSXM4xEmiICNLvcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KyFjlQSNxf74Oqy7Vk41Z9wIUXqjnooZpsxTmo8JSxgThzYTCwHWls0FF4kzamlkc
	 BlUnEdjGJSg5ibhkZUC8lt2Xeel4gl61vL89noc5We60f9m4H0aWRCbEggOM63FrzT
	 U1A8ZyDACddoeXAkXK1+9VK8ib5U8ZT0jbstEuF+R64RXuhWsc0+MKGFuei8pq2JaP
	 ExIXX0oF28y6mNxHposHwr0sC7JB71EKrozyr3MdNIBhBxgYeeV4gsGh6iS4aQxzwL
	 2hQ0TTKB2vLUf8IIclhWDz0+927nPTxLVGQ3oVViWPszlA80Fb4s07T232h/EFw9uT
	 NK7/pbaFd1cZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AE0D174C8D6;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 0/5] block: remove gfp_mask for
 blkdev_zone_mgmt()
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171079473317.25373.4387818669796784248.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: dlemoal@kernel.org, naohiro.aota@wdc.com, jth@kernel.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
 clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, jaegeuk@kernel.org,
 chao@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_134535_797881_B87C5038 
X-CRM114-Status: UNSURE (   9.06  )
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

On Sun, 28 Jan 2024 23:52:15 -0800 you wrote:
> Fueled by the LSFMM discussion on removing GFP_NOFS initiated by Willy,
> I've looked into the sole GFP_NOFS allocation in zonefs. As it turned out,
> it is only done for zone management commands and can be removed.
> 
> After digging into more callers of blkdev_zone_mgmt() I came to the
> conclusion that the gfp_mask parameter can be removed alltogether.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
    https://git.kernel.org/jaegeuk/f2fs/c/9105ce591b42
  - [f2fs-dev,v3,2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
    https://git.kernel.org/jaegeuk/f2fs/c/218082010ace
  - [f2fs-dev,v3,3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
    https://git.kernel.org/jaegeuk/f2fs/c/d9d556755f16
  - [f2fs-dev,v3,4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
    https://git.kernel.org/jaegeuk/f2fs/c/147ec1c60e32
  - [f2fs-dev,v3,5/5] block: remove gfp_flags from blkdev_zone_mgmt
    https://git.kernel.org/jaegeuk/f2fs/c/71f4ecdbb42a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



