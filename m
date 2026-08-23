Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D61C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HmT1MOv48aAYBABf9PQ/d8fJ9FPnoi9BNcTHvGpgYj8=; b=aX/FogOJfp4AJnrXuvEcJQ7PP+
	PfbjVBWFq2NCiEODfKg0jN0UPRKAuex3ISQXOu5X1wInIj8fj622bkxxqoYR0hRi7vqX99MBhXI+9
	vdFjCUTvfX/qyMobk5zBRjNAWGpWPV9u+WDllDPwrXwLmwfTfweWGBcIPreDA7AsoNDPcKqqKUpO+
	tBsEzbdN+Y9xKCVEAo8yKe5WZHFQKpFXgtCvW9/ejpN1iQcKfOYooi8RVsdRgU8mLnvnwCGY8eip0
	jbu9f47MunNvb+uOyzm/2LGdzyvGn3An/CLgRbMqJLdl6PRGz4kg0xJBD10T4FBBFjiOO0n0AjM/k
	pEMV1kkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4ZN-0000000FDnj-44NQ;
	Sun, 23 Aug 2026 09:32:49 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4ZL-0000000FDnM-12jF
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 09:32:48 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so277617766b.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 02:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787477565; x=1788082365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmT1MOv48aAYBABf9PQ/d8fJ9FPnoi9BNcTHvGpgYj8=;
        b=dpb0AqnPnG5h0qGQPwLrBKyER/OiftDwQdi3dvpcgJ9/plz6uxO0vh80Wi3rE383ga
         vKOduPWp3HYbM3ruMhdxV5yKHYb5HlGFFKN/81tn8K3o4NYe9QHp94LUQJbRmakBalWB
         IyTTEodvx+ebu+Rwpq/Blw4QGGThw3PanNsVdRTYUZLEAPYZU9fFBJ5IrAfY9LQm/jRx
         cEhTnEQciaSSNW4zCWojUeyEgOHo/htjSqbW9CM86Jupf4VhL3EBjpvFqXnonTIQ4Hgr
         SbS57DZPdcv3dP5Dayr/5SDHYYxRrb9ZvNfIaMqY5CQJij50akbccIYW9my+9tleuaG/
         oEbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp38TLnUP1ZnwYuZsg9wj4ImiKtqKUsBZF3Rop88Jy+DFX4tBL+VbGCt5vtSwHIQ5o3rS0qNpx+i0+6@lists.infradead.org
X-Gm-Message-State: AFuF++nYLjI+Q5h5Jvwjko9BenhMFHDrYbVmxjwDJri8Rd5mUkmQM+f+
	g+dEdY9oHfia38MqtasT5qJMKU3+KxcXtx+r7RqBhg+ntLnv0zdncxPZ
X-Gm-Gg: AR+sD11wA+/OmQHJrVk+bYG7hRRN1QGyVJQLdMMUYsoncAcPgYY0AHWsMyqFITrzTc3
	srfz79RfyKVwW8c1ar2q3XcDvkRcRLUams14NR3uLu1z5Un689kVJjn2K13Z7GxvAAuToK7p45m
	vCZGJ/SpmCcJ9ucGtu9bfhr/wkS/Gva+fUlWyYQHw1X0cqAclqI26Bb4JzqE+vZTWB22Wf23o5k
	4WbqYXBrRCd6YvZNmehOHkZ2iPP5+8G3pfWReN25mA4+2CrzQPmLwcYfLFMGlldESn0aROIk54G
	DtcPrSmZw7/MSJJPQl50Tm5FW2FqW7atixLzIWsjkIgbicZSCXzCnnsdEwcQI1cRZJ1IfvVdBZ1
	BrqLytHXcjshHlfhS1JSL5z426VPj+5+/xEDx3Ix9ohG2GCoTgAklEHCDn2lOWXdNM4bATPLN49
	L7vtpcjzItC8NdaVsLzY8so6LWLT2PZZRcfhNRcVUqWqCK5krfE6teQTooLRAN7MeFJm2qNXZx4
	GHj3fl/POLoh03hk3vN5u8MuBeUpg==
X-Received: by 2002:a17:907:a604:b0:c24:457b:86fc with SMTP id a640c23a62f3a-c246a66adb3mr2211253166b.21.1787477565258;
        Sun, 23 Aug 2026 02:32:45 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm2660132a12.9.2026.08.23.02.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:32:44 -0700 (PDT)
Message-ID: <6162ad2a-3355-44ab-913b-b1bb1f9531dd@grimberg.me>
Date: Sun, 23 Aug 2026 12:32:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add crd value to output error log
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
References: <20260809173545.54749-1-ikegami.t@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260809173545.54749-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_023247_300185_F9C73AFE 
X-CRM114-Status: GOOD (  14.51  )
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

This makes sense to me.

On 09/08/2026 20:34, Tokunori Ikegami wrote:
> Also add NVME_CRD to get the status CRD value.
>
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> ---
>   drivers/nvme/host/core.c | 15 +++++++++------
>   include/linux/nvme.h     |  1 +
>   2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..0178de333ceb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -326,7 +326,7 @@ static void nvme_retry_req(struct request *req)
>   	struct nvme_ns *ns = req->q->queuedata;
>   
>   	/* The mask and shift result must be <= 3 */
> -	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
> +	crd = NVME_CRD(nvme_req(req)->status);
>   	if (crd)
>   		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
>   
> @@ -344,7 +344,7 @@ static void nvme_log_error(struct request *req)
>   	struct nvme_request *nr = nvme_req(req);
>   
>   	if (ns) {
> -		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %u blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
> +		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %u blocks, %s (sct 0x%x / sc 0x%x) %s%scrd=%u\n",
>   		       ns->disk ? ns->disk->disk_name : "?",
>   		       nvme_get_opcode_str(nr->cmd->common.opcode),
>   		       nr->cmd->common.opcode,
> @@ -354,11 +354,12 @@ static void nvme_log_error(struct request *req)
>   		       NVME_SCT(nr->status),		/* Status Code Type */
>   		       nr->status & NVME_SC_MASK,	/* Status Code */
>   		       nr->status & NVME_STATUS_MORE ? "MORE " : "",
> -		       nr->status & NVME_STATUS_DNR  ? "DNR "  : "");
> +		       nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
> +		       NVME_CRD(nr->status));
>   		return;
>   	}
>   
> -	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
> +	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%scrd=%u\n",

no space? also perhaps "crd 0x%x" ?

