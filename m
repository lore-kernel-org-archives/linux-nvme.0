Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366D2C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YShejYzXpEI7DBG9jPq4o7RVZA9Kn7zM7WKlqtYJx38=; b=i8xZTSHcwqGZe9haHPCm5CKsjx
	xbXLCc53hCnpVr+7iWtxuYnfwkRaEwPUakFZkfvJ1aZ6f9Qu/3XwJPYYbBsNlDoX10dzZ/sjx1srK
	eWTnrreFChtTSq/H3/OpdyUhlUe5LpNn1T6UKVr9QKc3IEMzJCePM+eU7KFR3QweOLbmfYzwgzMUJ
	NuA5phf3myTwYjCYNAy8Dvd3gAQPJTw3lIWlIzozZ2uA1UVlj+fnrZbNNOS311KFPvLvZyFhAC6CG
	aq/P319G2nUMObZgFuwcV92J0Ok6teGJGVnPPXDgtEmR3B9BJ0qkorRXDccpmX6A4EZM3JMj2/ofo
	iF36rUaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSHY-0000000DeIO-0h2W;
	Wed, 12 Jun 2024 18:01:12 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSHU-0000000DeHi-3OOK
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 18:01:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 95E82CE1298;
	Wed, 12 Jun 2024 18:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD9FC116B1;
	Wed, 12 Jun 2024 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718215265;
	bh=YN7JjJ+ypi4AypUcccQNF9WQMHZ2Ts11DvJV8f8L+e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVsiepKAVbXO3E8IqL22By5w/vu9639ch/6d4WQTHZuEXlRmyhv0mBy6cGxsktzUd
	 fH9sV/ernVt1Kh4+HkFEYeKXGmO+C//Smcfz13cBGRtRIRgMaWTWXrymXw+m8dUrpm
	 /h6lprx5zowYVMJiNyUY1CnaG8ytJn8sN7MiOqDXUn37gdJPXhMliU5WmssChpR3yh
	 Y28wDgLx71PFK7xKGDr4zhX20dXgeHHV0VbOE0+IWnv0kzV0wEDBx7VorYxms/JBHv
	 5CAE6VxGUJteaj3n0YPXxQB4wMl5x5rB8YyHZcd/GkH/9FVDLaKEO/UDsn6wGzYRUz
	 WIKD/pLu7hwJQ==
Date: Wed, 12 Jun 2024 12:01:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "brookxu.cn" <brookxu.cn@gmail.com>,
	axboe@kernel.dk, hch@lst.de, maxg@mellanox.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: avoid double free special payload
Message-ID: <ZmniXyHNMNPKBYek@kbusch-mbp.dhcp.thefacebook.com>
References: <20240611100208.115211-1-brookxu.cn@gmail.com>
 <c6b15807-dc35-453e-b162-982fca77443f@grimberg.me>
 <da056c53-cbed-40c7-afa4-e8b57c48e0b4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da056c53-cbed-40c7-afa4-e8b57c48e0b4@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_110109_064918_22FD4B50 
X-CRM114-Status: GOOD (  19.27  )
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

On Tue, Jun 11, 2024 at 02:47:24PM +0300, Max Gurtovoy wrote:
> On 11/06/2024 13:53, Sagi Grimberg wrote:
> > On 11/06/2024 13:02, brookxu.cn wrote:
> > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > > 
> > > Now we may double free spacial payload for some requests, such as
> > > discard. This will corrupt the memory and lead to kernel crash. Now we
> > > will free special payload before retry it. If we disconnect device
> > > before reconnect success, then we will fail request by
> > > nvme_fail_nonready_command(), as a result we will double free
> > > special payload. Here try to fix it, we may can clear RQF_SPECIAL_LOAD
> > > bit after we cleanup command. This will not broken following clean
> > > logic of blkmq, as nvme request will not be partial complete.
> > > 
> > > Fixes: 16686f3a6c3c ("nvme: move common call to nvme_cleanup_cmd to
> > > core layer")
> I'm not sure that this commit caused the bug. The nvme_cleanup_cmd() was
> called in this path also before this commit.
> > > Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> 
> The fix looks fine to me, but the commit message can be improved a bit to be
> more clear about the scenario.

Yeah, that's a difficult read. I modified the commit message and applied
to nvme-6.10. Thanks!

