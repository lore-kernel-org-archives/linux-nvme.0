Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11968D339AA
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSi943pevgOoyLSZn45OdOvqLqbQTsdHUcnRUVpyjXY=; b=3cYjxJj1V7N9kDkxiJaqnN2y0w
	Qb1MgWS9PoFVjPWNPtoJm3T+VPjZKpE1j1G2w+PgJ8PSjDWhzRlzPa2T8wEcKh41b4o0SZIvn/pIZ
	D6NtAIeBSJ1yYY2HH1PmmZxv1y8ucpCmLU0txKLJL+zCo2I3AV1M/VGB3qEXC/qI25ciok3PJPKYI
	ZZZoaQGZYMOV/lSzOq2MzeJEkrcwMss4GzDCxVrd+xm+qUyMaVbAosuAfiaWcpi1gD5vgP5Jb9/0Z
	jh6EGepTVGjvEuek8NLO0Lq5ygMF7+DzaQOWi3QM7kOj/AHtsaN+3Se0V766yYD+5+oKNQtP6E49B
	L2p2qNEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRaHC-00000009mmL-3CRA;
	Fri, 05 Dec 2025 18:11:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRaHA-00000009mmF-2X6T
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 18:11:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 96E3A60010;
	Fri,  5 Dec 2025 18:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE33C4CEF1;
	Fri,  5 Dec 2025 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764958287;
	bh=xvJiMqYzv2lBABxfbmsAKWvxtjq41CSjpip/GdWHMHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLkGoCdUM+QqS7cLYuIjhmYVYVk64SMe3tUmgVbdaJsHW8T0AvuwaowVlbCRFLb31
	 Ko5npbaonrnhBIj6xPlWQapkWtbqWT74SbYsLU4FzfGQkw3Yryr60UT+nMZ/txJnTm
	 u07qpC8AHNqR9wy/jcVSgw1xbf7aGUwjZphmOEWm2hQHjV4X+L6rv+RDhVKX9hCgZ5
	 JhpXMiGh2yMitaqb35JmAZaKZ+5/qo05Up4/JfSiOEH8Ez8G38tfyagTUsYHaRygqK
	 UoqgOkdT6RIQtl8yuAGagMUt9xi7NWLCRmZGKgr27I+AJIZPQFKdAslz7YMmkkY/MM
	 9zgJbLPVsTRhA==
Date: Fri, 5 Dec 2025 11:11:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <aTMgS0njg-R-T0pT@kbusch-mbp>
References: <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
 <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>
 <aTI2L6j50VWjp7aW@kbusch-mbp>
 <20251205163926.GI2376676-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205163926.GI2376676-mkhalfella@purestorage.com>
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

On Fri, Dec 05, 2025 at 08:39:26AM -0800, Mohamed Khalfella wrote:
> Why sychronize_rcu() is intolerable in this blk_mq_del_queue_tag_set()?
> This code is not performance sensitive, right?

synchronize_rcu() gets expensive on servers with many CPUs. While this
is not a fast path, I think adding it here would still be harmful, if
only just to testing when devices are frequently created and deleted.

> Looking at the code again, I _think_ synchronize_rcu() along with 
> INIT_LIST_HEAD(&q->tag_set_list) can be deleted. I do not see usecase
> where "q" is re-added to a tagset after it is deleted from one.
> Also, "q" is freed in blk_free_queue() after end of RCU grace period.

I think you could skip the synchronize since the queue's memory free is
done in blk_free_queue_rcu from a call_rcu() callback.

