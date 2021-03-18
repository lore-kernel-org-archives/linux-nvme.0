Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21600C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:58:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74CB64E98
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74CB64E98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hnd1VnO4RyRtq4l4GJ35mr1Ji5ewhyed3zkBJwIziKA=; b=fczmbpHQUaVmv0VyYh79ytAGO
	cGN7eXSKveV1nuUUI+G/zgz6Sqi6F4PC8jFEuLae2KGzI/SLBnYIhsuZuORJ+ka0RnA0PEgcNQDi+
	6KWAJkRKXR+uvUGSgoBKt59+oomVFBAY+L9sJ1Gf856bHqX9kngt/S/a3fng1reloAM5XzbumNxHl
	0hDly+G9JIdgrey62I/rEKr2QSezlLiFbXnKEWgawftSrM9HZBFxVgtCxTMCGn0pPugMQ1CJA+s+3
	4INFbzmipO1WLmyXhA6N5O+O7DshReb7nnVQu+wkptHF3oEu1deF0LWSiOhtmw4KXv+igkwBX57w+
	ki8wa2ZHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMhvE-004GSj-8u; Thu, 18 Mar 2021 01:58:00 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMhv1-004GQd-Po
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 01:57:54 +0000
Received: by mail-pf1-x429.google.com with SMTP id c204so2390463pfc.4
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/AblZbqG1zvhUU4AtoW11+9MHGqRD3cJF+pFxBcZ/J4=;
 b=q/ov1maYChXBxVyui08P8Y90pRBvikFIfN+RGHIIAhB4VM7OTakFDPmwOQSlWh+ZYp
 qMbrFbo0DXj1M+gJ8+iEAnR7Chywnq6e+FYSF1A743SH4l9z0O/WhzcpI1fdohdiI/u5
 H2S8Xy6j60oh/VAEdxAwt5dd9YK4R9VnvPqtww8KlaiIrJVJPgPscP+FeYEC1FVbjEj+
 dQ5NRXkXem1qQszQVds9QbO40CnTbfS/0HKaTFNQ9NyTytYri12yjER/tSXmxCABGpyK
 F0dnfW4JIRchAF1u8cpui5iXphCbwXZ1ztNPoPyjpsR1S2tA7eB1ZEelyBq2NnDPFlZQ
 AjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/AblZbqG1zvhUU4AtoW11+9MHGqRD3cJF+pFxBcZ/J4=;
 b=L6jxQhYfJ4Gxfyk8UjD4SIA8C+8r3nKJMAeJIKq/jRN01RktQm2L7C/eaiB50d4TmO
 UUHpnUlZ1Fiuj0KCXRWVc+uoDCFNhXEuqEf7LdrdKUkiCjtCr0CH7SqNjWxr61nlwz6K
 pomy2++L5mU4qKm1mJ30eaDzaGq41XjR+QOy2r5wkV5bRZub2tOK4eFdyj1/NqzjEKxa
 y/Z3BdyiOhkBmaUd8RImKbaqATBXqkwfZBu4OYw29QxfB3IP5pwdP3ht1Ih8Tv10l4gb
 eUFh9VnnKmq1ElqiIGhzWiD+K67ERRFCFvAJSyeDccIB3vq2GpMD+PmU80MB4cNS2AuH
 g6ew==
X-Gm-Message-State: AOAM531GP66XTBmyVxuSafWRCxjtMf3k4ZEF5uBviRiU5wKWYoeLQiUy
 OchKaz42mEtpAj7tPgUF/IMHsw==
X-Google-Smtp-Source: ABdhPJxZSYlz4Wxp13k7Kza1gBmiA3e3SuqHF6nx0sejGX3ol1ARi9dTZqDJ7opVJ6EzOwt+314Hjg==
X-Received: by 2002:a05:6a00:a83:b029:1ed:55fc:e22a with SMTP id
 b3-20020a056a000a83b02901ed55fce22amr1728155pfl.45.1616032666076; 
 Wed, 17 Mar 2021 18:57:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id k128sm325953pfd.137.2021.03.17.18.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 18:57:45 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/3] io_uring: add helper for uring_cmd completion
 in submitter-task
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 chaitanya.kulkarni@wdc.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, nj.shetty@samsung.com,
 selvakuma.s1@samsung.com
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140233epcas5p372405e7cb302c61dba5e1094fa796513@epcas5p3.samsung.com>
 <20210316140126.24900-2-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05a91368-1ba8-8583-d2ab-8db70b92df76@kernel.dk>
Date: Wed, 17 Mar 2021 19:57:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316140126.24900-2-joshi.k@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_015752_796162_47929627 
X-CRM114-Status: GOOD (  27.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/16/21 8:01 AM, Kanchan Joshi wrote:
> Completion of a uring_cmd ioctl may involve referencing certain
> ioctl-specific fields, requiring original subitter context.
> Introduce 'uring_cmd_complete_in_task' that driver can use for this
> purpose. The API facilitates task-work infra, while driver gets to
> implement cmd-specific handling in a callback.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  fs/io_uring.c            | 36 ++++++++++++++++++++++++++++++++----
>  include/linux/io_uring.h |  8 ++++++++
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 583f8fd735d8..ca459ea9cb83 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -772,9 +772,12 @@ struct io_kiocb {
>  		/* use only after cleaning per-op data, see io_clean_op() */
>  		struct io_completion	compl;
>  	};
> -
> -	/* opcode allocated if it needs to store data for async defer */
> -	void				*async_data;
> +	union {
> +		/* opcode allocated if it needs to store data for async defer */
> +		void				*async_data;
> +		/* used for uring-cmd, when driver needs to update in task */
> +		void (*driver_cb)(struct io_uring_cmd *cmd);
> +	};

I don't like this at all, it's very possible that we'd need async
data for passthrough commands as well in certain cases. And what it
gets to that point, we'll have no other recourse than to un-unionize
this and pay the cost. It also means we end up with:

> @@ -1716,7 +1719,7 @@ static void io_dismantle_req(struct io_kiocb *req)
>  {
>  	io_clean_op(req);
>  
> -	if (req->async_data)
> +	if (io_op_defs[req->opcode].async_size && req->async_data)
>  		kfree(req->async_data);
>  	if (req->file)
>  		io_put_file(req, req->file, (req->flags & REQ_F_FIXED_FILE));

which are also very fragile.

We already have the task work, just have the driver init and/or call a
helper to get it run from task context with the callback it desires?

If you look at this:

> @@ -2032,6 +2035,31 @@ static void io_req_task_submit(struct callback_head *cb)
>  	__io_req_task_submit(req);
>  }
>  
> +static void uring_cmd_work(struct callback_head *cb)
> +{
> +	struct io_kiocb *req = container_of(cb, struct io_kiocb, task_work);
> +	struct io_uring_cmd *cmd = &req->uring_cmd;
> +
> +	req->driver_cb(cmd);
> +}
> +int uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> +			void (*driver_cb)(struct io_uring_cmd *))
> +{
> +	int ret;
> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> +
> +	req->driver_cb = driver_cb;
> +	req->task_work.func = uring_cmd_work;
> +	ret = io_req_task_work_add(req);
> +	if (unlikely(ret)) {
> +		req->result = -ECANCELED;
> +		percpu_ref_get(&req->ctx->refs);
> +		io_req_task_work_add_fallback(req, io_req_task_cancel);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(uring_cmd_complete_in_task);

Then you're basically jumping through hoops to get that callback.
Why don't you just have:

io_uring_schedule_task(struct io_uring_cmd *cmd, task_work_func_t cb)
{
	struct io_kiocb *req = container_of(cmd, struct io_kiocb, uring_cmd);
	int ret;

	req->task_work.func = cb;
	ret = io_req_task_work_add(req);
	if (unlikely(ret)) {
		req->result = -ECANCELED;
		io_req_task_work_add_fallback(req, io_req_task_cancel);
	}
	return ret;
}

?

Also, please export any symbol with _GPL. I don't want non-GPL drivers
using this infrastructure.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
