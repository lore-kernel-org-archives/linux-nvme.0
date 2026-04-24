Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E49CFF8850
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pr25t7P15J18RfSHbqQcUL+qYfPzWbIeBokx2OEbgE4=; b=yC6xcFxgKX4XJsOnggs22ejHXH
	iJ1VJuUSezhSNCkZNuGb2yTTfhGt/GyCHhKvK26vADIXcsQmxAYI6Bw5UCORZ63wmmE3Fzvk65ilx
	ILlhTy9NufXkLhBLl3v0KfNIyoVNAuWqSv6EN1RzRRcwtb318q6uLFSefTOGZwgnGxduJHKvS4b/n
	3+7lQAEq3mnxJaav6nSKdfUEd69TNRs5cPXpSkkoyDb5EWi7RqggTc8rxNHiAvL8W8FPccBAwgfXy
	INHi08wuolACFQBBIP3gwCNclD2xZOcGSOR/GF4ikdrsblV32XbuuLiV9m/jBm6N+eoNW1Ch3J7rJ
	taYMj2GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGOj2-0000000DnOd-2EvT;
	Fri, 24 Apr 2026 22:10:16 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGOiv-0000000DnO3-2zxZ
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:10:11 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7650202fso6363780f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 15:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068607; x=1777673407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr25t7P15J18RfSHbqQcUL+qYfPzWbIeBokx2OEbgE4=;
        b=k8BliFaiTRNQR3W4Vdhdc5vv7HSrkZ1P8euhoLSLY6YBqd6ZMpcuOSGLzLoWjYy9jL
         SVIgMcmF07ETcqC4EmUJlLkZM2IYAe+ICIXYQB9TXvOcThdsjPA4iTw37lslB5iV+xpv
         6sFh7ajPuAon7UpWzuXAM6NgUvRX2sKIfuP1CRLUsyGtFVzOQfaZLXfSvREexvYO/GC4
         jMq67wN2SaNaQKQ92pLb/coFf4kqppYw4NdW2/JgMlTgbz/LL6QXIuxOLlV1lydU7zNn
         eL+3nlZkXa+SZNRKiJPpAhY3xXA80MuplV6FpEaTMDKOpqL7oJH3UeEF7L05N2OctQFV
         Eu4w==
X-Forwarded-Encrypted: i=1; AFNElJ/5ZB+eWTBA4OryfLXB+7urn4IVwJRu1tGdQvLCoikmmomA1vB2MfZvRDt7peHrIYnLAPVEe93fh8nR@lists.infradead.org
X-Gm-Message-State: AOJu0YyvkqkTN8YirPc6VWRAYDaRqyxpBj9Q4lIb96aTL9NEnuggnO6O
	yqgFp5NZrBPqIC4if4dzqGEeRsezOlZJTFuIXlpJOhyG7o16E8Oi0KzX
X-Gm-Gg: AeBDietV+KuAb39qdx/2r2Ya5XlLvs5tgYFkObi0+LQIJ9RR+0Jl4GELkEICwVdOqjX
	rCw+Sgo4Nn0Etyx4smzK63AkSvd+FTsvB/yxbsVnaxJzavfs18Xf+kBNZf92eWJ+087Wm66fZn9
	NnMfOLlf+bvJRwE1gA087AY88eIunwfS/ENZcbL4KZkSGHvEcgK9RlPgG9vOLDzxV0bl1tSLlNe
	QxHrvuL50ZMOQ9S3zqtViezNVrNXWEGSK9psMjXNjos4t+39C/ua+GwS/K2v/2J5BxTjPXhKkRA
	b/eCwoa6JXT+JDkeEnyFxstg6Ch8Q3i904ru0puX7RYbdzyKd51hpbbSoBYCmKfQO7Vcnfiu9in
	DfRrd61YSInuAovnTWczGHlH8AOKglGvo4yyGSPjLEzcQipHfX9/PCDmzK0k4WxFr2QAzNqiIeQ
	GDTnkU1qS8ABE3ITkwkFvmTCV0kZsQsG3K6BssXSjRx6W4v35uU9xlhcE681WaPdokCTTi
X-Received: by 2002:a05:6000:1acc:b0:43e:a70d:7622 with SMTP id ffacd0b85a97d-43fe3e0c612mr54087408f8f.22.1777068606755;
        Fri, 24 Apr 2026 15:10:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm26771827f8f.21.2026.04.24.15.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:10:05 -0700 (PDT)
Message-ID: <67c5a032-4ba6-4dbb-bc48-072d82c3fbd0@grimberg.me>
Date: Sat, 25 Apr 2026 01:10:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] nvme-tcp: optionally limit I/O queue count based
 on NIC queues
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260420115716.3071293-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_151009_822507_84791F05 
X-CRM114-Status: GOOD (  36.97  )
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



On 20/04/2026 14:49, Nilay Shroff wrote:
> NVMe-TCP currently provisions I/O queues primarily based on CPU
> availability. On systems where the number of CPUs significantly exceeds
> the number of NIC hardware queues, this can lead to multiple I/O queues
> sharing the same NIC TX/RX queues, resulting in increased lock
> contention, cacheline bouncing, and inter-processor interrupts (IPIs).

Yes, I agree it is very inefficient to create something like 192 queues 
in practice.
Nevermind that this is pretty much never the case because real controllers
will limit the number of IO queues to something much lower than that,
in the majority of cases probably a handful or more.

Please note that this is very much in common with RDMA, so the
patch series should probably address both.

>
> In such configurations, limiting the number of NVMe-TCP I/O queues to
> the number of NIC hardware queues can improve performance by reducing
> contention and improving locality. Aligning NVMe-TCP worker threads with
> NIC queue topology may also help reduce tail latency.

As mentioned, from what I know, when using real nvmf arrays, the number of
queues will usually be much lower than both the cpu count as well as the 
NIC hw
queues.

>
> Add a new transport option "match_hw_queues" to allow users to
> optionally limit the number of NVMe-TCP I/O queues to the number of NIC
> TX/RX queues. When enabled, the number of I/O queues is set to:
>
>      min(num_online_cpus, num_nic_queues)
>
> This behavior is opt-in and does not change existing defaults.

In my mind, there is no real reason for an opt-in. The opt-in should
probably be if the user actually wants to use num_online_cpus() worth of 
queues (e.g. user explicitly asked for nr_io_queues).
>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/fabrics.c |   4 ++
>   drivers/nvme/host/fabrics.h |   3 +
>   drivers/nvme/host/tcp.c     | 120 +++++++++++++++++++++++++++++++++++-
>   3 files changed, 126 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ac3d4f400601..62ae998825e1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -709,6 +709,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TLS,			"tls"			},
>   	{ NVMF_OPT_CONCAT,		"concat"		},
>   #endif
> +	{ NVMF_OPT_MATCH_HW_QUEUES,	"match_hw_queues"	},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -1064,6 +1065,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->concat = true;
>   			break;
> +		case NVMF_OPT_MATCH_HW_QUEUES:
> +			opts->match_hw_queues = true;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index caf5503d0833..e8e3a2672832 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -67,6 +67,7 @@ enum {
>   	NVMF_OPT_KEYRING	= 1 << 26,
>   	NVMF_OPT_TLS_KEY	= 1 << 27,
>   	NVMF_OPT_CONCAT		= 1 << 28,
> +	NVMF_OPT_MATCH_HW_QUEUES = 1 << 29,
>   };

No need for the above in my mind.

>   
>   /**
> @@ -106,6 +107,7 @@ enum {
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
>    * @data_digest: generate/verify data digest (TCP)
> + * @match_hw_queues: limit controller IO queue count based on NIC queues (TCP)
>    * @nr_write_queues: number of queues for write I/O
>    * @nr_poll_queues: number of queues for polling I/O
>    * @tos: type of service
> @@ -136,6 +138,7 @@ struct nvmf_ctrl_options {
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
>   	bool			data_digest;
> +	bool			match_hw_queues;
>   	unsigned int		nr_write_queues;
>   	unsigned int		nr_poll_queues;
>   	int			tos;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 243dab830dc8..7102a7a54d78 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -16,6 +16,8 @@
>   #include <net/tls.h>
>   #include <net/tls_prot.h>
>   #include <net/handshake.h>
> +#include <net/ip6_route.h>
> +#include <linux/in6.h>
>   #include <linux/blk-mq.h>
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
> @@ -1762,6 +1764,103 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   	return ret;
>   }
>   
> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl)
> +{
> +	struct net_device *dev = NULL;
> +
> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
> +		dev = dev_get_by_name(&init_net, ctrl->opts->host_iface);
> +	else {
> +		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
> +
> +		if (tctrl->addr.ss_family == AF_INET) {
> +			struct rtable *rt;
> +			struct flowi4 fl4 = {};
> +			struct sockaddr_in *addr =
> +					(struct sockaddr_in *)&tctrl->addr;
> +
> +			fl4.daddr = addr->sin_addr.s_addr;
> +			if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
> +				addr = (struct sockaddr_in *)&tctrl->src_addr;
> +				fl4.saddr = addr->sin_addr.s_addr;
> +			}
> +			fl4.flowi4_proto = IPPROTO_TCP;
> +
> +			rt = ip_route_output_key(&init_net, &fl4);
> +			if (IS_ERR(rt))
> +				return NULL;
> +
> +			dev = dst_dev(&rt->dst);
> +			/*
> +			 * Get reference to netdev as ip_rt_put() will
> +			 * release the netdev reference.
> +			 */
> +			if (dev)
> +				dev_hold(dev);
> +
> +			ip_rt_put(rt);
> +
> +		} else if (tctrl->addr.ss_family == AF_INET6) {
> +			struct dst_entry *dst;
> +			struct flowi6 fl6 = {};
> +			struct sockaddr_in6 *addr6 =
> +					(struct sockaddr_in6 *)&tctrl->addr;
> +
> +			fl6.daddr = addr6->sin6_addr;
> +			if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
> +				addr6 = (struct sockaddr_in6 *)&tctrl->src_addr;
> +				fl6.saddr = addr6->sin6_addr;
> +			}
> +			fl6.flowi6_proto = IPPROTO_TCP;
> +
> +			dst = ip6_route_output(&init_net, NULL, &fl6);
> +			if (dst->error) {
> +				dst_release(dst);
> +				return NULL;
> +			}
> +
> +			dev = dst_dev(dst);
> +			/*
> +			 * Get reference to netdev as dst_release() will
> +			 * release the netdev reference.
> +			 */
> +			if (dev)
> +				dev_hold(dev);
> +
> +			dst_release(dst);
> +		}
> +	}

This looks like a helper that should be outside of nvme-tcp.
Nothing specific to it here. Something like dev_get_by_dstaddr()
> +
> +	return dev;
> +}
> +
> +static void nvme_tcp_put_netdev(struct net_device *dev)
> +{
> +	if (dev)
> +		dev_put(dev);
> +}
> +
> +/*
> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
> + * be determined.
> + */
> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
> +{
> +	struct net_device *dev;
> +	int tx_queues, rx_queues;
> +
> +	dev = nvme_tcp_get_netdev(ctrl);
> +	if (!dev)
> +		return 0;
> +
> +	tx_queues = dev->real_num_tx_queues;
> +	rx_queues = dev->real_num_rx_queues;

I can see various ways how this can get wrong with the variety of 
stacked network
devices. For example for bonding, this can easily diverge with the slave 
devices
queues (in theory at least). Also vlan/vxlan devices will also not 
represent the
real hw queues iirc.

This is a good example of how nvme-tcp is different than the other drivers.
It sits on top of an abstraction layer, which prevents it from "not 
getting it wrong".
It may get it right *some* of the time, but it can also get it wrong...

Maybe an explicit optin is warranted here...
I would not be against having this approach in case an explicit opt-in 
is passed
by the user I suppose.

btw such an approach would be much more robust in nvme-rdma which
does not see this set of abstractions.

One thing that I will comment in addition, is that nvme-tcp is likely to
see *multiple* controllers (HA fundamentals for nvmf arrays), so I think 
that
improving performance in this scenario would be much more impactful.

