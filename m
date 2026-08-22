Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26833C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0yGAPqaU3H1oRpnbPH7lrF5a+r8y54Cf4QZJfDQUV4=; b=ajMDODWo1onJG1XOse80b/8By+
	LV6dDclENS1llZmCkQhALbq4RwDeX0/MVosFnZfKLjMaOT2ypA6PWUacL7dObMERqbOexCFAHcMFN
	pmD+066I5JuwF/xCBoL72iEGvOnw+LVwyG4ADuOzctkIV3YWZBAxEXEEyic6hsoRqDS9Fgjf8TVUt
	3K90EYwdSG3g5VDYqKsFdv7m/nbZ8ZvG7uRZ3kKQFhOhObtdk9J5h22u4Iai/Lx571KkOvt/M2Qrv
	OoSmMFDBRbLqLEdlunJsp7rK89/4xUEjJuudFV531tTrcc60SV6wK2piJYFQLlR9TS0vU61HPX5lZ
	xiEILdvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtDy-0000000EoB3-2MRG;
	Sat, 22 Aug 2026 21:25:58 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtDs-0000000EoAT-2IQg
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:25:53 +0000
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so3916976a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787433950; x=1788038750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0yGAPqaU3H1oRpnbPH7lrF5a+r8y54Cf4QZJfDQUV4=;
        b=AIzVH7EKkPm0LWW7U1ISF5Ag3R/aRpM2umhgPw2BEOMtAFVZ37ad4jIoefjdM4otdW
         X8dw5+WCLsAbbshGKMoAIcIjuQ0mYvBrDINazTyiBJm95kEpmzDJ9voeI0MZYxuxCAcJ
         9ThVOW9AV/3q89PFO7USormZUQxe0KOwWoGlhIRgPROLhig5rcFzfrdmArFt1eF2jPgs
         cFryYJS7CxpoocvEIKhKXWeP1usvEZ9yQJrqH5PZjBazNPvIcH4E31ifQ+jP2TTycLK5
         3/UX+JCfhMs7kt3iiv27/5HOwlx3xKUXez6Vn8fqvjdf3+PFvp+WEg+BomjWDJkTOGwN
         Dj5A==
X-Forwarded-Encrypted: i=1; AHgh+RppQF+C0MfefKgC2pxWZT/PeoCZuj/+6ZrNYqdOfKHVY9RRP1VzcdZG2+YLva7A/4mwwdrQU0JiWgII@lists.infradead.org
X-Gm-Message-State: AFuF++liHx2kBW50emA4hD0Xz0UEaQEbG/4EAIOXwq8LJlfw0cKyuuw5
	h4Z1SWPeYfY6yOtsDxbw+wblVmiXT+8Pj+Gbqv0W1x0MDY8mtHIGZ5yZ
X-Gm-Gg: AR+sD10JS21gwIq7LpQWX2ktnC+0b7RSI22ZtePNPwEnUSzcc0Ucs/OA7iiaLu1Jyrh
	Z6AHU9Eb6W3NEux/88ZmadSxSypCCaiQxAwgzebz7aw+Hsi+vSqiZobsg7gAUCxE3rwGP7bWC1U
	5wKmMML7+NVECp3vfASWbSFgStXZ2aOELUD4x7JcAoXMuOkVwyc9V5q/mjd9/4qn17NPmSmcZlq
	t8buw+qbTcwXO/r5W6MjsR7rwi18L2bSVxBQRKBvaKjXS2Ra86GEZaylwiRKSqzoPQl3iMOzXdh
	6d9TbT2KbUsu7lelYZZNOK0rH8uQjAGPe7HIJZZnhaRFQzl5uKf/okqEH2efQnhIa1/nAZyOcS8
	lOLZlsM1bo7CfSzq+YEjYiYO7w+pGuOabNMxyEt7rGGj8ob425djEfStjUWvvq50u3ywZfvs7X8
	jwe81v5Iov9s5cem0toyisW1zUIVXlC27XVORLTD05a6o4RCiHZgwJ4/Bvm6UwjQsXhPOl02m3Z
	xyypVApekb+rQ2VJBpfpLM=
X-Received: by 2002:a05:6402:321a:b0:69a:a4cb:2882 with SMTP id 4fb4d7f45d1cf-6a42f216beamr19273125a12.9.1787433950109;
        Sat, 22 Aug 2026 14:25:50 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff177b1esm14319878a12.29.2026.08.22.14.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:25:49 -0700 (PDT)
Message-ID: <0a6b07e8-3ea6-4458-95eb-4a63b6108823@grimberg.me>
Date: Sun, 23 Aug 2026 00:25:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: reject C2HData for a non-read command
To: Chuyf26 <Chuyf26@linux.alibaba.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, roys@lightbitslabs.com,
 sashas@lightbitslabs.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <178730451245.442148.11684394617763960186@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <178730451245.442148.11684394617763960186@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_142552_611058_235BC610 
X-CRM114-Status: GOOD (  21.72  )
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



On 21/08/2026 12:28, Chuyf26 wrote:
> A malicious or buggy controller can send C2HData PDUs in response to a
> WRITE command.  nvme_tcp_handle_c2h_data() accepts them as long as the
> request has payload bytes and a current bio, which is true for writes,
> so the receive path ends up copying the incoming data into the
> request's iterator.  That iterator was initialized from rq_data_dir(rq)
> in nvme_tcp_init_iter(), i.e. ITER_SOURCE for a write, and
> _copy_to_iter() refuses to copy into a source iterator: it triggers its
> WARN_ON_ONCE() and returns 0, the short copy fails with -EFAULT, and
> the connection is torn down into error recovery.  The write never
> completes: every reconnect reissues it and a malicious target answers
> with C2HData again, keeping the controller in a permanent
> reset/reconnect loop.  With panic_on_warn this is an outright crash.
>
> C2HData carries data transferred from the controller to the host and
> is only valid for commands that read data from the device; write data
> travels host to controller in H2CData PDUs solicited by R2T.  This was
> reproduced against a target modified to reply to a WRITE with C2HData:
> the host logs
>
>      WARNING: CPU: 0 PID: ... at lib/iov_iter.c _copy_to_iter
>      Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>
> and the controller cycles through reset/reconnect without the write
> ever completing.
>
> Reject C2HData for any non-read command.  This is the symmetric case
> of commit 6efbc52237fa ("nvme-tcp: fix host memory disclosure on R2T
> for a read command"), which added the mirror-image direction check to
> nvme_tcp_handle_r2t().
>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Cc: stable@vger.kernel.org
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Assisted-by: abaci:qwen3.8-max
> Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
> ---
>   drivers/nvme/host/tcp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -685,6 +685,13 @@
>   	}
>   
>   	req = blk_mq_rq_to_pdu(rq);
> +	if (unlikely(rq_data_dir(rq) != READ)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d unexpected c2hdata for a non-read command\n",
> +			rq->tag);
> +		return -EPROTO;
> +	}
> +

It'd be better to check this before the req assignment.

Other than that, this looks good.

