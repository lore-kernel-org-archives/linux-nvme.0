Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F44ED6C285
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCNIxWB263H7bS1H/rRLbg47bt0RdRqcVFfwbHefgXM=; b=PRYut0Qbgqz0l9JsLqMFRhlSTT
	w2JOenwzT7DDe4+MFWiicsc0JQyVmHlKQLk5/rKCGGkgjBeo9zISUU7bUdgwfAIIoDgXfclMfaXeC
	vZIC5bRJGF2PXUpfiTW5F2Zc0J2zD880uVEt9BorRbZzKF9vVNQM6BSpKpi8un+BHEU3pFPmtrnjc
	5rGSFMgpqZO63IiiuzaVPdJUYnzzpPy/YpXmRR5h0+TnANBBAD4xNwKHy+YGYktY4vrvxfBlhtezn
	e25o+2Og1Xj9/Q0vQJ3LS7TuqVAXqPws3O7D1PY9YvW9r3bov/dfcNzk1bGaImZkP7Zi/lG6sS2Wc
	8iPiobtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDSnH-0000000DMKV-2C3x;
	Tue, 19 Nov 2024 18:17:43 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDSnF-0000000DMJg-2Hjs
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 18:17:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 34F22A42DCD;
	Tue, 19 Nov 2024 18:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE76C4CECF;
	Tue, 19 Nov 2024 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040260;
	bh=1Rx6a5V84mNsHyGKKeXNKMM/vPdlFSELDYwqEbiBPeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8EeqhnQi6uKCJjvjP6uWGWQ8590S9VIKoLh/HP/xmwfn+waAhC5hVS6XeGvcfHjM
	 WbJkdkFCu5UF/JOREe3/7z8j1PG4tOC52enCBYjrNVysiReas4HAZYXZk8RpbJACAr
	 fYj/9RvaTp0FA9LEtZXQ14k2n/5lEc/KwZjItXNX4Vt+w+ZsYjR0/nVE7/Hk0PtqXZ
	 yy3boh8RLCcHgPcsZGw+PWUo3IyDOiDjchIBIiq6YQ5hpJSTx9Vfr9wCRSCx2NahZD
	 TrTS0wtbty5NsrIWSDF7LrJ6fkG66Jlm+zyLpMoNF/N5+igSMjrHB0XBS/K8dOKrcS
	 6kXkMdfjTLQwA==
Date: Tue, 19 Nov 2024 11:17:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme: enable FDP support
Message-ID: <ZzzWQFyq0Sv7cuHb@kbusch-mbp>
References: <20241119121632.1225556-1-hch@lst.de>
 <20241119121632.1225556-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119121632.1225556-15-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_101741_644775_7809D4BA 
X-CRM114-Status: GOOD (  14.94  )
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

On Tue, Nov 19, 2024 at 01:16:28PM +0100, Christoph Hellwig wrote:
> +static int nvme_read_fdp_config(struct nvme_ns *ns, struct nvme_ns_info *info)
> +{
> +	struct nvme_fdp_config result;
> +	struct nvme_fdp_config_log *log;
> +	struct nvme_fdp_config_desc *configs;
> +	size_t log_size;
> +	int error;
> +
> +	error = nvme_get_features(ns->ctrl, NVME_FEAT_FDP, info->endgid, NULL,
> +			0, &result);
> +	if (error)
> +		return error;
> +
> +	if (!(result.flags & FDPCFG_FDPE)) {
> +		dev_warn(ns->ctrl->device, "FDP not enable in current config\n");
> +		return -EINVAL;
> +	}
> +
> +	log_size = sizeof(*log) + (result.fdpcidx + 1) * sizeof(*configs);
> +	log = kmalloc(log_size, GFP_KERNEL);
> +	if (!log)
> +		return -ENOMEM;
> +
> +	error = nvme_get_log_lsi(ns->ctrl, info->nsid, NVME_LOG_FDP_CONFIGS,
> +			0, 0, log, log_size, 0, info->endgid);
> +	if (error) {
> +		dev_warn(ns->ctrl->device,
> +			"failed to read FDP config log: 0x%x\n", error);
> +		goto out_free_log;
> +	}
> +
> +	if (le32_to_cpu(log->size) < log_size) {
> +		dev_warn(ns->ctrl->device, "FDP log too small: %d vs %zd\n",
> +				le32_to_cpu(log->size), log_size);
> +		error = -EINVAL;
> +		goto out_free_log;
> +	}
> +
> +	configs = (struct nvme_fdp_config_desc *)(log + 1);
> +	if (le32_to_cpu(configs[result.fdpcidx].nrg) > 1) {
> +		dev_warn(ns->ctrl->device, "FDP NRG > 1 not supported\n");

Why not support multiple reclaim groups?

> +		return -EINVAL;
> +	}

> +	ns->head->runs = le64_to_cpu(configs[result.fdpcidx].runs);

The config descriptors are variable length, so you can't just index into
it. You have to read each index individually to get the next index's offset.
Something like:

	struct nvme_fdp_config_desc *configs;
	void *l;
	int i;

	...

	l = log + 1;
	for (i = 0; i < result.fdpcidx; i++) {
		configs = l;
		l += le16_to_cpu(configs->size);
	}
	ns->head->runs = le64_to_cpu(configs->runs);

