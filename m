Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF5FEA812B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JoXzgbXa9nYcbkzxR0QqL3E+oOJT9hGNUS49tvktsFA=; b=aCwwGIJclBnOrSn3WHOvABAS6n
	T4CvW7Nd/CvEv/0nO1JjyCfeyyeVAKclZ7vdzV1FWwd5G2seDRgSGVA0BeuJOTXqQ9ogNYiIeCVh/
	Tq1Stvzdxec1jZokkisjpEPkbffJiO23pGZRjnZmqVfgKUwhSnj6bD1hyN6KsX7B2M6YUg+XFeg0B
	JlT792QrjPL64kMoSUpuS7OMsJIl/+bGeqfQx7xskJeSF537zTWk77dPwf1Jnwp3vRegleL5YnxIK
	T3tqf6nmTYPtFznCgagqyZc/KvyeTXGmRpUjeVDttMCZRvm5u4658Roc4fdllgOW2tJP/5ExzBT+g
	YQq7dORA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppPa-0000000H6qS-06aM;
	Tue, 10 Feb 2026 15:12:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppPX-0000000H6pU-1L3w;
	Tue, 10 Feb 2026 15:12:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 03FCD43B6C;
	Tue, 10 Feb 2026 15:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43725C116C6;
	Tue, 10 Feb 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736338;
	bh=ucAfPzMxN1e5F5AUgDTJeXDDV21kxbElkGDjdxAewOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz8+Vmivd/r4Bjxh1a6/1kJGqd6SO7CXP3N1CSFpPVfx1CAZBAjb+x12eAwZqBk7O
	 Hmjcnt4rsYPHr0Vn3CMLrFDG5h1Tn7O2UqTvMo51fbHEahsNRoESLv9fSwXxESCRgX
	 SbFv8bVA2vRXBqOoA/8ikgak1sl6LxJGx03LVKa+lypxDT1dshnMXE7zKs16LKdiED
	 Qmx0u6raLbSF6ttYAdNQTj01lKOyrN0tqVvviOqRsnjeDyRvQozs3kK65rdLah1oeg
	 DtbPfDTJOjT50y06CQN/4pyQqSCeLwcXJnjhcFTWEEo5nJllJEMulKsjucrCeCtvbX
	 isR26yTnHWszQ==
Date: Tue, 10 Feb 2026 08:12:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fnnas.com>,
	axboe@kernel.dk, sagi@grimberg.me, sven@kernel.org, j@jannau.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	tj@kernel.org, ming.lei@redhat.com, neal@gompa.dev,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYtK0C7hxrtz3XfN@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <ac55db2a-ab90-460d-9efa-e13c5a3f498d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac55db2a-ab90-460d-9efa-e13c5a3f498d@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_071219_375526_D80010AC 
X-CRM114-Status: GOOD (  16.42  )
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

On Tue, Feb 10, 2026 at 01:40:54PM +0530, Nilay Shroff wrote:
> On 2/9/26 9:05 PM, Keith Busch wrote:
> > 
> > We've left it frozen on purpose, though. The idea was to prevent new IO
> > from entering a hw context that's no longer backed by a hardware
> > resourse. Unfreezing prior opens that window up again. Maybe it's not a
> > big deal; I don't often encounter scenarios where the queue count
> > changes after a reset.
> 
> If an I/O were to slip through during the brief window between unfreeze
> and the subsequent freeze inside blk_mq_update_nr_hw_queues(), wouldn´t
> it still fail because the NVMe queues have already been suspended earlier
> in the reset path? My understanding is that when the controller reset
> reduces the number of online NVMe queues, the queues that are no longer
> backed by hardware remain in the suspended state. As a result, any I/O
> that reaches them before nr_hw_queues is updated should be rejected in
> nvme_queue_rq(). And if that´s the case, then allowing a small unfreeze
> window before updating the nr_hw_queue count shouldn´t result in a deadlock.
> What do you think?

Yeah, that wouldn't deadlock. It just increases the time for when you
may see IO failures if the queue count is reduced after the reset.

