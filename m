Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60C4C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YLFUlPTui3/pE3eQDmgaY4aPBj6iX8EWsrXBiwTh0N8=; b=k9u3ovXPtoMLtNBuSuvq3ylmag
	XMSm/o284T42vbQnU8IiBC01LSW+nHUexJwct4uP7B9CEfZXhg58UN8iU7LQEXhaoN7Xm6yhWiJ9z
	GHGG3zilYm9SUyZLjOFdggZOZbd1xnvBrveLFMojzjVj4wNWaWgGbIgVsTRPFxJ7CVXqODw/LDrMT
	oP2Y+doGovE28HFEk6vbDsHpfGJT435yf23OINaNZcOHSGfTnokntMm8YGZ7aXf7UevVI0bhvldt+
	c3sTkRgkmesNHP5ITgwS9HLLnVkR3i/bTGcr7PcfH/Lr1XPsW+qqlG/gRvvsPx9VKTLHNCtwTdP1b
	Ybldm3qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9229-00000005mH9-2H3c;
	Tue, 22 Sep 2026 15:03:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9228-00000005mGb-0BD0
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:03:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 82AD241E4D;
	Tue, 22 Sep 2026 15:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136111F000FF;
	Tue, 22 Sep 2026 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089427;
	bh=YLFUlPTui3/pE3eQDmgaY4aPBj6iX8EWsrXBiwTh0N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PYcV4UgDa50GO1bcILpQvxYF2Lfe6rRIcq+XL9Sag2jWoyBEnljkCa4Z+gZy7whZN
	 6XbuveAx/Ji99QXe4vwLe5okLIEOoQrsmZraA0sW5YChlTE+U9ylVdPXPtJWII9fon
	 P4oGwbDNMDvUvka9MYazYBA6yybu5O8oaYQfQ11ptuWuGrllH5dB1J8V6LpYD8VJ6K
	 6Qz4EdvhhnFEcL+0zhhaeX0l9znOTvJJomS6AOw6Z44oAbMeGFtIdK2HSRUyVPPunW
	 EIsM+ypUR6I1m4W8WPfNbc7tW/u6IiD2hmf0BGX7p6Vw4LGpUZO2cs52NTXukXKmJZ
	 Hul8L26btIDsg==
Date: Tue, 22 Sep 2026 09:03:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 1/1] nvme-multipath: expose path_state via sysfs
Message-ID: <arKY0R_YaFSnKnh8@kbusch-mbp>
References: <20260920025214.3089533-1-kanie@linux.alibaba.com>
 <20260920025214.3089533-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920025214.3089533-2-kanie@linux.alibaba.com>
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

On Sun, Sep 20, 2026 at 10:52:14AM +0800, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
> current path state, including whether the path is enabled or disabled
> with a specific reason.
> 
> Factor the path disable checks from nvme_path_is_disabled() into a new
> nvme_path_get_state() helper that returns an enum nvme_path_state. This
> keeps the path selection logic and sysfs reporting in sync, so any future
> updates to the path disable criteria are automatically reflected in the
> sysfs output.
> 
> Possible values:
>   - "enabled"      : path is usable for I/O
>   - "ctrl-down"    : controller is not live
>   - "ana-pending"  : ANA state change pending
>   - "ns-not-ready" : namespace is not ready
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.

Thanks, applied to nvme-7.4.

