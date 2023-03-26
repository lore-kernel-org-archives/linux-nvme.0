Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2CEC6FD1C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qgkJ2We0qcp9j3CcyyYU8CKDu2OA7+3QPtzRZPu3z4s=; b=EZHauVDmpFbI0j5tsm347wuoRk
	V3Fpm25Oa/gK+MlZeahO1wXIsT4fflOxUiyLCLBW0Kj/zucsjVhfUwNLwKYvNgcsOyIk4GDABjAJL
	Gb83akaE9SKUrGxoUxsrZdxFx43ws+R+R5i2CfpkQap5fxWd5rujt+P/IshRQs5kFbdtoC33B5W8b
	dM9PnThka5zuUuJ/tx9DoSYijLDfJfqwHEMoXVFkjTZuplJizeWdhSwtI50bktGQusc1kpg08i2yo
	oei51YhqtAME/AS6DmCgd/MrlIV6kXor/dGtxuKkjte2j/7rUVhw0l6vD56FhKJ7ZbOkQI5y+LgxB
	c7Yp/MVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgQ0Q-008RJH-1I;
	Sun, 26 Mar 2023 13:01:54 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgQ0M-008RIY-2Q
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 13:01:52 +0000
Received: by mail-ed1-f51.google.com with SMTP id t10so25177988edd.12
        for <linux-nvme@lists.infradead.org>; Sun, 26 Mar 2023 06:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679835709; x=1682427709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgkJ2We0qcp9j3CcyyYU8CKDu2OA7+3QPtzRZPu3z4s=;
        b=xWeVgeSouoSKZ78i+aN2YSmzgq2n5g61ybd9h+6kbr4jgH4WgGEXAhNfMVeat+FYYA
         km2Zz06wgjUGvX8k1MZHgbnCHh5uMeafTXXAS8tgwZtMbvByTe/RUoPIYHHGSHKmcnKk
         OwIC87QoTEgahxBrnWYwPi3g+LGqC5SZvttAX+QTwDSZoLNAvMPhcaCGjlyD25y4GV9S
         l9OyR1Rh26TJE2U+JQXICZL85rQgve+BTsN8xZBslmM2ywcniEWlqkZTWo+xAzp5n+K2
         oaUfnZSC8b9IhHHJ3pIbcFVGvXM1eAjVoUl67O3WEvaWoesexl6zUKAookRJwkChFUfz
         Kuzw==
X-Gm-Message-State: AAQBX9cdAv0p5ceGAsppuqNM8u/9aGH9hLYd9wlK8RZmdp2RqXWy5HGg
	opcIx5w9SPJ+1jG6LIyMSP0=
X-Google-Smtp-Source: AKy350ZJgIoqcJ0eFVlmxWEG1NpqNPfkqKKWnnoXk/aMzm+3X/FwO7GMiZpore4c3APCYqyQLJmR5Q==
X-Received: by 2002:a17:906:1001:b0:93f:e5e4:8c13 with SMTP id 1-20020a170906100100b0093fe5e48c13mr3175368ejm.5.1679835708840;
        Sun, 26 Mar 2023 06:01:48 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906309600b0092f289b6fdbsm12891737ejv.181.2023.03.26.06.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 06:01:48 -0700 (PDT)
Message-ID: <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
Date: Sun, 26 Mar 2023 16:01:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <20230324212803.1837554-2-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230324212803.1837554-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_060150_810339_6BBF6284 
X-CRM114-Status: GOOD (  23.57  )
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



On 3/25/23 00:28, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The first advantage is that unshared and multipath namespaces can use
> the same polling callback.
> 
> The other advantage is that we don't need a bio payload in order to
> poll, allowing commands like 'flush' and 'write zeroes' to be submitted
> on the same high priority queue as read and write commands.
> 
> This can also allow for a future optimization for the driver since we no
> longer need to create special hidden block devices to back nvme-generic
> char dev's with unsupported command sets.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/ioctl.c     | 79 ++++++++++++-----------------------
>   drivers/nvme/host/multipath.c |  2 +-
>   drivers/nvme/host/nvme.h      |  2 -
>   3 files changed, 28 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 723e7d5b778f2..369e8519b87a2 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -503,7 +503,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>   {
>   	struct io_uring_cmd *ioucmd = req->end_io_data;
>   	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> -	void *cookie = READ_ONCE(ioucmd->cookie);
>   
>   	req->bio = pdu->bio;
>   	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> @@ -516,9 +515,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>   	 * For iopoll, complete it directly.
>   	 * Otherwise, move the completion to task work.
>   	 */
> -	if (cookie != NULL && blk_rq_is_poll(req))
> +	if (blk_rq_is_poll(req)) {
> +		WRITE_ONCE(ioucmd->cookie, NULL);
>   		nvme_uring_task_cb(ioucmd);
> -	else
> +	} else
>   		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
>   
>   	return RQ_END_IO_FREE;
> @@ -529,7 +529,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
>   {
>   	struct io_uring_cmd *ioucmd = req->end_io_data;
>   	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> -	void *cookie = READ_ONCE(ioucmd->cookie);
>   
>   	req->bio = pdu->bio;
>   	pdu->req = req;
> @@ -538,9 +537,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
>   	 * For iopoll, complete it directly.
>   	 * Otherwise, move the completion to task work.
>   	 */
> -	if (cookie != NULL && blk_rq_is_poll(req))
> +	if (blk_rq_is_poll(req)) {
> +		WRITE_ONCE(ioucmd->cookie, NULL);
>   		nvme_uring_task_meta_cb(ioucmd);
> -	else
> +	} else
>   		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
>   
>   	return RQ_END_IO_NONE;
> @@ -597,7 +597,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   	if (issue_flags & IO_URING_F_IOPOLL)
>   		rq_flags |= REQ_POLLED;
>   
> -retry:
>   	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
>   	if (IS_ERR(req))
>   		return PTR_ERR(req);
> @@ -611,17 +610,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			return ret;
>   	}
>   
> -	if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
> -		if (unlikely(!req->bio)) {
> -			/* we can't poll this, so alloc regular req instead */
> -			blk_mq_free_request(req);
> -			rq_flags &= ~REQ_POLLED;
> -			goto retry;
> -		} else {
> -			WRITE_ONCE(ioucmd->cookie, req->bio);
> -			req->bio->bi_opf |= REQ_POLLED;
> -		}
> -	}
> +	if (blk_rq_is_poll(req))
> +		WRITE_ONCE(ioucmd->cookie, req);

Why aren't we always setting the cookie to point at the req?

