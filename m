Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4430C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 06:42:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8348920716
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 06:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dp+uOTg7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9cbbCuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8348920716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QFyGwTHRQJlwIZvw1pb3wMAmfaoKx2CVfdPNzv/ZbGI=; b=dp+uOTg7Ws5xsBp1v0+Rpg8EG
	oVtKMcLnPwSE4t2PfuPFcIgvcpS0PiduGLbAX6BfsfWPh5cueEfPB/fUkuTM3/xTsdDnxvEiJGhOC
	n+o0qlDNm6ZIVXx1VvK/VpbEkEYEOZdIGRnubfCS5jZIau0wcEhHJ0kSf2zWjSJ2gghwn8VGc+fNw
	4Ucd5yjZraj0QAOcd7V32zjG3hpjgOYVdQKkALphwEGRteWgmIePTxKnR78yEXfb829RgPMSWR+Ik
	yrhqA4XWeiHykG4/FZ2l9Vd9PMrE/Trd9c9LIVgg5FcXzU7rNkfQRsRoG+WZO0MJU0zt3MicL0mnk
	jPfN737+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7Yqw-0003uf-Um; Mon, 17 Aug 2020 06:42:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Yqv-0003uM-BQ
 for linux-nvme@merlin.infradead.org; Mon, 17 Aug 2020 06:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Zmke6G8N+PgZRa2aKdFidNd4uB0Pqzf1DiitvFCvCuU=; b=J9cbbCufoVG7GnQlnTllpVYRFS
 xnmN/E/lQoGNfjD9gxwvGVqpakG0w5kIL4+L7m9ciriu4JH8W1ZxNu8ORCPASxnqWk/X1CMn2BvZ/
 pWpASZXz2WRary7g+yGl0QziI8zpe11PoX/bMVoDZMd9VQosHhqr+Ntm/JT4hP7gueBY4LV+eVWD/
 1kXjUoRxjnnEkt4zXiIJM+LW2KL+/0QknKChKKctHpzbYVKw5qygt2HLMKm993b6GOSEtmNV7c3Hm
 arGX4g2yT+FKMZyCeBTGlIV0bRl/zfE2XDkY0H3DrQnj10BoNeL7nCQHgK6OZEz7H3SDC3Gfpvix7
 DOc366mQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k7Yqq-00061Q-I1; Mon, 17 Aug 2020 06:42:36 +0000
Date: Mon, 17 Aug 2020 07:42:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Xianting Tian <xianting_tian@126.com>
Subject: Re: [PATCH] block: don't read block device if it's invalid
Message-ID: <20200817064236.GA22917@infradead.org>
References: <1597153386-87954-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597153386-87954-1-git-send-email-xianting_tian@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 11, 2020 at 09:43:06AM -0400, Xianting Tian wrote:
> We found several processes in 'D' state after nvme device hot-removed,
> The call trace as below, we can see process 848 got lock 'bdev->bd_mutex'
> in blkdev_reread_part(), but scheduled out due to wait for IO done. But
> the IO won't be completed as the device is hot-removed. Then it caused
> the lock 'bdev->bd_mutex' can't be unlocked. As a result, it caused
> other processes, which need to get the same lock 'bdev->bd_mutex',
> blocked on this lock.
> 
> When nvme device hot-removed, kernel will start a thread to handle the
> task of nvme device removing, as the call trace of process 1111504 shows
> below. I listed the call trace of nvme_kill_queues() in detail as below,
> we can see 'NVME_NS_DEAD' is set, then when executing
> nvme_revalidate_disk(), it found 'NVME_NS_DEAD' is set and
> 'set_capacity(disk, 0)' will be called to set disk capacity to 0.
>     nvme_kill_queues()
>         if (test_and_set_bit(NVME_NS_DEAD, &ns->flags)) return;
>             revalidate_disk(disk)
>                 disk->fops->revalidate_disk(disk) <=for nvme device, revalidate_disk=nvme_revalidate_disk()
>                      mutex_lock(&bdev->bd_mutex)
> 
> This patch is to reduce the probability of such problem. Before getting
> the lock of 'bdev->bd_mutex' in blkdev_reread_part(), add the code to
> check if the capacity of the disk is 0, just return. Then we can avoid
> the happen of the issue:
> nvme device is hot-removed, and its capacity is alreday set to 0; then
> if there is process like 848 want to read the device, it will return
> directly in blkdev_reread_part(), then it will not get the lock
> "bdev->bd_mutex", which can't be unlocked by the process itself as IO
> can't be completed.

We need to fix this for real, as you stated at best this reduces the
window that the race can happen.

I think our main problem is that due to bd_mutex we can't update the
block device size from arbitrary context.  If we instead add an irqsave
spinlock just for the size we'd get rid of the limitation and can stop
papering over the problem.  Give m a little time to try to do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
