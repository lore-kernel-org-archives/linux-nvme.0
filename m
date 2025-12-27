Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD67E8FDD5
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hywlgOboQm9TOIab/Cv8U4hmdm6kAgE4l6mgRt+C/WU=; b=tpFSZznptK+6JdUXmEPD79ZJOp
	WO9uqRfkBd/URd3yZG6FQzDAvhQWBCQj6GLBHbG14roid4+End4p5UNO7z0PiBaCiyjB74ZlQuCiq
	g5hsrXWFUPylofVdB0Z0Lv2M7NkOZm98CKtV/3ZvijqTxkMia80T8R209v7O/Nr4UZZ3w+kSVDCqK
	bjSqXc95nvit2lMd5hhIvmpw/APxc2BsqBkYB7qm6GuntHu5+6sQDWusoGJmcWb58Rhtv+IAGUfYw
	VtrY1MbHt/s8nSJ8zRmqsG/2bb/EPDOvMj2OTWvuZPiVrbF09J3oJ/XPS5nXkfFVcsI0IbiImAZim
	VwyridKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRdz-00000001rbx-0yhN;
	Sat, 27 Dec 2025 10:35:31 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRdv-00000001rba-3cln
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 10:35:29 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso33793595e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 02:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766831726; x=1767436526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hywlgOboQm9TOIab/Cv8U4hmdm6kAgE4l6mgRt+C/WU=;
        b=o49KGHaELnX9y78fYkqyvZxR73h/94s4YSHKiFgWEja5OY/hxYOB6gF9OOoNuFL7zM
         242K8AokNjewAtRb9oCTkLFkoulfK22vSx4aeMb83J8Gq9aujZiTym427rKG4j0dOZ1M
         Kg76pSVOp3EZnTo7LwJTQiLr3FnPUC3WP7fEL2w+ym9Y8Y9lODYoPuJgH8uHuBFowVFC
         uGEdeaDLyCGwknsxh3WMGP0lX/OhTB5LCxUiLe3OHIA5B84Wu510TKe3FvZGAOZbxe5W
         gpmpnnFE8qzC2Wm242HlW9w+pE88jGsEXx9fIS/3PKHpVuSyzRP4OqNy8mjFzuUkdNx8
         IrRw==
X-Forwarded-Encrypted: i=1; AJvYcCVpCvwysP7eWpx15jFsWjaFaI0Ru7NoyISt9Sa8PLBjpqV2Qy6k28SaXYzAjKPlboxadBNcixuY+xqH@lists.infradead.org
X-Gm-Message-State: AOJu0YwRJ8CKMVzoe503QuzlAadMajslT4G29eT5bwHjpsCbTxeVo8ZB
	jsVImR7bPvld3VJJKAFJrtvM+E7OUftDXHXLy6fPBc/9JB9thIEJ4GIE
X-Gm-Gg: AY/fxX53esK6PgATx3Gh6KmKoFXNW2R5KtAm5Cvv18iDoXeabzPvPusYSAX6qwqjXj5
	BC/d/Kxbf3800ebTp41fEBEqFA2N4oYWN25u4YCKSrzLAbk13niIvtOcZUUQbc/WL3y/I79YYpp
	JxaOpC/Dujv5uz/yYupfo8vxcZo3/ON9dLKSPuBkir9jai+8zQsUbFgX1IfAS2Yq1NcbUMv/O1e
	t1mshaC+IHRKDX3HYi7n/R438/SKFRFhhRBvzJXSRQ8TP0Sd2YKkKxEK/n4fkOjSH87c8ToFvbJ
	k0J99pucND9jhD3sGrMbzK33jyYds2BsgYif0eMUwYz2Q0aXO5vg+FbSGMKWXaHp6wYyNowtAfR
	v8yw0DIFEaf8UMSVGEyoFKrMXg8UWbAshq8o1wgHjj1cy3xr6htMQ2EVSjOmTm2IT7rOoUeFT/8
	rUt8V8NgPsnKYCzm7zBt7ZJi6oWFxmnxZIXe/Og0Ij9M8=
X-Google-Smtp-Source: AGHT+IFOOBCMyjTHC1Y5xtuBUgTXZYA8Qi1S/4NrMgBaqSZRiauZ5oG2XtZGrPYnUapcGCPGnQiIrg==
X-Received: by 2002:a05:600c:8b06:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47d3b011b03mr133023195e9.19.1766831725769;
        Sat, 27 Dec 2025 02:35:25 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm418206505e9.4.2025.12.27.02.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 02:35:25 -0800 (PST)
Message-ID: <5befc95c-b66a-4dd8-bb72-7cc6839c7c4b@grimberg.me>
Date: Sat, 27 Dec 2025 12:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-11-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251126021250.2583630-11-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_023527_929487_09A79279 
X-CRM114-Status: GOOD (  29.08  )
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



On 26/11/2025 4:11, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to RECOVERING
> state instead of RESETTING state. In RECOVERING state ctrl->err_work
> will attempt to use cross-controller recovery to terminate inflight IOs
> on the controller. If CCR succeeds, then switch to RESETTING state and
> continue error recovery as usuall by tearing down controller and attempt
> reconnecting to target. If CCR fails, then the behavior of recovery
> depends on whether CQT is supported or not. If CQT is supported, switch
> to time-based recovery by holding inflight IOs until it is safe for them
> to be retried. If CQT is not supported proceed to retry requests
> immediately, as the code currently does.
>
> To support implementing time-based recovery turn ctrl->err_work into
> delayed work. Update nvme_tcp_timeout() to not complete inflight IOs
> while controller in RECOVERING state.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 52 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9a96df1a511c..ec9a713490a9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -193,7 +193,7 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> -	struct work_struct	err_work;
> +	struct delayed_work	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> @@ -611,11 +611,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   {
> -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RECOVERING) &&
> +	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))

This warrants an explanation. It is not clear at all why we should allow 
two different
transitions to allow error recovery to start...

>   		return;
>   
>   	dev_warn(ctrl->device, "starting error recovery\n");
> -	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
> +	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, 0);
>   }
>   
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> @@ -2470,12 +2471,48 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
> +static int nvme_tcp_recover_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	unsigned long rem;
> +
> +	if (test_and_clear_bit(NVME_CTRL_RECOVERED, &ctrl->flags)) {
> +		dev_info(ctrl->device, "completed time-based recovery\n");
> +		goto done;
> +	}

This is also not clear, why should we get here when NVME_CTRL_RECOVERED 
is set?
> +
> +	rem = nvme_recover_ctrl(ctrl);
> +	if (!rem)
> +		goto done;
> +
> +	if (!ctrl->cqt) {
> +		dev_info(ctrl->device,
> +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> +		goto done;
> +	}
> +
> +	dev_info(ctrl->device,
> +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> +		 jiffies_to_msecs(rem));
> +	set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
> +	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, rem);
> +	return -EAGAIN;

I don't think that reusing the same work to handle two completely 
different things
is the right approach here.

How about splitting to fence_work and err_work? That should eliminate 
some of the
ctrl state inspections and simplify error recovery.

> +
> +done:
> +	nvme_end_ctrl_recovery(ctrl);
> +	return 0;
> +}
> +
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   {
> -	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
>   				struct nvme_tcp_ctrl, err_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
> +	if (nvme_ctrl_state(ctrl) == NVME_CTRL_RECOVERING) {
> +		if (nvme_tcp_recover_ctrl(ctrl))
> +			return;
> +	}
> +

Yea, I think we want to rework the current design.

