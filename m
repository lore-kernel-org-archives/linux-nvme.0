Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010CAC982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uG/NSTfJZmszqigGPg5JstpiOxiaBZJTAai4JMqr7b0=; b=u0DJNhHhZcVmCLarFoM//s6obL
	8dZjTahqouh4K8id7nB+PLXc8Hy/L7/404bHU9KNd9UG8hVeBsCdyR19xiW4fN3ayk1VieGC2OgdC
	Wfz+LkjN7RVwoPCNFFgNpgq1CubtmgyIy9IBU+wtGFL9fOfEBJM6zs3g45MGR3qZdZHuG6o+UiTZQ
	+QfCPEGN1UlMDC9QKynp42W05XiaJzotRTtLwknYTTi8+vsltnQycUFy3OTuLQ3v3FYLKwOL9jvYd
	aI6iIXzC7fMblWgqcGkyZZOtLRqFCzBvSMUjHJ9qJZoKAQStJKBFIHJChdjSYigNUQhr3r5k5dNtS
	nwDwHIxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aOA-0000000ErZQ-34Q1;
	Fri, 18 Sep 2026 15:20:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aO9-0000000ErZ1-0Rbu
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 15:20:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7BCCA41B3C;
	Fri, 18 Sep 2026 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81FC1F000FF;
	Fri, 18 Sep 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744832;
	bh=uG/NSTfJZmszqigGPg5JstpiOxiaBZJTAai4JMqr7b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4wSpimK93zb8GON1S9dw1Gtn60wuLlEA3hJmpizRgxBDJJ+af5gn5yCD3Y4dENrs
	 lefUZf/LOkW/5ga9M0/URrPpadJ3eQ/XX5fdLiZe64GwpLpEDHyq13iMvCQW/3B8lG
	 eQL46VCu4Ztam4tWDv8Lfo9cP6M3apSjQeIDu51c9aiXzh26kC0qD7jqa6eSvrTQq3
	 RFaC6BQsWO2aLjiGELXqPmRzlZ8k0KZzLbxv+iBI7o7kZ5Lx5ly7r33N2wH+OWPdCd
	 STVuh/lIMj6CB3ab0kozRsdk/j0tOQo6qiUQbbQ2Zy+y0+H9nlb8bSirIS7m0wIYWd
	 XYUIi63pp8ocQ==
Date: Fri, 18 Sep 2026 09:20:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: copy the hostid into the ctrl before creating PR
 pc_refs
Message-ID: <aq1WvQtMSvLR2KLO@kbusch-mbp>
References: <20260916114254.335277-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916114254.335277-1-kanie@linux.alibaba.com>
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

On Wed, Sep 16, 2026 at 07:42:54PM +0800, Guixin Liu wrote:
> Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
> implementation") added a second uuid_copy() of args->hostid near the end
> of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
> uuid_copy") removed the original copy that sat before
> nvmet_ctrl_init_pr() instead of the new one.

Thanks, applied to nvme-7.3.

