Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCE8C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=by00rSofcVW0o+0DH/mIAxhhdK7UHVRdpxSnTxPjoUQ=; b=q+mxpnIkL5jfAo7ZGpd5RdxmEN
	F7731UvBKjg6+RtLUc40ZvDTOVhEMC3wOICEsi9MIbI2s7Gi9OalQk/0VUEQAHui2OmsHLPSwfAn2
	1l+ZGJfxc2q+i35U//arUjMu1fzIbfbF2g+I7jZ1U99RumCwkCBtVyydbo4K/ZGwiuPeVXt8JylIg
	6sNNPDGJUPKknUmLcrgyD+2EToD82gCz6hr9CviSzXyzrTy2l47UwKEMIM8vM/kR1wjWnkFwuyCY7
	jYZYs7CAGABo7oWI7OjWxGLGqamcBJCoula1ae2OCkaGh5HWRGZd2oFbixiPzyjUONpqeP1JJOFH+
	g0PFbLhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuYV-0000000EsN4-1DFW;
	Sat, 22 Aug 2026 22:51:15 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxuYT-0000000EsMi-0ZbX
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:51:14 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15e2dab83eso427424266b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439071; x=1788043871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=by00rSofcVW0o+0DH/mIAxhhdK7UHVRdpxSnTxPjoUQ=;
        b=PDizoEFwV98Cbm69n7Cbe7QoIRHU5fmK/ZSaqwqWFD6fVLdoyAYU/FbeOEp/s4oEwS
         sZHYh5/qeeluB61TxXTJmS2UwnporbtBzW+niP5cReb2q/X4Js8u985xA6LAmfZgFkk/
         He6EBMsPGmP0tLORg+TVoMkrvpgtyixneASRiPtv83LJA2ptr07zA/qMPlVbnK8Ei4Oj
         0sB2VmNJa9ICajg+nJ/NNZFQRT3GIOsM+Pa/TL+XtZXypKU3WzcEfbZeLoKQUvs191V3
         iTfUi5TjZR9ysBZiKmtu2AiRmWXHT/Op0pWfXQPN+5oATM/gsEASAgineIhuuK84Oz7y
         dMUw==
X-Forwarded-Encrypted: i=1; AHgh+Rps555TDNNiFKY6a0cB+IbUsUc6CAhkE5WXcZSfgx9xnkYPAwJNyCYR7VEWPhkuci5ESmZICrTb9/5j@lists.infradead.org
X-Gm-Message-State: AFuF++kr1pyum3t4sXbE5KhIkGez2dHdshPaT58V3o6KI11DjOG4X8hE
	b1/DaVWo8pZxRZRuVd4NVe6jdWkpJijfPKFxLi6NpwV7LKlyhNjcnAV7
X-Gm-Gg: AR+sD13al7vn3IOgyMTtR+B3QF5ZGuH8y5JJxD0Zi0EJ7tU7ksKQhPsdl1K6hmqPy4A
	/UOyJOC78tLhWqekUrQ9ILyXeCNIMoFsFLkftG/VNk6F0o9EyRIGgtNoLmPkPFtB/qzwxF8g2Gp
	oimqnEYE97Zkwi+lw9RG0f9LqQyDFVPKo8I/AqrKRNyV44/j6hbvZ/6pyIU98DLIwxeWNwksVB9
	WMczFtCLxZ8oOhmI+DCBL/ZXngqqh094ycvwyaE5WUJ5w2DoZdhExxynIYRgl6Gova5ovY+dGo+
	9RsaB1gs9bLEJfMlV15dKAQCT2LXaXgnrqOo/w+CQn+f4jYqcix8BovSckwJMo95zPj+IdBfhf5
	qRQzWWME+CCZp4Ia/xAxotRNGZdSTE3oL+uQREOXJx1kjJOJIa5KAZh2Wfaw/SDC6cS8u4gwkOg
	vtpV1eR2riJOdNOiBmxaZZYuK4AtKxVPp2f7UNqHzoVaSJIDm9zSHZVXBDiMs+Kmg04scmN6NEt
	lnGDWlGHl74ADKQKi288jSk
X-Received: by 2002:a17:906:f049:b0:c24:6045:2a94 with SMTP id a640c23a62f3a-c246a39f420mr1603195066b.4.1787439071040;
        Sat, 22 Aug 2026 15:51:11 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm578023866b.5.2026.08.22.15.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:51:10 -0700 (PDT)
Message-ID: <cfd6f450-220e-430d-a5e9-b8c9952ee44d@grimberg.me>
Date: Sun, 23 Aug 2026 01:51:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_155113_201252_4CDE432C 
X-CRM114-Status: GOOD (  30.01  )
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



On 18/08/2026 14:04, Yehyeong Lee wrote:
> nvme_tcp_handle_c2h_data() finds the request by command id and checks
> that it has a payload, but it does not check that the command asked for
> data to be read.  A controller that answers a write command with C2HData
> therefore reaches nvme_tcp_recv_data(), where _copy_to_iter() hits
> WARN_ON_ONCE(i->data_source) and returns 0.  The receive path turns that
> into -EFAULT and resets the controller.
>
> No data is copied, so this is not memory corruption.  What a controller
> gets is a kernel warning it can raise at will, which is fatal on a host
> booted with panic_on_warn.
>
> The send path already knows the direction - it consults rq_data_dir()
> when it builds a command - and nvme_tcp_handle_r2t() checks the length
> and the offset of the request it names.  The C2HData path does not check
> the direction at all.
>
> Reject a C2HData PDU whose command is not a read.  Rejecting it fails
> the command and resets the controller, as the neighbouring check in this
> function does; what goes away is the warning.
>
>    [    6.885580] ------------[ cut here ]------------
>    [    6.886457] WARNING: lib/iov_iter.c:193 at _copy_to_iter+0x289/0x1330, CPU#0: kworker/0:1H/71
>    [    6.888137] CPU: 0 UID: 0 PID: 71 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMETCP-gf5098b6bae76 #1 PREEMPT(lazy)
>    [    6.891165] Workqueue: nvme_tcp_wq nvme_tcp_io_work
>    [    6.891875] RIP: 0010:_copy_to_iter+0x289/0x1330
>    [    6.903739] Call Trace:
>    [    6.904085]  <TASK>
>    [    6.909254]  __skb_datagram_iter+0x433/0x820
>    [    6.911026]  skb_copy_datagram_iter+0x37/0x120
>    [    6.911622]  nvme_tcp_recv_skb+0xa07/0x4320
>    [    6.913378]  __tcp_read_sock+0x1ab/0x810
>    [    6.915788]  nvme_tcp_try_recv+0x152/0x1e0
>    [    6.918222]  nvme_tcp_io_work+0x1e4/0x6c0
>    [    6.926906]  </TASK>
>    [    6.927226] ---[ end trace 0000000000000000 ]---
>    [    6.927878] nvme nvme0: queue 1 failed to copy request 0x71 data
>    [    6.928709] nvme nvme0: receive failed:  -14
>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
> Applies on top of "nvme-tcp: do not accept C2HData based on
> blk_rq_payload_bytes() alone".
>
> Measured over a user-space target that answers every write with C2HData.
> The warning appeared in 5 of 5 runs without this patch and in none of 5
> with it, in each of three shapes: a buffered 8 KiB write, a 4 KiB write
> carried in the command capsule, and a discard.  In every run the command
> ids the target answered matched the ones the kernel named.  A conforming
> target is unaffected over 5 runs each way, including writes and a
> passthrough read, which rq_data_dir() classifies as a read.
>
> Those runs were on 7.2-rc5 with this patch as the only change.  Repeating
> the write, the in-capsule write and the conforming-target arms three
> times each on the base this patch applies to - 7.2-rc5 plus that patch
> and its predecessor - gave the same counts.
>
>   drivers/nvme/host/tcp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 85a87ed6df936..a62d6e48f7190 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -679,6 +679,13 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
>   		return -ENOENT;
>   	}
>   
> +	if (rq_data_dir(rq) != READ) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d tag %#x unexpected data for a write\n",
> +			nvme_tcp_queue_id(queue), rq->tag);
> +		return -EIO;

Minor nit - EPROTO would be more appropriate here (chiming in late here 
- not a really big deal)

