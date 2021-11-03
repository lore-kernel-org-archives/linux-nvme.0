Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:15:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB9160EDF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9AB9160EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=muLAWpN3BkjyQFcnpUV/Yv9/ZyepZ6oRJJzNs/laUhU=; b=ZrjwEW4E4v/EB6yJrXsSyNtrrv
	Hgz8K+R3Wr3AOiQtIqwmqgO3+S1p830LdUcBGtMXguocOd7R5phBpYvDBUCIkzUDT16GWXte58xmb
	7o6bEAew9PiNv9LWPM+hvvQlUuGDg2htj8Q3NGv/fk+uvVqm1yb6IpTMEMph/HhIrPHj1MUF2oUlo
	OA7MhudxrJSjnPWfe1pXvsAJOzAxr8OG1cDbejv4JMtfjO4CkwRIT3MJRc5xaHExVcZdQZRP8yqCS
	PeYUpngdBGzRm5M8MvCxZzSOjn9HgVKUyNw2aDAxYo70oVLxsrtXxvO26jKPwlMg1TN+8T2vllpJL
	VvtE/edg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi3wV-003bs3-Sf; Wed, 03 Nov 2021 00:15:51 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi3wS-003brA-SJ
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 00:15:50 +0000
Received: by mail-pg1-x52e.google.com with SMTP id s136so815322pgs.4
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=muLAWpN3BkjyQFcnpUV/Yv9/ZyepZ6oRJJzNs/laUhU=;
 b=aLzLTEu2wU8ri2utyj82ymvTI+ucU1cHQmf70g+lMSMUox85DCrceZr7gJAQgBWmKv
 Sba9EbOQY1JEDQ+auAFDsk3yqxwNPCb14p1fJn01kpWxp0mu+WMclNz5wJRCoF91Hi9O
 r23dtcS7JXqXVNpDdQVLHr4TmrehpXgUkIvU5rdpuu6y1Qkko1pNXG+NlewF+mUMRxTr
 EfeYdZitJduOHCa35L4Zg56acLKnmNuiquYyunIJinx0+Ku6V7gOoHo5Z0F5IYQ7ccps
 qnhavppmJRYY4hmqiVgasQ45urTO5Pf/602Uww3OXO7hDN+9KHUXKtwx/zNgVaRvXJK/
 wjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=muLAWpN3BkjyQFcnpUV/Yv9/ZyepZ6oRJJzNs/laUhU=;
 b=d8I7PbbC516oL+OiNDt+zA19V+ZuxTP0sHX3+191JYqJ5lLtj7pfDXMSRNEGFmf00W
 H6YtpOoqArhrRaK+5BqBzC4P7+RGH4QctqfgksvQN0X6FIgvNE3xIvN5kcZSD+Dm2vCU
 QAeXbNa1uiZv6CozB6nCHoQKT3xjV2kEo3p9nWnvTbtzT8roRDBQfu+f117M733YOa/k
 3MdJnCEO/rtxu6L1mWigh/jLA0mke1ctKsQm46KyH/FxMA7VKAa7xhVYIyHbhGgGQNGx
 1ajx8fTLXvt2BklO0LiCTnUfkwszOGt7Hn5KJe7DH7dG7qPc1XAU0JBRzpDqBsZOQWw0
 7Rsg==
X-Gm-Message-State: AOAM531yAsm2WUVGKTza5LH6cc7M0d/Z0TezQNPF4rPkDy/4v2mLLtr3
 BA9yfKaUNSHOYltwmPp2JdroJetcNoY=
X-Google-Smtp-Source: ABdhPJydyK2EoCkzS9ZJr1+1M8EC/09F8wKvIMCQ6NL22j2BTSI56v8jQh28MxqLKgjv/CgiDq8yWw==
X-Received: by 2002:a05:6a00:170e:b0:480:5cfa:ad88 with SMTP id
 h14-20020a056a00170e00b004805cfaad88mr27389228pfc.2.1635898548191; 
 Tue, 02 Nov 2021 17:15:48 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y25sm289933pfa.70.2021.11.02.17.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 17:15:47 -0700 (PDT)
Message-ID: <1c7414c7-89a0-7db8-49f7-428620603a0d@gmail.com>
Date: Tue, 2 Nov 2021 17:15:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 06/10] nvme/nvme-fabrics: introduce
 nvmf_reconnect_ctrl_work API
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-7-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_171548_959329_84024E5F 
X-CRM114-Status: GOOD (  21.88  )
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
> Reconnect work is duplicated in RDMA and TCP transports. Move this logic
> to common code. For that, introduce a new ctrl op to setup a ctrl.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 24 +++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/nvme.h    |  1 +
>   drivers/nvme/host/rdma.c    | 82 ++++++++++++++-----------------------
>   drivers/nvme/host/tcp.c     | 28 +------------
>   5 files changed, 58 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5a770196eb60..6a2283e09164 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -526,6 +526,30 @@ void nvmf_error_recovery(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_error_recovery);
>   
> +void nvmf_reconnect_ctrl_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
> +			struct nvme_ctrl, connect_work);
> +
> +	++ctrl->nr_reconnects;
> +
> +	if (ctrl->ops->setup_ctrl(ctrl, false))
> +		goto requeue;
> +
> +	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
> +			ctrl->nr_reconnects);
> +
> +	ctrl->nr_reconnects = 0;
> +
> +	return;
> +
> +requeue:
> +	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
> +		 ctrl->nr_reconnects);
> +	nvmf_reconnect_or_remove(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
> +
>   /**
>    * nvmf_register_transport() - NVMe Fabrics Library registration function.
>    * @ops:	Transport ops instance to be registered to the
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 8655eff74ed0..49c98b69647f 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -191,6 +191,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
>   void nvmf_error_recovery(struct nvme_ctrl *ctrl);
>   void nvmf_error_recovery_work(struct work_struct *work);
> +void nvmf_reconnect_ctrl_work(struct work_struct *work);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5cdf2ec45e9a..e137db2760d8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -497,6 +497,7 @@ struct nvme_ctrl_ops {
>   	/* Fabrics only */
>   	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl, bool remove);
>   	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl, bool remove);
> +	int (*setup_ctrl)(struct nvme_ctrl *ctrl, bool new);
>   };
>   
>   /*


Add in a routine to call to check for connectivity and we're pretty 
close to something FC could adapt to.

But I'd really like to get rid of the "new" argument that gets passed 
around. We should be able to have some kind of state on the fabric 
controller that allows us to derive new or not (fc did this - see 
ioq_live).

-- james



