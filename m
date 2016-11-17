From: keith.busch@intel.com (Keith Busch)
Date: Wed, 16 Nov 2016 19:09:18 -0500
Subject: [PATCH v1 5/7] nvme: Implement SED Security Operations
In-Reply-To: <1479338252-8777-6-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-6-git-send-email-scott.bauer@intel.com>
Message-ID: <20161117000918.GF10050@localhost.localdomain>

On Wed, Nov 16, 2016@04:17:30PM -0700, Scott Bauer wrote:
> +static int nvme_sec_submit(void *data, u8 opcode, u16 SPSP,
> +			   u8 SECP, void *buffer, size_t len,
> +			   sec_cb *cb, void *cb_data)
> +{
> +	struct request_queue *q;
> +	struct request *req;
> +	struct sed_cb_data *sed_data;
> +	struct nvme_ns *ns;
> +	struct nvme_command *cmd;
> +	int ret;
> +
> +	ns = data;
> +
> +	sed_data = kzalloc(sizeof(*sed_data), GFP_NOWAIT);
> +	if (!sed_data)
> +		return -ENOMEM;
> +	sed_data->cb = cb;
> +	sed_data->cb_data = cb_data;
> +	cmd = &sed_data->cmd;
> +
> +	cmd->common.opcode = opcode;
> +	cmd->common.nsid = ns->ns_id;
> +	cmd->common.cdw10[0] = SECP << 24 | SPSP << 8;
> +	cmd->common.cdw10[1] = len;

Need to use the write cpu_to_le* conversions.

> +	q = ns->ctrl->admin_q;
> +
> +	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
> +	if (IS_ERR(req)) {
> +		ret = PTR_ERR(req);
> +		goto err_free;
> +	}
> +
> +	req->timeout = ADMIN_TIMEOUT;
> +	req->special = NULL;
> +
> +	if (buffer && len) {
> +		ret = blk_rq_map_kern(q, req, buffer, len, GFP_NOWAIT);
> +		if (ret) {
> +			blk_mq_free_request(req);
> +			goto err_free;
> +		}
> +	}
> +
> +	req->end_io_data = sed_data;
> +
> +	blk_execute_rq_nowait(q, ns->disk, req, 1, sec_submit_endio);
> +	return 0;
> +
> +err_free:
> +	kfree(sed_data);

Missing 'return ret;', here.

> +}
