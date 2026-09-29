Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199F3CA5FAB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CYIGon90Dpyxdyj2gt7ks36c8ww0+aJ1J2OviNXcD4=; b=pRrru0uqd3B8o0OaNGFNXdV9ob
	IWzrQ0hoxZ+xLrwhNek47c+6aXYBZrI08vFwVHOp8a7q6u/iqkWaFbSnBPdCMsnuexZP1uxXYNcBc
	9USFqiyaGKD1JMVJ/WcDxos50Qy6whEvobtNVFrvcTfquLYnKq4oQ7eJ5ztOHLHkHkM+CkcPHtMdx
	8n6ck9+Ym3ukbFQdMnE33b5wnCRCuukxsLXTNwGdSthX8f8nZZzsyZg+ZrTLHUQJRVwFf08T7G/DN
	e1iVcH7ULw7HxhW0bTg0exEMALslgN4pf2kPPcSLBJBwMwROjG6qzbvIDeEpWYgpwdqSMI3m0nzgV
	VYyjUcXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBnQq-000000055rw-2XvY;
	Wed, 30 Sep 2026 06:04:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBfrr-00000004f12-1YNi
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Sep 2026 22:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/CYIGon90Dpyxdyj2gt7ks36c8ww0+aJ1J2OviNXcD4=; b=rZzU0duYyx0pNRmxJmOSxbXaPq
	lMa9DpErPOPHklV25ARfu8IWjm8x0GyJ6iDjJ8nr/tqeK+u6O35kWH4hJXW+anwAKm+8WWNGtyRrA
	l8oSSPJ5V8eEbdVG8GRHE465+vzGVfBv9n8NzUXQJnREncWHb6/+2QNSy6kkgqpV3l29BNhdo2EFt
	aicCS8MGX/29lJf0QD+GXlXRbTHR0VobMmvLtnNEyyTv5Qgw+majht4pF+uvvbS2A5Y3xqypnQD7C
	C479c1MxrjWnagR72jh9blToZtFxXYmWX1qE4BgcK6fg/LcWYUCiWZtFZQmBGvBuZhSKJb3XO5YCO
	0iT7upIg==;
Received: from smtp-68.smtpout.orange.fr ([80.12.242.68] helo=smtp.smtpout.orange.fr)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBfrn-000000037tG-2LpM
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 22:00:05 +0000
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.65.86.61])
	by smtp.orange.fr with ESMTP
	id BaRaxbqiWDYEzBaRaxk9aB; Tue, 29 Sep 2026 18:12:38 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id BaRRx1oDtLJYiBaRSxYYGg; Tue, 29 Sep 2026 18:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1790698358;
	bh=/CYIGon90Dpyxdyj2gt7ks36c8ww0+aJ1J2OviNXcD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eORPkq/KW8MQ+EAJSBy1x5irQF+H5qrTe5xccMDxElj9P2uXgSBHPxUwVpHTVCll6
	 5SVS/MDDhsDAZGN4AAL0A+pqjb3JpY0oiJi4RmA5a2LsMfvbHjAfYgoydzIlArDdd3
	 1gNGXNA6SYakaOVh4qsBVXhu7PPIDqHRVc+uJ/UQNcK+k5bW0OlHVkqB8NEKLzVQbj
	 WrWFK64mS0JYUGD9+lH3bZ6lo+erqhiqIDJbsj/gkK48oHXui/eMVQUzABmKt1pdft
	 A2BL3SeatpaJfbpiuXOHSGDlcAsarPXrMFwp14ziu6eev4OWwWLbbyK8angPUWfxcq
	 OziQJNEFIbFpw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Sep 2026 18:12:38 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <2620af49-ddd9-4df6-848a-d7c93e8a1c03@wanadoo.fr>
Date: Tue, 29 Sep 2026 18:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: Pavel Begunkov <asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
 <c33046bbadce5a2f14aa1874270ec2d10def58ef.1790602223.git.asml.silence@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
Cc: agk@redhat.com, akpm@linux-foundation.org, anuj20.g@samsung.com,
 axboe@kernel.dk, bmarzins@redhat.com, brauner@kernel.org,
 christian.koenig@amd.com, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, hch@lst.de, io-uring@vger.kernel.org,
 jack@suse.cz, joshi.k@samsung.com, kbusch@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
 phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
 sumit.semwal@linaro.org, tushar.gohad@intel.com, viro@zeniv.linux.org.uk,
 william.power@intel.com
In-Reply-To: <c33046bbadce5a2f14aa1874270ec2d10def58ef.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_230003_770404_4DED2664 
X-CRM114-Status: GOOD (  26.48  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 23:04:42 -0700
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

Le 28/09/2026 à 15:32, Pavel Begunkov a écrit :
> The goal is to be able to natively use dma-buf in the read-write / IO
> path. This patch adds basic building blocks serving as a glue and API
> between drivers and upper layer subsystems providing the uAPI. Later
> patches implement it for NVMe raw block devices and expose it to the
> user space via io_uring.
> 
> There are two main objects. struct dma_buf_io_ctx and struct
> dma_buf_io_map. The ctx is used during initial registration and serves
> as an interface between the upper layer user like io_uring and to the
> importer subsystem / driver. The map represents the actual dma map
> established for the target device[s] with dma_buf_map_attachment() and
> stored in a device specific format. The context is created via a new
> file operation ->init_dma_buf_io_ctx.
> 
> The ctx-map separation exists to support map invalidation (see
> dma_buf_io_invalidate_mappings()). A ctx can create
> multiple maps during its lifetime, but there can only be no more than
> one (active) map attached to it. Invalidation drops the active map
> if present, and the next map will only be attempted to be created
> once there is a new request that wants to use the dma-buf IO ctx.
> 
> The primary task of the dma_buf_io_map object is to count requests
> using it and to wait for their completion when we want to destroy the
> DMA map.
> 
> [un]mapping and any work with dma addresses is delegated to the
> importer driver via an ops table stored in the ctx, see struct
> dma_buf_io_ops. Only the target driver / subsystem knows about devices
> it wants to use the dma-buf with, especially in case of multi-device
> filesystems or stacking in the future.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

Hi,
a few nitpicks below, should it help


> +static void dma_buf_io_kill_maps(struct dma_buf_io_ctx *ctx, bool final)
> +{
> +	struct dma_buf_io_map *map;
> +
> +	scoped_guard(mutex, &ctx->map_mutex) {

guard() is enough. This saves indentation.

> +		if (final)
> +			ctx->maps_killed = true;
> +
> +		map = rcu_dereference_protected(ctx->map,
> +					lockdep_is_held(&ctx->map_mutex));
> +		if (!map)
> +			return;
> +		rcu_assign_pointer(ctx->map, NULL);
> +		percpu_ref_kill(&map->refs);
> +	}
> +}

...

> +int dma_buf_io_ctx_create(struct file *file,
> +			   struct dma_buf *dmabuf,
> +			   enum dma_data_direction dir,
> +			   struct dma_buf_io_ctx **out_ctx)
> +{
> +	struct dma_buf_io_ctx *ctx;
> +	int ret;
> +
> +	if (!file->f_op->init_dma_buf_io_ctx)
> +		return -EOPNOTSUPP;
> +
> +	ctx = kmalloc_obj(*ctx);

kzalloc_obj() and save the memset() below

> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +	ctx->dir = dir;
> +	ctx->dmabuf = dmabuf;
> +	get_dma_buf(dmabuf);
> +	mutex_init(&ctx->map_mutex);
> +	mutex_init(&ctx->map_create_mutex);
> +	atomic_set(&ctx->active_maps, 0);
> +	atomic_set(&ctx->all_maps, 0);
> +	refcount_set(&ctx->refs, 1);
> +	init_waitqueue_head(&ctx->maps_wq);
> +
> +	ret = file->f_op->init_dma_buf_io_ctx(file, ctx);
> +	if (ret) {
> +		kfree(ctx);
> +		dma_buf_put(dmabuf);
> +		return ret;
> +	}
> +
> +	if (WARN_ON_ONCE(!ctx->dev_ops ||
> +			 !ctx->dev_ops->map ||
> +			 !ctx->dev_ops->unmap ||
> +			 !ctx->dev_ops->release))
> +		return -EINVAL;
> +
> +	*out_ctx = ctx;
> +	return 0;
> +}
...

CJ


