Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F192EC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:32:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17C764E04
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17C764E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XhQguAs33vL42uUHJaRTV70l6zVdAnOMu7tZRrDzgmg=; b=RAmgLXeRhrxHJntFI6nIFJf7m
	AP2oV+Nc/I7oEh00ngbBAA3SmKHu9PEho6SaPqM4OQiy0BlkBDnDfcrFYqOnmjgEqImX1viN3osyl
	C9YN+d6RYW8Cwsem1T3c9NrQb6xc8jBuEQGtmxiIZFFdvHfJ2FNf3uBG809RsMEBolW/epSMCpm8I
	GpFsSI941kMsKFV/kI8iPo49BXQA1OIFc/UenKLGfoyUoiUYR3X3BYC4FIbjrSluJUvxpj6Ofn2/T
	ST2bOqAPDxCJRyfSlbA+ERS2y/XH+l7J8AAFlxE5MDJdWGFTwejPJSvl/xxH9htqqzddlpt5+kiyb
	+EGeNErMQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLr4x-00GWWD-TH; Mon, 15 Mar 2021 17:32:32 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLr4p-00GWUV-RU
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:32:27 +0000
Received: by mail-pl1-f175.google.com with SMTP id f8so2140783plg.10
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TKAZ8aAZDyNLoSV/Ynuhjm6MhzlMkhJJwED9weuVm/8=;
 b=d1/UjuIqXUfwdE5vrs6z977S+pYppcHYVAzoXUef+wb7iW97837fDw1yNweZsGzjIK
 yNUlPrEV/xZyVYbiGMOtVe8dEf62upPkF7buKebpRy3bmsIMG8O13Ky7HyFQ5/9vBLV6
 S++kYP+dKSTv+788osKNnJuq4+JmqDfjWX0142iqZbD6KhWKzphCj9VEk+oBaZ18SCvH
 w0CENl4o1016Kk1XeCD+2SHkA5P6bn3K1JW/O/qemIgM5an6ZDEL6s+0I88OHVl9pi+Z
 4B6wjZlvTxifzXaa7pVO7vRpNiAuYoioMqBc+jllpB5YhDHFdnbB+QzGz9ZOXVbx3oq2
 grsg==
X-Gm-Message-State: AOAM5318DGEA24Mu9Auh9PXDkOBtmLLasezGMSHjBBvSzY/6r67CY9a8
 sGhyvagdEs1pDoCjXar0A5A=
X-Google-Smtp-Source: ABdhPJxRrEXRYxa1r8W5GiMkR+bYXMuuCfa+sqZKucJE2/kUOBNqt0m/wLzdqhVJgKxtYDCOoDdeAA==
X-Received: by 2002:a17:90a:bb02:: with SMTP id
 u2mr139681pjr.175.1615829542107; 
 Mon, 15 Mar 2021 10:32:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id b9sm13593432pgn.42.2021.03.15.10.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:32:21 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: finish receiving before send back response if
 nvmet_req_init() failed.
To: Hou Pu <houpu.main@gmail.com>, hch@lst.de, chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <20210315100928.87596-1-houpu.main@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3a5bd33b-32c2-24c4-3880-883e33bfe282@grimberg.me>
Date: Mon, 15 Mar 2021 10:32:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315100928.87596-1-houpu.main@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_173224_799967_98DF365C 
X-CRM114-Status: GOOD (  22.57  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When receiving a pdu, if nvmet_req_init() failed (for example a ns is
> not found), the queue->rcv_state could be moved to NVMET_TCP_RECV_DATA
> by nvmet_tcp_handle_req_failure(). We should return 0 here to continue
> to consume the possible remaining inline write out data in
> nvmet_tcp_try_recv_one(). Otherwise, the response to this request would
> be sent and iov would be freed. Next time in nvmet_tcp_try_recv_one(),
> we would go to the receiving data phase and the iov is used again.
> 
> A panic happend with a 5.4 kernel installed as below:

Can you please try to reproduce this with upstream? and with latest
stable 5.4? there have been some fixes in this area. We may need
to help backported patches to stable if needed.

> 
> [  169.906573] nvmet_tcp: failed cmd 0000000027717054 id 106 opcode 1, data_len: 1024
> [  169.908131] general protection fault: 0000 [#1] SMP NOPTI
> [  169.908884] CPU: 0 PID: 122 Comm: kworker/0:1H Kdump: loaded Tainted: G           OE [...]
> [  169.910328] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), [...]
> [  169.911943] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
> [  169.912815] RIP: 0010:__memcpy+0x12/0x20
> [  169.913393] Code: e3 97 ff 0f 31 48 c1 e2 20 48 09 d0 48 31 c3 e9 79 ff [...]
> [  169.915819] RSP: 0018:ffffc9000026bbc8 EFLAGS: 00010246
> [  169.916547] RAX: ebf4958c4fda661b RBX: ffff888119613096 RCX: 0000000000000080
> [  169.917511] RDX: 0000000000000000 RSI: ffff888119613096 RDI: ebf4958c4fda661b
> [  169.918469] RBP: 0000000000000400 R08: 0000000000000000 R09: 0000000000000400
> [  169.919435] R10: 0000000000000000 R11: 000000000000003e R12: ffff888114244068
> [  169.920398] R13: 0000000000000400 R14: 0000000000000400 R15: ffff888118c37cb0
> [  169.921378] FS:  0000000000000000(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
> [  169.922473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  169.923269] CR2: 0000555eb19943e0 CR3: 00000001186fc000 CR4: 00000000000006f0
> [  169.924245] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  169.925214] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  169.926184] Call Trace:
> [  169.926569]  _copy_to_iter+0x26f/0x440
> [  169.927112]  ? __check_object_size+0x70/0x230
> [  169.927724]  __skb_datagram_iter+0x15a/0x290
> [  169.928327]  ? skb_kill_datagram+0x60/0x60
> [  169.928921]  skb_copy_datagram_iter+0x3b/0x90
> [  169.929545]  tcp_recvmsg+0x759/0xc50
> [  169.930081]  ? ksoftirqd_running+0x2c/0x30
> [  169.930668]  ? free_unref_page_commit+0x95/0x120
> [  169.931331]  inet_recvmsg+0x55/0xc0
> [  169.931834]  nvmet_tcp_io_work+0x685/0xb23 [nvmet_tcp]
> [  169.932549]  process_one_work+0x18c/0x370
> [  169.933118]  worker_thread+0x4f/0x3b0
> [  169.933654]  ? rescuer_thread+0x340/0x340
> [  169.934223]  kthread+0xf6/0x130
> [  169.934682]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  169.935393]  ret_from_fork+0x1f/0x30
> 
> Cc: <stable@vger.kernel.org> # 5.0
> Signed-off-by: Hou Pu <houpu.main@gmail.com>
> ---
>   drivers/nvme/target/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 8b0485ada315..da1c667e21ba 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -961,7 +961,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   			le32_to_cpu(req->cmd->common.dptr.sgl.length));
>   
>   		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
> -		return -EAGAIN;
> +		return 0;

What guarantees that you will actually have more to consume?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
