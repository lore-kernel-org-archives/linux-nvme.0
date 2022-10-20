Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FEAC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 06:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uwEt8fk765yCadxOA2QUAT3mutQPxT3s1Nt0+aiBzsk=; b=dJCKhXX5EikHYHZqmYjbnQrw+V
	ePS7UasoT5hQF2Binc3AS9CL5IvOoEhMooad5DN4ATTHmXQrZ1XStpNVfPlo9cQEKhvtXTOz+fF2C
	2tZKp9AiGKnvwssEWYrYZPmBKSxCxFdU+sPyRgSLFvC/99WlW81mTVyeLWcQEFFB20q51MxLUcUu6
	K75h7t7idh4lwdjGSBiTjCxfQoiV/Rb57g/dO0mKTy5bu2CLeIhZTBlX6H9jzQp2DKag6C6abMGrc
	7gGcjYyA5r7WGJEvHFGsCErhAkiAIzI77pmch++pxML+IXzlpXXyMqv0OmqDUD6LXMvxgebaDkB28
	f335yERw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olOlx-00AzNQ-9s; Thu, 20 Oct 2022 06:11:17 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olOlu-00AzL9-VQ
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 06:11:16 +0000
Received: by mail-wr1-f42.google.com with SMTP id b4so32562752wrs.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 23:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwEt8fk765yCadxOA2QUAT3mutQPxT3s1Nt0+aiBzsk=;
        b=ocMbrhhbTkFSrEU50U6jKZlozR+HaqRD5nAqBXKnWd3asQitjDJnvGBAq5AZavOe66
         uDLSXOgZUNeuLYha6g8HhVI5ZMltGCQO4c9HZ9ucfICx+Ut9x0uKpMI6SbTg9jHOslXR
         peqA7+qfsvTCplbXNbzAhZ5tjYIIvQ9C61g631IixXVsPpi4uymMwtNZpycgJglHc8uE
         nbwrPN519VHGjQyWpn1mwvlJCsikDowdSKhbvvXKKdhBEu9ZrLu4Oi63jCubokmieEJb
         wqDd6SVOjGiP6OsGFet2UX24P7Sgc1YAmVus7iEPA0gBKdtp09ZqMu8s/1dFz3fJg+za
         ZALg==
X-Gm-Message-State: ACrzQf3pQh6E7TUweeChS7MwiwEkOiG11Tevjs0uJ0SJ32o/lM0sX3ER
	uJr5W3an8nHsiso/sNttXOQ=
X-Google-Smtp-Source: AMsMyM4p3vnlvE9kiAcKZNaixcRib/7SSZ3+QL5Vcm68SlFhrqmMcVepSOKWjBwzQbhsCido5VqoWw==
X-Received: by 2002:adf:fb43:0:b0:22b:64:8414 with SMTP id c3-20020adffb43000000b0022b00648414mr7436837wrs.70.1666246269453;
        Wed, 19 Oct 2022 23:11:09 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c3b0e00b003b4fe03c881sm1800757wms.48.2022.10.19.23.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 23:11:08 -0700 (PDT)
Message-ID: <13088882-2d1b-ca71-8420-84bb47760cff@grimberg.me>
Date: Thu, 20 Oct 2022 09:11:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/2] nvme: use blk_mq_[un]quiesce_tagset
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
 paulmck@kernel.org
References: <20221020035348.10163-1-lengchao@huawei.com>
 <20221020035348.10163-3-lengchao@huawei.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020035348.10163-3-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_231115_041657_031E76F7 
X-CRM114-Status: GOOD (  17.56  )
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



On 10/20/22 06:53, Chao Leng wrote:
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> nvme connect_q should not be quiesced when quiesce tagset, so set the
> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
> 
> Currntely we use NVME_NS_STOPPED to ensure pairing quiescing and
> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> In addition, we never really quiesce a single namespace. It is a better
> choice to move the flag from ns to ctrl.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 57 +++++++++++++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  3 ++-
>   2 files changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c1..c7727d1f228e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> +		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, ctrl->connect_q);
>   	}
>   
>   	ctrl->tagset = set;
> @@ -5013,6 +5014,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> +	mutex_init(&ctrl->queue_state_lock);

Why is this lock needed?

