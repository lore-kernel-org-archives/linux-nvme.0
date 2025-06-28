Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E24DC7EE32
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Jun 2025 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAeip+ZgoQPXyxkDsAJDwje6lfQ4g6jf4qqXOmEFdYg=; b=mIetRcAipiz7vfOG0NvXPXxOCU
	pkUeKOIabfDJflfzDatyhVnfSThPxA5A/ejHVZCAUovtsaFton5sFMCMjho6wCgBbc2xmEmQOWnTR
	lMcYkp74IQLg3jB5eIb5r7RufHjppx2JciIFVL0QIfRadHDhAF8C0ttqsvPayxFoL2CH3A+lJCjsK
	LKDbzH9J1pD31xUTsLjJdeJOGpptUBbkId+KldxD76kdxQO5UpL/HmF5FANjq6R4NHzkC14ilmuNx
	8wsrUSQL7gNURJ7F41FcL3w8lG3DJTczmCXuOtWONcMUv4IU6olvh5HoGLwdOarphd+T4SpuLw1VC
	YCUe9U8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVSZB-0000000Gg5O-172L;
	Sat, 28 Jun 2025 10:13:49 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVSZ8-0000000Gg53-3kBL
	for linux-nvme@lists.infradead.org;
	Sat, 28 Jun 2025 10:13:48 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453426170b6so20927545e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 28 Jun 2025 03:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751105625; x=1751710425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAeip+ZgoQPXyxkDsAJDwje6lfQ4g6jf4qqXOmEFdYg=;
        b=BmQ03S0ZEJ/8kTW+WeEL2rSldo1rG+vEL/wvSbolKz5qA1ISII6b4hZb78T+tRA68c
         n4Wj+GLVlQy+wgvpAszCDmtrnhH3c2BJ2c6HLajvOt0WBSqPJ0njMvhDZdvcQPBkD9E/
         l36xGvlTBXMw25P8nv59zztb26fh8btmqsRIjtapNDslJzuXwV49EAKI/fTun2+7DOsj
         B+5XSfvuCBMKBD6As25djTH4TNqMRuVluhBh1QQqxXLxmcLtscevV0+fXT1KEMw5Qut8
         6CdJwCrFjLyt0BFH90dq99s8KPyh70cp6ECgyHoWKdvAm4DHzxz+8l13CkeaEs6yLF+O
         snpg==
X-Forwarded-Encrypted: i=1; AJvYcCXo1AjbaSqxVwuMwiLsMadqBWRtt1qcGCDjiaYg8Tmpt5pLIi3okG0JpfgBAvm5L57X3Uo0HBeNo1uX@lists.infradead.org
X-Gm-Message-State: AOJu0YwB/R6B4p881TuKJ/IaSDQLoWRByuC2+W1CTmngZWCV6pHAagGE
	wR3RxBU9sXg7y45ulIoucPqwog1fSGeXZW7EEHOTYB9IDDqa2L+eqFO2
X-Gm-Gg: ASbGncsKZwrsxhH6C59ZH7AhE7z10gda8eZdyPQ9a9HHAhmENgmT3My5i1GoD1NoAbQ
	T4OSruyvsJEzP3YOyFZCC0nTBDyooQ5R9ilGI1yDecg8q4mEqdvREDzhXkJ0M+n6OBmW4S4eSb+
	e9THEG3RtBwsKSNTbgoUQa84bYl372mZG3EzM9Zv85jOvVhef8/gy7U0q8EiS0XZyW3CDVHN/UP
	9oJ4oEtuIZNCxl5fuW/kYSIFAQ+QL9dvXzCE/tjHPF5jbwcZz+4Mdr3tzxmpSHFg3Ldih6wqr0+
	tL7X8pXx+hWTKq1O9qXZpF7aRiTRpMhl2SfayLcBChgDmvTANAEpI8djYpTLxNe2EuP2/bZKpdV
	RujbIQNhZl+ABEMFYg8Z2gA==
X-Google-Smtp-Source: AGHT+IGv3C9+CbOxvwovO1McDRPkuH/sVtjblzbZ/xKR7LXlp4Iz5f6FbX/7Cnv0QsRt2HxPje/tCw==
X-Received: by 2002:a05:600c:3b2a:b0:453:7713:476c with SMTP id 5b1f17b1804b1-4538f2bfb46mr62616475e9.2.1751105624590;
        Sat, 28 Jun 2025 03:13:44 -0700 (PDT)
Received: from [10.100.102.74] (89-138-75-164.bb.netvision.net.il. [89.138.75.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad1adsm106139235e9.24.2025.06.28.03.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 03:13:44 -0700 (PDT)
Message-ID: <af65c545-a108-4045-874e-c67f894a3235@grimberg.me>
Date: Sat, 28 Jun 2025 13:13:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: clear nvme request for nonready request
To: Yu Kuai <yukuai1@huaweicloud.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: yi.zhang@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250628064634.3823093-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250628064634.3823093-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250628_031346_940730_53DC4EEB 
X-CRM114-Status: GOOD (  18.42  )
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

First, we need change the patch title to clarify that it fixes a bug.

i.e. something like:
nvme: fix nvme-mpath misaccounting of inflight active IO

Second, we need to add a fixes tag (i.e. addition of nvme-mpath 
nr_active accounting)

Third, we need a code-comment that explains this subtlety because it is 
not trivial.

On 28/06/2025 9:46, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> It's found nvme mpath IO inflight counter can be decreased to negtive by
> following stack:
>
> CPU: 12 UID: 0 PID: 466 Comm: kworker/12:1H Tainted: G
>     6.16.0-rc3.yu+ #2 PREEMPT(voluntary)
> Workqueue: kblockd blk_mq_run_work_fn
> RIP: 0010:bdev_end_io_acct+0x494/0x5c0
> Call Trace:
>   <TASK>
>   nvme_end_req+0x4d/0x70 [nvme_core]
>   nvme_failover_req+0x3bd/0x530 [nvme_core]
>   nvme_fail_nonready_command+0x12c/0x170 [nvme_core]
>   nvme_fc_queue_rq+0x463/0x720 [nvme_fc]
>   blk_mq_dispatch_rq_list+0x358/0x1260
>   __blk_mq_sched_dispatch_requests+0x2dd/0x480
>   blk_mq_sched_dispatch_requests+0xa6/0x140
>   blk_mq_run_work_fn+0x1bb/0x2a0
>   process_one_work+0x8ca/0x1950
>   worker_thread+0x58d/0xcf0
>   kthread+0x3d5/0x7a0
>   ret_from_fork+0x403/0x510
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>
> The IO inflight counter is not increased from nvme_fail_nonready_command()
> yet, hence decrease it will cause it to be negative.
>
> This is not a problem for blk-mq request because it's already
> initialized before issuing, however, nvme request is only initialized from
> following nvme_setup_cmd(). Fix the problem by clearing it in
> nvme_fail_nonready_command().
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs_+dauobyYyP805t33WMJVzOWj=7+51p4_j9rA63D9sog@mail.gmail.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/nvme/host/core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 92697f98c601..8caafa25c010 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -764,6 +764,9 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
>   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> +
> +	if (!(rq->rq_flags & RQF_DONTPREP))
> +		nvme_clear_nvme_request(rq);
>   	return nvme_host_path_error(rq);
>   }
>   EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);


