Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60008E8FDD6
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LtLBBtJhALKfBZ8r2HTslPHOEI+CfYAyFADAeQFApKA=; b=nk3kIgiePityxWh0yrT5ztGoTE
	V/xpCJsQbGS0+NFGvwNLsLufAVBzWmRcst2QNv0N4hJT0kaFhvavtPfOtAlOBkMoHNveO5orOEHNZ
	Am8mrRbunJ9d0FPTl2b/2PHkVljh7l8RUi7EMU2aJL/31RreR5bbaa1B4+L4NL+BFh3z3wl1icn15
	JJl9eDFFLk4z9kCI92AiBqa4hPjfDTC1mVO4QKKijK38aErrnGk4ZsNXsM7wiqmLRymXd+SirQbPd
	CVxb/hSTH9YHEBXErtlBMgqkwuDFEl6gJ3GoZFmdFhyJPSTz0xZ+CYxbTKBe7yxwT9xvEYz5DR6cO
	vaYs8gpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRkz-00000001rtM-2KEd;
	Sat, 27 Dec 2025 10:42:45 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZRkx-00000001rt0-0ofS
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 10:42:44 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so9066785e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 02:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766832161; x=1767436961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtLBBtJhALKfBZ8r2HTslPHOEI+CfYAyFADAeQFApKA=;
        b=C8+9dyvp/mUMzZLMoIU+YCmYQFK6bA0HknQTGF9OFT1jFNAsMP7RtrvbJbmCgCFXln
         6TngGse5pOcAPN2Cn91i1LncznLB6ON5zqLTbLrqGpiFqxxxF+0gQRdMfS3+AvTxc55M
         ogDAsUkTmfahcuOHdXwtFrfF10jBTr/S7BS9+WedfvXp/3ptXJNSe2/P1Rqqxyp0ZmMU
         fdFy5gJVbcIuyZx/2Cjl8yDxIZMwVeUMn7j+vHvSnbO8S5pW9jhNGxG7J11gvVrFlGho
         cEkDcopswOQ/13o5E0Tv/SbBBGgZuvZPc1LwXlfJ/LZdNrZZfWKZMcZ9VLL7vUYbLDgZ
         +V3A==
X-Gm-Message-State: AOJu0YytSo4koKjkTf6ZIp1JA+wyFJH25iVWikIoYOPT8XUK4M4+48jt
	8vkarx76NL8uCnFsXji44l3DzsNbjVdEdGjQ6cXYviVRzVlpVzmH7xgO
X-Gm-Gg: AY/fxX7rpRCs1ZBO1IIsvwzJPy9DZafmnTg3Oh3TBabWr96D229Iw7xabocUfHkYkly
	/5B32Wp4ziJ1wXTZIhaVETEWNJSsKnVor4mGDVy2nc6hUFntG6bkck6qSQnxZ0LOHbQqhqfPJP1
	yWmGcgutJwI3uLW4JfQfrK1Y33xwsspWBV1/7V7oHGTxiPYJP1g5p9gg3MooPDpQU0MYK23OpO8
	yBsii3oVfYdKjZIaJg/Py+q6gu9SL4Zip8yXXlKnMjWe61ZMPQwHA9OQtRiH67NJqj7YuqmL5Em
	QdTC+pts+fi1VGjEJJevxNXRiqUFnEr4LAlXQhpeR3uR2Di2nAqpvuqawQ3CEvQnLvA819qKSSe
	uCJ5f9Z2V4CtJLxN+oRxE6FRPGlcIS9/V3S7JPGaIcnig3xFv5HHFqQOO31yEq0k4T6h6jM2P5Y
	BpGRtTmZqhihoL3u6Ftf/dLT0aF4ga3f35qQdjJbI7G8s=
X-Google-Smtp-Source: AGHT+IFifuKoIXgl+8sbJHAXGbEeChOXwycxKAlvotTjNABbq8Myxb19pNbT8slbgYzuKWDeS2s9sw==
X-Received: by 2002:a05:600c:1550:b0:477:9fcf:3ff9 with SMTP id 5b1f17b1804b1-47d19589575mr261915915e9.27.1766832160985;
        Sat, 27 Dec 2025 02:42:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a203d4sm189837855e9.1.2025.12.27.02.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 02:42:40 -0800 (PST)
Message-ID: <91ed7327-bf4c-4912-a490-ce7606b854a7@grimberg.me>
Date: Sat, 27 Dec 2025 12:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/host: add delayed retries upon non-fatal error
 during ns validation
To: Alex Tran <alex.t.tran@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251226-nvme_ns_validation-v2-1-0e1b3a142553@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251226-nvme_ns_validation-v2-1-0e1b3a142553@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_024243_263134_80E27373 
X-CRM114-Status: GOOD (  30.45  )
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



On 26/12/2025 19:54, Alex Tran wrote:
> If a non-fatal error is received during nvme namespace validation, it
> should not be ignored and the namespace should not be removed immediately.
> Rather, delayed retries should be performed on the namespace validation
> process.
>
> This handles non-fatal issues more robustly, by retrying a few times before
> giving up and removing the namespace. The number of retries is set
> to 3 and the interval between retries is set to 3 seconds.
>
> The retries are handled locally. Upon success then end. Upon fatal error
> then remove the namespace before ending. Upon non-fatal error, retry
> until the max retry amount is hit before ending.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
> Changes in v2:
> - Simplify retry logic with local loop instead of delayed work.
> ---
>   drivers/nvme/host/core.c | 37 +++++++++++++++++++++++++++++--------
>   drivers/nvme/host/nvme.h |  6 ++++++
>   2 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7bf228df6001f1f4d0b3c570de285a5eb17bb08e..6cd1ce4a60af55e5673e5fd0ec2053a028fae4f2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4289,23 +4289,44 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>   static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
> +	unsigned int i;
>   
>   	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
> -		dev_err(ns->ctrl->device,
> -			"identifiers changed for nsid %d\n", ns->head->ns_id);
> +		dev_err(ns->ctrl->device, "identifiers changed for nsid %d\n",
> +			ns->head->ns_id);
>   		goto out;
>   	}
>   
> -	ret = nvme_update_ns_info(ns, info);
> +	for (i = 0; i <= NVME_NS_VALIDATION_MAX_RETRIES; i++) {
> +		ret = nvme_update_ns_info(ns, info);
> +		if (ret == 0)
> +			return;
> +
> +		if (ret > 0 && (ret & NVME_STATUS_DNR))
> +			goto out;
> +
> +		if (i == NVME_NS_VALIDATION_MAX_RETRIES) {
> +			dev_err(ns->ctrl->device,
> +				"validation failed for nsid %d after %d retries\n",
> +				ns->head->ns_id,
> +				NVME_NS_VALIDATION_MAX_RETRIES);
> +			return;
> +		}

This is really redundant. just make the loop (i < 
NVME_NS_VALIDATION_MAX_RETRIES)
and print in the end outside the loop.
BTW, don't you need to remove the ns here?

> +
> +		dev_warn(ns->ctrl->device,
> +			 "validation failed for nsid %d, retry %d/%d in %dms\n",
> +			 ns->head->ns_id, i + 1, NVME_NS_VALIDATION_MAX_RETRIES,
> +			 NVME_NS_VALIDATION_RETRY_INTERVAL);

This can safely be debug print.

> +
> +		msleep(NVME_NS_VALIDATION_RETRY_INTERVAL);
> +	}
> +
>   out:
>   	/*
>   	 * Only remove the namespace if we got a fatal error back from the
> -	 * device, otherwise ignore the error and just move on.
> -	 *
> -	 * TODO: we should probably schedule a delayed retry here.
> +	 * device.
>   	 */
> -	if (ret > 0 && (ret & NVME_STATUS_DNR))
> -		nvme_ns_remove(ns);
> +	nvme_ns_remove(ns);
>   }
>   
>   static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9a5f28c5103c5c42777bd9309a983ef0196c1b95..dcbdc7fa8af0cb838b3f1a774d4c67fa69a00050 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -46,6 +46,12 @@ extern unsigned int admin_timeout;
>   #define NVME_CTRL_PAGE_SHIFT	12
>   #define NVME_CTRL_PAGE_SIZE	(1 << NVME_CTRL_PAGE_SHIFT)
>   
> +/*
> + * Default to 3 retries in intervals of 3000ms for namespace validation
> + */
> +#define NVME_NS_VALIDATION_MAX_RETRIES 3
> +#define NVME_NS_VALIDATION_RETRY_INTERVAL 3000
> +
>   extern struct workqueue_struct *nvme_wq;
>   extern struct workqueue_struct *nvme_reset_wq;
>   extern struct workqueue_struct *nvme_delete_wq;
>
> ---
> base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
> change-id: 20251225-nvme_ns_validation-310a07aa8b2b
>
> Best regards,


