Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F5AC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gza6J2jaZmWLNj09RMdVw66yl8FVHQjujLyaQCc4YZ4=; b=1gcoe2D4HlRzu7UX5gJ9KYnaqT
	pGyJC1Eog2BhHeusvH3UPsyMjVz4qpdl1+0A2ixVMAYx59PHmFKgf2aD8UvC1r+wQ2YFaOaAqoFon
	bWOlqGVNU3KJFNXlflC96ihhpwjguBHSwZaFkETvsWLGt9uxBk5ZPcIEGEcsacDlVbrg4yDp6Oac8
	Dy80D/TJtIg3tNZhAb2gz2QhCWuA5XZSTPrKmU1Bxkdf0mRfBMmlO9eFed0ouOpwnkKJ5wNhSaixG
	VnT4jEBfYJ0F6xeodceHvgNqnedbbdjOcmrtuYxp/hRKU4chdM4gK7y6Ugx0jLGq0orTjCzB4Xgvq
	9a7HQeYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrJe-00000000VtQ-3Nzf;
	Wed, 19 Jun 2024 09:09:18 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrJZ-00000000VsT-1HWE
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 09:09:16 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaea316481so7705931fa.2
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 02:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788151; x=1719392951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gza6J2jaZmWLNj09RMdVw66yl8FVHQjujLyaQCc4YZ4=;
        b=XkpxxA5q3/9vCmhCmAgkt/beuHMlV9tsFnVBbaDadYNxXB1XYSx89XSUFtRoF2SBpo
         HmJ9q5kowZPBlLVztggAz0iRjMJAMFceXiaOY3MTfMFPwumj2bi55CHjGNDHi13kTWeH
         nOtYf0e7G0nKjd73n3u8SkVwi3Z5w3vktxrSOpyrpRfTGZOgDoPujfxFUhGDA1zTb9uN
         VgWndYHdr3dRR67sFaFWWZ6yccHIN1gh6uW9lW5+pouFCbyVcWuPnyFozg5ZyvBfr0Zl
         bfGGNz3BsyQuV025R58t3oLacz2WHadt3NfNX67/Oeh7eVGnoHmLLrlKD9GCza9j2wGJ
         2Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCV1wur+Fgo9BOdGxXKrYAHEbz/eo9O3cxhLZgc6SbcqcSKcVEd3gKl7fJMGXhgu6z1+WMnyf41ddIwF6L5HyHvja7137dCwT1D5zDJV4l8=
X-Gm-Message-State: AOJu0Yx6Bbhz334bS+LUp2UzkRkI2kbN7n470prQo3xqPL/IlKC4DD1q
	elX96GHcoQkenEIrxb+JAcR/xuWiJUG8OsTAh7FYiXKan74K+1iv
X-Google-Smtp-Source: AGHT+IFs/yVKw+Tezqx4eP51oFbndGSd3kv7nf/zGQVhk8gXf7XoqiLkR4Z+KMeSTY5zlsJ4gJF4UA==
X-Received: by 2002:a2e:3c10:0:b0:2ec:17e6:f9d0 with SMTP id 38308e7fff4ca-2ec3d015449mr10676761fa.5.1718788151166;
        Wed, 19 Jun 2024 02:09:11 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4246b67f0aesm88873305e9.45.2024.06.19.02.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:09:10 -0700 (PDT)
Message-ID: <d12f32f0-ac4a-4bb1-a3e6-a1a606d4f89b@grimberg.me>
Date: Wed, 19 Jun 2024 12:09:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_020913_441979_497BDA60 
X-CRM114-Status: GOOD (  28.02  )
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



On 18/06/2024 3:10, Max Gurtovoy wrote:
> To avoid leakage for QPs assocoated with SRQ, according to IB spec
> (section 10.3.1):
>
> "Note, for QPs that are associated with an SRQ, the Consumer should take
> the QP through the Error State before invoking a Destroy QP or a Modify
> QP to the Reset State. The Consumer may invoke the Destroy QP without
> first performing a Modify QP to the Error State and waiting for the Affiliated
> Asynchronous Last WQE Reached Event. However, if the Consumer
> does not wait for the Affiliated Asynchronous Last WQE Reached Event,
> then WQE and Data Segment leakage may occur. Therefore, it is good
> programming practice to teardown a QP that is associated with an SRQ
> by using the following process:
>   - Put the QP in the Error State;
>   - wait for the Affiliated Asynchronous Last WQE Reached Event;
>   - either:
>     - drain the CQ by invoking the Poll CQ verb and either wait for CQ
>       to be empty or the number of Poll CQ operations has exceeded
>       CQ capacity size; or
>     - post another WR that completes on the same CQ and wait for this
>       WR to return as a WC;
>   - and then invoke a Destroy QP or Reset QP."
>
> Catch the Last WQE Reached Event in the core layer without involving the
> ULP drivers with extra logic during drain and destroy QP flows.
>
> The "Last WQE Reached" event will only be send on the errant QP, for
> signaling that the SRQ flushed all the WQEs that have been dequeued from
> the SRQ for processing by the associated QP.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/infiniband/core/verbs.c | 83 ++++++++++++++++++++++++++++++++-
>   include/rdma/ib_verbs.h         |  2 +
>   2 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 94a7f3b0c71c..9e4df7d40e0c 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1101,6 +1101,16 @@ EXPORT_SYMBOL(ib_destroy_srq_user);
>   
>   /* Queue pairs */
>   
> +static void __ib_qp_event_handler(struct ib_event *event, void *context)
> +{
> +	struct ib_qp *qp = event->element.qp;
> +
> +	if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
> +		complete(&qp->srq_completion);
> +	else if (qp->registered_event_handler)
> +		qp->registered_event_handler(event, qp->qp_context);

There is no reason what-so-ever to withhold the LAST_WQE_REACHED from 
the ulp.
The ULP may be interested in consuming this event.

This should become:

+static void __ib_qp_event_handler(struct ib_event *event, void *context)
+{
+	struct ib_qp *qp = event->element.qp;
+
+	if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
+		complete(&qp->srq_completion);
+	if (qp->registered_event_handler)
+		qp->registered_event_handler(event, qp->qp_context);




> +}
> +
>   static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
>   {
>   	struct ib_qp *qp = context;
> @@ -1221,7 +1231,10 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
>   	qp->qp_type = attr->qp_type;
>   	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
>   	qp->srq = attr->srq;
> -	qp->event_handler = attr->event_handler;
> +	if (qp->srq)
> +		init_completion(&qp->srq_completion);

I think that if you unconditionally complete, you should also 
unconditionally initialize.

