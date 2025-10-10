Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684B7CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fqh81JzkebFW9NBa0luG9R0++lVoMrJoQsGMBGNWkDQ=; b=rrgcXdTpKBk/94nOtqLFEZ+4I6
	V2HWqkgwU8DbHYj+Cy8dwxpPHewH5aYiuR5oLAEhDQsbiJrS5Y4E3I5Ugs4MdBS3Jusf5vaJj3Izm
	QSNqZ2wFwFac89xqGdKiNOZjA5/58GTx8WM4jPDOi+/BbkaS9r+F96CHgeUynFEvG9GpI9MCt4pkp
	/gIniYdBFrBfQVaxVTsK2k4MyLs3s1Z/Tj7OVGOxwS0Ye1Dx4G8FtTtzcKDt66U2y5rEQ7v/TOOs2
	E8OeLB0Xz8abqiLkXgtswt6NGxWp/0V9gcncJ4JIWhiCj3o0JKHiJ6h8I+zfBl1CrKNxbNev8xn/c
	OTvYzBzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75dO-00000007hqf-1Rri;
	Fri, 10 Oct 2025 05:25:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75dM-00000007hqG-10Wx
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 05:25:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0921548CA2;
	Fri, 10 Oct 2025 05:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8211C4CEF1;
	Fri, 10 Oct 2025 05:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760073938;
	bh=GXluhzyEekuhBdcSbhL8/EI3wLJYUL+QewwbLwip4sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IgAYxOm1sGOZIDpRtgR4D53NpFyvNfaHzGRlRa3kp26VUMJlPvi0f/RxocjJAasRS
	 Mxdf+/wSwuij/YWm7MHbzetBO609JQ94ZQl48lwJXnFfWqiK/HagH8RlDrvEK6NdpS
	 LW0mX/B+vVH8Be5yCSleqlDCrCWM63Ewr8OY4B0N8UlX/i/4+vw99W4p6N+iHhQKet
	 giRZY1/4GDhfNmplkzhR3jnmxZnpzFPoapi0iWT1wLZnizq8aoK9/AXZPSMANS1P9d
	 OFRfGYCdBi6DCqlzcZuT9VMDC0347Mwc7bCvUxTK8GfT6olij6tliQdYxoN8uzWvi2
	 ZJ4zfJGzMCahw==
Message-ID: <c39248ad-9adf-471f-a344-762920743d83@kernel.org>
Date: Fri, 10 Oct 2025 14:25:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251010042514.704249-2-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251010042514.704249-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_222540_302888_381E2E00 
X-CRM114-Status: GOOD (  20.04  )
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

On 2025/10/10 13:25, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> With TLS enabled, records that are encrypted and appended to TLS TX
> list can fail to see a retry if the underlying TCP socket is busy, for
> example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
> to the NVMe TCP driver, as the TLS layer successfully generated a record.
> 
> Typically, the TLS write_space() callback would ensure such records are
> retried, but in the NVMe TCP Host driver, write_space() invokes
> nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
> list to timeout after not being retried.
> 
> This patch fixes the above by calling queue->write_space(), which calls
> into the TLS layer to retry any pending records.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> V2:
>     - Unconditionally invoke TLS write_space(). This means we don't need
>       to export tls_is_partially_sent_record()
> ---
> drivers/nvme/host/tcp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d5..6016510577bd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock *sk)
>  
>  	read_lock_bh(&sk->sk_callback_lock);
>  	queue = sk->sk_user_data;
> +

White space change... Remove please.

>  	if (likely(queue && sk_stream_is_writeable(sk))) {
>  		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +		/* Ensure pending TLS partial records are retried */
> +		if (nvme_tcp_queue_tls(queue))
> +			queue->write_space(sk);
> +

Maybe remove this empty line too.

>  		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>  	}
>  	read_unlock_bh(&sk->sk_callback_lock);


-- 
Damien Le Moal
Western Digital Research

