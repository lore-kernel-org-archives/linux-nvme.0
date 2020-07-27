Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFF7C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 18:44:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87F92075A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 18:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0eFMH/Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87F92075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BFQ/NN+HRdsOOHNgpX4tyg+dekcN8Uu5aOu1KeOX7Xo=; b=0eFMH/FdzaTdAo/e0a0QibIye
	GyAEEv7ny/893L3WZIuxpk12Du1ulIdjsMVGxKGwLs90KY7YzK16jMki9LvbKZfK/6YQ/pYIQuHy5
	rBXVfVPpMZmeuADPXBw1n4bXjDI6PszUSsK4lcwPD2NI1lyDBhUwQVtl0qU6CmczEgJMULD8CtAL1
	RTus51+FEKSrCJ85ekLM6B8AfiKLXXUAGYJ0uyvdglphNwKb+sh4zGHGhrD/rRNxw0nE4UN8eSYdb
	bth2CGsLfXZpNOgtUEeSAbw7VLwEBLhEbxbb7BrwcMD/a9UASvBO/LKzr0dOJVXPNP9pGhYIlTGOl
	juMp/bwuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k086v-0001mn-PE; Mon, 27 Jul 2020 18:44:29 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k086t-0001m7-9h
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 18:44:28 +0000
Received: by mail-pj1-f68.google.com with SMTP id a9so10103064pjd.3
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 11:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nRt+5Fhf3T1Q6L2YNwg9k7zsoVADxlOPQYa1Rb8y2Rs=;
 b=sbdbAKFNJAo/yaOuueREK94oWJyH4CvU0fEPBhjowm0OWN556BRUMUhYj+WfRF8LPe
 g89hQjOTSwu78efUEGzJOmmPXOyQYrhoj/I8nsI/nN0ktVyqg0zeBE3N4hmvfS26HazN
 EXXwG8ZLK6ufA9C98JnUOxW/EiaOW8yYrmnDCtk1fEMBjRu7dKnsRIQUAw5SPss/mAi3
 YPxoJLlDIhXQPoE9EeGdObb0/sJ+WE4PqkfZLnIvVQZusfAdqKyrt7idoblULyOsDC5v
 4HjZT5FgxBxNDj5Cwl8ffD6VKDYyDEvmmxZqnrya21Ch4iOKKomO8gx3hCHHC950arbs
 jz8w==
X-Gm-Message-State: AOAM532YfjWNK8khXPiCO9Mj7GaQs0beMb4lFGP5PtV+nfsOQwhPjbeS
 +f+3e3zcH57DcfDhzoelwJQoGhaf
X-Google-Smtp-Source: ABdhPJxorPcbc3RuGTyznEj3yo1XOhxjLlRtNsWOFGrcCVCaaCP3kq6ktgD1RxyH7VkNGMk45gJo0A==
X-Received: by 2002:a17:90a:d482:: with SMTP id
 s2mr624742pju.140.1595875465364; 
 Mon, 27 Jul 2020 11:44:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id t19sm15186619pgg.19.2020.07.27.11.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 11:44:24 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix deadlock when delete ctrl due to reconnect
 fail
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200727080926.30776-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e477f1b3-f351-1aa3-6132-d7e729db11b9@grimberg.me>
Date: Mon, 27 Jul 2020 11:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727080926.30776-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_144427_368021_993A4093 
X-CRM114-Status: GOOD (  22.00  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> A deadlock happens when test link blink for nvme over roce. If time out
> in reconneting process, nvme_rdma_timeout->nvme_rdma_teardown_io_queues
> will quiesce the io queues, and then the ctrl will be deleted after
> reconnect times exceed max_reconnects. If run fdisk from the time
> when the queue is quiesced to the time when the ctrl is deleted,
> delete ctrl will deadlock, the process: nvme_do_delete_ctrl->
> nvme_remove_namespaces->nvme_ns_remove->blk_cleanup_queue->
> blk_freeze_queue->blk_mq_freeze_queue_wait, blk_mq_freeze_queue_wait
> will wait until q_usage_counter of queue become 0, but the queue is
> quiesced, can not clean any request.
> 
> Solution: nvme_rdma_timeout should call nvme_start_queues after
> call nvme_rdma_teardown_io_queues. further more, we need start queues
> regardless of whether the remove flag is set, after cancel requests
> in nvme_rdma_teardown_io_queues.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/rdma.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f8f856dc0c67..b381e2cde50a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -989,8 +989,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>   				nvme_cancel_request, &ctrl->ctrl);
>   			blk_mq_tagset_wait_completed_request(ctrl->ctrl.tagset);
>   		}
> -		if (remove)
> -			nvme_start_queues(&ctrl->ctrl);
> +		nvme_start_queues(&ctrl->ctrl);

This will fail I/O during controller reset, so nak on this.

>   		nvme_rdma_destroy_io_queues(ctrl, remove);
>   	}
>   }
> @@ -1128,7 +1127,6 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   
>   	nvme_stop_keep_alive(&ctrl->ctrl);
>   	nvme_rdma_teardown_io_queues(ctrl, false);
> -	nvme_start_queues(&ctrl->ctrl);
>   	nvme_rdma_teardown_admin_queue(ctrl, false);
>   	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
