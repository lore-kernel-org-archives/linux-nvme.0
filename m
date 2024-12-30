Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2395FE77188
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Dec 2024 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhS7pHbhr28gZ/Rk64UTfD4r1LLW5qyytEVvGHdae5M=; b=dEBcGXAEXBw4PYF69viB7H+KV0
	PMtORzcEgOIlobaiRECIT730hwnX+VLJZGNoqm9Bn8t5W9eerQxlukyo3NwoJcAKI3JIlqiVZnxMc
	47vOWFT8Tl1bMoB8QDMZkG8bVE9bQ3ofveBt7t2+9bxPnIuxIWZwfFnHOlc10iR8rxiA7Xc44dIul
	a6tteLcJoRPU39WwxKQPt/w8JLKcngkMDrESlj466sYzWXQ199YQy6pur6Bgl2S4NvADRZd15XF2/
	276bbgYFCulvuV9dhGLX2ukHPxbFVY4BhUnlurESST0LD7qsXxWnS6U/sill3XL7uf4nisARMhHym
	ObZ7izCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBBK-00000004oVe-0KDx;
	Mon, 30 Dec 2024 08:31:22 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBBD-00000004oVG-1Ufa
	for linux-nvme@lists.infradead.org;
	Mon, 30 Dec 2024 08:31:16 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso64169345e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 30 Dec 2024 00:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735547473; x=1736152273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhS7pHbhr28gZ/Rk64UTfD4r1LLW5qyytEVvGHdae5M=;
        b=LZSsNXxpuvAg3VJisI06wtLsKFMHKKrZs72earmgBJsYQs0ntuj5DRZrRrZGCgydMR
         gJMylK0+aYpME3/6QB+73cd5Ux+0oSp5aENhfM7jZsOuT2vyf72IWU9EDe1iEVJKS/hd
         3HqmYMRsOO90rVRjWDgzCx9WNXmc6eHXOv2X/5cd0s5yHFIw5TR6UmklVJdIf7bNB3mO
         eYsUL5V0Wm/Y6X5LJMkndeDS+mksyslWOuml7Uv96L8YJaKQy+IxHcrI7Nqz95BlGevc
         O/6Pjxy6PWOmI2NomDJ5qkDzR1OAkpNuo4a1W1Qn/Fls+ntyLb4XxGHGEDLYGof5BfQ7
         HzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7VgtrVvjdMmZDos4W/oo9S5qh5j3O8tUVfoIsq0t1hOVabSsTwZRdo5R2ltuI/hiUsqneB8slw/1g@lists.infradead.org
X-Gm-Message-State: AOJu0Yy81HfeRjWkjPqla7t+If1wgPcRoRU3YzqeuhJdiX9UN8/Ti4lx
	dxBggM4t8PZ1+B5VUkzhPkuKG36Jykgtfm4er6VyHMzuchcx9x7X
X-Gm-Gg: ASbGncv7OHMvsRVmClrYINaK0hplzNkPMIOR01KHhf9tNZIe4IiYFtk/Td3j73MR+k+
	9OxzBy7vJtfF4GDqkflkgYtZFsyqLBQaaOTZDHbH+GrGPbUfuUx/2onGOYyz75tGcljFcq4gSxa
	/oCgKsROx8vTQbXihp+NBDkB6HjA7ScGSqGbONUMRuwHa+NTZ23GicY6962EHjhezlQWORYHgKN
	8z5f/ziOBOnslQW+dZXLNCRkx5tq5F/MD/JkPbowpqemfZKS5xRWPywJQH6TjUHWmtsa10w+/ai
	0Jn/SFOjG00FpFEJPJ6aKcQ=
X-Google-Smtp-Source: AGHT+IEi3Q4xeR7kHGS4cMAwBlvUVlrmHcPIGbEFW0eApxuPTU//lvdPMsStXA+UwBu3ojCFQrj10g==
X-Received: by 2002:a05:600c:46ce:b0:434:fdbc:5ce5 with SMTP id 5b1f17b1804b1-43668b78d1fmr275895395e9.29.1735547472584;
        Mon, 30 Dec 2024 00:31:12 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289995sm346780575e9.36.2024.12.30.00.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 00:31:12 -0800 (PST)
Message-ID: <5b064644-bd21-445f-b46a-cfe82fe184db@grimberg.me>
Date: Mon, 30 Dec 2024 10:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] nvme-tcp: switch nvme_tcp_set_queue_io_cpu() to
 using cpumask_next_wrap()
To: Yury Norov <yury.norov@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-11-yury.norov@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241228184949.31582-11-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_003115_399325_946EE303 
X-CRM114-Status: GOOD (  16.45  )
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




On 28/12/2024 20:49, Yury Norov wrote:
> Calling cpumask_next_wrap_old() with starting CPU == -1 effectively
> is the same as request to find next CPU, wrapping around if needed.
>
> cpumask_next_wrap() is the proper replacement for that.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 054904376c3c..088101c57f53 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	if (wq_unbound)
>   		queue->io_cpu = WORK_CPU_UNBOUND;
>   	else
> -		queue->io_cpu = cpumask_next_wrap_old(n - 1, cpu_online_mask, -1, false);
> +		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask);
>   }
>   
>   static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)

Acked-by: Sagi Grimberg <sagi@grimberg.me>

Note that this will conflict with another outstanding patch:
https://lore.kernel.org/linux-nvme/20241224120457.576100-1-sagi@grimberg.me/T/#u 


