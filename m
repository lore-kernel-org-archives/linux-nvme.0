Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13131C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yR56X11HWS399diDPUhRtu1xkQ9o5pVqGKNwjok/hc=; b=41eu/H0lKkMsX2vcQ5I2h4885X
	bWA0rh4Egl5CJGZWQBFRdTrLOcYUxmhaddoyAaMNFLj95ZPXVmeadwOnlHZnI2cnMBLXdTz2xjIop
	sUJokJGHzEJXERSwdwzWJ81gooT6rD7gFFnV7/dxsL4lRhElvNAEQN0BPl7Hxw6k+dPIerlH+6IFg
	wL6CefQCp8pJ787Obw1151aCA6stqqaM7CZpuUGcwXPNTuVD2PHTNPT1rj85uk0MV7OTef2g7oEwE
	2i7mG1J9j7EDJnzdb+vL0ZQLjvgTljn8wnz7hrn9MsTtN0yvQRAb6FXcjYdW7o7IE4iWPsgpsAIe/
	E2+h4+Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vNA-004vr5-38;
	Tue, 28 Nov 2023 10:31:20 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vN6-004vod-2M
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 10:31:18 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50bc0fc570eso8156e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 02:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701167474; x=1701772274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yR56X11HWS399diDPUhRtu1xkQ9o5pVqGKNwjok/hc=;
        b=JC3IR+4hP4czmB0ZjB1ri96LsQJG9ljpMj1+O07oEDDZ7qBRKfUAKdkx6eRoz61k3M
         kioJ0iKOUruXkrRmrmq7K/stlWT3PPvKOg/t26uIez3uFSG5PN3qSE/YGQmLvzQQMx8I
         BRDZ81EoxKZ8TBnNsN0iT1Qa5+JLTVybNaYJ0Xls+C7npc7tBb6Rp2shJhXq1TUQU1FH
         SHDwTx0QXJdugMjjhj3P5c8VouazE9b1A5DL1Fgav7yqnR7s9wTGVNI7t26CtXOXDGCY
         QNydOF3HUQHb3sEg3AvPS3yzG3Qt4Bl9uzjcE3L6ShKPY9t/Xbam4LMuUsu0mEJoriaa
         sXlw==
X-Gm-Message-State: AOJu0YxnJIFbTq87lnCbRDfLU7+4fBU6RPaB5AVOWUAYyI7tESpv3Lfd
	jXrLFIj3nSXoqmkMsPPvWyo=
X-Google-Smtp-Source: AGHT+IGJ1s8onHo8QUQVT/hXY+aUbiU0A/sw+v2cTa1kT/gekp8iJ+bOtPT+Poy3Q+hMBDLQUO63lw==
X-Received: by 2002:a05:6512:e86:b0:507:9d5c:62e3 with SMTP id bi6-20020a0565120e8600b005079d5c62e3mr9345653lfb.5.1701167474289;
        Tue, 28 Nov 2023 02:31:14 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600c3d0500b00405d9a950a2sm17858127wmb.28.2023.11.28.02.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:31:14 -0800 (PST)
Message-ID: <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
Date: Tue, 28 Nov 2023 12:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-6-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_023116_771945_76EAD615 
X-CRM114-Status: GOOD (  37.21  )
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



On 11/22/23 15:48, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> This commit introduces direct data placement offload to NVME
> TCP. There is a context per queue, which is established after the
> handshake using the sk_add/del NDOs.
> 
> Additionally, a resynchronization routine is used to assist
> hardware recovery from TCP OOO, and continue the offload.
> Resynchronization operates as follows:
> 
> 1. TCP OOO causes the NIC HW to stop the offload
> 
> 2. NIC HW identifies a PDU header at some TCP sequence number,
> and asks NVMe-TCP to confirm it.
> This request is delivered from the NIC driver to NVMe-TCP by first
> finding the socket for the packet that triggered the request, and
> then finding the nvme_tcp_queue that is used by this routine.
> Finally, the request is recorded in the nvme_tcp_queue.
> 
> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
> it with the PDU header TCP sequence, and report the result to the
> NIC driver (resync), which will update the HW, and resume offload
> when all is successful.
> 
> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
> for queue of size N) where the linux nvme driver uses part of the 16
> bit CCID for generation counter. To address that, we use the existing
> quirk in the nvme layer when the HW driver advertises if the device is
> not supports the full 16 bit CCID range.
> 
> Furthermore, we let the offloading driver advertise what is the max hw
> sectors/segments via ulp_ddp_limits.
> 
> A follow-up patch introduces the data-path changes required for this
> offload.
> 
> Socket operations need a netdev reference. This reference is
> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
> a follow-up patch.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 259 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 246 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 89661a9cf850..7ad6a4854fce 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -21,6 +21,10 @@
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
>   
> +#ifdef CONFIG_ULP_DDP
> +#include <net/ulp_ddp.h>
> +#endif
> +
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> @@ -46,6 +50,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +#ifdef CONFIG_ULP_DDP
> +/* NVMeTCP direct data placement and data digest offload will not
> + * happen if this parameter false (default), regardless of what the
> + * underlying netdev capabilities are.
> + */
> +static bool ddp_offload;
> +module_param(ddp_offload, bool, 0644);
> +MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -119,6 +133,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -146,6 +161,18 @@ struct nvme_tcp_queue {
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
>   
> +#ifdef CONFIG_ULP_DDP
> +	/*
> +	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
> +	 * an additional flag in the lower 32 bits) that the HW send to
> +	 * the SW, for the SW to verify.
> +	 * - The 32 high bits store the seq number
> +	 * - The 32 low bits are used as a flag to know if a request
> +	 *   is pending (ULP_DDP_RESYNC_PENDING).
> +	 */
> +	atomic64_t		resync_tcp_seq;
> +#endif
> +
>   	/* send state */
>   	struct nvme_tcp_request *request;
>   
> @@ -188,6 +215,12 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device	*ddp_netdev;
> +	u32			ddp_threshold;
> +#ifdef CONFIG_ULP_DDP
> +	struct ulp_ddp_limits	ddp_limits;
> +#endif
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -291,6 +324,166 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_ULP_DDP
> +
> +static struct net_device *
> +nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	struct net_device *netdev;
> +	bool ok;
> +
> +	if (!ddp_offload)
> +		return NULL;
> +
> +	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
> +	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
> +	if (!netdev) {
> +		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
> +		return NULL;
> +	}
> +
> +	ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
> +				  ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
> +				  ctrl->ctrl.opts->tls);
> +	if (!ok) {

please use a normal name (ret).

Plus, its strange that a query function receives a feature and returns
true/false based on this. The query should return the limits, and the
caller should look at the limits and see if it is appropriately
supported.

The rest looks fine I think.

