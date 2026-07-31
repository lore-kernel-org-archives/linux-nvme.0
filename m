Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4D3C5516F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geJgXx5Dm6qqt2ZAAFVL9G2Q6MfkYPKO/H3Ubz8hDvA=; b=a37SGK0jOZ0GMfxqGQnHIbmsKA
	gcKmqHkAKUQlqSdKQvDstLUdBeNZclQJDjX49xs+lwBcirlCu55XhRTr9yRZ16Nbh7CkWEP0zQS7V
	ifDBKyEhPao+xQRk8r3eNulBwLElDZSStIrR5o5Io9KmZ9b1zcWfkjz99K4yISAQuuC19lxXAcfEN
	e4/Zh11u2rOGpSN6YC0Hfmx+XG2I8cenBZ4pDURkFgHYVdhKbPuKY7ykI/h/IiP/QoOmH9frGDj5c
	256zPJv/VjXlySv87Zr2gXfR63+hmPiNl6FEzkkc8duocG38pyY0lfSJYBVYS0b7GnY1Sr2Ihzsqz
	ecPRE3fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpqIJ-0000000DAH4-324g;
	Fri, 31 Jul 2026 16:41:11 +0000
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpqIH-0000000DAGO-2AFn
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 16:41:10 +0000
Received: by mail-pz2-x01.google.com with SMTP id 41be03b00d2f7-ca7d1dc4554so507368a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785516069; x=1786120869; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geJgXx5Dm6qqt2ZAAFVL9G2Q6MfkYPKO/H3Ubz8hDvA=;
        b=ieeMlmoL9iZfS53apxcwDpQllcyIJOUVYs8brmPQ21x1c1OkQwrHq83SJuunbub8OJ
         02JPxMsSPWxtlUiRWBXsnS5nZG1M1cgSTX8y5wZ/pWXD5lf7K+h4L3KxHBDTHStfTokv
         xmymcVMjpR61hULcwapxE8NgUr2B0H953uIUgdmeTVodtoRD9UaEhGn46vCQsKGGo8Xn
         frj4Tmqv/sW8VPsETL6mT2ZAeKWR9WSYSX8XYK2HV1iXA7ZCAAPUMX377XfzWnL2CJ73
         yq8/xMcGP9ShhweZmwNYXxyEuHF85xrb6lbqtuD2B0uWgYKj8QXvRT5S5QJ7FIvixNts
         LUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516069; x=1786120869;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geJgXx5Dm6qqt2ZAAFVL9G2Q6MfkYPKO/H3Ubz8hDvA=;
        b=jKzN9QOejSx0hCwUwxIWW03G//WRqZ/YdDj2QcGm9/hQyJFrt6sGGIosF4bY/9PMco
         MbtEB27Apa4MxnRrdiuyTgxiEk1D8H465HcwWFQrAAn/Yr88QvhFaU2uvMGIco0lKMpZ
         xv3P5x07QSeotnyN0G8HVsTDJNbr4xqrrd/sBkA4ZFNtNU4QXYf4Mr3Hk5U5LqSyIbcV
         PJH6YUzzOrvy84wI1Vr0D8lXeA+8F+uM5dpdxN/9SrQXgoSWK3AWpnQWOi1d4TvA7Pfj
         zEnlwJbRgUU0aievy/QsdX/BCZX2jY5PkWlBg9362nu/Xx8MuJ0GY0N0Yzqni6gjn/H4
         pN8A==
X-Forwarded-Encrypted: i=1; AHgh+RpgM4TATYiqRJAv+VMCD5AHOyoAM7hOoZJ39PBqxRNRWxDrhJyoDwnF6Iw7rtXgHRa82LyhMz9hHdet@lists.infradead.org
X-Gm-Message-State: AOJu0YzkR5+8RMKeRhzH7v1wmmvTc4Ftwk9qudKmd4L0JFH+Jem0vFdA
	ivD4MUZvMSW2h7rwqwpJ4BmA4fvVKSRn+FZZaBziU6G2Hmc5ebUY/+Tk
X-Gm-Gg: AR+sD11zrRkzx3igTH8GXFf6KArj/H7zl5KfnYfycA+8jLVD3MspjdrCYOaDsY/fW5/
	owjiMRPPovLcPD5byjWWXdsYiHYhq8e0+p5ndMugHDdI6wS+T5ySdgPp35qYuGJ7UGVZ562JMLT
	kKIaWnswGxVp4hgIvgEqBiDfB1Zhkt8fvXT83x1O/GzKpR1U/f7IVOb1j+2VPAc30Me0V0WWdAZ
	xhEDkO8ycap3wM63/E6FPA8Lpj+uK0SsMU915zogofXPiUn024MfQ+8hg2ZMVc9SY3e8rgyC23i
	1w+Y7TDMEeflDKrYDaLmICLFXIgK5cRAYwQQKkDc37857PsH+fQqa4gNyIO6N+wLeWx2DexvwOR
	roAMVNIvAGk+dok69LoZBAaAIu8xqYdh4giNl4Rw8ATydZ+qGWNhIs+LkUQu52PvY3oRk3UFWcL
	/ksYFusy2SnsPIA80bjgIPL97uUALv+yMoruejphd3ka3y7rIn7+ej7g==
X-Received: by 2002:a05:6a00:4fc7:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84ee4899b2dmr323897b3a.39.1785516068847;
        Fri, 31 Jul 2026 09:41:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d901csm675606b3a.48.2026.07.31.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:41:08 -0700 (PDT)
Date: Fri, 31 Jul 2026 09:41:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me, 
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on
 NIC queue count
Message-ID: <amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731073918.614014-3-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_094109_555639_9C31B9FD 
X-CRM114-Status: GOOD (  22.11  )
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

On 07/31, Nilay Shroff wrote:
> NVMe-TCP currently provisions I/O queues based primarily on the number
> of online CPUs. On systems where the CPU count significantly exceeds the
> number of NIC hardware queues, multiple NVMe-TCP I/O queues end up
> sharing the same NIC TX/RX queues. This increases lock contention,
> cacheline bouncing, and inter-processor interrupts (IPIs), reducing I/O
> efficiency.
> 
> Limit the number of NVMe-TCP default I/O queues to the smaller of the
> number of online CPUs and the number of NIC hardware queues. Aligning
> the number of NVMe-TCP I/O queues with the NIC queue topology reduces
> queue sharing, improves locality, and can improve throughput while
> reducing tail latency.
> 
> The number of NVMe-TCP I/O queues is now limited to:
> 
>     min(num_online_cpus, num_nic_queues)
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/tcp.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..a2110287099e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1774,6 +1774,50 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>  	return ret;
>  }
>  
> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl,
> +		netdevice_tracker *tracker, gfp_t gfp)
> +{
> +	struct net_device *dev = NULL;
> +
> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
> +		dev = netdev_get_by_name(&init_net, ctrl->opts->host_iface,
> +				tracker, gfp);
> +	else {
> +		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
> +		struct sockaddr_storage *src = NULL, *dest = NULL;
> +
> +		if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
> +			src = &tctrl->src_addr;
> +
> +		dest = &tctrl->addr;
> +
> +		dev = netdev_get_by_addr(&init_net, src, dest, tracker, gfp);
> +	}
> +	return dev;
> +}
> +
> +/*
> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
> + * be determined.
> + */
> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
> +{
> +	struct net_device *dev;
> +	int tx_queues, rx_queues;
> +	netdevice_tracker tracker;
> +
> +	dev = nvme_tcp_get_netdev(ctrl, &tracker, GFP_KERNEL);
> +	if (!dev)
> +		return 0;
> +
> +	tx_queues = dev->real_num_tx_queues;
> +	rx_queues = dev->real_num_rx_queues;
> +
> +	netdev_put(dev, &tracker);
> +
> +	return min(tx_queues, rx_queues);
> +}
> +
>  static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  				key_serial_t pskid)
>  {
> @@ -2165,6 +2209,23 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;

[..]
 
> +	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES)) {
> +		int nr_hw_queues;

Looks like the userspace can already pass the preferred number of queues,
so in this case, why not do all this netdev resolution and queue
estimation in the userspace? Presumably most or the users you care
about always go through nvme-cli, right?

