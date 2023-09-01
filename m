Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F033CA0FE4
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Sep 2023 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vy/OYZjEThy9PnU+XOs2FP+vp54WWzeQiLbmJLp6KHo=; b=zrFhBmhMWC+TOUWuwp7vAIpk8w
	XC+sBJ9ZTBJoxafsEHd01OACVvHEhr8HvcAhwEIiq7Ur/dDJCtcRWHFIrCLnL1aAx3pmEbX3xi2d4
	v0k/AzXdy2AoAtZsCOV5RIgjEm/StlAiOSmt6Kj0dciexogU+VM4UyLOvA35mKvS0PRfK+qe4JWcg
	q6kT8EmO0nzK4g2VIWofIu4i7N9No5WTWzsIV/Ska6gPQ9p6RVtfSCHu/9ALRkid4SFZTWuGosJ4v
	sBLe2aquq/fil3y7jo8C8PQrkKnEyqy7WJpw9nKjkcdxF17gWuwnySHVIDJS4sXLqk5fNzk7DW3uW
	GN842u4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc6Ag-0006EV-2W;
	Fri, 01 Sep 2023 15:34:54 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc6Ac-0006DS-0y
	for linux-nvme@lists.infradead.org;
	Fri, 01 Sep 2023 15:34:52 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760dff4b701so19023339f.0
        for <linux-nvme@lists.infradead.org>; Fri, 01 Sep 2023 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693582489; x=1694187289; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy/OYZjEThy9PnU+XOs2FP+vp54WWzeQiLbmJLp6KHo=;
        b=NX5CFEj1OESu8HZ4O3X57JcxrwtYVjiMMhlIIL79gpyLh6odraxGPBeKPIluGBKLCx
         ABugTcZXtfSGzhuFehjtdDf4qdExEot1yd9amLeZyUwGJUn+D/MqxKe3R4bIYEbGdLDD
         +9hvGBVs8xOTLWWUYrvsc5sT/mMPkCG5gtFiIC3sPBK9DW8wSIBkuvWaueNjAh4NWr+n
         TVlQyExS4OX5dYc/PdpgbvM+LlkHXUzfXFmV2qpfT5euCfA+NX+Uoo1mde/1L+Q0vHC8
         7GKEQXKD9ahfkTtvPVtF0cNMNrjlzLliWS00PKR1CFIQY0KW2r54Ddzf1uOJt4BKotMW
         VPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582489; x=1694187289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy/OYZjEThy9PnU+XOs2FP+vp54WWzeQiLbmJLp6KHo=;
        b=eLHVw5JBg+G/6Eetbrbs1JhDOq19WLktLchXZyfHES5thU+Qx+gEUTgvdg/nM9l1YQ
         /cYlLYry14eRI9JG7nRlFMiOd7NdJh6pxlfkBhWdnp6FFQv+Dh0AFkdtohWTL5OEm++R
         7qLetlOTFvlmXne7lWv0xYdMBhSB7+e9EgCChlMp5Sf74uJST4nZHes0E4ILEiBx2NV5
         sL1iGxzrMUDsHu7CPqT8GlejXiPzWMBhwftcIx8HTH5ZmsnZO5a7j6k3ZmWREVqD6C/t
         NcskkoHKubcCEZ4PJBJC06yRwd5YXKzoZOORNxP9IRiCzu4VYezPqV3sTBi0trnaNrdL
         8oqQ==
X-Gm-Message-State: AOJu0Yx8zHUVutheCguRD6fIRNx9jBnOJE55lT6ulArS18DbQgNjSuDC
	3TJhgwXos6kALbfLjPR4LwLtZw==
X-Google-Smtp-Source: AGHT+IE25sW9iNQNVMCxEyOy37iHO5xdtl+9ffputSUWi9pZwG7+OF/RT+RNDdNOXuIZcLLsJ4GQow==
X-Received: by 2002:a6b:1495:0:b0:790:958e:a667 with SMTP id 143-20020a6b1495000000b00790958ea667mr2898469iou.2.1693582488777;
        Fri, 01 Sep 2023 08:34:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c16-20020a5ea910000000b0079263d9b6a8sm1113234iod.11.2023.09.01.08.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:34:48 -0700 (PDT)
Message-ID: <3969ed5a-b422-4b27-bff4-1db38d9d238b@kernel.dk>
Date: Fri, 1 Sep 2023 09:34:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] lib/group_cpus.c: avoid to acquire cpu hotplug lock in
 group_cpus_evenly
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20230831093754.2322955-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230831093754.2322955-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_083450_342141_F4172250 
X-CRM114-Status: GOOD (  13.08  )
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

On 8/31/23 3:37 AM, Ming Lei wrote:
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
> 
> Then dead lock is caused:
> 
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
> 
> 2) error handler is waiting for CPU hotplug lock
> 
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
> 
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.
> 
> Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


