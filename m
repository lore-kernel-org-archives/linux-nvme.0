Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A24FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CcqUZ4I1aXMWGhgVAAt6UYjQ5+a0myvwxtYCWAHuYPU=; b=GC0s/CQ3LpymS+QrMaDcSNcEYU
	4nIqKVjub7y5OD52FgD6G29YG3d1OhObgihhNGyB28CNzCfPF7+vqv4Q94mjme6W6FVe+MaRbG3Kv
	w2nSLb3QS5j6DzNIru6Z7l2AlPRgGIuReVJDTlsElIBjFNP5JSke051aI7kYvDA5L9hRWGK2zLw0W
	NQKg21YdAXsL8cq4u6AxbRJ9VV85Hp+KJeQ00wc6l7ixj9gh/nScI4u2hqW0AUp789MrqM23n7SbV
	uCjG0CIs3t+pNrIVrT5lMOgLZjZ/hGCQPZWql3J9Dl3kHTIOatexpsCezNPa1bysyCSqwMsiFHpSZ
	0mzqQM8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHgxu-00ARZs-1Q;
	Mon, 25 Dec 2023 09:09:38 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHgxr-00ARZ7-1s
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 09:09:37 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3367f8757d0so650289f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 01:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703495372; x=1704100172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcqUZ4I1aXMWGhgVAAt6UYjQ5+a0myvwxtYCWAHuYPU=;
        b=NRYsizLRNoVdxwhXzfnHro9LwO82nkOc8wYxR7qE1AgpJrD3WcfiHwgcPEhu1Z+T4s
         NIRaovI3KlvHJPJj8s0qbzfO0J6N1KRdjnHfDu4YHfz5YqQVliCZkrSAdDXpTEPS8vAj
         0LQckRhm/FRoaWP6YMY5HNTPS22IiQPa2oijj5BV8G76kXa2D8BTfSrIgQ4QNyZ65xpn
         Fx5NAzf2XcXS+gaK13aGMgrEmJBitk840k5j8cYHFKY01BLlX0pvRSoYo3EzYRQwFu8w
         c+faLj7indNpsFIKcV+0l3AdjWWHpV5BmVZUu/4XSWYRxRdpHJsZdeVp79vorWfzw/UI
         SJjQ==
X-Gm-Message-State: AOJu0YwJwWuA+oji/j2yK5jfh+kRSAdX6tuV6O2x6t8OkS+Lh2viIoFN
	OrbRelQXGQANw6tBW599eFE=
X-Google-Smtp-Source: AGHT+IHf8ba6RyAQazIKGAMqpV46oxWzPnAE1NrIfBiVJB8heqammukE1L2fv01HnN9xn/CKqpKI4g==
X-Received: by 2002:a05:600c:1d02:b0:40d:5547:11dd with SMTP id l2-20020a05600c1d0200b0040d554711ddmr2499665wms.1.1703495372205;
        Mon, 25 Dec 2023 01:09:32 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b0040d3b0780d5sm16875603wms.30.2023.12.25.01.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:09:31 -0800 (PST)
Message-ID: <d84dfede-8efd-4446-b273-03dbf6fcbc10@grimberg.me>
Date: Mon, 25 Dec 2023 11:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] nvme-tcp: fix a possible double-free after failed to send
 request
Content-Language: en-US
To: zhangyanjun@cestc.cn, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231222111225.72015-1-zhangyanjun@cestc.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222111225.72015-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_010935_625522_F96A4FD7 
X-CRM114-Status: GOOD (  20.96  )
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



On 12/22/23 13:12, zhangyanjun@cestc.cn wrote:
> From: Yanjun Zhang <zhangyanjun@cestc.cn>
> 
> In storage clusters constructed by nvme-tcp driver, we have encountered
> the following crash on the host kernel severval times.
> 
> [248514.030873] nvme nvme1: failed to send request -13
> [248514.035916] ------------[ cut here ]------------
> [248514.035918] kernel BUG at mm/slub.c:379!
> [248514.037647] invalid opcode: 0000 [#1] SMP NOPTI
> [248514.039416] CPU: 0 PID: 9 Comm: kworker/0:1H Kdump: loaded Tainted: G S                5.15.67-6.cl9.x86_64 #1
> [248514.041376] Hardware name: CECLOUD CeaStor 16114/BC13MBSBC, BIOS 1.37 02/24/2023
> [248514.043433] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [248514.045576] RIP: 0010:__slab_free+0x16a/0x320
> [248514.047751] Code: 24 20 e8 69 28 78 00 44 8b 44 24 0c 4c 8b 54 24 10 44 0f b6 5c 24 1b 0f b6 74 24 1c 48 89 04 24 4c 8b 4c 24 20 e9 28 ff ff ff <0f> 0b 41 f7 46 08 00 0d 21 00 75 a0 4d 85 ed 75 9b 80 4c 24 5b 80
> [248514.052500] RSP: 0018:ff51b1a6c0273bf0 EFLAGS: 00010246
> [248514.054798] RAX: ff2378e68268b800 RBX: 0000000080080004 RCX: ff2378e68268b000
> [248514.057038] RDX: ff2378e68268b000 RSI: ffca59110c09a200 RDI: ff2378a480034d00
> [248514.059245] RBP: ff51b1a6c0273c90 R08: 0000000000000001 R09: ffffffffc0901a0a
> [248514.061386] R10: ff2378e68268b000 R11: ffffffff86e06000 R12: ffca59110c09a200
> [248514.063423] R13: ff2378e68268b000 R14: ff2378a480034d00 R15: 0000000000000078
> [248514.065428] FS:  0000000000000000(0000) GS:ff2378d32fe00000(0000) knlGS:0000000000000000
> [248514.067456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [248514.069531] CR2: 00007f4759e1c800 CR3: 0000001b5e5a6005 CR4: 0000000000771ef0
> [248514.071706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [248514.073916] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [248514.076130] PKRU: 55555554
> [248514.078392] Call Trace:
> [248514.080640]  <TASK>
> [248514.082898]  ? sk_stream_alloc_skb+0x66/0x2e0
> [248514.085231]  ? tcp_skb_entail+0x11d/0x130
> [248514.087595]  ? tcp_build_frag+0xf0/0x390
> [248514.089980]  ? nvme_complete_rq+0x1a/0x1f0 [nvme_core]
> [248514.092433]  kfree+0x215/0x240
> [248514.094918]  nvme_complete_rq+0x1a/0x1f0 [nvme_core]
> [248514.097469]  nvme_tcp_recv_pdu+0x534/0x570 [nvme_tcp]
> [248514.100070]  nvme_tcp_recv_skb+0x4f/0x23e [nvme_tcp]
> [248514.102699]  ? nvme_tcp_recv_pdu+0x570/0x570 [nvme_tcp]
> [248514.105317]  tcp_read_sock+0xa0/0x270
> [248514.107958]  nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
> [248514.110666]  ? nvme_tcp_try_send+0x16b/0x200 [nvme_tcp]
> [248514.113431]  nvme_tcp_io_work+0x4d/0xa0 [nvme_tcp]
> [248514.116247]  process_one_work+0x1e8/0x390
> [248514.119085]  worker_thread+0x53/0x3d0
> [248514.121980]  ? process_one_work+0x390/0x390
> [248514.124887]  kthread+0x124/0x150
> [248514.127835]  ? set_kthread_struct+0x50/0x50
> [248514.130836]  ret_from_fork+0x1f/0x30
> [248514.133841]  </TASK>
> 
> By analyzing the vmcore, we know the direct cause is that the slab object
> request->special_vec was freed twicely. According to the error message
> "nvme nvme1: failed to send request -13" and nvme_tcp_request->state =
> NVME_TCP_SEND_DATA, the pdu has been send by nvme_tcp_try_send_cmd_pdu.

So what exactly failed to send? incapsule date? Or h2cdata?

> And the nvme_tcp_fail_request would execute nvme_complete_rq after failed
> to send data.

That is correct.

> Then the nvme_tcp_recv_pdu may receive the responding pdu

Which PDU was that? Isn't the controller expecting request data?

> and the nvme_tcp_process_nvme_cqe would complete the request again. To
> avoid this slab object double-free issuse, we try to make the following
> code modifications, can you give some suggestions, thanks!
> 
> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 08805f027..84f724558 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -581,6 +581,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> +	if (!blk_mq_request_started(rq))
> +		return 0;

First, I want to understand if this is a spurious completion, meaning is
this suggesting a protection against a misbehaving controller? Or there
was actually something that the host got wrong?

Because this sort of check does not belong in the tcp driver.

