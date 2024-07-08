Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6213C3DA42
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Jny6GEOV2wfe9Ou/EU5olj7Tsvr8SWqOsqJEzTXeMg=; b=E6+jG/5koavg5IyYpVSnvpYNGH
	UXUipOvlSZmX8TY1SKwn1VQcGZGxoK4uWwMm8EhATSI6NTG7dWg++ivHuTmul4bhI27aRLRlyZyDR
	WLANRFOeRUeixOfjVCL/kza7es++XWOPqNquvmiNaou2rbWAMBehEU/O+v6B4dmls6ngx8jX85Vuc
	2XNfqaPV3WOecRUIkcHQk5NlLgVdX+Fqky+sXmdPwAZf8JpFfzmOGmwUVDXF9+CXbg4qS5QBcQ5SW
	ZLNVA/fmedT1z/W4RjIrPcvQpebuYcj/Deusk1RGSADHbkd9LUQHZASHZh7e/O7WDg/hzzzi+vjav
	m2I6Eokg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnED-00000003jld-0nS4;
	Mon, 08 Jul 2024 12:12:21 +0000
Received: from mail-lf1-f48.google.com ([209.85.167.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnEA-00000003jkg-3aKk
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 12:12:20 +0000
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea333534cso252873e87.3
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 05:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440737; x=1721045537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Jny6GEOV2wfe9Ou/EU5olj7Tsvr8SWqOsqJEzTXeMg=;
        b=rTgm/1cBOjb1kg/8MqGPkLD6noGk1h82pBpJzFEYFoOq8FQlZihoE05Q/yLmZo4SL6
         HwnYG6sKfWlvtNO/Qk6m6rv7hVvmfhUQ+pEj2sYkbgmrFgq1jUnYwlsULdIe5JEj1l93
         ONn5uUTB3HF5eNKeezmlkZa5klAldJZxQ+6ogK6nn0Ajzukjv6ETewvD/eWxWdQo0N/V
         216O2ddiWEXJK/MPFahbGLfSl4AHWAgV/Gez+YakHKvpEuapGdPsdYFtRHP7mubC0SJ4
         BKjc1wvLHL8XP5on52vj3NADFgZlmAW2HIdL6ZF14s1pKBMPQ+RjUJUp9TqRNs1ez72s
         Ys5g==
X-Forwarded-Encrypted: i=1; AJvYcCXMABCaMQpHSdey2Mq6IVkHFaqUJ95MFmsiK7IhgjJPe+UvYDjBT6I0V10e7H55z8PxLaY90AiV2y87R7FzBkF2HUJ6bse6HRmzxAG1FnQ=
X-Gm-Message-State: AOJu0Yzhr7hjwWIv+rauPUzpfjPEa+fTRw46/CRoBaz67bsSGIg9ofKN
	ZhFhx7WPRM2q4TN+Ctmr8sVYJNWalJ/Bwje7Ft/gKdNXqTFb6Tqj
X-Google-Smtp-Source: AGHT+IGuFziqObhRfw/moAnORC99YcJGIx15R4TY9fzomjzuKgnQAEaVRk89AqktvLcWvT99nPT9ww==
X-Received: by 2002:a19:4308:0:b0:52c:ce28:82bf with SMTP id 2adb3069b0e04-52ea075dd8bmr6076026e87.5.1720440736557;
        Mon, 08 Jul 2024 05:12:16 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426697db10fsm40044565e9.40.2024.07.08.05.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:12:16 -0700 (PDT)
Message-ID: <15107646-6467-46af-8fd8-5d83225612ee@grimberg.me>
Date: Mon, 8 Jul 2024 15:12:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: per-controller I/O workqueues
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240708071013.69984-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_051218_926680_EB9C6522 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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



On 08/07/2024 10:10, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Implement per-controller I/O workqueues to reduce workqueue contention
> during I/O and improve I/O performance.
>
> Performance comparison:
>                 baseline rx/tx    blk-mq   multiple workqueues
> 4k seq write:  449MiB/s 480MiB/s 524MiB/s 540MiB/s
> 4k rand write: 410MiB/s 481MiB/s 524MiB/s 539MiB/s
> 4k seq read:   478MiB/s 481MiB/s 566MiB/s 582MiB/s
> 4k rand read:  547MiB/s 480MiB/s 511MiB/s 633MiB/s

I am still puzzled by this one.

This is for 2 controllers? or more?
It is intresting that the rand read sees higher boost from the seq read.
Is this a nature of the SSD? What happens with null_blk ?

CCing Tejun. Is it possible that using two different workqueues
for a symmetrical workload is better than a single global workqueue?

