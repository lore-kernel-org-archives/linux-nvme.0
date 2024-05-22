Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A18C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bX1pEcojrNVLAoFV8QVxTVlxEgltaGiUAz5dVcPjqHY=; b=pBjurrYzMYzhbhTBcl1Sx2UM5O
	DygefRf0HVlwG7sPGUfQ1Jg/ed8ehof5rC6UD7kd9brqKWp3/8pTff+YevIwXlG1eGTBnrTgB7tQa
	I3sifzLFB6WgAxfcBzmgB42uO1fAQOB4WdJrtustIU6gIDhzIw5DfTB7L505oRT7kWlrrDMWE9Rqs
	yR/72b99lp5qGmF65DFYW+jH28+yHHs59fxsxl8KQPZtcju3zkqUssTEEz4itMvaCqUnVKplRCsxm
	dir9S+0DwHbfQ8Y4USPD4UVuJ66uumYK3f7uBFeC2pLObQOvTbXD53A+WNP59EKbuDVMqdoBKKwu6
	YCG2cjpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oZm-00000003Ucj-0Ibz;
	Wed, 22 May 2024 16:12:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oZj-00000003Uc8-0cee
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 16:12:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7C44062A45;
	Wed, 22 May 2024 16:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB888C2BBFC;
	Wed, 22 May 2024 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716394342;
	bh=eui3vNonzRctoG5LJGZLZR0YU1/Yu3qSiv0XRljU2Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFvKRtJF52urNKKwzlyj9HKwnfR/CnR/N/3yNEZdAjmF6IGchZTMFNDxjJqFQjQ7j
	 u9oPTLZAiPn9wPuION+019IdIHB8jM0wImRLmctsr61Wo72xK+XgGHtxFN2tKFHEeM
	 DE5oHLZ4TKK7Pkglb2JArMR/0/Za1FuFZtKhgQmEX/aIFO3BB0VkjSydJHnb4oAk+l
	 khO4m84MAna128NK038+qjP6zvGQunHZufoqyExcneeBVX9xwWav9YatYQs2P7Iti6
	 dtKessQOBmZMyhEtyAhCmEVUh/qbmh5L3ikTBCDS0zfv3PV+mLIa+XM90ul57RGCSM
	 YRic/QpW6eEDw==
Date: Wed, 22 May 2024 10:12:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522091534.472449-1-sagi@grimberg.me>
 <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_091223_429569_852AF3DC 
X-CRM114-Status: GOOD (  16.98  )
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

On Wed, May 22, 2024 at 12:18:57PM +0000, Shinichiro Kawasaki wrote:
> On May 22, 2024 / 12:15, Sagi Grimberg wrote:
> > lockdep complains about the timeout handler running concurrently with
> > the reset work which is syncing the IO request queues (which in turn
> > flushes the timeout work).
> > 
> > We know it cannot be the case because the ctrl state machine prevents
> > the timeout handler from disabling the ctrl when the reset work is
> > running (changing ctrl state to RESETTING will fail, and the state is not
> > terminal). If this assumption happens to break in the future, we won't
> > have lockdep to assist, but for the time being we are simply seeing
> > false-positive complaints from it...
> > 
> > Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Suggested-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Sagi, thank you very much. I confirmed this patch avoids the lockdep WARN
> observed with the blktests test case nvme/050 [1]. When I repeated the test case
> around 10 times on v6.9 kernel without this patch, the lockdep WARN was
> recreated in stable manner. After applying this patch, the WARN was not
> observed even when the test case is repeated 100 times.
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

This is not desireable, but I give up trying to appease lockdep for this
one.

