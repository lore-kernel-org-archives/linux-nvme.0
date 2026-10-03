Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC26CA5FE3
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nN3MZABTIIjxIMWdjQc1xGIL8klPhNn3S21ASF4my+g=; b=kznzcPwxO2W5rK0Nm/4hvYmrjm
	zpkZUci2W0jU/CzwSlf/m2pNAGPleeo9ro9ZF+at/z3nrudB6s4uLzde0670RWLa59XvtXHtO64TL
	zVfy8JQF7Qlgev2vYPCvhR5bLV9OCh+ftfnR/XkGeEHI7IcWtDEfIapLOwssKWAPf691UNo58RnEq
	BRkJJnFfjLiCYrVwsy8RFOHJHA2ho33litWYEv+9cCs6Yl7FbCuETeJ9yxbz3PK8cpJhI1ep3/fax
	UMLKxU08JgU763TU+fSAkmXlWq4V6CyjZFeD5Jav6Vf5rSrwdovPx/Roa+XOIUrKgD62FQNsaVpsZ
	aUAVameA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvY2-0000000DDsE-0LSY;
	Sat, 03 Oct 2026 08:56:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvY1-0000000DDs8-1Kkc
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 08:56:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BF10A602C2;
	Sat,  3 Oct 2026 08:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3373A1F0089B;
	Sat,  3 Oct 2026 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017808;
	bh=nN3MZABTIIjxIMWdjQc1xGIL8klPhNn3S21ASF4my+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SrPJpIoK7LzXm/h+MaAdShNOXpWjvgbQYHYwfSPIq+j65GsuThrhsUH7K68Br42R9
	 gpdMOrrbOjXXdXbZLjacE4yvZg7wyQkweCTL1DZBSUB/pKv4MFQ4yPUJsIHOZuvqWs
	 nOt/F6C53S9/F2Tcn7xQk9axjy7fLCiuMugQUkA0rY5wZrR+1gn8/V/lJ6UfbahtbD
	 BUYWZBPeg/yvo+4/iLL2wOT5AL1fsLVfJBoDQLqX56BlEclXSJkbTZrZ38B8FtXkvD
	 eTDo23q0/7nu/yIhaHqmQLJRbmpg6md40fBoqXbUsh/RGjbv8zX6OzjKFuxQh+CB6u
	 U/ONEWlQWHgBw==
Date: Sat, 3 Oct 2026 09:56:42 +0100
From: Keith Busch <kbusch@kernel.org>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien Le Moal <dlemoal@kernel.org>, Yao Sang <sangyao@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com,
	syzbot+2e02ccadb3c5522a5c59@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: revalidate head zones after unfreezing
 the head queue
Message-ID: <asDDSv8LFGefB8xw@kbusch-mbp>
References: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
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

On Wed, Sep 30, 2026 at 07:26:47AM +0100, Palla Raghunath wrote:
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

Thanks, applied to nvme-7.3.

