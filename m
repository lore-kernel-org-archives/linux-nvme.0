From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Aug 2016 20:24:50 +0300
Subject: [PATCH WIP/RFC v3 3/6] nvme_rdma: keep a ref on the ctrl during
 delete/flush
In-Reply-To: <f3b74c6ef7caba2fdff194be0c90ec7423103893.1472574410.git.swise@opengridcomputing.com>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <f3b74c6ef7caba2fdff194be0c90ec7423103893.1472574410.git.swise@opengridcomputing.com>
Message-ID: <c749145e-618e-ef0c-4249-8f441c55e4b1@grimberg.me>


> -	/* Queue controller deletion */
> +	/*
> +	 * Queue controller deletion. Keep a reference until all
> +	 * work is flushed since delete_work will free the ctrl mem
> +	 */
> +	kref_get(&ctrl->ctrl.kref);

kref_get_unless_zero?
