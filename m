Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00564C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UsvkB3tKN7NANvqC2/wjxmprg5ts1g/9BjRaY0fx/IU=; b=ECTQF7jtibRpDjx69WHaxSHChI
	Z3Lvys6sG1+Dz2eXBUcFu4/QtO4ai43nLg7566llBfeRkijTaeu/m8+tZjakR/UK3+t4/WcKLoiZ6
	JzhlF1UZiUUMi4wBVgb4cZgcBCr5wJTfOCDWT2Nv6O5tCGMKYP+iX0uKphusAzR7qWCLA8vz848o1
	BZ1AAu/C9irg0g4WQ1gsFBbq/A+JjXnuId4C2CoD17dkBIBE/YHEzwZqlKebe74nMRTte+ZA4QOlp
	vPTnHa3rjl2VPnpvfPoaC3KUdH5dcKDG0Slm122kOJP4W68GTjvv3g1J3ZX1dV/khmjwZv4NTpflC
	h776tQsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgcta-0000000Bd31-3hgC;
	Mon, 06 Jul 2026 06:33:34 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgctY-0000000Bd2Q-11Qz
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 06:33:33 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-381ed661712so2192778a91.2
        for <linux-nvme@lists.infradead.org>; Sun, 05 Jul 2026 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783319611; x=1783924411; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsvkB3tKN7NANvqC2/wjxmprg5ts1g/9BjRaY0fx/IU=;
        b=B3KWArLWKyJD+Z3zfS41T7WgTeCP4ufgh5rzp8pb/AIhg1wrMtHOJa1ly07lnfLGIK
         /TMwJ1gxKZM7+rR/S5GrjXBHfydwpVEP2TP/vCkHvd6bB374LkTos41/bMbIiTl+LAR2
         T6/omfajMqc4sciDTYcrUZ34JIwUIwQ+KI561Pz7IDfJHqE2vPyZftSLrG5ea8yIh48X
         y5HtVtdvnB6zQzjp57tiZaJRXYOkYNOdQPGvG3iFcAUK65bqucsXvFVX9Z4ldi0ZdV8T
         1inFT7ss4IU2X/6083bVtOnshlK+isA9Vj1kYhP7bnQRhc3s8cXF6tKMq/3hsbnGXvQk
         0WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783319611; x=1783924411;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsvkB3tKN7NANvqC2/wjxmprg5ts1g/9BjRaY0fx/IU=;
        b=Xtc+pZYOpuW//qH2Q0Ts4ORU5vbo/dL4uaZxeDbjst1alJv++8Wl3XleUrgS80rDVT
         eZsQlX/4p83oQmZbD4LHybj/KMXWgqunzQuGiBf0bOXeMfcWLQNeUDzOZ+nnhV8rNqqE
         phn7rRq2qd1mjR0ZC6/gBh2gr9EBItgaGR1lCyPz7GMZ6AUfV6J3XdEbHx4k9Hzrnneo
         qWDdnDDETOxKZvZClwgrFvcz6mWk80F7zI7riYr4Zk+bfRhoXveqcuM4aoYnm+Ew3g2X
         VqDQpSH3LuT6INEyGATZci/BN/WO4wrm3cORv+gyf7MDV7owFIOGpPzXZukV6H34zqIv
         HU/A==
X-Gm-Message-State: AOJu0YxQaZaJFGsrSY8RNu6Fmp71lpi6Q+u7FNCk/tDXbrwIdCVhDNZn
	PluJQvrDc8S0IVBn4G5+eAbBypVQt9BOb4sgRZijQgHxpR6oh6vSoTURXR/BOw==
X-Gm-Gg: AfdE7cmZca19h8jgNbeXv05wgNUNOvUWILKfQdT6pnrsLqtMtJGj1Edl6e3v1v1jxcM
	dLpAYF5qtV4Aop7WEtTW9YsxqaxSSL0EsfQx2GixDvk1LSvmtHZnvuPYeo66DaPFvC/K+p8GfiP
	shQ6ohp0PrfMGUUcyyF6M4r5V9LpucyR0Bgmmuesyv3UtEMbuKClLTOcvLMjxxFikTbYXWGpt/o
	QYr+Lwrmok4bBj9e74+jgGI4ZEdY+GpCkQFfJQarHmJGFZ9/cxLQ8hnSWMgdvzzsztyo+qsHoAJ
	feRRGD3hoaeY3OsY9qa4bqY0myQujwZ37wtJ6p8CZk5+wVHGysjEsRbmjrFr+J/SdOczSc7btjc
	S4qvofYcZ6BQsEQuyTGJm9qF0TIF/MSl0PZrEtU96/cSqQx0itwIs0JZFDlfElhBNI5inOI+fUb
	5jclgB5fL1M+WmUFrOlDJR7DZR+pHIHWFn6AVGfnw=
X-Received: by 2002:a17:90b:2542:b0:387:872:7b87 with SMTP id 98e67ed59e1d1-38708727debmr5135a91.13.1783319610524;
        Sun, 05 Jul 2026 23:33:30 -0700 (PDT)
Received: from [10.200.202.226] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3812815d3e7sm4216158a91.14.2026.07.05.23.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 23:33:30 -0700 (PDT)
Message-ID: <3194c6ab-866f-4149-8c2b-9b2e5b29eb22@gmail.com>
Date: Mon, 6 Jul 2026 14:33:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: guzebing <guzebing1612@gmail.com>
Subject: Re: [PATCH] nvme: make firmware activation poll interval configurable
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guzebing <guzebing@bytedance.com>
References: <20260627010610.47768-1-guzebing1612@gmail.com>
In-Reply-To: <20260627010610.47768-1-guzebing1612@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260705_233332_303895_31DFBEC9 
X-CRM114-Status: GOOD (  25.55  )
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

Hi Keith, Jens, Christoph, Sagi,

Gentle ping.

The motivation is to reduce the extra time I/O queues remain quiesced
after the controller has finished online firmware activation. In our
Gen5 NVMe SSD update test, using a 10 ms poll interval instead of the
current 100 ms interval reduced the observed completion detection time
from 311 ms to 266 ms.

Could you advise whether this is a latency issue worth addressing
upstream now? If so, would you prefer a fixed shorter polling interval
instead of a module parameter?

If the current benefit is not compelling enough, would it be better to
defer this until firmware activation times become shorter on more
devices, where the fixed 100 ms polling interval would account for a
larger part of the I/O quiesce time?

Thanks,
Guzebing

On 6/27/26 9:06 AM, guzebing wrote:
> From: Guzebing <guzebing@bytedance.com>
> 
> nvme_fw_act_work() polls the controller processing-paused status every
> 100 ms while firmware activation is pending. Some devices can complete
> online activation in only a few hundred milliseconds, so the fixed
> interval can add noticeable latency before the driver observes
> completion.
> 
> Add an nvme_core.fw_act_poll_interval_ms module parameter to make the
> poll interval tunable. Keep the default at 100 ms to preserve existing
> behavior, and accept values from 10 ms to 100 ms so systems that need
> faster completion detection can opt in to a shorter interval.
> 
> Signed-off-by: Guzebing <guzebing@bytedance.com>
> ---
> We recently observed this issue while performing online firmware
> updates for Gen5 NVMe SSDs in a production environment.
> 
> During firmware activation, the kernel quiesces I/O. Detecting the end
> of firmware activation earlier lets the driver unquiesce I/O earlier,
> which is important for the long-tail I/O latency of production
> workloads.
> 
> Operation steps:
>   nvme fw-download /dev/nvme13n1 \
>     -f ./Inventec_G238B_NVME_LDD5902Q_MZWL61T9HFLT-00B07.bin
>   nvme fw-commit /dev/nvme13n1 -s 0 -a 3
>   nvme fw-log /dev/nvme13n1
> 
> Operation device:
>   Samsung PM9D3a Gen5 NVMe SSD, model MZWL67T6HBLC-00B07
>   Firmware update: LDD5702Q -> LDD5902Q
> 
> Operation results:
>   100 ms polling interval: 3 polls, 311 ms
>    10 ms polling interval: 24 polls, 266 ms
> 
>  drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3b7a8f7a35426..784da06fee559 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -58,6 +58,21 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
>  MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
>  EXPORT_SYMBOL_GPL(nvme_io_timeout);
>  
> +#define NVME_FW_ACT_POLL_INTERVAL_MIN_MS	10
> +#define NVME_FW_ACT_POLL_INTERVAL_MAX_MS	100
> +static int fw_act_poll_interval_ms_set(const char *val,
> +				       const struct kernel_param *kp);
> +static const struct kernel_param_ops fw_act_poll_interval_ms_ops = {
> +	.set = fw_act_poll_interval_ms_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int fw_act_poll_interval_ms = 100;
> +module_param_cb(fw_act_poll_interval_ms, &fw_act_poll_interval_ms_ops,
> +		&fw_act_poll_interval_ms, 0644);
> +MODULE_PARM_DESC(fw_act_poll_interval_ms,
> +		 "firmware activation polling interval in ms (10-100)");
> +
>  static unsigned char shutdown_timeout = 5;
>  module_param(shutdown_timeout, byte, 0644);
>  MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
> @@ -106,6 +121,13 @@ module_param(disable_pi_offsets, bool, 0444);
>  MODULE_PARM_DESC(disable_pi_offsets,
>  	"disable protection information if it has an offset");
>  
> +static int fw_act_poll_interval_ms_set(const char *val,
> +				       const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, NVME_FW_ACT_POLL_INTERVAL_MIN_MS,
> +				     NVME_FW_ACT_POLL_INTERVAL_MAX_MS);
> +}
> +
>  /*
>   * nvme_wq - hosts nvme related works that are not reset or delete
>   * nvme_reset_wq - hosts nvme reset works
> @@ -4798,7 +4820,7 @@ static void nvme_fw_act_work(struct work_struct *work)
>  			nvme_try_sched_reset(ctrl);
>  			return;
>  		}
> -		msleep(100);
> +		msleep(READ_ONCE(fw_act_poll_interval_ms));
>  	}
>  
>  	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||


