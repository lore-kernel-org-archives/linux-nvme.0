Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE4DECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rshYd4dUtWMzJUNDvjpHRZD3bgRUnkncQnT1dG/c594=; b=RDgEjDWt6Ix66iHRLKrJ+kquBM
	qFxAuIBhJ/X3bdjBei7Wdm2UaFtgIDw4KvTeyVxYoZ+1DJzzZehSnp7bcZsbYSHgqAt548ikwgz/x
	HdKl/CC/XNTvQ+j0XbqukcLWyXOXqADbYY7XRF5tFbTowXx+NXCo82ueNXohjt/Dqqbwv/vQTafFi
	KGDWbrlCnsROQ+vmqjTKFrRTs/Ygk08UztljJ/+gegQhS6KhMlEq48oRwMYiseZH7R44NKun5U510
	GKMzYOlHbSxEzlmET/HicOetMsluysusPN90OdOBlyLpOWBl/GtMLuD8WkTlDiAmImtwvUj3RayqJ
	OOBfV5lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT1J9-00HNai-E5; Tue, 30 Aug 2022 13:29:35 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT1J6-00HNZO-40
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 13:29:33 +0000
Received: by mail-wr1-f42.google.com with SMTP id bq11so14219230wrb.12
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 06:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rshYd4dUtWMzJUNDvjpHRZD3bgRUnkncQnT1dG/c594=;
        b=LDwbneRLthQReE7DZIdkbwZ7Vvh5lTaJ8FXnzWBdG9l1EFx3FVt9yr/Rtwu7Gi+x1K
         KKQk/Yir++yCMf1/XepJrvkHXs/ve5x2LdijnSNtGVGQ4Qhhu1Z/yjz41jywxV2r40kr
         /XwiRYiEzTfp0SBIDXGUgrGnVVkGAs6bYsL9O4emIOxD4d1I1Aa8dHX/Ue+GO6O1gnFy
         jxu1WL1wsLgMsM9N+v7fn3gJLkw09VtNE01GJZhIha2/5e4xPUYTDY6iZuXL4mtW3YbH
         +YlzFvpiMYnOpmvco5a73HJ9JmZKhapNemVh7U+DlB2VUJ0+kCNBHYwmUzrDb59vahqK
         XIVQ==
X-Gm-Message-State: ACgBeo2dHP7RNUnuWoRsiT6VtuWRMLfT8hGvz3ZF7niEBoXVrSx5aT6b
	N55qAZjDr+By5NjcVhXiTuL/cpP10FI=
X-Google-Smtp-Source: AA6agR5MGTWN0mrrVYC+h8g/kkurbZkP+cd2N0epztHYidcPtnlfCnh70/GQyMofYvL9T2UfO3UANg==
X-Received: by 2002:a5d:64e5:0:b0:220:7859:7bc with SMTP id g5-20020a5d64e5000000b00220785907bcmr8502943wri.669.1661866170257;
        Tue, 30 Aug 2022 06:29:30 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002250c35826dsm9544008wrr.104.2022.08.30.06.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:29:25 -0700 (PDT)
Message-ID: <dd59a485-3ff0-86f8-5675-073174931c80@grimberg.me>
Date: Tue, 30 Aug 2022 16:29:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-tcp: Fix NULL pointer dereference during release
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20220830083628.499028-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830083628.499028-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_062932_204369_15E5260D 
X-CRM114-Status: GOOD (  22.01  )
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



On 8/30/22 11:36, zhenwei pi wrote:
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

This data access is specific to data-digest, because at this point there
is no way for the data to be sent down the wire as the socket is shut
down.

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
> To fix this issue, free CMD buffers until all the inflight IO
> complete.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index dc3b4dc8fe08..2325246e3b4d 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1449,8 +1449,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	/* stop accepting incoming data */
>   	queue->rcv_state = NVMET_TCP_RECV_ERR;
>   
> -	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
> +	nvmet_tcp_uninit_data_in_cmds(queue);

We still need to uninit the nvmet request so nvmet_sq_destroy()
can complete. Please separate nvmet_tcp_uninit_data_in_cmds to
uninit and free potions, only the free should go after the sq_destroy.

