Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE36C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jan 2023 08:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OijiV6OVzQQXZXQcRcFVtee1iCbxYaJU5KIGDnpPPw=; b=bOlW5Dh13UeIRznJvM5mS92KBa
	6riwpJnYpOQYoujBmg3yTh9xybcMAzjj2DY9yhpwibOnjv+Un37Sh2BrZc7saBOYiCGUg1QT1a1ww
	5/hF4u4RDF/RDCGUQh3S4N5EEU00EKyz8IcJv8uGCZM6o61KpmlpYM3fmL+OySz6d652UrDMlm0Sy
	sEVmM2s5nIF7sg63tV5vkqqPIogQTsUfUTsutkLoC6kMkR4T//RWStcsIV+Y/dwmn9GoK4cCIzZhE
	CTis4Rx5JxrZUOapMU0/ZPImoKX0vyev5c65qFcWYWbifQqNIq0XmA8pxl6mDrecQ4CYU3bGO6Gdv
	XHYDHlRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzOt-007kPW-Ee; Wed, 04 Jan 2023 08:45:31 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzNl-007jsw-6U
	for linux-nvme@lists.infradead.org; Wed, 04 Jan 2023 08:44:23 +0000
Received: by mail-pj1-x102c.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so861261pjb.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jan 2023 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OijiV6OVzQQXZXQcRcFVtee1iCbxYaJU5KIGDnpPPw=;
        b=d0laUTYmkQEtQsFQlPIFUQ8QOuWDtfodcYFCnA+0nes8SVHLJ0QcsebA1o/thtIWwN
         B8QqOdo+Jx2STcVjktJFcW5XxawhpJcdSPxjAdIailb2PQ10UzdGzX8lrGe+6jL+HGrq
         wdQGKlUxrHbub1XTPjjrvgr5ciYwx0y4u4xpGrMcbhTCFfIqcjURe5qeIQ7haDiAvldC
         kudptHnCd8BSaCGh3YarA0HeOJ7OURfpopwvuevjWdzyC50tsGUZFL67Nx3ZGsBkDmyq
         lCwxqlw57ocT5JsGbRaG2olkWjEpS0N1LdiKZ+PhII8uyAIIoLEep7aWTDo38IPcxZdV
         GVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OijiV6OVzQQXZXQcRcFVtee1iCbxYaJU5KIGDnpPPw=;
        b=PCquBtP4riUmIvqXuwsaaY/YCM/2v16b+vbIuhkUIkRamrzq3PmlGfBaxrzA9kKQLF
         pXWMmpc733r9Fcz9GZpnT4E7RNJtjr3jNeTZ0AYUwCMHFLFUizzQqFVWQnHyV2oXJhan
         GGxtL3sYegmTvrpyrJjf0vSt4nPqwwA9zovUk58d8lMYt0qXaM7MlsFtlhTRQTKlNqAj
         8NmjGnVj6msUUkTfKNvGWHYmmKgMPiP4IX1OFc2S/DSKR4fohrAIBM7HTnrswm0TONYt
         oo1W2MUIFSXRcMo9dTtSYYCu1nZOawilVCYaqu/6bQXWogYhYLYb0u3DxUzjTCOPtsq+
         Xz5w==
X-Gm-Message-State: AFqh2kolOerkGfaXAQvfshWGnuOlTvkMFGTvVO862Cy/1SbBnZ+4uyso
	O6U6SrjwP6D3SlIMiUsFHv8=
X-Google-Smtp-Source: AMrXdXvWOTjtEIyG7dTs7fjwwCK1D2kmp3r80xO0ahDgDU06+vyiIu6LhWhFQTEgovNPnh2BOPZvGQ==
X-Received: by 2002:a17:90b:280d:b0:21a:1f5f:e798 with SMTP id qb13-20020a17090b280d00b0021a1f5fe798mr52484456pjb.48.1672821857777;
        Wed, 04 Jan 2023 00:44:17 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d31-20020a17090a6f2200b00223f0592e81sm16980605pjk.4.2023.01.04.00.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 00:44:17 -0800 (PST)
Message-ID: <f9754b2f-a260-9d38-355d-8923399c1e7c@gmail.com>
Date: Wed, 4 Jan 2023 17:44:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] nvmet-tcp: fix memory leak in
 nvmet_tcp_free_cmd_data_in_buffers()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, kch@nvidia.com
Cc: larrystevenwise@gmail.com, anthony.j.knapp@intel.com,
 pizhenwei@bytedance.com
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-5-ap420073@gmail.com>
 <f49ee5c1-cea7-86fc-b92a-4423a94389be@grimberg.me>
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <f49ee5c1-cea7-86fc-b92a-4423a94389be@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_004421_465286_E3A369C4 
X-CRM114-Status: GOOD (  29.31  )
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

Hi Sagi,
Thank you so much for your review!

On 1/3/23 19:54, Sagi Grimberg wrote:
 >
 >> While tcp socket is being released, nvmet_tcp_release_queue_work() is
 >> called.
 >> It calls nvmet_tcp_free_cmd_data_in_buffers() to free CMD resources.
 >> But it may skip freeing resources due to unnecessary condition checks.
 >> So, the memory leak will occur.
 >>
 >> In order to fix this problem, it removes unnecessary condition checks
 >> in nvmet_tcp_free_cmd_data_in_buffers().
 >>
 >> This memory leak issue will occur in the target machine when a host
 >> sends reset command to a target.
 >>
 >> Reproducer:
 >>     while :
 >>     do
 >>         echo 1 > /sys/class/nvme/nvme<NS>/reset_controller
 >>     done
 >>
 >> unreferenced object 0xffff88814a5c6da0 (size 32):
 >>    comm "kworker/2:1H", pid 176, jiffies 4305953739 (age 72707.743s)
 >>    hex dump (first 32 bytes):
 >>      82 84 c8 04 00 ea ff ff 00 00 00 00 00 04 00 00  ................
 >>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 >>    backtrace:
 >>      [<ffffffffaa795cf7>] __kmalloc+0x47/0xc0
 >>      [<ffffffffab030a72>] sgl_alloc_order+0x82/0x3a0
 >>      [<ffffffffc086593c>] nvmet_tcp_map_data+0x1bc/0x570 [nvmet_tcp]
 >>      [<ffffffffc086a7d4>] nvmet_tcp_try_recv_pdu+0x7f4/0x1e20 
[nvmet_tcp]
 >>      [<ffffffffc086c5a0>] nvmet_tcp_io_work+0x120/0x3272 [nvmet_tcp]
 >>      [<ffffffffaa1b059d>] process_one_work+0x81d/0x1450
 >>      [<ffffffffaa1b177c>] worker_thread+0x5ac/0xed0
 >>      [<ffffffffaa1c8ccf>] kthread+0x29f/0x340
 >>      [<ffffffffaa0034cf>] ret_from_fork+0x1f/0x30
 >> unreferenced object 0xffff888153f3e1c0 (size 16):
 >>    comm "kworker/2:1H", pid 176, jiffies 4305953739 (age 72707.743s)
 >>    hex dump (first 16 bytes):
 >>      80 84 c8 04 00 ea ff ff 00 04 00 00 00 00 00 00  ................
 >>    backtrace:
 >>      [<ffffffffaa795cf7>] __kmalloc+0x47/0xc0
 >>      [<ffffffffc0865a80>] nvmet_tcp_map_data+0x300/0x570 [nvmet_tcp]
 >>      [<ffffffffc086a7d4>] nvmet_tcp_try_recv_pdu+0x7f4/0x1e20 
[nvmet_tcp]
 >>      [<ffffffffc086c5a0>] nvmet_tcp_io_work+0x120/0x3272 [nvmet_tcp]
 >>      [<ffffffffaa1b059d>] process_one_work+0x81d/0x1450
 >>      [<ffffffffaa1b177c>] worker_thread+0x5ac/0xed0
 >>      [<ffffffffaa1c8ccf>] kthread+0x29f/0x340
 >>      [<ffffffffaa0034cf>] ret_from_fork+0x1f/0x30
 >>
 >> Fixes: db94f240280c ("nvmet-tcp: fix NULL pointer dereference during
 >> release")
 >> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
 >> ---
 >>   drivers/nvme/target/tcp.c | 9 +++------
 >>   1 file changed, 3 insertions(+), 6 deletions(-)
 >>
 >> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
 >> index cc05c094de22..dac08603fec9 100644
 >> --- a/drivers/nvme/target/tcp.c
 >> +++ b/drivers/nvme/target/tcp.c
 >> @@ -1427,13 +1427,10 @@ static void
 >> nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 >>       struct nvmet_tcp_cmd *cmd = queue->cmds;
 >>       int i;
 >> -    for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 >> -        if (nvmet_tcp_need_data_in(cmd))
 >> -            nvmet_tcp_free_cmd_buffers(cmd);
 >> -    }
 >> +    for (i = 0; i < queue->nr_cmds; i++, cmd++)
 >> +        nvmet_tcp_free_cmd_buffers(cmd);
 >> -    if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
 >> -        nvmet_tcp_free_cmd_buffers(&queue->connect);
 >> +    nvmet_tcp_free_cmd_buffers(&queue->connect);
 >>   }
 >>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
 >
 > Would it be possible to understand what are the commands that are
 > leaking here? commands that do not wait for data from the host, should
 > have a normal path of release, if that is not happening, we may be in
 > risk for use-after-free or still have a leak somewhere.

I tested with a reproducer and a debug patch like below.

#SHELL 1
while :
do
     echo 1 > /sys/class/nvme/nvme0/reset_controller
done

#SHELL 2
mount /dev/nvme0n1p66 ~/mnt
while :
do
    echo "aaaaaaaaaaaaa" > ~/mnt/test.txt
done

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cc05c094de22..0cdf83b636a2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1428,8 +1428,13 @@ static void 
nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
         int i;

         for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-               if (nvmet_tcp_need_data_in(cmd))
+               if (nvmet_tcp_need_data_in(cmd)) {
                         nvmet_tcp_free_cmd_buffers(cmd);
+               } else {
+                       if (cmd->req.sg) {
+                               printk("[TEST]%s %u cmd = %x exec = 
%pS\n", __func__, __LINE__, cmd->cmd_pdu->cmd.common.opcode, 
cmd->req.execute);
+                       }
+               }
         }

Results:
[  393.244102] [TEST]nvmet_tcp_free_cmd_data_in_buffers 1435 cmd = 1 
exec = nvmet_bdev_execute_rw+0x0/0xc20
[  393.607385] [TEST]nvmet_tcp_free_cmd_data_in_buffers 1435 cmd = 1 
exec = nvmet_bdev_execute_rw+0x0/0xc20
[  393.717213] [TEST]nvmet_tcp_free_cmd_data_in_buffers 1435 cmd = 1 
exec = nvmet_bdev_execute_rw+0x0/0xc20
[  393.825434] [TEST]nvmet_tcp_free_cmd_data_in_buffers 1435 cmd = 1 
exec = nvmet_bdev_execute_rw+0x0/0xc20
[  393.952042] [TEST]nvmet_tcp_free_cmd_data_in_buffers 1435 cmd = 1 
exec = nvmet_bdev_execute_rw+0x0/0xc20

I think these are not only the leaking case.
Possibly there are more cases.
But I can't test all the cases.

I'm not sure that this info is what really you wanted.
If this is not satisfactory info, please let me know.

Thanks,
Taehee Yoo

