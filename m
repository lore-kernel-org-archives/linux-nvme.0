Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AABC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 19:12:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF3522D6E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 19:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF3522D6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zr284eSZ01nVUM4U35lkxy84igouwLQkhOguHFWxC2U=; b=MZ+H3fB6P8lTHWmRBHoDdbZAq
	L4Rh9YCjQ/8r1h4vR5PQuLi1KVVWTdINawVsBHR62JLjQI+2eDR3U0cyRhAnwhjoNom0WIHf/mQm/
	kcEHqJN2p/aL/ayb4kAKsIeBxnx40v2EfhPZ/dPwxyohdvifVKGSI4dcmZ27c+aBX3U/c2jzZcfyh
	9cEenr9e9pNIPv77KyRFZilVv93P2I5yV+or+w3MHrCiPQ4jbXT37va2ae3+FL7G5b5jlyVb538ZH
	MIS5fOH6oPIrIkJDInmfZ+Ab1rN26H4NmMOMraRrbI6WhUBBoiltAnglwYuZmqPx/EVg5JFwwfkdb
	IHIvmlwkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwrkQ-0006O4-B6; Tue, 05 Jan 2021 19:12:02 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwrkN-0006Ng-Bx
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 19:12:01 +0000
Received: by mail-pg1-x52c.google.com with SMTP id e2so498929pgi.5
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3zIFBPQg8IPmi+klJdFBx9OZP1riJjqye12qq2Ji44Y=;
 b=o5roT/G77K1zjPOlknkmJMyAT0zIEi+6jXa6i9dStajstpKfU8DOGD7bj5JqErdsbs
 FlenuWrPGE5ZhhU+B93EIrlsJkLKY3R8Megj/R/bYmahQ5lq1FqjDjjhMyFIy0BIWSq+
 o14ADyREMc8IXlgQ6QlcR4T70Cus/GT+ywZdeY6woRHQd8A/OduSzDnfq5eQad83VeDf
 5Lk3y4iKhmmyU1Glv5tCkDudNt0Q612z/84v+F+UTYdDXQt79+NMrT3vMOFrmPR70yhg
 dQ0EOTS4w0/I7mhpOu9N5EAwu8bkdxLuwz8y/il07RGABdA7XAiyZpnHqp0ld0eABM+9
 wjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3zIFBPQg8IPmi+klJdFBx9OZP1riJjqye12qq2Ji44Y=;
 b=h3I+rq6cSTIhcemchdWQ9yh54EhghR2ZM6ZPM+w1kUO05i1sRB0ZtfziYwikX9whbZ
 prGwPTo+4cmsUzsXzoJZTJFqkKnDcf0xi5KpwEuamUrZfVfsM2h9LqMKkS7EoEPWGnSn
 08DuXRSlTE+17lR3KTJnwgzHRkH8rIB3UcfuWpigyD8kQIKuY5BIKbCr/uInPP5z26Xg
 nCMUHosj7SKDAY4soQHtLvt39YjMtg67p3lsyI30VePonSlarW8VT9K3UTUPbXEKVTIr
 XGc+e47SWSbQ6Y380uV2QcwSryAfm97n5kJ7SJQkzAI64Ad2fKyMNLWYWbp7JJaYaRVp
 juzg==
X-Gm-Message-State: AOAM533gPtOYZYuOOKWUPAEJOrUSUmSXFk0JndXVbkmt5gP+HXErhnB7
 xPq/ivj7MpBzy1imY276F38=
X-Google-Smtp-Source: ABdhPJwyAsMRMa6qi3/f5aIwb7buln5cWdj+WbjR15vMqBIr8HuFm3Xwussprj4gqDYLbQqmyxsxOg==
X-Received: by 2002:a63:fc42:: with SMTP id r2mr747278pgk.234.1609873916504;
 Tue, 05 Jan 2021 11:11:56 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id a18sm153176pfg.107.2021.01.05.11.11.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Jan 2021 11:11:56 -0800 (PST)
Date: Wed, 6 Jan 2021 04:11:54 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 2/6] nvme-core: introduce complete failed request
Message-ID: <20210105191154.GA4426@localhost.localdomain>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-3-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210105071936.25097-3-lengchao@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_141159_489315_FDD1F0EF 
X-CRM114-Status: GOOD (  21.75  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 21-01-05 15:19:32, Chao Leng wrote:
> When a request is queued failed, if the fail status is not
> BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE,
> the request is need to complete with nvme_complete_rq in queue_rq.
> So introduce nvme_try_complete_failed_req.
> The request is needed to complete with NVME_SC_HOST_PATH_ERROR in
> nvmf_fail_nonready_command and queue_rq.
> So introduce nvme_complete_failed_req.
> For details, see the subsequent patches.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>  drivers/nvme/host/nvme.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bfcedfa4b057..1a0bddb9158f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -649,6 +649,24 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
>  extern const struct attribute_group *nvme_ns_id_attr_groups[];
>  extern const struct block_device_operations nvme_ns_head_ops;
>  
> +static inline void nvme_complete_failed_req(struct request *req)
> +{
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_set_request_complete(req);
> +	nvme_complete_rq(req);
> +}
> +
> +static inline blk_status_t nvme_try_complete_failed_req(struct request *req,
> +							blk_status_t ret)
> +{
> +	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE ||
> +	    ret == BLK_STS_ZONE_RESOURCE)
> +		return ret;

If it has nothing to do with various conditions, can we have this if
to switch just like the other function in the same file does:

	switch (ret) {
	case BLK_STS_RESOURCE:
	case BLK_STS_DEV_RESOURCE:
	case BLK_STS_ZONE_RESOURCE:
		return ret;
	default:
		nvme_complete_failed_req(req);
		return BLK_STS_OK;
	}

> +
> +	nvme_complete_failed_req(req);
> +	return BLK_STS_OK;
> +}
> +

Can we have these two functions along side with nvme_try_complete_req()
by moving declaration of nvme_coplete_rq() a little bit up ?

>  #ifdef CONFIG_NVME_MULTIPATH
>  static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>  {
> -- 
> 2.16.4
> 

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
