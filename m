Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=05uMJ1HV6yuQQLQ150EYxSvw5gBUJ5qB8Poyf8GW6q4=; b=ZMUjT6upR1ylf3Xi8IGkq9Q2Zf
	1G8NwK3/I+zzdV+QBhH/0PGUwwt6xnzaQFaGwmC9DPrZyd/R56YnHWksdoZ6ACoiNKwHNquyCHlod
	t6uY+I3hropo9BKS6jTZF4Co+uqhaNe8QCenuzPa+RWM01QtsZWAwTIqII0KFn2aElmSQa1gOU6vO
	pmnAjde/Cbq6EpP+L0G3bLS10dtAFE3B1q4tfSwT27aGvPG+ZpD9IM9HEhVo1MPJbOemGZsMwkxD+
	vxChJ9XbW9xRgZsFLEmCMG3lGzmaK7UuN63fzXGgreKw/Kjg/kBxryJKJdxlgCssaqhAKWnHTto9B
	jTqBYWeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwIW9-00ELEy-Uv; Wed, 01 Jun 2022 07:11:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwIW7-00ELE9-FS
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 07:11:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CF5E761328;
	Wed,  1 Jun 2022 07:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87AC385B8;
	Wed,  1 Jun 2022 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654067502;
	bh=msvXeenbVZkFFjDrBwDGhupiSlP9tbiX4Ft0x4Ech6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZEnabnhlnptNTwlqLetggxM0qB9RfzMjTfcYWooe8t39hTdz3Neg44WxfFOcxWZu
	 GseZdVPiLFptSKd3XGZrDbTo0pqhWAuzVVytqByTMVvrg7cTHwE5Us4XzXdaC1HF2A
	 N7C/oVr7CcFSN7FzyEo5KvBCsd05XUmyRQWCU8fAifVwI3KXc2jMeaPQLOV2YzvPgL
	 kQwoBIZv/IQN/ugsODtQsBIXGRrpjAqSJw2oNo3+a00mim7kk7GVOHTsm81sGj98yl
	 rGA8dmLVmIrzLofXBsyt6/uCMb+3xHt8UV0mZ4S4ty748cnysXqJMXPeWgKtyEfQVg
	 unHxy8dSjbJjw==
Date: Wed, 1 Jun 2022 00:11:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <YpcRLKwZpN+NQRxn@sol.localdomain>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_001143_594665_9F1C7710 
X-CRM114-Status: GOOD (  14.65  )
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

On Tue, May 31, 2022 at 12:11:26PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The most significant change from v4 is the alignment is now checked
> prior to building the bio. This gets the expected EINVAL error for
> misaligned userspace iovecs in all cases now (Eric Biggers).
> 
> I've removed the legacy fs change, so only iomap filesystems get to use
> this alignement capability (Christoph Hellwig).
> 
> The block fops check for alignment returns a bool now (Damien).
> 
> Adjusted some comments, docs, and other minor style issues.
> 
> Reviews added for unchanged or trivially changed patches, removed
> reviews for ones that changed more significantly.
> 
> As before, I tested using 'fio' with forced misaligned user buffers on
> raw block, xfs, and ext4 (example raw block profile below).
> 

I still don't think you've taken care of all the assumptions that bv_len is a
multiple of logical block size, or at least SECTOR_SIZE.  Try this:

	git grep -E 'bv_len (>>|/)'

Also:

	git grep '<.*bv_len;'

Also take a look at bio_for_each_segment(), specifically how iter->bi_sector is
updated.

- Eric

