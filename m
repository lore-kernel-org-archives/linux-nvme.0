From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 14 Nov 2017 11:14:41 +0200
Subject: [PATCH v3 2/9] IB/isert: use implicit CQ allocation
In-Reply-To: <20171108095742.25365-3-sagi@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <20171108095742.25365-3-sagi@grimberg.me>
Message-ID: <e0428a24-a9b5-75f1-f514-ef6df6c5dd69@mellanox.com>

Hi Sagi,

> @@ -535,13 +410,15 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
>   
>   	isert_set_nego_params(isert_conn, &event->param.conn);
>   
> -	ret = isert_conn_setup_qp(isert_conn, cma_id);
> -	if (ret)
> +	isert_conn->qp = isert_create_qp(isert_conn, cma_id);
> +	if (IS_ERR(isert_conn->qp)) {
> +		ret = PTR_ERR(isert_conn->qp);
>   		goto out_conn_dev;
> +	}
>   
>   	ret = isert_login_post_recv(isert_conn);
>   	if (ret)
> -		goto out_conn_dev;
> +		goto out_conn_qp;

This is a bug fix, right ?

>   
>   	ret = isert_rdma_accept(isert_conn);
>   	if (ret)
> @@ -553,6 +430,8 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
>   
>   	return 0;
>   
> +out_conn_qp:
> +	ib_destroy_qp(isert_conn->qp);

maybe use rdma_destroy_qp(isert_conn->cm_id) as we do in nvme/nvmet_rdma ?


Otherwise, Looks good

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
