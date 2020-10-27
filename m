Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E7C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 13:19:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C531820878
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 13:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VlaucjXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C531820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z7QdoVEaTG+pNZP6YPUxM3Bu5oFXUmJBPSwzplnygMQ=; b=VlaucjXj0x53w3ARn0BU6nFl/
	xz6C1CwO1/rtNjUcTDg8jBzQ43MQ+dUBhgVYIZZOhufxqZAK9QyBfma5xYjNZ3EWzjCHffO92wIN8
	8t3pQ2GIngeAU297lMAsIvLMikjeFD97aHf6nXyodLabvvVSktA/nAsXY9l2FeW/uVR+OB8Y5IMYG
	VbMqHpuhpUIQPN3vH6ovLjZOiONhiFwxCanNytRf0nk5MUHm3xJusLAyCOvwjpe4qb84IuQmwb/Cp
	QxDTSAvMclaiEnhaMq6HY/VrmSetLHGi3wCOE+oaF+GeUbTzqa3iOOCm8nx9fRsiImciElBGafDym
	rV59Tfp6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXOt7-0003pp-FK; Tue, 27 Oct 2020 13:19:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXOt5-0003oh-88
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 13:19:44 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0357020829;
 Tue, 27 Oct 2020 13:19:39 +0000 (UTC)
Date: Tue, 27 Oct 2020 15:19:36 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
Message-ID: <20201027131936.GD1763578@unreal>
References: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_091943_420268_BA1FBBFE 
X-CRM114-Status: GOOD (  25.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 rds-devel@oss.oracle.com, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 27, 2020 at 09:20:36AM -0300, Jason Gunthorpe wrote:
> There are two flows for handling RDMA_CM_EVENT_ROUTE_RESOLVED, either the
> handler triggers a completion and another thread does rdma_connect() or
> the handler directly calls rdma_connect().
>
> In all cases rdma_connect() needs to hold the handler_mutex, but when
> handler's are invoked this is already held by the core code. This causes
> ULPs using the 2nd method to deadlock.
>
> Provide a rdma_connect_locked() and have all ULPs call it from their
> handlers.
>
> Link: https://lore.kernel.org/r/0-v1-75e124dbad74+b05-rdma_connect_locking_jgg@nvidia.com
> Reported-and-tested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Fixes: 2a7cec538169 ("RDMA/cma: Fix locking for the RDMA_CM_CONNECT state")
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c            | 40 +++++++++++++++++++++---
>  drivers/infiniband/ulp/iser/iser_verbs.c |  2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  4 +--
>  drivers/nvme/host/rdma.c                 |  4 +--
>  include/rdma/rdma_cm.h                   | 14 ++-------
>  net/rds/ib_cm.c                          |  5 +--
>  6 files changed, 46 insertions(+), 23 deletions(-)
>
> v2:
>  - Remove extra code from nvme (Chao)
>  - Fix long lines (CH)
>
> I've applied this version to rdma-rc - expecting to get these ULPs unbroken for rc2
> release
>
> Thanks,
> Jason
>
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 7c2ab1f2fbea37..193c8902b9db26 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -405,10 +405,10 @@ static int cma_comp_exch(struct rdma_id_private *id_priv,
>  	/*
>  	 * The FSM uses a funny double locking where state is protected by both
>  	 * the handler_mutex and the spinlock. State is not allowed to change
> -	 * away from a handler_mutex protected value without also holding
> +	 * to/from a handler_mutex protected value without also holding
>  	 * handler_mutex.
>  	 */
> -	if (comp == RDMA_CM_CONNECT)
> +	if (comp == RDMA_CM_CONNECT || exch == RDMA_CM_CONNECT)
>  		lockdep_assert_held(&id_priv->handler_mutex);
>
>  	spin_lock_irqsave(&id_priv->lock, flags);
> @@ -4038,13 +4038,21 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
>  	return ret;
>  }
>
> -int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
> +/**
> + * rdma_connect_locked - Initiate an active connection request.
> + * @id: Connection identifier to connect.
> + * @conn_param: Connection information used for connected QPs.
> + *
> + * Same as rdma_connect() but can only be called from the
> + * RDMA_CM_EVENT_ROUTE_RESOLVED handler callback.
> + */
> +int rdma_connect_locked(struct rdma_cm_id *id,
> +			struct rdma_conn_param *conn_param)
>  {
>  	struct rdma_id_private *id_priv =
>  		container_of(id, struct rdma_id_private, id);
>  	int ret;
>
> -	mutex_lock(&id_priv->handler_mutex);
>  	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT)) {
>  		ret = -EINVAL;
>  		goto err_unlock;

Not a big deal, but his label is not correct anymore.

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
