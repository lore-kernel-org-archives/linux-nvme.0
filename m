Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29777C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzFHQf5iN3DJ4ZkE+Pw7IPRJ0cBTgtu0mOALOS+oIw0=; b=l77ns7Ced9SiXcOQlP7YiPNupU
	RYdrKfTZOzIhOpnn7I2tMbkVsxLrU8BmdFXOI2kRtqJrF0XwozthOL4abrwY7/XI4p70OYRSJu35j
	Jnc+2S3ojn+ToQaqqcknMtRY+EyGdHHfSHZ0trLd5m+rvdliQuA2qkXTPu1N66xCzlQBogwI4K14V
	fHN4RCPDWzdUOpvaMQINPFa9weMaWSLfIAD3F2vC5iapAcUTBjsFKxMWzxwI020gqtWiMCtlxH4or
	0ffRLMWpYctt8BUG+cENAkm/ixj2zkfmjYqZkf/RsoIk8KDseApA/FFV5lt8CfUcTr70JfdznjwJO
	UjnMU1qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpb1-007Tlq-Kn; Wed, 09 Mar 2022 06:14:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpax-007TkT-Tw
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:14:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7174868AFE; Wed,  9 Mar 2022 07:14:42 +0100 (CET)
Date: Wed, 9 Mar 2022 07:14:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220309061442.GA31316@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308151606.2563-1-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_221448_297722_6B14C467 
X-CRM114-Status: GOOD (  34.21  )
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

On Tue, Mar 08, 2022 at 11:16:06PM +0800, Mingbao Sun wrote:
> From: Mingbao Sun <tyler.sun@dell.com>
> 
> congestion-control could have a noticeable impaction on the
> performance of TCP-based communications. This is of course true
> to NVMe_over_TCP.
> 
> Different congestion-controls (e.g., cubic, dctcp) are suitable for
> different scenarios. Proper adoption of congestion control would benefit
> the performance. On the contrary, the performance could be destroyed.
> 
> Though we can specify the congestion-control of NVMe_over_TCP via
> writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
> changes the congestion-control of all the future TCP sockets that
> have not been explicitly assigned the congestion-control, thus bringing
> potential impaction on their performance.
> 
> So it makes sense to make NVMe_over_TCP support specifying the
> congestion-control. And this commit addresses the host side.
> 
> Implementation approach:
> a new option called 'tcp_congestion' was created in fabrics opt_tokens
> for 'nvme connect' command to passed in the congestion-control
> specified by the user.
> Then later in nvme_tcp_alloc_queue, the specified congestion-control
> would be applied to the relevant sockets of the host side.
> 
> Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
> ---
>  drivers/nvme/host/fabrics.c | 12 ++++++++++++
>  drivers/nvme/host/fabrics.h |  2 ++
>  drivers/nvme/host/tcp.c     | 20 +++++++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ee79a6d639b4..79d5f0dbafd3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_TOS,			"tos=%d"		},
>  	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>  	{ NVMF_OPT_DISCOVERY,		"discovery"		},
> +	{ NVMF_OPT_TCP_CONGESTION,	"tcp_congestion=%s"	},
>  	{ NVMF_OPT_ERR,			NULL			}
>  };
>  
> @@ -829,6 +830,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>  		case NVMF_OPT_DISCOVERY:
>  			opts->discovery_nqn = true;
>  			break;
> +		case NVMF_OPT_TCP_CONGESTION:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			kfree(opts->tcp_congestion);
> +			opts->tcp_congestion = p;
> +			break;
>  		default:
>  			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>  				p);
> @@ -947,6 +958,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>  	kfree(opts->subsysnqn);
>  	kfree(opts->host_traddr);
>  	kfree(opts->host_iface);
> +	kfree(opts->tcp_congestion);
>  	kfree(opts);
>  }
>  EXPORT_SYMBOL_GPL(nvmf_free_options);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index c3203ff1c654..25fdc169949d 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -68,6 +68,7 @@ enum {
>  	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
>  	NVMF_OPT_HOST_IFACE	= 1 << 21,
>  	NVMF_OPT_DISCOVERY	= 1 << 22,
> +	NVMF_OPT_TCP_CONGESTION	= 1 << 23,
>  };
>  
>  /**
> @@ -117,6 +118,7 @@ struct nvmf_ctrl_options {
>  	unsigned int		nr_io_queues;
>  	unsigned int		reconnect_delay;
>  	bool			discovery_nqn;
> +	const char		*tcp_congestion;
>  	bool			duplicate_connect;
>  	unsigned int		kato;
>  	struct nvmf_host	*host;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index babbc14a4b76..3415e178a78b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1403,6 +1403,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>  {
>  	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>  	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> +	char ca_name[TCP_CA_NAME_MAX];
> +	sockptr_t optval;
>  	int ret, rcv_pdu_size;
>  
>  	mutex_init(&queue->queue_lock);
> @@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>  	if (nctrl->opts->tos >= 0)
>  		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
>  
> +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> +		strncpy(ca_name, nctrl->opts->tcp_congestion,
> +			TCP_CA_NAME_MAX-1);
> +		optval = KERNEL_SOCKPTR(ca_name);
> +		ret = sock_common_setsockopt(queue->sock, IPPROTO_TCP,
> +					     TCP_CONGESTION, optval,
> +					     strlen(ca_name));

This needs to use kernel_setsockopt.  I also can see absolutely no
need for the optval local variable, and I also don't really see why
we need ca_name either - if we need to limit the length and terminate
it (but why?) that can be done during option parsing.

