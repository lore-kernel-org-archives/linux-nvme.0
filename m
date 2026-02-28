Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9001048925
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sz+nw9RHvnXIemxs0AJJA/Skq4z5y0Q6hDr8HHtUbVk=; b=FSgwMBTcwz7nxvVvLaAmzBo8Wm
	R06zEGNlwUxxCxPcQf+ZdWa09YTOSr0KvisI3yanBWbFArAZpQhO5VV04Ue5mFvQ+9IVfwgPbSVqw
	SvNu0a0+uuiUKaqCFRl9CqIsExzCkNCDhr2iN2X1mohYffu9R7dCwMB9bcUkelgotHNMazA6Dc9MP
	8ia2zcZn/AIbs5nJ89n10RTzirp6z9pAWE/afHvOOhqt2IpunmOKyQMMBFAhHI4CExPQn6aQLQxTw
	v1O/zj2wDlNHm73dUmbbbCGF0qTlQ8O7OcWDKJHCS5bZj7Nx7pEYYgt37CvbrZ9BrvlkiVmIRrof7
	LKPqozQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8kW-00000009Mft-3Ytj;
	Sat, 28 Feb 2026 01:04:04 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8kT-00000009MfM-0cik
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 01:04:04 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-8cb40149037so269740385a.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 17:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772240639; x=1772845439; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sz+nw9RHvnXIemxs0AJJA/Skq4z5y0Q6hDr8HHtUbVk=;
        b=kUjiM/K3M/j/QZwtnypzeDwQ+AG5euXPuMkIyjN8pHLbJVYifjxXlaj1SFWF5HYPME
         I0ENuOxXTMRsOSCHSlSINMjzvtiFvkfjS8XT1lRYttHMSQNKNG3v5POCn/m+nWNPQI2P
         7mYiBvujaKOeoFHKiFzI8QfhVziI2JlZ2QQEh+SULvHFUH2M5PG1If/4VChzjEUTjJmW
         XsBeSb4Bn6CEL437FW6hvXnzLZ3n4c1DSzifQUz0B/wmEo9oB/arD7A05ubtfW+SJf5u
         lRKZ5Of7kFowgvvAQvEQqbFg2pLXyxsJ7qBfWx2X8ALStaMpQkTzgm5Fre+vmlRe8x5Q
         9dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240639; x=1772845439;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sz+nw9RHvnXIemxs0AJJA/Skq4z5y0Q6hDr8HHtUbVk=;
        b=EEmfYioU/ESOi2tSsTZv1etK285JfBByKp8qisg4521IngIejX7JVyDx7v3xfoiGQG
         cj5AmUXsyGCJilp3NSMPSj1FCm0NVMcQ449JamBqSZblq47N6iL1mGJF8LvYmClCAeuL
         abW8QHNN6kLjwwBTr3bGkpD0gpfiW6sCGIkIOKp8loDsKK6Rcux1eRJCPjBRHl6YXnXX
         OSYw13zKPv22w2xuiFY+0AaN/GHDc3/IzUPOZT9JP+Ee/bs65UvMS2aBmKwgiWxqITBn
         a/gQjU8/JEL8Su9GPahuumEjBl0q77aHXXcONhQlSDxUaUyIZbYUMYHqsLOBtNJxgSuW
         jlWw==
X-Forwarded-Encrypted: i=1; AJvYcCW/9ZMAKhrw+YSuX1dnOXgGWLpYT7LS0JfJ35DQGBZpaPmlhhfUqCxGrsHaW/tLLfhza1is12ubHmau@lists.infradead.org
X-Gm-Message-State: AOJu0YxU0QiIMAopoQe0QauNIu/RgKsDmb39n+K0hnSJlWlbb2SpDLN7
	/Xe89ciMFDTo60ZhFjBKYYJB1+7KrQpB6PRkT2Hs2V4tRsSrViJ5fPHo
X-Gm-Gg: ATEYQzzNku70khUVJFTmc1qs6T55iaf4TdlUHolfsJY5yMvjvaZqsHo+tndmx4Tk8c6
	ZuQcqEFD6D3eSAeSB9dcOMn6V8Egobt7bUr1C5lOTx43I/VWJAnxEw2BZnYHZKQMckEHGWE2L1V
	EO5AgQsNYWZO5OPcDz/CLhRcicfPT88C+sy3QojvxOZ//cYjeV2U0dtdVS5gbJYjYONTzivsS/m
	4q6NTasXQI4PvOF294nL//HfKNUiKdKSsSJZkt/YrMCz+5JqOXarGbRIQRZHRaUQ55wmOQN8IEx
	hXyvTLOhvLk3aHF9nk6HOuYXLtw/ilhZwFHzeHlhA/W+eSPbDD01aj42pjzqsKy+y81wEVdV48M
	eAkDSPxSPUjb8+vBbQUxSOzGXh3vrbc/nlUP/X0QtSH4bvWUcyKf2faQrB60XwKaqgew2a9wnt8
	KReSZeQoIcVGI1D0um4dHlPjY8Qp2prUmrJBLQ8IROTbkX
X-Received: by 2002:a05:620a:470b:b0:8cb:4ad6:6aa0 with SMTP id af79cd13be357-8cbc8e12bc5mr604670985a.68.1772240639428;
        Fri, 27 Feb 2026 17:03:59 -0800 (PST)
Received: from [10.69.56.189] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630a0sm53364841cf.6.2026.02.27.17.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 17:03:58 -0800 (PST)
Message-ID: <d6013719-8169-4ad0-bb05-a626a717e8b1@gmail.com>
Date: Fri, 27 Feb 2026 17:03:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Smart <jsmart833426@gmail.com>
Subject: Re: [PATCH v3 13/21] nvme-fc: Use CCR to recover controller that hits
 an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, jsmart833426@gmail.com
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-14-mkhalfella@purestorage.com>
Content-Language: en-US
In-Reply-To: <20260214042753.4073668-14-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_170401_925790_F22A5DD6 
X-CRM114-Status: GOOD (  22.32  )
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

On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e6ffaa19aba4..6ebabfb7e76d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
>   	struct blk_mq_tag_set	admin_tag_set;
>   	struct blk_mq_tag_set	tag_set;
>   
> +	struct work_struct	fencing_work;
>   	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
>   
> @@ -1868,6 +1869,24 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   	}
>   }
>   
> +static void nvme_fc_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *fc_ctrl =
> +			container_of(work, struct nvme_fc_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	rem = nvme_fence_ctrl(ctrl);
> +	if (rem) {
> +		dev_info(ctrl->device,
> +			 "CCR failed, skipping time-based recovery\n");
> +	}
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);

catch the rework of prior patch

> +}
> +
>   static void
>   nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   {
> @@ -1889,6 +1908,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   		return;
>   	}
>   
> +	flush_work(&ctrl->fencing_work);
>   	nvme_fc_error_recovery(ctrl);
>   }
>   
> @@ -1915,6 +1935,14 @@ static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
>   {
>   	enum nvme_ctrl_state state;
>   
 From prior patch - the CONNECTING logic should be here....

> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: starting controller fencing %s\n",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_wq, &ctrl->fencing_work);
> +		return;
> +	}
> +
>   	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
>   		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
>   			 ctrl->cnum, errmsg);
> @@ -3322,6 +3350,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
>   
> +	flush_work(&ctrl->fencing_work);
>   	nvme_stop_ctrl(&ctrl->ctrl);
>   
>   	/* will block will waiting for io to terminate */
> @@ -3497,6 +3526,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> +	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
>   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
>   	spin_lock_init(&ctrl->lock);
>   

there is a little to be in sync with my comment on the prior patch, but 
otherwise what is here is fine.

What bothers me in this process is - there are certainly conditions 
where there is not connectivity loss  where FC can send things such as 
the ABTS or a Disconnect LS that can inform the controller to start 
terminating. Its odd that we skip this step and go directly to the CCR 
reset to terminate the controller.  We should have been able to continue 
to send the things that start to directly tear down the controller which 
can be happening in parallel with the CCR.

-- james


