Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16469C47258
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEwj62BHY/FYaS4xbB1ZGlDK7z3dB1l+H9aStAz6p8Q=; b=MSPSJ6qvoaI5W9iMcHOmu8X5f5
	iEGJ4JRcIFa+n7iNOHYVtL4rrFTMAgIhJnZFFJBzoZIqdKBG61co/nYerljArfRLCxmHPp0/jkPR/
	iiGON1x2oNmfE6LCuoJYSnGKYAgdLog0JYWOljFE40+RnHhiEiC0Y6p5gkH3USDNXWqG9Kcvj9lqU
	6D93l4Dl9tk6Q8MRAXw4X/m6BTgTIpCWtHcXLlFRZ2DZZG21+1k3yzlQMCIVp7uuLECjJ4e3ZuDHV
	cd6lToZwuP7n+E1NICpzi/c9cHYhLJgRYFg6SlKqLNWvUBFA9gI69Hb3v8urR1tcLRFxfc2Ji30Cp
	XWtANaEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU2yY-00000009Hb0-0sXt;
	Sun, 28 Jan 2024 11:05:22 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU2yS-00000009HaU-2Oj4
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jan 2024 11:05:18 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33aeac77bc4so46049f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jan 2024 03:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706439913; x=1707044713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEwj62BHY/FYaS4xbB1ZGlDK7z3dB1l+H9aStAz6p8Q=;
        b=KivhJj4QRWtRcBNIl46xaSitZ1JSI83ICBTpiUi0X7vnKMRFBFoQy0OmQlDJ3hVfGN
         CH0XH09u3LBKHObuRF8hCloJ95BRbGLVohdaZszJJg5RvvAYny/pLWNd4SfVKHKOGlD1
         5fZpsGk4sAEdCqFcsuoa4Lq7g+FYIAtipqFM87wzvHGM3ltbxlDm8Eh4bsGmqweYYYaA
         xknoud7U9+ooIY2l4I4mqEbJyO/Oa1Uuq1/hkt94ivzPgCHLAGnS0YJix5HESPgJeca7
         9E407dimYT65Kms0X06zNZO6lVoPxRzY5WP3SeWMbgosFjSfYqSvjp3wxCmHJhSI5HmD
         J+jA==
X-Forwarded-Encrypted: i=0; AJvYcCXKWXfm1gohhaKZHCC/8cbmS5uxlzgi4Bz2PxRA2RbhMD9E3OlL1davmD5GUfVLNvtXTxIwt5ZcSpPYC83Z3bc/mhNfW+JVF9z2yf01DFs=
X-Gm-Message-State: AOJu0Yw3cSgwepDe9pvngI2tgIrxF/vR616xSJ3aEbltP3yYj3VgYKri
	/XSUEJ453xWUnv9cubcG022RP2qFDnP82NOZ7w200BwRM9b3VyZJ
X-Google-Smtp-Source: AGHT+IF119AbDAu5NIzD3uaPHF7CAAZeFXn6SQcxnLLGdQf9xhjndGpMoIujS9c/eGTQlSKIboMMUw==
X-Received: by 2002:a05:600c:1e8a:b0:40e:ee43:555d with SMTP id be10-20020a05600c1e8a00b0040eee43555dmr3046004wmb.1.1706439913046;
        Sun, 28 Jan 2024 03:05:13 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id he9-20020a05600c540900b0040ed1df542bsm6993636wmb.20.2024.01.28.03.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 03:05:12 -0800 (PST)
Message-ID: <e05c2ce0-d884-47d3-8b1b-b7b6b0e96192@grimberg.me>
Date: Sun, 28 Jan 2024 13:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp: question on poll return value
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_030516_650837_C27726A3 
X-CRM114-Status: GOOD (  24.51  )
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



On 1/24/24 17:31, Daniel Wagner wrote:
> Hi Sagi,
>
> I am stubled across nr_cqe while debugging something else and I am not
> sure if the poll function is doing the right thing with it. IIUC, the
> blk_mq_ops poll callback is supposed to return > 0 value when it
> processed at least one element. If this is the case, than I think we
> would need to first copy the current value in nr_cqe before calling
> nvme_tcp_try_recv. The function will reset queue->nr_cqe to 0, thus
> nvme_tcp_poll will always return 0.
>
> Does this make any sense?

Not sure I understand your logic. nr_cqe is cleared when try_recv starts 
and incremented
in every completion, and nvme_tcp_poll is returning this value as these 
are the number
of cqes collected during the try_recv triggered by nvme_tcp_poll.

It is true that if between try_recv triggered by nvme_tcp_poll and 
another try_recv called
from the RX io_work path, nr_cqe may be cleared again. That is something 
we can address
by passing nr_cqe by reference as an in+out parameter to try_recv. But I 
don't see how
nr_cqe is going to always be 0.

>
> Thanks,
> Daniel
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d79811cfa0ce..db9a105bd986 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2573,6 +2573,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   {
>   	struct nvme_tcp_queue *queue = hctx->driver_data;
>   	struct sock *sk = queue->sock->sk;
> +	int nr_cqe;
>
>   	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>   		return 0;
> @@ -2580,9 +2581,10 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>   	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>   		sk_busy_loop(sk, true);
> +	nr_cqe = queue->nr_cqe;
>   	nvme_tcp_try_recv(queue);
>   	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
> -	return queue->nr_cqe;
> +	return nr_cqe;
>   }
>
>   static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)

This is wrong, in this case, nr_cqe would represent what happened 
_before_ calling it
and not how many completions it consumed.

