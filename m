Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D967C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:20:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD33023120
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD33023120
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Byry8H/s5/BKHH9VfQyjE5kL8c3XalIpjOPmb5cvk2Q=; b=arv/wYESDAduLJN8GDvcF8IfM
	Zp0gjDnRenbPPMehy3fDt3X2n88w6dwGmKd+Ag4X5IG8y3f1sN5Yq5GJp090pRFereVUSch/7MNTQ
	3J/QvEjhYXSlXlGcuqLoSqa2xKbZBFK2T4SPUHMurf72jpFBagnH3wcNJfGkhQOaGeWYA5MhB1KwM
	WxI4KcD4snpTA9yB9t4M60A40J7c+6sgp4SKtk0atqSEc/VbXWnSemkB2wq/LEGaAonOCRypZjOWx
	nk8uKBhIgIE3mfqy9Kq+LLHsYvlrm9RYmlKDWkgBJiYhP/bbJCYObQxBspni4gskW8oXh0fmrYfwL
	7eP987VXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzqMk-0006Xm-Mq; Thu, 14 Jan 2021 00:19:55 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzqMh-0006XL-N3
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 00:19:52 +0000
Received: by mail-wr1-f44.google.com with SMTP id y17so3957515wrr.10
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 16:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QKyQAKUG74ERfhNn7PLJoK1vBWNcwgfr7UQBcd/3CAY=;
 b=SrfxTW8QC/1VDTBPNQhdKV9V6UL4MqW6rS0KBdiNoZQgUHjNcau0HQYlprKlsahJVk
 N1HhBfrZLXoAZyQjI0mHTNv3Nyj7wBcAvLWIPSXOlmTcbjowHpSLJX5HPKqBnLliFIkP
 2rcz8VM+cBA1IoPHOViRakoyO63yFYVR7rXeh2oRYyKi44AXxO+yfTzfB3GCI9e+xByJ
 dy57yZ34LcXiJkYFNNe5uzjxR4lToI7dYYOpmQRqWSmvnJqxXF5s5jJYJ/GvXF9nSEma
 b3f1cpsV2h1djT0eXBQw74AvVbrP7OVViBWW84vRiISvwYJFILsgngX7/PioExm9KhS8
 aalw==
X-Gm-Message-State: AOAM530J9ejXAGuUQK0IOTCyRukhJL+UByA+V4MtDpdttycxh3Mwvj7V
 R/PtXgM6U4kLewCibwd23N8=
X-Google-Smtp-Source: ABdhPJzxrhFpOBtsKJZ4rbU+zKE/yi0qjhtXrcnLSfbOSfEjClVRzjHS0tCL8T5ekeYRPwJlH1HWlQ==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr5053555wrt.46.1610583590598;
 Wed, 13 Jan 2021 16:19:50 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id s3sm4848530wmc.44.2021.01.13.16.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 16:19:50 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
Date: Wed, 13 Jan 2021 16:19:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-5-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_191951_778337_33FAD480 
X-CRM114-Status: GOOD (  23.73  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When a request is queued failed, blk_status_t is directly returned
> to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
> BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
> blk_mq_end_request to complete the request with BLK_STS_IOERR.
> In two scenarios, the request should be retried and may succeed.
> First, if work with nvme multipath, the request may be retried
> successfully in another path, because the error is probably related to
> the path. Second, if work without multipath software, the request may
> be retried successfully after error recovery.
> If the request is complete with BLK_STS_IOERR in blk_mq_dispatch_rq_list.
> The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
> request asynchronously such as in nvme_submit_user_cmd, in extreme
> scenario the request will be repeated freed in tear down.
> If a non-resource error occurs in queue_rq, should directly call
> nvme_complete_rq to complete request and set the state of request to
> MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
> the request.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index df9f6f4549f1..4a89bf44ecdc 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2093,7 +2093,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   unmap_qe:
>   	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
>   			    DMA_TO_DEVICE);
> -	return ret;
> +	return nvme_try_complete_failed_req(rq, ret);

I don't understand this. There are errors that may not be related to
anything that is pathing related (sw bug, memory leak, mapping error,
etc, etc) why should we return this one-shot error?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
