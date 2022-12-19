Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F72C10F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50qS+Meg+WNTr0FfcIwcNdGuzDQP1jY8Tm+rHFTPGf0=; b=ZAbEiKDqvubcKkEO+KWDmliOZd
	Irqa200Qjzzi621SCz9GUjH3Qqx1XyUaHIsN8kWPSvvleZ/qqEFzkeeK0O341EfWSEfwjH7okmrIL
	1BKdRhMfiKe7bx9kFre6qRfkXqNX7Lefb1yYxdOEVVHiSCXHVwX7jOvynGegPopzQcG4NNgbf/V3M
	x9/xywQveo2sgl4j+U57IHjDQSAziadHjxni+0V1GrJDtkTzk8OqNov0UYPA42OX2MFxgviUlWLHc
	qJbgpKjar4G9Ry5BqhsFkT4HR4szUIe2GvhGJvGcVqM/Kf+yLVxRwFQEjHgahQrlTE6YkJ5vM7axO
	ZC+st0RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7BMI-00ASkM-9N; Mon, 19 Dec 2022 08:18:50 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7BMA-00ASVM-0P
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 08:18:43 +0000
Received: by mail-wr1-f54.google.com with SMTP id f18so7807125wrj.5
        for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 00:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50qS+Meg+WNTr0FfcIwcNdGuzDQP1jY8Tm+rHFTPGf0=;
        b=kLcGFOtsFWfDFK19NAXZnJ+S+GJ17UF6hn9opGeLypJWg2l4+cG1dY7/mG4HkPyxA3
         bv5jPzdEY/9Trdc+Awtthvenst2uOalSoiYlBCv+5PX+6QiAUxELVwSAvGjggGtJSVS+
         iWflsaRuo9La86oQ2eunfKx4pmXALJY0XeAGz9IBnF9QS+ElpvXoUfdDHrv83M47w1Ck
         mPZpNRkpsxyoYZeMgleNkCZ9mIhGFXGrF1i8ABLKkgqYpDSKsOvN+ACFYm72lv/IEdmC
         D80EG/nreqa0NmhoSKoecNdi7KLtq1K3+Es5OJeZ6WgwSWy85pzHeZlMZM7eGeJmqlb5
         EE6g==
X-Gm-Message-State: ANoB5plFVcp/a0una8kM6sQVMHZRuPlA+jaAb43jFHdJof1wU3wez5Rx
	qMzq9ZNQmqpSnEbxbU31jns=
X-Google-Smtp-Source: AA0mqf7zEeubaDizxf07nE9uYcD5bxd2huDS1UmEm+daFFYP8cj+gvIwJEyJ7l5D8eVm5mhNi4gbeQ==
X-Received: by 2002:adf:fcca:0:b0:242:3473:2fe0 with SMTP id f10-20020adffcca000000b0024234732fe0mr21753184wrs.71.1671437910651;
        Mon, 19 Dec 2022 00:18:30 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b0024165454262sm9292231wrz.11.2022.12.19.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 00:18:30 -0800 (PST)
Message-ID: <b21afbbd-c806-72e9-c064-483df1335a45@grimberg.me>
Date: Mon, 19 Dec 2022 10:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: fix multipath crash caused by flush request when
 blktrace is enabled
To: zhangyanjun@cestc.cn, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221218144807.6383-1-zhangyanjun@cestc.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221218144807.6383-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_001842_218949_609BC6BA 
X-CRM114-Status: GOOD (  23.22  )
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



On 12/18/22 16:48, zhangyanjun@cestc.cn wrote:
> From: Yanjun Zhang <zhangyanjun@cestc.cn>
> 
> The flush request initialized by blk_kick_flush has NULL bio,
> and it may be dealt with nvme_end_req during io completion.
> When blktrace is enabled, nvme_trace_bio_complete with multipath
> activated trying to access NULL pointer bio from flush request
> results in the following crash:
> 
> [ 2517.831677] BUG: kernel NULL pointer dereference, address: 000000000000001a
> [ 2517.835213] #PF: supervisor read access in kernel mode
> [ 2517.838724] #PF: error_code(0x0000) - not-present page
> [ 2517.842222] PGD 7b2d51067 P4D 0
> [ 2517.845684] Oops: 0000 [#1] SMP NOPTI
> [ 2517.849125] CPU: 2 PID: 732 Comm: kworker/2:1H Kdump: loaded Tainted: G S                5.15.67-0.cl9.x86_64 #1
> [ 2517.852723] Hardware name: XFUSION 2288H V6/BC13MBSBC, BIOS 1.13 07/27/2022
> [ 2517.856358] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [ 2517.859993] RIP: 0010:blk_add_trace_bio_complete+0x6/0x30
> [ 2517.863628] Code: 1f 44 00 00 48 8b 46 08 31 c9 ba 04 00 10 00 48 8b 80 50 03 00 00 48 8b 78 50 e9 e5 fe ff ff 0f 1f 44 00 00 41 54 49 89 f4 55 <0f> b6 7a 1a 48 89 d5 e8 3e 1c 2b 00 48 89 ee 4c 89 e7 5d 89 c1 ba
> [ 2517.871269] RSP: 0018:ff7f6a008d9dbcd0 EFLAGS: 00010286
> [ 2517.875081] RAX: ff3d5b4be00b1d50 RBX: 0000000002040002 RCX: ff3d5b0a270f2000
> [ 2517.878966] RDX: 0000000000000000 RSI: ff3d5b0b021fb9f8 RDI: 0000000000000000
> [ 2517.882849] RBP: ff3d5b0b96a6fa00 R08: 0000000000000001 R09: 0000000000000000
> [ 2517.886718] R10: 000000000000000c R11: 000000000000000c R12: ff3d5b0b021fb9f8
> [ 2517.890575] R13: 0000000002000000 R14: ff3d5b0b021fb1b0 R15: 0000000000000018
> [ 2517.894434] FS:  0000000000000000(0000) GS:ff3d5b42bfc80000(0000) knlGS:0000000000000000
> [ 2517.898299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2517.902157] CR2: 000000000000001a CR3: 00000004f023e005 CR4: 0000000000771ee0
> [ 2517.906053] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2517.909930] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2517.913761] PKRU: 55555554
> [ 2517.917558] Call Trace:
> [ 2517.921294]  <TASK>
> [ 2517.924982]  nvme_complete_rq+0x1c3/0x1e0 [nvme_core]
> [ 2517.928715]  nvme_tcp_recv_pdu+0x4d7/0x540 [nvme_tcp]
> [ 2517.932442]  nvme_tcp_recv_skb+0x4f/0x240 [nvme_tcp]
> [ 2517.936137]  ? nvme_tcp_recv_pdu+0x540/0x540 [nvme_tcp]
> [ 2517.939830]  tcp_read_sock+0x9c/0x260
> [ 2517.943486]  nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
> [ 2517.947173]  nvme_tcp_io_work+0x64/0x90 [nvme_tcp]
> [ 2517.950834]  process_one_work+0x1e8/0x390
> [ 2517.954473]  worker_thread+0x53/0x3c0
> [ 2517.958069]  ? process_one_work+0x390/0x390
> [ 2517.961655]  kthread+0x10c/0x130
> [ 2517.965211]  ? set_kthread_struct+0x40/0x40
> [ 2517.968760]  ret_from_fork+0x1f/0x30
> [ 2517.975745]  <TASK>
> 
> To avoid this situation, add one more req->cmd_flags check with
> REQ_OP_FLUSH before calling trace_block_bio_complete.
> 
> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
> ---
>   drivers/nvme/host/nvme.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a29877217..69b7a2b57 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -888,7 +888,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
>   
> -	if (req->cmd_flags & REQ_NVME_MPATH)
> +	if (req->cmd_flags & REQ_NVME_MPATH && req_op(req) != REQ_OP_FLUSH)

I'd say that it would be better to have a proper interface to this
question and export is_flush_rq to use here.

