From: bharat@chelsio.com (Potnuri Bharat Teja)
Date: Wed, 24 Jul 2019 11:58:38 +0530
Subject: [PATCH] nvme-tcp: Use protocol specific operations while reading
 socket
In-Reply-To: <20190708095200.15921-1-bharat@chelsio.com>
References: <20190708095200.15921-1-bharat@chelsio.com>
Message-ID: <20190724062836.GA25058@chelsio.com>

On Monday, July 07/08/19, 2019@15:22:00 +0530, Potnuri Bharat Teja wrote:
> Using socket specific read_sock() calls instead of directly calling
> tcp_read_sock() helps lld module registered handlers if any, to be called
> from nvme-tcp host.
> This patch therefore replaces the tcp_read_sock() with socket specific
> prot_ops.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat at chelsio.com>
> Acked-by: Sagi Grimberg <sagi at grimberg.me>
> ---
Hi Sagi/Christoph,
Can this be queued for rc?

Thanks,
Bharat

>  drivers/nvme/host/tcp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 08a2501b9357..6ba667e62b75 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1016,14 +1016,15 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>  
>  static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>  {
> -	struct sock *sk = queue->sock->sk;
> +	struct socket *sock = queue->sock;
> +	struct sock *sk = sock->sk;
>  	read_descriptor_t rd_desc;
>  	int consumed;
>  
>  	rd_desc.arg.data = queue;
>  	rd_desc.count = 1;
>  	lock_sock(sk);
> -	consumed = tcp_read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> +	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>  	release_sock(sk);
>  	return consumed;
>  }
> -- 
> 2.18.0.232.gb7bd9486b055
> 
