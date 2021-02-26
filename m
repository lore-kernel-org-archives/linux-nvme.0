Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9BBC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:07:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070E164EC3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070E164EC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/Ksfw4du/EB/sMLRM+nFPMibmstHEGwul1r9nzBXqiQ=; b=ddG3NHuChb3BSKyoerZAOBPFD
	LpllB3F26hV8Msugd6uqS1RElkvk1OObgwMn3Z+evTRDHGcNusVTILYQNFOQYRvJjNl0rVNF8EJYo
	1PrPRGQcTrf6OAZJNWrTiVLKq/u+PLQM8DdHZazily2I7/DigWJmmGcJNTLhj45u8r2iEw9xya095
	04z3gmY6afWW5ds4JQmg9F8oE0o7TE/s20zs736Rd8eSdqwzPcEyqN7GTs/5qZxDYf+BIbSBGVnT9
	xuHqAp8Rd6RZNXpzHsSy6Rj8jWeljTYuh2GmBD2gZGup//FXCbtc3khAsRhQwEUsd2boANu/0RSoP
	MN0ZnTzYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFRbJ-00017B-QB; Fri, 26 Feb 2021 01:07:25 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFRbG-00016V-NQ
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 01:07:24 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DmrzF1tvdz13wLg;
 Fri, 26 Feb 2021 09:04:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 09:07:17 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 09:07:16 +0800
Subject: Re: [PATCH 6/6] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-7-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <8028fcce-0eb6-f375-070e-4f85451248cd@huawei.com>
Date: Fri, 26 Feb 2021 09:07:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210225105527.75277-7-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_200723_261566_6C1B3629 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good to me.
Maybe it is better to split multiple patches for different transports.


On 2021/2/25 18:55, Hannes Reinecke wrote:
> When a command times out we should be returning -ETIMEDOUT in
> nvme_submit_sync_cmd(), and not requiring the caller to guess whether
> a specific NVMe status should be interpreted as a timeout.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 2 ++
>   drivers/nvme/host/fc.c   | 1 +
>   drivers/nvme/host/nvme.h | 1 +
>   drivers/nvme/host/rdma.c | 1 +
>   drivers/nvme/host/tcp.c  | 1 +
>   5 files changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 624531a6b7c6..5c1ec3bfb9d3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1004,6 +1004,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   		*result = nvme_req(req)->result;
>   	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>   		ret = -EINTR;
> +	else if (nvme_req(req)->flags & NVME_REQ_TIMEOUT)
> +		ret = -ETIMEDOUT;
>   	else
>   		ret = nvme_req(req)->status;
>    out:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 86395b66310d..bcc086fcbe61 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2551,6 +2551,7 @@ nvme_fc_timeout(struct request *rq, bool reserved)
>   		"x%08x/x%08x\n",
>   		ctrl->cnum, op->queue->qnum, sqe->common.opcode,
>   		sqe->connect.fctype, sqe->common.cdw10, sqe->common.cdw11);
> +	op->nreq.flags |= NVME_REQ_TIMEOUT;
>   	if (__nvme_fc_abort_op(ctrl, op))
>   		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 07b34175c6ce..02aa4ba665c0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -173,6 +173,7 @@ struct nvme_request {
>   enum {
>   	NVME_REQ_CANCELLED		= (1 << 0),
>   	NVME_REQ_USERCMD		= (1 << 1),
> +	NVME_REQ_TIMEOUT		= (1 << 2),
>   };
>   
>   static inline struct nvme_request *nvme_req(struct request *req)
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 53ac4d7442ba..99ad2e10b295 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1990,6 +1990,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
>   	nvme_rdma_stop_queue(queue);
>   	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
>   		blk_mq_complete_request(rq);
>   	}
>   }
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 69f59d2c5799..64aab742c84d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2189,6 +2189,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>   	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
>   		blk_mq_complete_request(rq);
>   	}
>   }
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
