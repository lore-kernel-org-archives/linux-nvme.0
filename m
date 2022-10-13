Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA85FC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAFpSuhE/g245plQMmYFcjOwS/J2mWdqesS431eNBu0=; b=g7SCVbQ9Mho3rXxug5RK0sR5ws
	gSmlyKWTtDlmVsA2iHl7J55IrvOCPo7oX2O2bg+AFsNhs+CZ6ng5g7/nNw1u3+x6pvyU8PwBoRLhX
	NJesdobKgRTp9zipcCO8U15ciqaOk630eHBaFyyuIaMSRKE7UupxEhDfLd9jP1/m0UZ+FKmXIh0ba
	Gi+yXX6iqvXsLtyPzfZvJ+LccKo33bGhf9keTgWM4nSyOu+rdtYsuAFvB9XLXqyjrDF4KMiSd1yNZ
	/1zvqSKLmtYWuRJNtMi1+zjISMLpMwSsDpDZp2E8N37k7DGxqeRQNSeobum2/Dj/NoYu7I/7hCrox
	RDtpPf+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oivM9-00BPhQ-Cs; Thu, 13 Oct 2022 10:22:25 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oivM6-00BPfa-5D
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 10:22:23 +0000
Received: by mail-wr1-f50.google.com with SMTP id a3so2178321wrt.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Oct 2022 03:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAFpSuhE/g245plQMmYFcjOwS/J2mWdqesS431eNBu0=;
        b=eFarCYB6WxqFzs5QfqTYrwAV8raKymcnVLc+zzQI3UoaRqxEjKMahGAPaPW4hFLLwQ
         BMczn19GLSGVRjGbsv3TDNtGSVjogKd5RTqD1SBaCXL1E3kj7Umx3DqIFlXZgVzjMhNX
         jaE+EErMGpwf0ZoCjnnI87Gipfr9TZiBm+/FEVvavmTiwSHTX7yRnz6+sXHuf8wEmQAG
         X6/0uOZD72wUoiPsZND24dbeYwoGlxwy807txlHFoewI025Ty5X1omBUSEUk5NQHG6Y0
         IvrBqxJ3gtZeK8haKZUiowJ+RKwB4EjAGoL8jrkU4ay4+s3XBC2k89OFSJ+0ydDzx9aJ
         2dpQ==
X-Gm-Message-State: ACrzQf0ZIR3Ngv2jmLpn9vyn5jKrqcGMRVs6hDMe1HppxzXFQ47NyARh
	8UK20ryS9il8Pn9LC6XShTxm+DaVDn0=
X-Google-Smtp-Source: AMsMyM7EfaYNqJToij1GvgOfjzZDuLhFqSCkJv00XeteuZgZh5Q91WNfLJ+64cMWrkoky5RfML6bmQ==
X-Received: by 2002:a5d:5950:0:b0:22d:d0b5:a9b2 with SMTP id e16-20020a5d5950000000b0022dd0b5a9b2mr21165934wri.452.1665656537723;
        Thu, 13 Oct 2022 03:22:17 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm5940326wmp.45.2022.10.13.03.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 03:22:16 -0700 (PDT)
Message-ID: <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
Date: Thu, 13 Oct 2022 13:22:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-3-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221013094450.5947-3-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_032222_232623_7E314557 
X-CRM114-Status: GOOD (  23.61  )
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



On 10/13/22 12:44, Chao Leng wrote:
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> Now use NVME_NS_STOPPED to ensure pairing quiescing and unquiescing.
> If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be invalided,
> so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> 
> nvme connect_q should be never quiesced, so set QUEUE_FLAG_NOQUIESCED
> when init connect_q.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 42 +++++++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c1..0d07a07e02ff 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> +		blk_queue_flag_set(QUEUE_FLAG_NOQUIESCED, ctrl->connect_q);
>   	}
>   
>   	ctrl->tagset = set;
> @@ -5089,20 +5090,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   
> -static void nvme_start_ns_queue(struct nvme_ns *ns)
> -{
> -	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_unquiesce_queue(ns->queue);
> -}
> -
> -static void nvme_stop_ns_queue(struct nvme_ns *ns)
> -{
> -	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_quiesce_queue(ns->queue);
> -	else
> -		blk_mq_wait_quiesce_done(ns->queue);
> -}
> -
>   /*
>    * Prepare a queue for teardown.
>    *
> @@ -5111,13 +5098,14 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>    * holding bd_butex.  This will end buffered writers dirtying pages that can't
>    * be synced.
>    */
> -static void nvme_set_queue_dying(struct nvme_ns *ns)
> +static void nvme_set_queue_dying(struct nvme_ns *ns, bool start_queue)
>   {
>   	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>   		return;
>   
>   	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> +	if (start_queue)
> +		blk_mq_unquiesce_queue(ns->queue);
>   
>   	set_capacity_and_notify(ns->disk, 0);
>   }
> @@ -5132,6 +5120,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>   void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
> +	bool start_queue = false;
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   
> @@ -5139,8 +5128,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
>   
> +	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> +		start_queue = true;

Why can't we just start the queues here? just call nvme_start_queues()?
Why does it need to happen only after we mark the disk dead?
The documentation only says that we need to set the capacity to 0
after we unquiesce, but it doesn't say that we can't unquiesce erliear.

Something like this:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7e840549a940..27dc393eed97 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5127,8 +5127,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
                 return;

         blk_mark_disk_dead(ns->disk);
-       nvme_start_ns_queue(ns);
-
         set_capacity_and_notify(ns->disk, 0);
  }

@@ -5149,6 +5147,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
         if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
                 nvme_start_admin_queue(ctrl);

+       if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
+               nvme_start_queues(ctrl);
+
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 nvme_set_queue_dying(ns);
--

