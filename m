Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0DCC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0xdtWUgrgEBgOKj1dqsZeSSY9e5E0JF2TnGzqMcS4k=; b=S1/jGWtSHKC2JX13NwS6UegC4w
	bMFeQR1HAS2maKD2FHLkrdA3i2whTDnqvP8XaUD8kbJC5/6qMMTdvlAQL5z8wCQhxGHnl3jhpRRNs
	5cabVgRysyEl9miT5rJgeAeixknwueoepyoe2BewQEltRlpXccxCcZW4JySqZlPR+LI+d+K3UyqZx
	aRkbWzRVCqruxas8ntPacTgsB/RrN1NISIjRJwM4fC20ywxZuOjtepnoqo7YDqZVQcoSlzoYW3KHt
	VAD9kBmx6OP7bnjmotJc2aW/5kvgizjiZN5of/mzY4hJPhz2N182cNHYaKzUttUMyrmL1YeM7CG+n
	NkYAU4CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olrw7-007sPg-VN; Fri, 21 Oct 2022 13:19:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olrw1-007sI5-1u
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 13:19:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B4CD68B05; Fri, 21 Oct 2022 15:19:33 +0200 (CEST)
Date: Fri, 21 Oct 2022 15:19:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <20221021131932.GA22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-3-hch@lst.de> <Y1HyOS9A72GZIQWT@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HyOS9A72GZIQWT@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_061937_275566_B1F3FA39 
X-CRM114-Status: GOOD (  15.72  )
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

On Fri, Oct 21, 2022 at 09:13:29AM +0800, Ming Lei wrote:
> > -	blk_mq_wait_quiesce_done(q);
> > +	/* nothing to wait for non-mq queues */
> > +	if (queue_is_mq(q))
> > +		blk_mq_wait_quiesce_done(q);
> 
> This interface can't work as expected for bio drivers, the only user
> should be del_gendisk(), but anyway the patch is fine:

Another one is the wb_lat_usec sysfs attribute.  But maybe it is better
do just do this in the callers and WARN?


