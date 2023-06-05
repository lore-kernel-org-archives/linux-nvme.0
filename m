Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9B7C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PluP4pcqVp71M7UxnRP1BkUQjoEKQCeTxcFCsx0HT2E=; b=fk5bz5HKGv1jH891nPzQ2C86OL
	pTgyxVYlqs4pj3wEkYurpYjHRnPLYPKCLZle/QdEJBahuvmNKcievG5gghtIX0AVSFHXeP36TqSZH
	6xBBbS34vtPODdpnLpE+fQh5mmJOwrFeRd4Z2Yb0sCKx72FNK/f3tVn2OUZ8wj6XX1LXUkU5izygt
	GIN8QDRXxnxhJSZVMtBC3i1UelWViZqa1obLLyht8QsVVgOsDSMFmA2Mzv7BNabnGjmbvjqrgQNd7
	6VAXrwFFaM1pRQr5wg6KfhFkQ9CkMnk0bDyFyUSA6HkzbSYn1rXCPRkWYkQvbqLa+hpgnE4nqKCU6
	nll2D0bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6I48-00GuWH-23;
	Mon, 05 Jun 2023 21:48:40 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6I45-00GuVg-2O
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 21:48:39 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f628cc4a35so300467e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 14:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001714; x=1688593714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PluP4pcqVp71M7UxnRP1BkUQjoEKQCeTxcFCsx0HT2E=;
        b=FmJ1cqTaIDfpNXG1K/++eIRkexdHV+DR4IXTduAlGNjY4Ue6FO+YPm4F27zfBsjZ8w
         960L4ih8nBiRVfjUy01FhirHBm5/YzESF/yXCrh8bx3gP4tXj9EcV/8B0tmHVOWd0hWd
         ulJH0Lm/lixjWIkMH6+rvfjHyUruUyCACG31VsTXwtGzELfGONQYj55GlTqAOcUT6c+H
         uLodyNbHrNDqyNVnzMIGLGlzK2aUwR9JQFXCYcQbA/a9xLfKBpFXCTE5hzxDX3/jVzOs
         fF50I5J5pPKA4Z/3NJ1fLik70ZExlo2O77kM1GXUUqv2svsYtXzC2i296I77+ie01nwx
         pG8g==
X-Gm-Message-State: AC+VfDzTumKQreGtgqkE7orKCFKtL+XlbYXd6x15Fjrp9480b/Cx1u9x
	6V9cMJu00C96Y8CoXq2EVCI=
X-Google-Smtp-Source: ACHHUZ6AVk4xND3kKuKtE+dG5nfWFMXNYK5ajgsdr58a8P2KGASY6jmQ+9ebzKBrztHL4H7pBi8uNg==
X-Received: by 2002:ac2:4824:0:b0:4f6:2d40:f910 with SMTP id 4-20020ac24824000000b004f62d40f910mr138673lft.0.1686001714204;
        Mon, 05 Jun 2023 14:48:34 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25ff0000000b004b5979f9ba8sm1237664lfg.210.2023.06.05.14.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:48:33 -0700 (PDT)
Message-ID: <5ac19a92-bfc8-1e1e-a37d-983f19217df7@grimberg.me>
Date: Tue, 6 Jun 2023 00:48:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] nvme: add API of nvme_delete_dead_ctrl
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org
References: <20230530094322.258090-1-ming.lei@redhat.com>
 <20230530094322.258090-2-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230530094322.258090-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_144837_779166_2A12E3E3 
X-CRM114-Status: GOOD (  27.80  )
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


> When driver confirms that the controller is dead, this controller should
> be deleted with marking as DEAD. Otherwise, upper layer may wait forever
> in __bio_queue_enter() since the disk won't be marked as DEAD.
> Especially, in del_gendisk(), disk won't be marked as DEAD unless bdev
> sync & invalidate returns. If any writeback IO waits in
> __bio_queue_enter(), IO deadlock is caused.
> 
> Add nvme_delete_dead_ctrl() for avoiding such kind of io deadlock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ccb6eb1282f8..413213cfa417 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -227,16 +227,38 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
>   	nvme_do_delete_ctrl(ctrl);
>   }
>   
> -int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
> +static int __nvme_delete_ctrl(struct nvme_ctrl *ctrl,
> +			      enum nvme_ctrl_state state)
>   {
> +	if (state != NVME_CTRL_DELETING && state != NVME_CTRL_DEAD)
> +		return -EINVAL;
> +
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
>   		return -EBUSY;
> +	if (state == NVME_CTRL_DEAD) {
> +		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD))
> +			return -EBUSY;
> +	}
>   	if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
>   		return -EBUSY;
>   	return 0;
>   }

the user can trigger a delete in exactly the same condition as
the transport (say a nanosecond before the transport exhaust
the max_reconnects).

I think that we'd want something like
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 841f155fe0b3..6c718ad46e06 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -231,6 +231,11 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
  {
         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
                 return -EBUSY;
+
+       if (ctrl->ops->transport_disconnected &&
+           ctrl->ops->transport_disconnected(ctrl))
+               nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD);
+
         if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
                 return -EBUSY;
         return 0;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 054bf2f8b1a1..657d3f79953d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,6 +2828,13 @@ static bool nvme_pci_supports_pci_p2pdma(struct 
nvme_ctrl *ctrl)
         return dma_pci_p2pdma_supported(dev->dev);
  }

+static bool nvme_pci_disconnected(struct nvme_ctrl *nctrl)
+{
+       struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+       return !pci_device_is_present(to_pci_dev(dev->dev));
+}
+
  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
         .name                   = "pcie",
         .module                 = THIS_MODULE,
@@ -2841,6 +2848,7 @@ static const struct nvme_ctrl_ops 
nvme_pci_ctrl_ops = {
         .get_address            = nvme_pci_get_address,
         .print_device_info      = nvme_pci_print_device_info,
         .supports_pci_p2pdma    = nvme_pci_supports_pci_p2pdma,
+       .transport_disconnected = nvme_pci_disconnected,
  };

  static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..2a03df693b0e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2235,6 +2235,18 @@ static void nvme_rdma_reset_ctrl_work(struct 
work_struct *work)
         nvme_rdma_reconnect_or_remove(ctrl);
  }

+static bool nvme_rdma_disconnected(struct nvme_ctrl *nctrl)
+{
+       struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+       int i;
+
+       for (i = 0; i < ctrl->queue_count; i++) {
+               if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags))
+                       return false;
+       }
+       return true;
+}
+
  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
         .name                   = "rdma",
         .module                 = THIS_MODULE,
@@ -2247,6 +2259,7 @@ static const struct nvme_ctrl_ops 
nvme_rdma_ctrl_ops = {
         .delete_ctrl            = nvme_rdma_delete_ctrl,
         .get_address            = nvmf_get_address,
         .stop_ctrl              = nvme_rdma_stop_ctrl,
+       .transport_disconnected = nvme_rdma_disconnected,
  };

  /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fe01ba75570d..043ce9878560 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2536,6 +2536,18 @@ static int nvme_tcp_get_address(struct nvme_ctrl 
*ctrl, char *buf, int size)
         return len;
  }

+static bool nvme_tcp_disconnected(struct nvme_ctrl *nctrl)
+{
+       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+       int i;
+
+       for (i = 0; i < ctrl->queue_count; i++) {
+               if (test_bit(NVME_TCP_Q_LIVE, &ctrl->queues[i].flags))
+                       return false;
+       }
+       return true;
+}
+
  static const struct blk_mq_ops nvme_tcp_mq_ops = {
         .queue_rq       = nvme_tcp_queue_rq,
         .commit_rqs     = nvme_tcp_commit_rqs,
@@ -2569,6 +2581,7 @@ static const struct nvme_ctrl_ops 
nvme_tcp_ctrl_ops = {
         .delete_ctrl            = nvme_tcp_delete_ctrl,
         .get_address            = nvme_tcp_get_address,
         .stop_ctrl              = nvme_tcp_stop_ctrl,
+       .transport_disconnected = nvme_tcp_disconnected,
  };

  static bool
--

