Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8723CC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 14:14:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5875260F8F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 14:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5875260F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDd4+zyhss9ZAouduQv/tTng8pis4kRMChF6D85Kmck=; b=tEA8iZJLzxQdCUCz2QVX9TaYoT
	RrFU+TNh8OWTnaUBt9BPGpkXv94DxIPUJJ3LQ0U+fXSVSIg6Bcqw86ifUDAevqBEK/Mww9U37XJrf
	00xh4j9zFNVeupK00+EtOScmk2Wkk+HWfidfyyFMDEqrAhlzC434ni6JRU0lvG/k6SXpXO09c2/nB
	TsjUkPbxML0tnD+rFMI91rNHTPZOu6aLUsn+90vTnW6JyAV2FVQwFYHJxde4YBvaDB5WMSmuxJqbu
	Exvkl+GFNrret+T8OMxoI3xf7tgt6iwqeFiMCOZeqGnPA6PTVChHbN9lqLrTGf5Q+TfEfrEDzIqX2
	h4AKDEnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcTOz-00G1s7-Gw; Mon, 18 Oct 2021 14:14:09 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcTJA-00G01B-OH
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 14:08:10 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 e5-20020a17090a804500b001a116ad95caso62980pjw.2
 for <linux-nvme@lists.infradead.org>; Mon, 18 Oct 2021 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=sDd4+zyhss9ZAouduQv/tTng8pis4kRMChF6D85Kmck=;
 b=FOP3QJEgM0gUHNVmVW2NTX6sBvHyLswIy582yFz8lGGFF7GpGeN3GsDG/5TUaJ29eY
 1hDYFmVprU4u80ViOVlEEg+DaIigWvgzeS+NdbOCFsbzPS0Qn9joRWLLhu+DzFV+AtE7
 yKhbHdwpOg7bWbzbyq9/KhTgxis1C1pQ8jwFFQ29FQL4MMuS3HEZUh1SFu0vtJrMVsgG
 TtGjUw9L0UPG35VRDIEIgjJ8kAqTeaRCTJkAsxDzLIHK4kzUtt6RtvsSHU8nndCQDA3+
 Hgk4oRGLkOa7rcEHdDZRCpCxgad/v/8BdyLy/tBDJQcZME9U0FwukkQHVTotUJ2i3D3c
 vEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sDd4+zyhss9ZAouduQv/tTng8pis4kRMChF6D85Kmck=;
 b=62PTL5Z7Oz1qJW/iViKgslaVaq1UBaeSM8r6hM/WhG6LC7kndBcBY9ARt0psmU6mux
 JvCxo1vOXktfOXSJwz5FCvvwRtuJ/Fj0YBVaz3WRZTxG2tNtAm3tdx1sx0PUAv+iBbeb
 I6yFi5Mq94b7O4r3+Wxm6ovMrU4JKxPCjcrPCZ0qDSRtba+TbXc4BdxRbrRdn/IIwunx
 t8/nH2CHp4aQ6u2g2//C/ax+VMbIDaY5UiICvrtvfx1uLuOiLR3ofb5oLOfiVHFCJHtF
 nKE28lOCsT6DBMbRIY9slGyeyVoJFXmM4EjOJQrUomX84eEaOxLt4LZ2i/8p5ruTzA0N
 Xcrw==
X-Gm-Message-State: AOAM532gJgMlr8X7nZE7QrkSRnqtgPulylJ3ix75ZWcCTlwQAaVlgV52
 4jDjoO9tzEy2rx8vfd/w2fk=
X-Google-Smtp-Source: ABdhPJy6DLUh7xumfWey3D8WpnrDOG7EE05rEIYgo4W5iQPgXTNESOkKnosTpigS60oEwqlrv1m00Q==
X-Received: by 2002:a17:90b:164b:: with SMTP id
 il11mr34256152pjb.98.1634566085134; 
 Mon, 18 Oct 2021 07:08:05 -0700 (PDT)
Received: from [192.168.1.26] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id rm14sm8494264pjb.4.2021.10.18.07.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Oct 2021 07:08:04 -0700 (PDT)
Message-ID: <4002b4b2-1a57-8c4f-c2cb-5c4bf13aafbe@gmail.com>
Date: Mon, 18 Oct 2021 07:08:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/7] Centrelize common fabrics code to core drivers
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_070808_893173_CCCEF5DB 
X-CRM114-Status: GOOD (  16.97  )
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

On 10/18/2021 6:40 AM, Max Gurtovoy wrote:
> Hi Christoph, Sagi, Keith and Co,
> This series is intended to move common reconnection, device removal and
> error recovery logic to common fabrics and core drivers. In this stage,
> it mainly deals with the RDMA and TCP drivers which had the same logic
> for the above tasks. FC driver can start using this framework in the
> future after some preparation work that should be done.
> 
> This will ease on code maintenance and reduce the code duplication
> between the RDMA and TCP drivers.
> 
> Since there are some attributes that were moved to generic nvme_ctrl
> structure, I've measured perf impact.
> 
> NVMe PCI Perf numbers using NVIDIA's NVMe SNAP Bluefield-2 device
> (Fio 16 jobs, 128 iodepth, libaio):
> 
> IO size   rand READ (before/after)  rand WRITE (before/after)
> -------- -------------------------  --------------------------
>   512B          2189k/2197k                2031k/2092k
>   1KB           2188k/2201k                2027k/2088k
>   2KB           2166k/2181k                2023k/2078k
>   4KB           2153k/2169k                2025k/2076k
>   8KB           1381k/1381k                1378k/1375k
>   16KB          669k/676k                  660k/664k
>   32KB          320k/322k                  305k/305k
>   64KB          157k/157k                  151k/151k
> 
> As we can see, there is no impact on the performance.
> 
> Max Gurtovoy (7):
>    nvme: add connect_work attribute to nvme ctrl
>    nvme-fabrics: introduce nvmf_reconnect_or_remove API
>    nvme: add err_work attribute to nvme ctrl
>    nvme-fabrics: introduce nvmf_error_recovery API
>    nvme/nvme-fabrics: introduce nvmf_error_recovery_work API
>    nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work API
>    nvme-fabrics: add nvmf_init_ctrl/nvmf_teardown_ctrl API
> 
>   drivers/nvme/host/fabrics.c |  90 ++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |   4 ++
>   drivers/nvme/host/fc.c      |  23 ++++---
>   drivers/nvme/host/nvme.h    |   7 ++
>   drivers/nvme/host/rdma.c    | 134 ++++++++++--------------------------
>   drivers/nvme/host/tcp.c     | 124 ++++++++-------------------------
>   6 files changed, 180 insertions(+), 202 deletions(-)
> 

Thanks Max.

I've been thinking we needed to do this for a while as well.  FC should 
be part of this, and up front, so the abstraction is tested properly. 
I'd rather merge now than spin things again.  I'll go through this over 
the next day or so.

-- james


