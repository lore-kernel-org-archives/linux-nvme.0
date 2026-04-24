Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A49CFED3CB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixBREJVKgp131kWjN5dj+QRXsNTVV5aVTaajqR7ILbc=; b=RY/xsk4R1mmDm+zBTund/6ez4M
	yCTJ3Pb9ouRm5N/ooytkeuJW6TwLAQm8btaiJ0hH9aKSv0pokV3KLLPetfok0Dc6p2b5qSSFTsCu8
	0l0H+YAGbI4DzL5pcuY21K33pn1V4oU1RoIV35+9RwXgTNgSR6QJR6ENJ47d5pR12NkMz8dDH1dQn
	0AAC8wR7b2KuR7no8p1ygVtbRsnR7CM5pA0Nk5JBqeP9UanpxxcwjbVRZxxXO1nKTK6PmUFlsNKLX
	MKa7UKeN7AxlXb5XmLTorw2bMTwW+O1NCviPRtiICpwKXDgb69da5SHq12O30j6wes++WJlA5vlXf
	WL9iaejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGrU-0000000DGnh-3VCF;
	Fri, 24 Apr 2026 13:46:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGrS-0000000DGmu-1xTq
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 13:46:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4382768C4E; Fri, 24 Apr 2026 15:46:21 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:46:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
	gjoyce@linux.ibm.com
Subject: Re: [RFC PATCH 1/4] nvme-tcp: optionally limit I/O queue count
 based on NIC queues
Message-ID: <20260424134620.GA17351@lst.de>
References: <20260420115716.3071293-1-nilay@linux.ibm.com> <20260420115716.3071293-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420115716.3071293-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_064626_645275_9DB6A22F 
X-CRM114-Status: GOOD (  21.44  )
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

> In such configurations, limiting the number of NVMe-TCP I/O queues to
> the number of NIC hardware queues can improve performance by reducing
> contention and improving locality. Aligning NVMe-TCP worker threads with
> NIC queue topology may also help reduce tail latency.

Yes, this sounds useful.

> 
> Add a new transport option "match_hw_queues" to allow users to
> optionally limit the number of NVMe-TCP I/O queues to the number of NIC
> TX/RX queues. When enabled, the number of I/O queues is set to:
> 
>     min(num_online_cpus, num_nic_queues)
> 
> This behavior is opt-in and does not change existing defaults.

Any good reason for that?  For PCI and RDMA we try to do the right
thing by default.

> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl)
> +{
> +	struct net_device *dev = NULL;
> +
> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
> +		dev = dev_get_by_name(&init_net, ctrl->opts->host_iface);

Return early here instead of the giant indentation for the new options.

> +	else {
> +		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
> +
> +		if (tctrl->addr.ss_family == AF_INET) {

And then split each address family into a helper.  And to me those
look like something that should be in net/.

> +
> +/*
> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
> + * be determined.
> + */
> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)

drop _current to make this a bit more readable?

> @@ -2144,6 +2243,24 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;
>  
> +	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES) &&
> +			(ctrl->opts->mask & NVMF_OPT_MATCH_HW_QUEUES)) {

The more readable formatting would be:

	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES) &&
	    (ctrl->opts->mask & NVMF_OPT_MATCH_HW_QUEUES)) {

> +		int nr_hw_queues;
> +
> +		nr_hw_queues = nvme_tcp_get_netdev_current_queue_count(ctrl);
> +		if (nr_hw_queues <= 0)
> +			goto init_queue;
> +
> +		ctrl->opts->nr_io_queues = min(nr_hw_queues, num_online_cpus());
> +
> +		if (ctrl->opts->nr_io_queues < num_online_cpus())
> +			dev_info(ctrl->device,
> +				"limiting I/O queues to %u (NIC queues %d, CPUs %u)\n",
> +				ctrl->opts->nr_io_queues, nr_hw_queues,
> +				num_online_cpus());
> +	}

And splitting this into a helper would help keeping the flow sane.


