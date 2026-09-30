Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93794CA5FC1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qM9t6iP2bgFF9RahCkjeLDxCRIlqy5ztRLf73Y/bLXU=; b=0iuz8ptUW8zrUPuXlcpkxf1LfD
	E1eTw94hPTxl9zr5+A0zfHzQw9zdXfoGgawjP/BKlvp3JusswNOrSNRkSF0JkbU1DhNYzrqtR59fw
	QesAUiQUjNOqGz0xVee/h7MS/FxloiqDFFMiy1MXpVB+9kEJetWfINXA3p3/sw9iMW1aor013HvDc
	NMuYnHU0uyX2tDKfIH3hQg/OmxFEsVVRqx48JbjqkamEalUrQOFvhL+ZVSXUm5z0IGr+SbJtFBYTN
	n0AHIb/MmV54Sb88x5nCgSBwKxNQw+gQeKALDILALG3xnK4cVDAixsKIjYUGq0aA6DYFGWk2uktmG
	XHt5pJRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBp0z-00000005JOz-0lth;
	Wed, 30 Sep 2026 07:46:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBp0x-00000005JOU-1eeg
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 07:46:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7806E60236;
	Wed, 30 Sep 2026 07:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22391F000FF;
	Wed, 30 Sep 2026 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754366;
	bh=qM9t6iP2bgFF9RahCkjeLDxCRIlqy5ztRLf73Y/bLXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kVDu7uhDaxO446ri8ycNWWVSGgdU8tPuJN9xijTCSpXWv4ZcRrc+r3JZ4MCMjTmr9
	 GAv5aAkhBqn8aGj1JbPkM20ZM5G1mNrbZ0Y8lKUpAkGB6tCcEN9iglYzRGrtSn+oRd
	 8vQm19tN4DQcQE5SW49M3Qvd4JOmaE54QxR4ofoMXor9GukvaVkfz7NKpX/4gWu9wU
	 6kFKMhPnI+urQ4x1Gl7cgBU9+eUVXqvPvSeGprTI51HvLihq8SlpO1VP9VnqwKpf4o
	 O48qXeR7jNdGZ6b9GjnFnuY6a91XUINxBHg2VmEdP6j5zkmtNRVKl0gmH1bP7Ibrb4
	 G6Q6UW+NsyTrg==
Message-ID: <da512295-e265-43eb-b44a-74bc7647acfa@kernel.org>
Date: Wed, 30 Sep 2026 09:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: revalidate head zones after unfreezing
 the head queue
To: Palla Raghunath <raghunathpalla.0209@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Yao Sang <sangyao@kylinos.cn>
Cc: Shuah Khan <shuah@kernel.org>, Brigham Campbell <me@brighamcampbell.com>,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com,
 syzbot+2e02ccadb3c5522a5c59@syzkaller.appspotmail.com,
 linux-nvme@lists.infradead.org
References: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2026/09/30 8:26, Palla Raghunath wrote:
> When a namespace on a multipath controller is updated,
> nvme_update_ns_info() freezes the head disk queue, commits the new
> limits, and then calls nvme_mpath_revalidate_zones() before it
> unfreezes the queue again.
> 
> That is the wrong way round for blk_revalidate_disk_zones(). It starts
> a limits update, which takes q->limits_lock, and it freezes the queue
> itself while updating the zone resources. The block layer takes
> limits_lock before freezing the queue, never the other way around, so
> calling it with the head queue already frozen reverses that order.
> 
> syzbot has hit this twice. One report goes through q->limits_lock. The
> other one is on linux-next, where blk_revalidate_disk_zones() also
> takes disk->zone_revalidate_mutex and holds it across alloc_workqueue()
> the first time a disk's zone resources are set up. Lockdep then sees:
> 
>   q_usage_counter(io) (frozen head queue, nvme_update_ns_info())
>   --> &disk->zone_revalidate_mutex
>   --> wq_pool_mutex --> fs_reclaim --> q_usage_counter(io)
> 
>   WARNING: possible circular locking dependency detected
>   kworker/u8:10/3352 is trying to acquire lock:
>   (&disk->zone_revalidate_mutex){+.+.}-{4:4}, at: blk_revalidate_disk_zones+0x1c5/0x1650
>   but task is already holding lock:
>   (&q->q_usage_counter(io)#75){++++}-{0:0}, at: nvme_update_ns_info+0x3ac/0x1200
>   ...
>    blk_revalidate_disk_zones+0x1c5/0x1650 block/blk-zoned.c:2560
>    nvme_mpath_revalidate_zones+0x106/0x1c0 drivers/nvme/host/multipath.c:301
>    nvme_update_ns_info+0x984/0x1200 drivers/nvme/host/core.c:2620
> 
> The rest of the driver already does this correctly:
> nvme_update_ns_info_block() unfreezes ns->disk->queue before calling
> blk_revalidate_disk_zones(), and nvme_mpath_set_live() revalidates the
> head zones without freezing the queue. Do the same here, and only
> revalidate the head zones once the queue is unfrozen and the limits
> update has succeeded.
> 
> Fixes: 224041412693 ("nvme-multipath: revalidate zones for namespace heads")
> Reported-by: syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0910be96b7c31314822
> Reported-by: syzbot+2e02ccadb3c5522a5c59@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2e02ccadb3c5522a5c59
> Link: https://lore.kernel.org/all/2bfc96f2-7d0d-47e0-936e-8810abb31a9f@acm.org/
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Brigham Campbell <me@brighamcampbell.com>
> Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

