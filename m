Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE33C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rd9mpww30KfCTr7fFwwzdbYpEpm9V77w7Sk1CvWbaAc=; b=y4+goyXBlRICjLQTEYB87JD7nk
	mQv5idlrmdi1RjI88yliuX6y0AU4XP74WvUGDy/nzZqI6H+gJh8VHEO0/QDDzcpblpz0X5VOUS6NF
	cuR5n6cuK329TL+RvKZImdwlC0By9Qpe3k/U3V2+gSL/qHkWYlZWB3F/PIk4hWiQejKiULfg/skTj
	DIW53nfioCccZKteFb3MiUtnD0Et9aiypUOZLczI6vVef0JQEPYWY1EUwI6vphisbA3bu4SpEnB5k
	/RoK+1QyYxdgqoLHl6rzcn0cu6WVlS4N4QlQIo4aA+CeabQli0xwYhkzfhILd+anoyr6r2GKuf2BN
	TYNMBL2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7DCU-00000007Cyg-06o5;
	Tue, 22 Apr 2025 12:58:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7C6t-000000070Zc-07MK
	for linux-nvme@bombadil.infradead.org;
	Tue, 22 Apr 2025 11:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Rd9mpww30KfCTr7fFwwzdbYpEpm9V77w7Sk1CvWbaAc=; b=ZyabAnoCiEhvvfT+HZQ6rwEL50
	+qoiwmQWAlvheAdsgK8Q0je9+07kWv5deLd4i6i6mumHhFFZp6uFlY9rTuE7IaW5LusV9ANferS1U
	cI/VTXvfFyxUF/tX6mwFl8edPHWLe7gko6ahBSvcrMfq8A6M379+HfwH3CAs2UqfcdTka14MJ7MxW
	D6xAnkpq/kKDT7R48aB0iU2ntKBikg2oeTvn8WiORD5V/hqC7ScXGQ15SA3dALmjP4u+Xq2gN+9qX
	zwsbSR+TInrD/z3ES1x3MTGip2qqkAR0TCoSKbjtcNxbvqRuA/Ek6WumQcBrjLjYoOQ9197SQXAF4
	b5uJZu9Q==;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7C6p-0000000BCm8-3ng0
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 11:48:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso23433405e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 04:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322494; x=1745927294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd9mpww30KfCTr7fFwwzdbYpEpm9V77w7Sk1CvWbaAc=;
        b=EiEs4F99bOMsk5YFO/MQzkmXmPMH/LLHwBWl0OT0yJOTdGnVbI3VXlZDuFCg92fhn/
         EaJh0PPt1TsBTaI3EApkJK453p4vTjImhSqgICxw4QINrE7Aed81EWoceMXndO3wADVn
         +8PfkHUOGNMwjgjTuk4uK4w3MCwSo5rmrP/jRrNXOUWBKa+hsELEfCu/f9qaX+oJ6So1
         VOw5/YlGAFCRPCPmNaks0Yc4+x+Tto0JO6yyOHieEYs0v+TKnF1NNrQ+a/j68x+2tmQP
         hWT1tZNFTvUuKW20iHeROam7xwHwnetwGtUm5ILLV2QrLCLvhIuxezgDTKi/PFkAMN+I
         g1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWD3NOnloLQbvqUqQEYs2yV0+jh5fN+nmmg2aoHoZt0DZB0viLovriJm2JNkXVdze2Xflx8XzorlWGY@lists.infradead.org
X-Gm-Message-State: AOJu0Ywo2FwBIPTyamW+WK1kw6HkIIkgWj6VMOtbbVVe022VS6bHLUy4
	TTuGkS2aUFRxrd3N6M+rZCUh1QXu1umu26D6YB+rDJtHdxQR4KVJ
X-Gm-Gg: ASbGncthg43DS4iKj+aW7d3vasX0FCDROE//aYnJMmFh+3seOBbxCy5gUMm4egNrmaf
	ykNgw9kWTI7JvmQZJcjT+iXecAsfoQ15urm8Yb/HKuUmGqkcC2bXZL6EXJdxXf13V7j/Wo2G1CI
	6YACTogn/YMAwxFwoTgamA9RS0nSMbBu4LSHEY+T5+nVOoOEUDcKotSXDnsyXqcfTOjydoPZuQ+
	avx1a+0SkzbgtnFR0yMhm67Nv+S00qWWKjdOuakMGC5ws0gb6YuNLMeK0Z0vlYtt75cRE5+IEwp
	ttWck02oTrbMAyzE2/vMJIK8Y1dhGaGpiJHkcGNbwKgjM6PdEnAzCzz+dbqjv7Dh5OCdleO0IaP
	7zMytxg==
X-Google-Smtp-Source: AGHT+IEKsk0gnKO/XC4zScRVkpX1Ie7Ny5ViJQfVzCiVrieXqCEHQly9ujKORgiytv0YRGPXmAbOrg==
X-Received: by 2002:a05:600c:1c8f:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-4406ab981c5mr135046415e9.14.1745322493645;
        Tue, 22 Apr 2025 04:48:13 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6dfed6sm170150065e9.35.2025.04.22.04.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:48:13 -0700 (PDT)
Message-ID: <4cf8af38-419e-4d7c-95f7-7248faf3c7bb@grimberg.me>
Date: Tue, 22 Apr 2025 14:48:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250421165525.1618434-1-csander@purestorage.com>
 <20250421165525.1618434-3-csander@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250421165525.1618434-3-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_124816_109728_8C76040B 
X-CRM114-Status: GOOD (  25.42  )
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



On 21/04/2025 19:55, Caleb Sander Mateos wrote:
> NVMe commands with more than 4 KB of data allocate PRP list pages from
> the per-nvme_device dma_pool prp_page_pool or prp_small_pool. Each call
> to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
> These device-global spinlocks are a significant source of contention
> when many CPUs are submitting to the same NVMe devices. On a workload
> issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
> to 23 NVMe devices, we observed 2.4% of CPU time spent in
> _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
>
> Ideally, the dma_pools would be per-hctx to minimize
> contention. But that could impose considerable resource costs in a
> system with many NVMe devices and CPUs.
>
> As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
> nvme_queue to the set of DMA pools corresponding to its device and its
> hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
> about half, to 1.2%. Preventing the sharing of PRP list pages across
> NUMA nodes also makes them cheaper to initialize.
>
> Link: https://lore.kernel.org/linux-nvme/CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com/T/#u
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>   drivers/nvme/host/pci.c | 144 +++++++++++++++++++++++-----------------
>   1 file changed, 84 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 642890ddada5..7d86d1ec989a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -16,10 +16,11 @@
>   #include <linux/kstrtox.h>
>   #include <linux/memremap.h>
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/nodemask.h>
>   #include <linux/once.h>
>   #include <linux/pci.h>
>   #include <linux/suspend.h>
>   #include <linux/t10-pi.h>
>   #include <linux/types.h>
> @@ -110,21 +111,24 @@ struct nvme_queue;
>   
>   static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
>   static void nvme_delete_io_queues(struct nvme_dev *dev);
>   static void nvme_update_attrs(struct nvme_dev *dev);
>   
> +struct nvme_prp_dma_pools {
> +	struct dma_pool *large;
> +	struct dma_pool *small;
> +};
> +
>   /*
>    * Represents an NVM Express device.  Each nvme_dev is a PCI function.
>    */
>   struct nvme_dev {
>   	struct nvme_queue *queues;
>   	struct blk_mq_tag_set tagset;
>   	struct blk_mq_tag_set admin_tagset;
>   	u32 __iomem *dbs;
>   	struct device *dev;
> -	struct dma_pool *prp_page_pool;
> -	struct dma_pool *prp_small_pool;
>   	unsigned online_queues;
>   	unsigned max_qid;
>   	unsigned io_queues[HCTX_MAX_TYPES];
>   	unsigned int num_vecs;
>   	u32 q_depth;
> @@ -160,10 +164,11 @@ struct nvme_dev {
>   	struct nvme_host_mem_buf_desc *host_mem_descs;
>   	void **host_mem_desc_bufs;
>   	unsigned int nr_allocated_queues;
>   	unsigned int nr_write_queues;
>   	unsigned int nr_poll_queues;
> +	struct nvme_prp_dma_pools prp_pools[];
>   };
>   
>   static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
>   {
>   	return param_set_uint_minmax(val, kp, NVME_PCI_MIN_QUEUE_SIZE,
> @@ -189,10 +194,11 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
>    * An NVM Express queue.  Each device has at least two (one for admin
>    * commands and one for I/O commands).
>    */
>   struct nvme_queue {
>   	struct nvme_dev *dev;
> +	struct nvme_prp_dma_pools prp_pools;
>   	spinlock_t sq_lock;
>   	void *sq_cmds;
>   	 /* only used for poll queues: */
>   	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
>   	struct nvme_completion *cqes;
> @@ -395,18 +401,67 @@ static int nvme_pci_npages_prp(void)
>   	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
>   	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
>   	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
>   }
>   
> +static struct nvme_prp_dma_pools *
> +nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
> +{
> +	struct nvme_prp_dma_pools *prp_pools;
> +	size_t small_align = 256;
> +
> +	prp_pools = &dev->prp_pools[numa_node < nr_node_ids ? numa_node : 0];

I'm assuming you are checking numa_node == NUMA_NO_NODE ?
Perhaps it is better to check that explicitly?

Otherwise, looks good
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


