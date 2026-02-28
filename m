Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D0F1048926
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m6eRP1oJT7zYaDw0uvn+FXXWlZ3RPzlF7BDTnIzrj7Y=; b=TgWfRgigKTeo7iYFZ9chtFLRLI
	LfT1qVKYN3xbSx+yd+eP6MDjryLJgtidNYG+su7GTFzxnMa580jrBLqUSP6E8s/9cY5z771AHh4nc
	euNnXew3RcwxrbbxNDSUaJGM8jINRMaqxJ1kgsXn1w+cXgdcTwGeyVTy18I9OWdkq3mAuaA35+MSJ
	FSOJXIhMfn7e8tYZvnZ0KT2Q4h02CP/WQF1+E6dnuHOsooxL9c85VRY/MY38GAk4TeUgE6aN3OSLB
	dOcbauKhO+jgsEGvfwXWRO4dsCxFtfqv8+4tDCH6vGgTaW5UMolZNTiUFcWQQHIX7ne5+yvEvm+Cc
	aeUgN4ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw90m-00000009Nvl-0SMF;
	Sat, 28 Feb 2026 01:20:52 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw90j-00000009NvH-36Gw
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 01:20:50 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-506aa68065eso27066181cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 17:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772241648; x=1772846448; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6eRP1oJT7zYaDw0uvn+FXXWlZ3RPzlF7BDTnIzrj7Y=;
        b=ACD/ODiMBTLAG4TxRJ+1RIyx67aqZYHeqWvkkIanKaHxT8CiazR6UonEKJHbpOe6cp
         SlsgziZCW/5ZHGc2zZFyvjz5O+D9p+vIY8sHnh7G3AQwpVXpKcyS16uuDrW8sLkqm3bx
         px2s4AbXWT6WwX6q15OpoxED8lmbSyvTt7CogNvslKg3idUkJ/f0s2pWf5xjnW8bxFNC
         h4gkssFvy5GjK5CZCDQIE0BU2B45KFLEY0hRc9MM7fgVtGFDW1r5Qdlta8OK7+d/YEgz
         amACxuaqWNoiMolQKNpPXhd+fFbCuQdhziZk2+s5VvsH5pVZPVU1dDwIEVGPyCbGyses
         /5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772241648; x=1772846448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6eRP1oJT7zYaDw0uvn+FXXWlZ3RPzlF7BDTnIzrj7Y=;
        b=vuoAWEFm0Qvsa0m514F618pLkCt6fQPI5Mcd3OD+DghPMBzVN+EqZOdUkXM7iSQwkg
         gvayyNnQfG4yta9ZjLc8bH4YP7IB5NhfmSV5b5efhDelxZfPXjtLWabv3fH+n+9WNGd7
         ubVJTyIUtEhJG18YydjHM3vIHU6ap//t8DQErbw1mPp+tPwceON8Yfv2taELqIKiNcKP
         rRFJodoN+usb35QtiwRcHTvHCHEXFQCau3moPpcB7We7b0OR9aEReCJv5T8Fj2IJ4QuL
         KWnA6gR8/9HmgqWnQpwyJlJgDINXetsnRBprDs0aFm0mzn4KrwEUl7nwvgBucn2ZKAZu
         cWjA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQzbpKqwBLucNH6aHX5Oq3G9YUOhujrYsLifTptuTWCaQL3Ik5drxzsiKonDpnu841tUa2a9oXzMN@lists.infradead.org
X-Gm-Message-State: AOJu0YzcPNTEMbfqfX6dGR7TV6G2hDZbYUfTBJQrMepF0XSWwXfulg+9
	u1E3Rb3pxIhgCUcQh21HlXhYFA78Xa/dOYQlUKihS9BMi+03mzjTFf86
X-Gm-Gg: ATEYQzyjt2C2QScivgvx5H++4rE2YKCJqxWol0AWY6nuHQjJtjj4Uc1oKdAgU6+R5ZS
	AL5Ycm5NkDc9K+ZW/+QkyLvk0UcBkd3REK4kTAfKMdwupOFkLx+DOrY7bYQ2rmPUL/5RDYnJqLd
	EIPgQwernG5b+7W7IC1Dlhw8Cbr2mRV6vmfW8O5nzwKFM44sz1JP/J13EIHstH7nnpDxpeh/gJ7
	UJCDisYOzd02Y5JFHv5NKG7bKSaMjmXvMmSJcm3piJWxW4XuRWwc5Rssn8sapBrpWv5/JZoeHHk
	rh6lCXsROpPckVFxYmPkbvcWtC6LjVLDwu3QhLvPunEhjBCWT67U9/BF+i862itgN2bF5WsfVAm
	ARJI/YZ45E+uUBk8GhvG3uYCnU9S/TIdEwwZX4B9nWvop4m8Nz+HtMZlpEBnf31n3g5cgKNtM58
	1GLskf5oKar7RZW93VxiJFn0cDNCqF4wz1fCO/8MpswdJV
X-Received: by 2002:ac8:7f47:0:b0:4f4:ee07:91b9 with SMTP id d75a77b69052e-5075299a340mr57870231cf.47.1772241648332;
        Fri, 27 Feb 2026 17:20:48 -0800 (PST)
Received: from [10.69.56.189] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab2fd9sm54220151cf.19.2026.02.27.17.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 17:20:47 -0800 (PST)
Message-ID: <74b4496a-5ce9-496f-8032-a220c2f69cfd@gmail.com>
Date: Fri, 27 Feb 2026 17:20:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/21] nvme-fc: Extend FENCING state per TP4129 on CCR
 failure
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
 <20260214042753.4073668-22-mkhalfella@purestorage.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <20260214042753.4073668-22-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_172049_800402_29076885 
X-CRM114-Status: GOOD (  19.54  )
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
> If CCR operations fail and CQT is supported, we must defer the retry of
> inflight requests per TP4129. Update ctrl->fencing_work to schedule
> ctrl->fenced_work, effectively extending the FENCING state. This delay
> ensures that inflight requests are held until it is safe for them to be
> retired.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 39 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index eac3a7ccaa5c..81088a4ce298 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
>   	struct blk_mq_tag_set	tag_set;
>   
>   	struct work_struct	fencing_work;
> +	struct delayed_work	fenced_work;
>   	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
>   
> @@ -1878,6 +1879,18 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   	return ret;
>   }
>   
> +static void nvme_fc_fenced_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
> +					struct nvme_fc_ctrl, fenced_work);
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +
> +	dev_info(ctrl->device, "Time-based recovery finished\n");
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);

sync with comments on patch 12

> +}
> +
>   static void nvme_fc_fencing_work(struct work_struct *work)
>   {
>   	struct nvme_fc_ctrl *fc_ctrl =
> @@ -1886,16 +1899,33 @@ static void nvme_fc_fencing_work(struct work_struct *work)
>   	unsigned long rem;
>   
>   	rem = nvme_fence_ctrl(ctrl);
> -	if (rem) {
> +	if (!rem)
> +		goto done;
> +
> +	if (!ctrl->cqt) {
>   		dev_info(ctrl->device,
> -			 "CCR failed, skipping time-based recovery\n");
> +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> +		goto done;
>   	}
>   
> +	dev_info(ctrl->device,
> +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> +		 jiffies_to_msecs(rem));
> +	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
> +	return;
> +
> +done:
>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
>   	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>   		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
>   }
>   
> +static void nvme_fc_flush_fencing_works(struct nvme_fc_ctrl *ctrl)
> +{
> +	flush_work(&ctrl->fencing_work);
> +	flush_delayed_work(&ctrl->fenced_work);
> +}
> +
>   static void
>   nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   {
> @@ -1917,7 +1947,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	flush_work(&ctrl->fencing_work);
> +	nvme_fc_flush_fencing_works(ctrl);
>   	nvme_fc_error_recovery(ctrl);
>   }
>   
> @@ -3396,7 +3426,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
>   
> -	flush_work(&ctrl->fencing_work);
> +	nvme_fc_flush_fencing_works(ctrl);
>   	nvme_stop_ctrl(&ctrl->ctrl);
>   
>   	/* will block will waiting for io to terminate */
> @@ -3573,6 +3603,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
>   	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
> +	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
>   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
>   	spin_lock_init(&ctrl->lock);
>   

looks ok.

Signed-off-by: James Smart <jsmart833426@gmail.com>

-- james


