Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FADC6FA86
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QOL+oMNg0eM0tTAE71ld0QPIqQDtfEjtKFkdkyTQhU8=; b=fe86o/mvoVsZJz8Z+gqFJeTB+c
	aavb258KeQc9hvnG3KEDiEaHwKwPYM/Wl+Z0PCpL0Gm7CDBoEU0UqyI1VWvtV/gkglk2sUStTdgde
	DQH3YG3M++aXEKfq2Hq0GRAjfyOvIwXS4qSxW41foZVxWjhhh6XkWGvids+iDazGCZphalV3Gslxw
	TjKjPuieK5B14JV3pR9S7TOOCC6MQc/4nT4PyFe7FTabz/U+4z/L5KnY7m2BJcqdRmuUGNIK+YScX
	Fwcd6OfYyRi+hsnh8ZrTU9JB8CNRw79rWiNJ7CMIls2EGxnOcVBJaNaj3sekPo+f9nZC8jZSMQ7tw
	KQAvftjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPsu-00FKnj-8G; Wed, 14 Sep 2022 10:44:48 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYPsr-00FKjf-Ge
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 10:44:46 +0000
Received: by mail-wr1-f41.google.com with SMTP id b5so24986587wrr.5
        for <linux-nvme@lists.infradead.org>; Wed, 14 Sep 2022 03:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QOL+oMNg0eM0tTAE71ld0QPIqQDtfEjtKFkdkyTQhU8=;
        b=MorYCHVStmRN+7HnWKSlj1/B7fuSZGcl3TciWA2Qelh9ikSFR8GogmvnHSlnvVzsVV
         oE8ZgVeW7R0nGU4/UCIyVbtXdvUeAte5E/U2OTdfcSQtX5aNEHeljugKOyKuqI9ty4ET
         L2v+N2rzoWq01wquaqJy9nhDDlCnxPC0GtVmkGQv1go1wP8aZcxwExwwVmAlzhwngAau
         Q8wGMi9EwK3E5S+SmLULiTPIY2crz/vb6u97oPPCT7RLcypu1WjbIkWl3nld0xsqpaZ9
         KypuvxmYR0GHWI1wHCqrdBFEDdce5YT7mEBwadL+T8HtK22Jkd5x2Gvxex2E8LSgb/Wc
         mRlQ==
X-Gm-Message-State: ACgBeo3ZNaUelTrnLJn754glVy6S6hW22cAnVogVC98AIMnkUWJdH7US
	R3ODtSJCcaTfjnwoiQjUaqk=
X-Google-Smtp-Source: AA6agR5hggG1w1ie4m5/qGfpPM6I176LS3LXTZ7FXZkrQh7NWVRUy5TQGGY3eCREse2cj5hP0ldGiA==
X-Received: by 2002:a05:6000:2c5:b0:225:618e:1708 with SMTP id o5-20020a05600002c500b00225618e1708mr22022909wry.510.1663152282539;
        Wed, 14 Sep 2022 03:44:42 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003b47ff307e1sm11793345wmg.31.2022.09.14.03.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 03:44:42 -0700 (PDT)
Message-ID: <b3362f45-fcb5-4ace-16e5-97a77ca3ca10@grimberg.me>
Date: Wed, 14 Sep 2022 13:44:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com
References: <20220913014253.931724-1-pizhenwei@bytedance.com>
 <20220913014253.931724-2-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220913014253.931724-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_034445_582182_D7D5290A 
X-CRM114-Status: GOOD (  23.04  )
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



On 9/13/22 04:42, zhenwei pi wrote:
> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>   RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
>   RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
>   RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>   R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
>   FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
>   Call Trace:
>    <TASK>
>    nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
>    ? __switch_to+0x106/0x420
>    process_one_work+0x1ae/0x380
>    ? process_one_work+0x380/0x380
>    worker_thread+0x30/0x360
>    ? process_one_work+0x380/0x380
>    kthread+0xe6/0x110
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x1f/0x30
> 
> Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
> steps:
>    uninit data in cmds                  <- new step 1
>    nvmet_sq_destroy();
>    cancel_work_sync(&queue->io_work);
>    free CMD buffers                     <- new step 2
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/tcp.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a3694a32f6d5..3ac9750b41ad 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1423,14 +1423,29 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
>   			nvmet_req_uninit(&cmd->req);
> +	}
> +
> +	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
> +		/* failed in connect */
> +		nvmet_req_uninit(&queue->connect.req);
> +	}
> +}
>   
> +static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
> +{
> +	struct nvmet_tcp_cmd *cmd = queue->cmds;
> +	int i;
> +
> +	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
> +		if (!nvmet_tcp_need_data_in(cmd))
> +			continue;
>   		nvmet_tcp_unmap_pdu_iovec(cmd);

This will cause a merge conflict, because nvme-6.1
nvmet_tcp_unmap_pdu_iovec does no longer exist.

Other than that, looks fine to me,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

