Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 12:01:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8179860F94
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 12:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8179860F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F56ySn91q9t4VXEX4Opd1U8XAEIB7c/S7Gc9tSONP9Q=; b=A6QaSTA4v3HbDxyVBsK47VL1BI
	P8z19Aatj7OgmQy7UV+dhJOMXvXJ7a0ysPuh1Yo7NbYkQWEBIgq9h77B2N5BnjVavE1agmD5IScSe
	ha+KHBKRviiHsH7+G3BL0TLpofNIWy+vYuIirsJDLFzgKJePuUw3+lhUfxQAi7fboNbv55/7fN1xT
	cdBUS3yt2uzgOG1mUwMcA+8KCtq9rLppCcmpB5BSpGS9HXAJD3ftLvSmHnIc3ZoDujt+jUUjsP/Dh
	/vzs0wzTjyimszf/beu87HPKNGQ7WStLKESfK5ESLPm7nGGx3+nTjLykKXDKLHZPzFL/JOKEsla0l
	l9dpu/wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macwy-00GRNf-Jw; Wed, 13 Oct 2021 12:01:36 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mabtE-00G7LK-Td
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:53:42 +0000
Received: by mail-wr1-f47.google.com with SMTP id y3so6951738wrl.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jkexyjpjWtchbt6lNUNbTEVgq3MA1z7TXzSJ3cC0SuY=;
 b=abFdBFh4kZrMvl0j7jut4UgqmsCirfvo4l7ohVoEn+QP8hZROOb6Qm9qAScm+tqWR8
 Lac6Y4w2IsB7Dudk/GJscuOMcxOxofNhzorRX+prYSo90oloJMwlXi5P3bNiJziUi/aU
 Go89c5ZUm4U9xvytP6kREQQojtL4wpOQRtP00+6nH1xfe3WuH4i8DGawOb7Ey7QS0Ntg
 KxExkVQM1rVQwWjE2gGy+i5bnw96Un7YiKMnahbm3MQrhYmlsJ8rpt12HcO78Il28lg9
 hRkT1KwAdFoMK5Qz/zHF7s5D/lzOjJJ+iXJrKJNEKC14w6JZThdq+saaVlyflAENjb/F
 0tDQ==
X-Gm-Message-State: AOAM531GVlVeDdnwKyzvtzQA/qSgqbfFBaBuX2u1LhkfKbFdSILuNXNp
 ax6Dtnz6nEHVBD7D7504ndU=
X-Google-Smtp-Source: ABdhPJxy8xMfvwAcWuiIK4XRZLUCm7IbCILUSCMzQamyfsZB1IoDLrscAL7TUBY90wttGDQAPSfFWA==
X-Received: by 2002:a05:6000:168d:: with SMTP id
 y13mr31146520wrd.172.1634122419433; 
 Wed, 13 Oct 2021 03:53:39 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id s14sm12749416wro.76.2021.10.13.03.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:53:39 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: calculate IO timeout
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20211013022744.1357498-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1505b177-5360-20d1-48ba-6ffb65933a00@grimberg.me>
Date: Wed, 13 Oct 2021 13:53:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013022744.1357498-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_035341_020666_B0B8D19B 
X-CRM114-Status: GOOD (  20.56  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Existing host and nvme device combinations are more frequently capable
> of sustaining outstanding transfer sizes exceeding the driver's default
> timeout tolerance, given the available device throughput.
> 
> Let's consider a "mid" level server and controller with 128 CPUs and an
> NVMe controller with no MDTS limit (the driver will throttle to 4MiB).
> 
> If we assume the driver's default 1k depth per-queue, this can allow
> 128k outstanding IO submission queue entries.
> 
> If all SQ Entries are transferring the 4MiB max request, 512GB will be
> outstanding at the same time with the default 30 second timer to
> complete the entirety.
> 
> If we assume a currently modern PCIe Gen4 x4 NVMe device, that amount of
> data will take ~70 seconds to transfer over the PCIe link, not
> considering the device side internal latency: timeouts and IO failures
> are therefore inevitable.
> 
> There are some driver options to mitigate the issue:
> 
>   a) Throttle the hw queue depth
>       - harms high-depth single-threaded workloads
>   b) Throttle the number of IO queues
>       - harms low-depth multi-threaded workloads
>   c) Throttle max transfer size
>       - harms large sequential workloads
>   d) Delay dispatch based on outstanding data transfer
>       - requires hot-path atomics
>   e) Increase IO Timeout
> 
> This RFC implements option 'e', increasing the timeout. The timeout is
> calculated based on the largest possible outstanding data transfer
> against the device's available bandwidth. The link time is arbitrarily
> doubled to allow for additional device side latency and potential link
> sharing with another device.
> 
> The obvious downside to this option means it may take a long time for
> the driver to notice a stuck controller.
> 
> Any other ideas?

I think that the case where the workload will behave in the worst
possible case then the admin should probably override the default
manually. I don't think it is desirable to have an absolute-worst-case
default timeout.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
