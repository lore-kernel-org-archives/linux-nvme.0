Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D916AC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJ9RcxcCkW2M7OPQ/OJGApyhr3Ci1CM13lpfXbD2VU0=; b=0v+zR5Jhoh8/xsrC5CR/ey79Qi
	ADd5NpxMwZvxVOrXySQE7Q8X8Lwb+pezL2sfi5YauFoo0ugbZn1t1r7gV2JilO5U0Pudl6NuFPDPm
	ApYwkCeIH5a9hcQ9yGtlQOEJPJ1F3nlL0i+RYSmIJeBgCWDBt3LRcXD/ZN0pQko3vVuDQin1KQQvb
	OQJI+9RAqKeII1wnxXYdc8PJANOL4WBP2SjE/lnOiNfS0TtAVQPsRQuH7fOBWT1FCMhiZkZjSykSh
	4oLVGn0Pg6If0Xhz2dU9aMfw6yrlFfCObwRYtkkyCsyao6FRLDn8DTyw5v4Dzi1XLw91CNVQsADKK
	Si3kUBnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot81z-006C4L-Lp; Thu, 10 Nov 2022 13:55:47 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot81w-006C1M-JA
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 13:55:46 +0000
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso4750276pjc.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Nov 2022 05:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ9RcxcCkW2M7OPQ/OJGApyhr3Ci1CM13lpfXbD2VU0=;
        b=UOfFvHnIDiCu0HqzK+oKurNlylWD8R28WYdw+OpALlIqhupx/zXZledxaa3H3oQN81
         uAtpQeR9gssMjyE1hBqVnHpTq8CRMd7KiQytmDn6uF4DY18uMnxLqjpQf4ogIXk4Y+vR
         3W9K1b/pnNZ6mpUhvxhYXlC+afQrxz/BTe+RZuBvWoNzywpLx9QeuUizkeVz37q2cx0l
         gdX+0xby/vhBUyOW5iGs7ruddeuSfZqM19vm76nFSVX64JRS9UIj7UE0/JZcC3qWKw/R
         hmbIm/YFamIbjPYJJSMgTm6ybdQodD2KDndWGi46W0sinTIc6pkjl6TWlcLItdy81Ovu
         JfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ9RcxcCkW2M7OPQ/OJGApyhr3Ci1CM13lpfXbD2VU0=;
        b=NOMygUovW7DV1BfH0jcjdSri8dVU1BybrMgq2naQ7v4+5gwPft8I9b6NTzU7xcsUzE
         0JnDfeJOlwHsvGzYJQQjhVUcuwrGDxR/SCHAH7yGDwzwI1OP+ZDUsDs9FrXLb0vA/dfZ
         uAyXehV5koUfEs3Swfrs/vAqapoAyDXcs0XIpwpQi/SRMB2TGp8PunUy8cJDZLAAR8OP
         8J8FYr9SS5MPiSbWgSo8cYY1mllnrtuLfYjU/vez5RxJGiJFhgDyGM6atXtvkDg1cfDT
         JFq8IOgiKuS7n2Wrr4EKSPfzrnxE6708ZzhnnP6yPQajZM3djXAo36eG+HcIshALQVvM
         W2AQ==
X-Gm-Message-State: ACrzQf3lBh+cCHFcnRJ+eh95KMHLkhseOFlpzpa84y0BLMVcQKAAzV+Z
	as//difW3jznt4caxEjVuseqdA==
X-Google-Smtp-Source: AMsMyM7atE7lTTwF9STan7M4HamFf6AO8qtlF/PgNBnvo15LitZ0xLgt7Fm65pCTXz4D+QkkIJTm2A==
X-Received: by 2002:a17:90b:3148:b0:214:199e:7e6f with SMTP id ip8-20020a17090b314800b00214199e7e6fmr46727295pjb.126.1668088541372;
        Thu, 10 Nov 2022 05:55:41 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b0056bb7d90f0fsm10212236pfr.182.2022.11.10.05.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:55:40 -0800 (PST)
Message-ID: <8f69c93b-f1dd-e9ea-5e4e-a4caed4b983a@kernel.dk>
Date: Thu, 10 Nov 2022 06:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] nvmes fixes for Linux 6.1
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y2zL45ll7KIIc0zF@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2zL45ll7KIIc0zF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_055544_882554_351E6C1D 
X-CRM114-Status: UNSURE (   8.75  )
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

On 11/10/22 3:01 AM, Christoph Hellwig wrote:
> The following changes since commit f829230dd51974c1f4478900ed30bb77ba530b40:
> 
>   block: sed-opal: kmalloc the cmd/resp buffers (2022-11-08 07:14:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-10

Pulled, thanks.

-- 
Jens Axboe



