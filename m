Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F0C9830B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Subject:Cc:To:
	From:Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgZUvBrrAuwrQe14rTlJOhArvVwE613lQBZdvtVkXCo=; b=JJezL+DhEbzcBy6QEhpQzWMzOC
	RflXuupLkaVndWeulOV8JCeDqTlZlEbmT5E3Q5r6WT2xIQ5YjG7FYZVkqBGmeA3TG4fmSNJgiame/
	uo1sT5VSJpQjg9+HTEfIS7rFzNPHwuZGmjQPgzq8R2Vri2pZZwstW4QuKZ7ANmsUGrTIQPgqn8SWs
	MC4Iypi22BZeNIiUOiYHg3ZUoJiNrhKUIEFldXyNuW8pUhD6sa5BF1uOMPoabz1M24vfjSka8YQwk
	QLiXFm60AJRkoJiyzxOT6NJZ2NZ0dGYJDflkwE4DIwwdQlIGcwM3so2RHo0/3evbW6/qn0xzsBW6k
	0lz+bwCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Pzh-00000008tPb-2Rbo;
	Wed, 23 Sep 2026 16:38:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Pzg-00000008tPO-1YDq
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 16:38:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2363F43702;
	Wed, 23 Sep 2026 16:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16DD1F000FF;
	Wed, 23 Sep 2026 16:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181532;
	bh=QgZUvBrrAuwrQe14rTlJOhArvVwE613lQBZdvtVkXCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Owm43DhkUjfV0zbwB2N3JOtVKELcHE7IyuyRCQiySnRq7aWSFltqHyaUW5fyiywvG
	 Vd9bpsqpATnGbeaojI26R+lbJ64DA8QGKxzVFbK7jmGLZ5OB3U0f9entAkyqIxuJDq
	 kFr55421mEIXwwODWWb9BAwaMko0zB090EE/Ba9nA+1TipLMrJy0LxUeiYssL7Bkci
	 KyRl7/duHPFB8deQFySaEYVdCV/vcvLg5WaOFm/foothz38i7wVtu16fcFKEobK2O/
	 rWYgdiQAfb0xyiIEim7wwZrqbzF0dqk6ytJ4KZSreHqQBtsMA6lTg9R9tvrw5DvPU/
	 RJs8vFuBfdSoA==
Date: Wed, 23 Sep 2026 06:38:50 -1000
Message-ID: <700928ff02d35c58ccba15ec371f2e8b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
In-Reply-To: <20260923152653.40953-1-yupeng0921@gmail.com>
References: <20260923152653.40953-1-yupeng0921@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Hello, Peng.

On Wed, 23 Sep 2026 08:26:53 -0700, Peng Yu wrote:
> Implementation:
> * Add a `cgroup_path` attribute under the nvmet namespace folder, e.g.:
>   /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/cgroup_path

Maybe take a cgroup ID instead of a path? Userspace can read it as the
inode number of the cgroup directory, and cgroup_get_from_id() resolves it
at enable time the same way cgroup_get_from_path() does now. The attribute
then becomes a u64, which drops the string allocation and freeing along
with the path validation. IDs are also never reused, while a path can
later name a different cgroup created at the same location.

Thanks.

--
tejun

