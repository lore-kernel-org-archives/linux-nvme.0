Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C1606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=weFYbdat
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8JTbHrH4N7N3ldLPgUShUY0SdrKh5nZlLSuJwoQovPg=; b=weFYbdatmFN33/MARiEoQ+TMyq
	D2GqnmML1z9+kh9+FR/FzODS52OdTdTIYA1GhtKB4ANK7qN6PTvC+tSZfwqUZsJNv+ORqWWV0gq+O
	3LaMbV6nM5Vp8SMHUwBAEgfw/fVLyE/ZpdxpMDU4SArVwP+m8645LHhJ060j16kXi3freloaulgbw
	U/U9WRmSe5KHLAq/gK88RGb1xlgAqwzPAxzFuDRS8az+e0og8T73Bw0HPPHkLJDfzbKFizEHP2diY
	1Cp0+uKmY62rmglgDl1vOi9waIOZ9rui8DeUzD46ePDwhhgyvrr5jBvfy6p1xJO03YU5v6mMjL/BE
	YceiT9iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7Zw-00000001AnR-1nzI;
	Tue, 03 Nov 2026 06:01:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7Zu-00000001Amw-0gD5
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:01:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9AE868AFE; Tue,  3 Nov 2026 07:00:58 +0100 (CET)
Date: Tue, 3 Nov 2026 07:00:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Josef Bacik <josef@toxicpanda.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 05/19] nvmet: accept I/O queues on the controller's
 port only
Message-ID: <20261103060058.GB1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-6-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_220102_350336_40C77B41 
X-CRM114-Status: GOOD (  26.17  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:52:38AM -0700, Keith Busch wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_ctrl_find_get() looks the subsystem up through the port of the
> request, but then takes the controller from the subsystem list whatever
> port it was created on. A controller belongs to one port and one
> transport: ctrl->ops is that of the admin queue, and both
> ->install_queue() and ->delete_ctrl() assume the queues are their own.
> So an I/O queue arriving on another port of the same subsystem, possibly
> on another transport, is installed into a controller it has no part in,
> nvmet_tcp_install_queue() writes to it as a TCP queue, and an error on
> it deletes that controller. The Connect comes before any authentication.
> 
> Skip controllers of other ports, and compare the transport too since a
> port's transport can be changed while it's disabled.
> 
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index a8171b88035c5..27b27c83ff831 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1512,6 +1512,11 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>  				pr_warn("hostnqn mismatch.\n");
>  				continue;
>  			}
> +			/* All queues of a controller come in by its port. */

This comment is vert confusing.  I'd drop it.

> +			if (ctrl->port != req->port || ctrl->ops != req->ops) {
> +				pr_warn("port mismatch.\n");
> +				continue;
> +			}

And I don't think this warning is very useful (same for the hostnqn one
above that looks like an accidental debug printk).


