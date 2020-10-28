Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432DDC4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:19:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A493B2468F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lH8NzXsM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qNDlP+Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A493B2468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Gl3YsP7ujOFEqPkX1MO1EzeuURwHl+/sT4mktkIhKqg=; b=lH8NzXsM4Y/UoVH9WQwqpuinw
	z8XomCMcNbXixpvlbQywQVCuu3W2OS7WNNVhJcyZBXhfkcqk0X0YyVQlRVguDyXhAmVZUlTOo/yvR
	SMhD/UCEAJqlYyGB9Ja+UrMuL4tKLA9UfL9pkpVfqBiRerSq/8i2sIykaRHQ7wokQ5NSWresYfu2O
	l+gSHMLtgLBwbvhbG5yRCLfqB9pYqevXF7VMPZan4hLwuisz2Njfiw2D+vNCiX35pU62HBTbvXlXz
	7/AVODah7/bqWM7xVfOgbfulGP/RYz00/h+EL3w7J1OwJXBRfRrPC18zIUxjzFvBvMNTqtJ5xy+3q
	62qMLT2yg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXhcD-0000cn-54; Wed, 28 Oct 2020 09:19:33 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXhcA-0000bv-7F
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 09:19:31 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9937a00000>; Wed, 28 Oct 2020 02:19:28 -0700
Received: from [172.27.12.9] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 09:19:17 +0000
Subject: Re: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
To: Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
From: Maor Gottlieb <maorg@nvidia.com>
Message-ID: <4401b7b1-5d05-a715-4701-957fd09f34c9@nvidia.com>
Date: Wed, 28 Oct 2020 11:19:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603876768; bh=XscdbeyWaoB/vfuZasdw22xljV+Xi4ClUgxt2b6ar54=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=qNDlP+RxxHLU6MAoIg+xgjNlamRRemu/d0Vq/hL6byWLAtPdYv72HBcNuecZbguVi
 ReSB5bgBo/6TqRDWk0MWErWlORXb9c0v9ASL+vc/mXlb1w6ySO2rpK40zKbP+iYL3C
 WFpbGmgyX/l21pb/LsAuLy0KwkyPLWvio1k1Onq5eOLAzT/NV1qZx+zM6qGSSqdyrQ
 o8/gzPVNZNVnK95n8OQZaYvX3piqSCK04ccI//tcc/tjr8PfgA8WtDbFJzn6qFSNIw
 WFmBm4lDWkdXZ79SkdWPcY8WwH8vBw11FTkKZNfhX1rGLeYam3q5G55JfsPOQQvV51
 ThPe98voTTolA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_051930_352708_F6027C5D 
X-CRM114-Status: GOOD (  29.38  )
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
 Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>, rds-devel@oss.oracle.com,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/27/2020 2:20 PM, Jason Gunthorpe wrote:
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
>   drivers/infiniband/core/cma.c            | 40 +++++++++++++++++++++---
>   drivers/infiniband/ulp/iser/iser_verbs.c |  2 +-
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  4 +--
>   drivers/nvme/host/rdma.c                 |  4 +--
>   include/rdma/rdma_cm.h                   | 14 ++-------
>   net/rds/ib_cm.c                          |  5 +--
>   6 files changed, 46 insertions(+), 23 deletions(-)
>
> v2:
>   - Remove extra code from nvme (Chao)
>   - Fix long lines (CH)
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
>   	/*
>   	 * The FSM uses a funny double locking where state is protected by both
>   	 * the handler_mutex and the spinlock. State is not allowed to change
> -	 * away from a handler_mutex protected value without also holding
> +	 * to/from a handler_mutex protected value without also holding
>   	 * handler_mutex.
>   	 */
> -	if (comp == RDMA_CM_CONNECT)
> +	if (comp == RDMA_CM_CONNECT || exch == RDMA_CM_CONNECT)
>   		lockdep_assert_held(&id_priv->handler_mutex);
>   
>   	spin_lock_irqsave(&id_priv->lock, flags);
> @@ -4038,13 +4038,21 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
>   	return ret;
>   }
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
>   {
>   	struct rdma_id_private *id_priv =
>   		container_of(id, struct rdma_id_private, id);
>   	int ret;
>   
> -	mutex_lock(&id_priv->handler_mutex);

You need to delete the mutex_unlock in success path too.
>   	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT)) {
>   		ret = -EINVAL;
>   		goto err_unlock;
> @@ -4071,6 +4079,30 @@ int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
>   err_state:
>   	cma_comp_exch(id_priv, RDMA_CM_CONNECT, RDMA_CM_ROUTE_RESOLVED);
>   err_unlock:
> +	return ret;
> +}
> +EXPORT_SYMBOL(rdma_connect_locked);
> +
> +/**
> + * rdma_connect - Initiate an active connection request.
> + * @id: Connection identifier to connect.
> + * @conn_param: Connection information used for connected QPs.
> + *
> + * Users must have resolved a route for the rdma_cm_id to connect with by having
> + * called rdma_resolve_route before calling this routine.
> + *
> + * This call will either connect to a remote QP or obtain remote QP information
> + * for unconnected rdma_cm_id's.  The actual operation is based on the
> + * rdma_cm_id's port space.
> + */
> +int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
> +{
> +	struct rdma_id_private *id_priv =
> +		container_of(id, struct rdma_id_private, id);
> +	int ret;
> +
> +	mutex_lock(&id_priv->handler_mutex);
> +	ret = rdma_connect_locked(id, conn_param);
>   	mutex_unlock(&id_priv->handler_mutex);
>   	return ret;
>   }
> diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
> index 2f3ebc0a75d924..2bd18b00689341 100644
> --- a/drivers/infiniband/ulp/iser/iser_verbs.c
> +++ b/drivers/infiniband/ulp/iser/iser_verbs.c
> @@ -620,7 +620,7 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
>   	conn_param.private_data	= (void *)&req_hdr;
>   	conn_param.private_data_len = sizeof(struct iser_cm_hdr);
>   
> -	ret = rdma_connect(cma_id, &conn_param);
> +	ret = rdma_connect_locked(cma_id, &conn_param);
>   	if (ret) {
>   		iser_err("failure connecting: %d\n", ret);
>   		goto failure;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 776e89231c52f7..f298adc02acba2 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1674,9 +1674,9 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
>   	uuid_copy(&msg.sess_uuid, &sess->s.uuid);
>   	uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
>   
> -	err = rdma_connect(con->c.cm_id, &param);
> +	err = rdma_connect_locked(con->c.cm_id, &param);
>   	if (err)
> -		rtrs_err(clt, "rdma_connect(): %d\n", err);
> +		rtrs_err(clt, "rdma_connect_locked(): %d\n", err);
>   
>   	return err;
>   }
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index aad829a2b50d0f..8bbc48cc45dc1d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1890,10 +1890,10 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
>   		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
>   	}
>   
> -	ret = rdma_connect(queue->cm_id, &param);
> +	ret = rdma_connect_locked(queue->cm_id, &param);
>   	if (ret) {
>   		dev_err(ctrl->ctrl.device,
> -			"rdma_connect failed (%d).\n", ret);
> +			"rdma_connect_locked failed (%d).\n", ret);
>   		goto out_destroy_queue_ib;
>   	}
>   
> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index c672ae1da26bb5..32a67af18415d6 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -227,19 +227,9 @@ void rdma_destroy_qp(struct rdma_cm_id *id);
>   int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
>   		       int *qp_attr_mask);
>   
> -/**
> - * rdma_connect - Initiate an active connection request.
> - * @id: Connection identifier to connect.
> - * @conn_param: Connection information used for connected QPs.
> - *
> - * Users must have resolved a route for the rdma_cm_id to connect with
> - * by having called rdma_resolve_route before calling this routine.
> - *
> - * This call will either connect to a remote QP or obtain remote QP
> - * information for unconnected rdma_cm_id's.  The actual operation is
> - * based on the rdma_cm_id's port space.
> - */
>   int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
> +int rdma_connect_locked(struct rdma_cm_id *id,
> +			struct rdma_conn_param *conn_param);
>   
>   int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
>   		     struct rdma_ucm_ece *ece);
> diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
> index 06603dd1c8aa38..b36b60668b1da9 100644
> --- a/net/rds/ib_cm.c
> +++ b/net/rds/ib_cm.c
> @@ -956,9 +956,10 @@ int rds_ib_cm_initiate_connect(struct rdma_cm_id *cm_id, bool isv6)
>   	rds_ib_cm_fill_conn_param(conn, &conn_param, &dp,
>   				  conn->c_proposed_version,
>   				  UINT_MAX, UINT_MAX, isv6);
> -	ret = rdma_connect(cm_id, &conn_param);
> +	ret = rdma_connect_locked(cm_id, &conn_param);
>   	if (ret)
> -		rds_ib_conn_error(conn, "rdma_connect failed (%d)\n", ret);
> +		rds_ib_conn_error(conn, "rdma_connect_locked failed (%d)\n",
> +				  ret);
>   
>   out:
>   	/* Beware - returning non-zero tells the rdma_cm to destroy

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
