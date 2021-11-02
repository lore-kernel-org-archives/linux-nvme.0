Return-Path: <SRS0=i2V4=PV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBAC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F9360FC4
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Nov 2021 23:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27F9360FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilzLa8AB6SXsmBEdjhyx6Gc4TJNdvm7RhkQ2Ud29M4E=; b=i1St6Y2Oul/a9iNe8s+GDzjC5B
	z0lnWpYE6xoo3BkYiGfkH4ZpTuIcI2bxb2t7pfYZMXpEVkDnCU+JOtt3BIRrUD3/zIn1pSL3Wha8t
	sCXEl6f8YZmH9uo8Mu1iZu3vyNOqm2nlp2dVktYzFuL4YGNXVgazn0qu1OL88U3M6Ug6vtiNTWFcF
	6P0TsYcpJ0e7Yts4H1/JOmvJ/Xer5bX3EB4AXPLkAGQSnyfYfvebjdQo3pDRqWsQPINF1d90jCK31
	I8BWkAwZyRhorJ+xpCsLn4RaEeYZg3rX7FJPoS+voS/3u95fEoC07PG1UBgisrLF6xIcnZW0zMP2+
	163PQ92Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi3MX-003QQN-3T; Tue, 02 Nov 2021 23:38:41 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi3MT-003QOb-Qd
 for linux-nvme@lists.infradead.org; Tue, 02 Nov 2021 23:38:39 +0000
Received: by mail-pg1-x532.google.com with SMTP id n23so739887pgh.8
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ilzLa8AB6SXsmBEdjhyx6Gc4TJNdvm7RhkQ2Ud29M4E=;
 b=R71vzcHq3l6fa9Rn947qo/KsSqTPdHY7oyQzMZbyJ9WcWX/0z+QBG5z/NupLrag0Ky
 PJzTqzR5hGPxQsSt+zLPpuK+t1o2OI4huwc+EGqmnft5sUGPnpOKDaXcaprLCIL8HUEa
 N8nXsOb5T3R19tviJg4siNdHK0NuYW0viRFMmdCiNf64y07rfvj3z3qM0daUqZhpfcZc
 WhPwZWu0RFMFRa7YkXxsD6Qo4EqqL5uHi3Y41s+SR8a9oVqgxEl2UBdw5sajZ9vxIWE/
 4VLBWQSGVwMfyX9NsQhduz5zn2U6btaa+j4Epf30rtQF91SxkdA8ErXFC8M0Cl4x1TVh
 OZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ilzLa8AB6SXsmBEdjhyx6Gc4TJNdvm7RhkQ2Ud29M4E=;
 b=AufmcKojzbCoup+43bvNOsbL9JSULUPDAU50RLot/GdXFzDclPrbvxNh58heq3wCEy
 ySQ3DK40d79IFd2tfT1p7jr/j2bfeW1lKkP2k2Kjn2kbqQZolswMGfao/SnA0EEydxuZ
 Gv4JSSa5cMA52jM5lP9k8DVHbcOnGym40yTHYrQJhIOB0d15ATbXmrXfmfbL8zZ+VwE6
 g07tfa+u8YZUVluX5/Vn06ZP/rfPYoM6gmnz3z0NXpZPWPCzqSmNswbty561rvW/xmu7
 0Vs9SOcJBRz1WgRg3WGHJ3kA2HzdBZUuiESd420L0YR00Bsdmr5Iev3i4KwwBNs2h9pj
 sjCw==
X-Gm-Message-State: AOAM531auq9a0g3zZE/eOJk5/DlMthz9xY8A6vjqCffujj8lCS9NgSfX
 DQrlgORamxppNmRHhvFt5qW2SqolCQ4=
X-Google-Smtp-Source: ABdhPJwi0MG0omBqaFUtrwKL2PeHYOsXrdA8Pv9zOMTaCnp/NwQIpOV5UkPc2RbIDcjKtxf0xZbWmw==
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id
 c1-20020a056a000ac100b0044c4dc6b897mr40892513pfl.25.1635896314938; 
 Tue, 02 Nov 2021 16:38:34 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id p9sm245745pfn.7.2021.11.02.16.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 16:38:34 -0700 (PDT)
Message-ID: <b4fb943d-3860-62d2-985e-0abd075bed48@gmail.com>
Date: Tue, 2 Nov 2021 16:38:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 02/10] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-3-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_163837_905563_A177D5C4 
X-CRM114-Status: GOOD (  27.53  )
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> This logic is duplicated today for RDMA and TCP controllers. Move it to
> the fabrics driver and export it as a new API.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 21 +++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/rdma.c    | 25 +++----------------------
>   drivers/nvme/host/tcp.c     | 26 +++-----------------------
>   4 files changed, 28 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 668c6bb7a567..4a1ef67c6fb3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -472,6 +472,27 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
>   
> +void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +{
> +	/* If we are resetting/deleting then do nothing */
> +	if (ctrl->state != NVME_CTRL_CONNECTING) {
> +		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
> +			ctrl->state == NVME_CTRL_LIVE);
> +		return;
> +	}
> +
> +	if (nvmf_should_reconnect(ctrl)) {
> +		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
> +			ctrl->opts->reconnect_delay);
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work,
> +				ctrl->opts->reconnect_delay * HZ);
> +	} else {
> +		dev_info(ctrl->device, "Removing controller...\n");
> +		nvme_delete_ctrl(ctrl);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
> +

This won't be sufficient for FC so it can't use it.  I'd have to think 
if there's a way to restructure or wrapper it. But not a great fit.

I do think what FC is doing relative to NVME_SC_DNR should be done in 
rdma/tcp as well.

In other words, this should minimally be:

void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl, int status)
{
         /* If we are resetting/deleting then do nothing */
         if (ctrl->state != NVME_CTRL_CONNECTING) {
                 WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
                         ctrl->state == NVME_CTRL_LIVE);
                 return;
         }

         if (!(status > 0 && status & NVME_SC_DNR) &&
             nvmf_should_reconnect(ctrl)) {
                 dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
                         ctrl->opts->reconnect_delay);
                 queue_delayed_work(nvme_wq, &ctrl->connect_work,
                                 ctrl->opts->reconnect_delay * HZ);
         } else {
                 dev_info(ctrl->device, "Removing controller...\n");
                 nvme_delete_ctrl(ctrl);
         }
}
EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);

then change the callee's to set status to pass the return value from the 
status that caused the reschedule. It'll either be set to a -Exxx value 
or to a NVME status code returned by one of the core routines during the 
controller init. This allows an uncorrectable failure during controller 
init will just fail w/o rescheduling.


...
> @@ -1181,7 +1162,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
>   requeue:
>   	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
>   			ctrl->ctrl.nr_reconnects);
> -	nvme_rdma_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(&ctrl->ctrl);

This would become:

@@ -2,10 +2,12 @@ static void nvme_rdma_reconnect_ctrl_wor
  {
  	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
  			struct nvme_rdma_ctrl, reconnect_work);
+	int ret;

  	++ctrl->ctrl.nr_reconnects;

-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
  		goto requeue;

  	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
@@ -18,5 +20,5 @@ static void nvme_rdma_reconnect_ctrl_wor
  requeue:
  	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
  			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
  }


>   }
>   
>   static void nvme_rdma_error_recovery_work(struct work_struct *work)
> @@ -1202,7 +1183,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	nvme_rdma_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(&ctrl->ctrl);
>   }

@@ -16,5 +16,5 @@ static void nvme_rdma_error_recovery_wor
  		return;
  	}

-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, 0);
  }


>   
>   static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
> @@ -2265,7 +2246,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>   
>   out_fail:
>   	++ctrl->ctrl.nr_reconnects;
> -	nvme_rdma_reconnect_or_remove(ctrl);
> +	nvmf_reconnect_or_remove(&ctrl->ctrl);
>   }

@@ -2,6 +2,7 @@ static void nvme_rdma_reset_ctrl_work(st
  {
  	struct nvme_rdma_ctrl *ctrl =
  		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	int ret;

  	nvme_stop_ctrl(&ctrl->ctrl);
  	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -12,12 +13,13 @@ static void nvme_rdma_reset_ctrl_work(st
  		return;
  	}

-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
  		goto out_fail;

  	return;

  out_fail:
  	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
  }


And similar mods to tcp.

-- james



