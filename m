Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB48C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCvoAgk8zhYKOoAjq5TY4OQ9rPhl649ZNxRx5rL2Pgk=; b=dM+IiY/QGGp1i6bCkAPIEbGY/p
	U6y3xxsYgb8+/GbDkD3OY6pK+Uapg0jMuI8Rt3ld59fdZjkRSbV3Ptgi92TuTiWvhc8kU5rWENjS2
	6Zh07riWhsmKdSKLch25MRJl14Zu5zSU4VlZRTi1WX6m/CGBIPqOmuVQh1W2AbbmUoONzxZ/iiuSr
	Znys0nNZiNWh4WdJL7N2eqba3Wr8S0hafHPfcWA9EbyIj2UyJ8McWkixSHnFCEfH1KGbprAtzAgOs
	Ep/DQvxVEHxgpCdSLu/5lyLdv4F0WPooOFDYW7NJHHHC23oi+WCQ2dZOS8Ya2jw2paUGV4mJiB+Tj
	5m524sGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6AVO-00FeiI-1k;
	Mon, 05 Jun 2023 13:44:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q6AUn-00FeYT-1D;
	Mon, 05 Jun 2023 13:43:41 +0000
Date: Mon, 5 Jun 2023 06:43:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
	dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <ZH3mjUb+yqI11XD8@infradead.org>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
 <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
 <20230605121732.28468-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605121732.28468-6-nj.shetty@samsung.com>
X-Mailman-Approved-At: Mon, 05 Jun 2023 06:44:14 -0700
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

>  		break;
>  	case REQ_OP_READ:
> -		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
> +		if (unlikely(req->cmd_flags & REQ_COPY))
> +			nvme_setup_copy_read(ns, req);
> +		else
> +			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
>  		break;
>  	case REQ_OP_WRITE:
> -		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
> +		if (unlikely(req->cmd_flags & REQ_COPY))
> +			ret = nvme_setup_copy_write(ns, req, cmd);
> +		else
> +			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);

Yikes.  Overloading REQ_OP_READ and REQ_OP_WRITE with something entirely
different brings us back the horrors of the block layer 15 years ago.
Don't do that.  Please add separate REQ_COPY_IN/OUT (or maybe
SEND/RECEIVE or whatever) methods.

> +	/* setting copy limits */
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, q))

I don't understand this comment.

> +struct nvme_copy_token {
> +	char *subsys;
> +	struct nvme_ns *ns;
> +	sector_t src_sector;
> +	sector_t sectors;
> +};

Why do we need a subsys token?  Inter-namespace copy is pretty crazy,
and not really anything we should aim for.  But this whole token design
is pretty odd anyway.  The only thing we'd need is a sequence number /
idr / etc to find an input and output side match up, as long as we
stick to the proper namespace scope.

> +	if (unlikely((req->cmd_flags & REQ_COPY) &&
> +				(req_op(req) == REQ_OP_READ))) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_OK;
> +	}

This really needs to be hiden inside of nvme_setup_cmd.  And given
that other drivers might need similar handling the best way is probably
to have a new magic BLK_STS_* value for request started but we're
not actually sending it to hardware.

