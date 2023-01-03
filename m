Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E72BC3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DB8QKwatZ+QnPJXm6vnk2qzX/s/q0HMZzzArnj4bqSM=; b=ZyBiqZzILca/rG5Vtp5yXW1+jE
	WQczz7iBeFQ/iQSq9ROll0RLpo6B5fAjfQ5/OqpApojfHU4eSUxDN1BWirut+42PYPsucbpSp2NhN
	GOVHJKoCYuiGbbO7KIUFN/CGhtmgvcPqCDz4wVKZa6X8wvo9HFA7w7seSpqRM2T908xezSM3ksVnF
	ahvsrZPdqWBGh2PQgzHHZ05mG7ENDYp8pQhuAd4NErpb8LRJ9n5mssB2ts3YCTCIu2k612iJ4qGu7
	eg4ceX9ub3prvdCP5aSob9dFviv0UacMZDJHg+i+wfg/llDBGBhc/u9iK/6RvP+fQjMkWZ8IdAV/j
	UyTGAHvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCfmJ-0013Di-C0; Tue, 03 Jan 2023 11:48:23 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCevv-000q9G-4Y
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:54:18 +0000
Received: by mail-wr1-f54.google.com with SMTP id h16so28989476wrz.12
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DB8QKwatZ+QnPJXm6vnk2qzX/s/q0HMZzzArnj4bqSM=;
        b=yfNXXcaG+MOyaK6jICR1GilOr/TNWMhiBf1P6m7IIFL+OL5Q4ePN2KgDL2Qj1M0OWg
         hUOc2LNM5bpy2+6s8xUrSNoPk6jazwdkz0mH2WZflGDTEiTFOwt87/Id7wpCujR0a7ss
         IVmzrLgCUP+PWFMLhHur01N5tP6OoYtM0WGTVJgJIVQKzrBLqQx5NcQaCFQ5jnKmoISJ
         nchiyS9FCW9XaGfge83HfkYmQkHZZvzaYJ3kVAcat/ou9Tb/e+XPoiDc7Av1H8XbNr6W
         0vjLr+hWxvSaVscqc8+GRMkxL1P340dl+vZYnxaedqfoVfKgxePHK9a3kyuqCnBVoizo
         DskQ==
X-Gm-Message-State: AFqh2krL0gDmuS3zxbemk1itL29ZI+5BAZQx+DPy8xhaHF+f3HlI7hv7
	o17D2bOQ5L+KH4Z0awStmbI=
X-Google-Smtp-Source: AMrXdXt2tU7cVjWlBV7lZezm1vEhxKjK4pUKTIaCLAyXBRlg3Avzq+JPA0nk3ITvhUG9ya3+VyJnzQ==
X-Received: by 2002:adf:e383:0:b0:242:69f4:cb6f with SMTP id e3-20020adfe383000000b0024269f4cb6fmr27404818wrm.32.1672743252305;
        Tue, 03 Jan 2023 02:54:12 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b0027cb20605e3sm23103130wrs.105.2023.01.03.02.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:54:11 -0800 (PST)
Message-ID: <f49ee5c1-cea7-86fc-b92a-4423a94389be@grimberg.me>
Date: Tue, 3 Jan 2023 12:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] nvmet-tcp: fix memory leak in
 nvmet_tcp_free_cmd_data_in_buffers()
Content-Language: en-US
To: Taehee Yoo <ap420073@gmail.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, kch@nvidia.com
Cc: james.p.freyensee@intel.com, ming.l@ssi.samsung.com,
 larrystevenwise@gmail.com, anthony.j.knapp@intel.com, pizhenwei@bytedance.com
References: <20230103100357.875854-1-ap420073@gmail.com>
 <20230103100357.875854-5-ap420073@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230103100357.875854-5-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_025415_250675_EC11D8F6 
X-CRM114-Status: GOOD (  23.41  )
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


> While tcp socket is being released, nvmet_tcp_release_queue_work() is
> called.
> It calls nvmet_tcp_free_cmd_data_in_buffers() to free CMD resources.
> But it may skip freeing resources due to unnecessary condition checks.
> So, the memory leak will occur.
> 
> In order to fix this problem, it removes unnecessary condition checks
> in nvmet_tcp_free_cmd_data_in_buffers().
> 
> This memory leak issue will occur in the target machine when a host
> sends reset command to a target.
> 
> Reproducer:
>     while :
>     do
>         echo 1 > /sys/class/nvme/nvme<NS>/reset_controller
>     done
> 
> unreferenced object 0xffff88814a5c6da0 (size 32):
>    comm "kworker/2:1H", pid 176, jiffies 4305953739 (age 72707.743s)
>    hex dump (first 32 bytes):
>      82 84 c8 04 00 ea ff ff 00 00 00 00 00 04 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffffaa795cf7>] __kmalloc+0x47/0xc0
>      [<ffffffffab030a72>] sgl_alloc_order+0x82/0x3a0
>      [<ffffffffc086593c>] nvmet_tcp_map_data+0x1bc/0x570 [nvmet_tcp]
>      [<ffffffffc086a7d4>] nvmet_tcp_try_recv_pdu+0x7f4/0x1e20 [nvmet_tcp]
>      [<ffffffffc086c5a0>] nvmet_tcp_io_work+0x120/0x3272 [nvmet_tcp]
>      [<ffffffffaa1b059d>] process_one_work+0x81d/0x1450
>      [<ffffffffaa1b177c>] worker_thread+0x5ac/0xed0
>      [<ffffffffaa1c8ccf>] kthread+0x29f/0x340
>      [<ffffffffaa0034cf>] ret_from_fork+0x1f/0x30
> unreferenced object 0xffff888153f3e1c0 (size 16):
>    comm "kworker/2:1H", pid 176, jiffies 4305953739 (age 72707.743s)
>    hex dump (first 16 bytes):
>      80 84 c8 04 00 ea ff ff 00 04 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffffaa795cf7>] __kmalloc+0x47/0xc0
>      [<ffffffffc0865a80>] nvmet_tcp_map_data+0x300/0x570 [nvmet_tcp]
>      [<ffffffffc086a7d4>] nvmet_tcp_try_recv_pdu+0x7f4/0x1e20 [nvmet_tcp]
>      [<ffffffffc086c5a0>] nvmet_tcp_io_work+0x120/0x3272 [nvmet_tcp]
>      [<ffffffffaa1b059d>] process_one_work+0x81d/0x1450
>      [<ffffffffaa1b177c>] worker_thread+0x5ac/0xed0
>      [<ffffffffaa1c8ccf>] kthread+0x29f/0x340
>      [<ffffffffaa0034cf>] ret_from_fork+0x1f/0x30
> 
> Fixes: db94f240280c ("nvmet-tcp: fix NULL pointer dereference during release")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>   drivers/nvme/target/tcp.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index cc05c094de22..dac08603fec9 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1427,13 +1427,10 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
>   	struct nvmet_tcp_cmd *cmd = queue->cmds;
>   	int i;
>   
> -	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
> -		if (nvmet_tcp_need_data_in(cmd))
> -			nvmet_tcp_free_cmd_buffers(cmd);
> -	}
> +	for (i = 0; i < queue->nr_cmds; i++, cmd++)
> +		nvmet_tcp_free_cmd_buffers(cmd);
>   
> -	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
> -		nvmet_tcp_free_cmd_buffers(&queue->connect);
> +	nvmet_tcp_free_cmd_buffers(&queue->connect);
>   }
>   
>   static void nvmet_tcp_release_queue_work(struct work_struct *w)

Would it be possible to understand what are the commands that are
leaking here? commands that do not wait for data from the host, should
have a normal path of release, if that is not happening, we may be in
risk for use-after-free or still have a leak somewhere.

