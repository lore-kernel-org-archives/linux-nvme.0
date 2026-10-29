Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC9606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4Np8ALgk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3qYACbe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=z0T3u86hkedH3eaRgGYwzQ+GOmGeNII7gwe8E9j9n9o=; b=4Np8ALgkQmt68/
	17RPDKkXWtDkegXd5i+vvmXBuD/RCT1OUmsowh5dzC+K5q7O2sHP6QdTkXp4mGq2LtJujwD2OeZ/C
	71C2dsXA11vIU8Ei0lYOSNtVqr3YxYLnySwpFQ+e82XC/cuL1OwofQ/9F9sTMJE50yQf4MAHTXpCs
	yLtlvwyjBzfRHR+S2qiqf+U24utHSC1Jtb7L6AE2oGo9GfOa8fAT1LgQkB3RuekGUMdUBWCOEEShE
	7ShEbaolR/tfRyh1r3+/l6l6TN8Y7USKBlhytyuzJ/twc0bVkOuTcaSpjyw3i6hAEZpzg0QdIooqw
	k/iUnb1kq9E6rlEsmL+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNku-000000091Il-1moC;
	Thu, 29 Oct 2026 10:53:12 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNkq-000000091I4-3wYU
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 10:53:10 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-48c45111bebso907147f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271186; x=1793875986; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0T3u86hkedH3eaRgGYwzQ+GOmGeNII7gwe8E9j9n9o=;
        b=K3qYACbehb+RG9/URtH/ZV64VOCi05XQTMDBYFaVPrKJcGj8HiegIGAJEucXTmehoI
         LAsiODpttMwNazW1lw+/KOObyu2jcC/RDL7hTIgtSRWsxgF6sh11slHiavLR4kqhzaXY
         HrYRP6myRzrfmrDwXCz1daPMmf9wIPlgFw7x1Sul6RjKmHnZZ5iODsoqGpmB/ChuFvHS
         qULYK6FwVRlmMhix6p5X894xTU2o2H2tM2+btkdKRu0cU6436HBn6xr1JFVNCMugTNoa
         9Q0xh0HI4tjlmuQDnlbG8ZnHPrMr2GkRRMAy+7xjsmzj7u0MrYNtZT5GmpN1mzVBPHSm
         Lnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271186; x=1793875986;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0T3u86hkedH3eaRgGYwzQ+GOmGeNII7gwe8E9j9n9o=;
        b=GG7ThpB+dV+H7WsZrK5zdpsnEBxAhhnTv0LuobQXQsPGEnseTQbmJcPAm4m2Tdqob4
         8x7kMiaE3sVDgVh2S3irKE80AB3fnKlMTK7E6toKjGCHCHn3e8ffuyLHYZ6nMQE4XoBS
         XVpy3sYFF+pcGYeu7tIyIXOdMevXRCqJDv3ipx1GWue9Z+maiwwewEYGrUWVXZ6MsZhX
         aXZ191KEO2gmOVTFfv4lgOxIfLyqZnuY1Su4ID2KXgsVVkw2r0QruvGj4O17JMQalRd8
         q8TkCU6az8RzXd1h8LAvlUAUusNjLkx941p3itP3mVhhMuYyCZsCLaVm+6uVQKEUfeJd
         RuMA==
X-Forwarded-Encrypted: i=1; AKwUvBxn+69w+jXsO1nx1U6/nHKl1+61UIfG8mUFFQ8pz/ff16y81lBW0FhkCkuzWyIafflYLLXIFrrHID05@lists.infradead.org
X-Gm-Message-State: AFq9FYL3ly8H3+Sf03WmhRUIKmHzJCuOzQljM5LqQYyAMr7fQh+x3iU+
	GmVn8Nc4lzsHLz21M1wbcnbw815RFiMXFN9gc0BlcClsWh/VDXKfwpue
X-Gm-Gg: AYBFou3li71v6b4BaL/NWTslaxTuitL+2hjw7jGy/7Ya3Ng6o5NP2moDUibQjzQyMi/
	eeGov9rbaEEO/rdmUFxew3uwjHbX+JAIpsNtYnmIkyzt4UgJeSb/0rQ5hcRdWevl5H1KW/1zpME
	PTokGEr9o/rzWVUD7Y81/Bk5GVHFdgiSoCFUllrs7QrzU8lXfmGFdoLtNl6caFf1GYqcgWteKsv
	m91QuvhBLULVxCxFRFrGU7MR83++tbbsLiyFO0B+rsXdhJFhlks/56VpXW7eBuYVHiu5MyvFVwj
	e0GV2MQufwtEGCSHN1bKZUsw4LtuCnH6JvpAPybc0f5z+OTepflM6lB8KeSgjZ3cIKYBoo6XnJk
	e8peUIzx4AAEMPF61hXAZOoTurIkuygaP1FYxp7MzPTZhF7qaEHDFwVizQ6yKduaq1GpYDR53Ny
	9/lenk2+5B7MXiGEfor0oPkMeMvb6jXep/GgSCEKRzd89PECC5awN17z+iTJTge3yOg6OJC1bic
	BU3sJ8IG8+FnAGTsRjO12caUM8YU/ReZ/in5IzBF/s47zNhrkgssDxqcG/+IkeBmJMHFxNnj41a
	E71XhDjG28a+FSAULRSQNdvay/KvYnoxfnVCVr3yrLT3KSZ8pkJZ7oOJvmLEt5DbQ5wj/Hx1L/q
	sA0lbqwM0QmGmjmh7eipq135vuZ7DkxVqI3NUgxx7anA3e5Xi59qTEwflD2JA1Jesaa1xH01/it
	PAfWVgE4EBfU2mGxAj61GYgeI=
X-Received: by 2002:a5d:5f52:0:b0:48c:69bd:e971 with SMTP id ffacd0b85a97d-48e5d2e6d40mr12705105f8f.16.1793271186318;
        Thu, 29 Oct 2026 03:53:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm31889960f8f.7.2026.10.29.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:53:05 -0700 (PDT)
Message-ID: <7fb73a55-c7f8-45bd-b12d-e46f1efcbe67@gmail.com>
Date: Thu, 29 Oct 2026 10:53:07 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] nvme: support dma-buf registered buffers for
 passthrough
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-6-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-6-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_035309_005593_4B058A78 
X-CRM114-Status: GOOD (  17.44  )
X-Spam-Score: -1.1 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 15:44, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Allow registering a dma-buf against an NVMe namespace character device
> and using it as the data buffer of fixed uring_cmd passthrough I/O.
> Complete through io_uring_cmd_hw_done(), so the dma-buf map is released
> at hardware completion.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   drivers/nvme/host/core.c  | 16 ++++++++++++++++
>   drivers/nvme/host/ioctl.c |  5 +++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d81462e864a4..6157ff839929 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -8,6 +8,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-integrity.h>
> +#include <linux/dma-buf-io.h>
>   #include <linux/compat.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> @@ -3982,6 +3983,20 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> +static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
> +					   struct dma_buf_io_ctx *ctx)
> +{
> +	struct nvme_ns *ns =
> +		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +
> +	if (ctx->dmabuf->size > UINT_MAX)
> +		return -EINVAL;
> +	if (!ctrl->ops->init_dma_buf_io_ctx)
> +		return -EINVAL;

Let's return -EOPNOTSUPP for consistency, with that

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


