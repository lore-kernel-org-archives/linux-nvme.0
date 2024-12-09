Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEEAE7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02BiDEF69CuAK9Zxg8tGc+B0KIUMPQeTfXn/xvYHRUo=; b=ZB09NDeRY712Aeouvw4KJ3rGYk
	nekcHcNRv9doedqgaaTPHbBpg47ZC0gb1B6SWf0qGU6OL2ZfO8rp2v5F5UWE8t7s51mD7jJBLIBbf
	p74UL3U0ffS4Kt2RWtJFUAhL+Pw260veGMqPMXzEnpERu+kGshm5wTPfJx8wTdL08fzpxSDUuVFar
	AfFurm4kF2MD3nrYj79EmFM1HKT2gDOVtE5FsaJwK2vPkY/z76gwk5zUk2EueYdDUXUmEBDPFzbmy
	a+QGTUUddvz9uvfiN913A9DOcMEPlJfKh4GKhtiO2MH4UJ+Ja1mYYp4ryTLtkTDn1/gH+mhBn4PS2
	6VxY+oRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdme-00000007yen-1rzd;
	Mon, 09 Dec 2024 13:26:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdea-00000007w8a-3v7m
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 13:18:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF3DA68D09; Mon,  9 Dec 2024 14:18:19 +0100 (CET)
Date: Mon, 9 Dec 2024 14:18:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <20241209131819.GA16038@lst.de>
References: <20241206221801.790690-1-kbusch@meta.com> <20241206221801.790690-12-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206221801.790690-12-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_051825_115332_E4816E99 
X-CRM114-Status: GOOD (  19.84  )
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

> +static int nvme_check_fdp(struct nvme_ns *ns, struct nvme_ns_info *info,
> +			  u8 fdp_idx)

Maybe nvme_query_fdp_runs or something else that makes it clear this
is trying to find the runs field might make sense to name this a little
bit more descriptively.



> +{
> +	struct nvme_fdp_config_log hdr, *h;
> +	struct nvme_fdp_config_desc *desc;
> +	size_t size = sizeof(hdr);
> +	int i, n, ret;
> +	void *log;
> +
> +	info->runs = 0;
> +	ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,

Overly long line here, and same for the second call below.

> +			   (void *)&hdr, size, 0, info->endgid);

And this cast isn't actually needed.

> +	n = le16_to_cpu(h->numfdpc) + 1;
> +	if (fdp_idx > n)
> +		goto out;
> +
> +	log = h + 1;
> +	do {
> +		desc = log;
> +		log += le16_to_cpu(desc->dsze);
> +	} while (i++ < fdp_idx);

Maybe a for loop makes it easier to avoid the uninitialized variable,
e.g.

	for (i = 0; i < fdp_index; i++) {
		..

> +	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> +		ret = nvme_query_fdp_info(ns, info);
> +		if (ret)
> +			dev_warn(ns->ctrl->device,
> +				"FDP failure status:0x%x\n", ret);
> +		if (ret < 0)
> +			goto out;
> +	}

Looking at the full series with the next patch applied I'm a bit
confused about the handling when rescanning.  AFAIK the code now always
goes into nvme_query_fdp_info when NVME_CTRL_ATTR_FDPS even if
head->plids/head->nr_plids is already set, and that will then simply
override them, even if they were already set.

Also the old freeing of head->plids in nvme_free_ns_head seems gone in
this version.

Last not but least "FDP failure" is probably not a very helpful message
when it could come from about half a dozen different commands sent to
the device.


