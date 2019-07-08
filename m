From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Jul 2019 02:57:19 -0700
Subject: [PATCH 3/3] nvme-tcp: replace sendpage calls with sendmsg calls
 for SLAB chunks
In-Reply-To: <cdce4bc7cedc11a80c01e457a4b18933b73017e2.1562234605.git.mskorzhinskiy@solarflare.com>
References: <cover.1562234605.git.mskorzhinskiy@solarflare.com>
 <cdce4bc7cedc11a80c01e457a4b18933b73017e2.1562234605.git.mskorzhinskiy@solarflare.com>
Message-ID: <28d0887b-692e-0b33-7530-673006340431@grimberg.me>


> According to commit a10674bf2406 ("tcp: detecting the misuse of .sendpage
> for Slab objects") and previous discussion[1][2], tcp_sendpage should not
> be used for pages that is managed by SLAB, as SLAB is not taking page
> reference counters into consideration.
> 
> This change prevents sendpage calls for payload sending too, although this
> is true only for admin commands, so actual data transfer performance
> should be untouched.
> 
> [1] https://www.spinics.net/lists/netdev/msg553616.html
> [2] https://www.spinics.net/lists/netdev/msg553285.html

Well, the lifetime here is guaranteed to be the same for the buffers
in question.

Was any issue seen in action?

> @@ -860,7 +878,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   		else
>   			flags |= MSG_MORE;
>   
> -		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
> +		ret = nvme_tcp_sendpage(req, page, offset, len, flags);

Please just do this instead:
--
	/* can't zcopy slab pages */
	if (unlikely(PageSlab(page))
		sock_no_sendpage()
	else
		kernel_sendpage()
--

> +static inline int nvme_tcp_try_send_pdu(struct nvme_tcp_request *req,
> +					int len, int flags)
> +{
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct msghdr msg = { .msg_flags = flags };
> +	struct kvec iov = {
> +			   .iov_base = req->pdu + req->offset,
> +			   .iov_len = len,
> +	};
> +
> +	return kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
> +}
> +
>   static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
> @@ -898,8 +929,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,  flags);
> +	ret = nvme_tcp_try_send_pdu(req, len, flags);

This is unneeded given that pdus are page fragments, NOT slab pages.
