From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Mon, 8 Aug 2016 16:09:50 +0000
Subject: [PATCH RFC] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <1470452441-4005-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470452441-4005-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1470672588.40000.22.camel@intel.com>

Hi Jay,

On Fri, 2016-08-05@20:00 -0700, Jay Freyensee wrote:
> -	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
> -	queue->send_queue_size = le16_to_cpu(req->hrqsize);
> +	queue->recv_queue_size = le16_to_cpu(req->hsqsize)+1;
> +	queue->send_queue_size = le16_to_cpu(req->hrqsize)+1;

I think the +1 needs to be inside the le16_to_cpu() in both cases.

-- Daniel
