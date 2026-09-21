Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAE4C982E6
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=; b=0TsX0FhUO78/HmbhEGFHLdEx0Z
	co57Rz3sm21rRSMdmBEcP7ZnIluG7WfhMnBH9IvSKgC5AKLdQjIG4i3LgDhuhwmSZIotj9mfrjwai
	ZMZWL7ZLX5olHEbwPK0W+cWAXGQIXCKAT7bJ5PO+amWK7eXQCH6e0bd/lFQ0HqPKLk7NJWAdFyyjT
	r6Z+o7hPkIZkz5afJAY01tUrWrh1nCuRm7mLSCGYNcnESynwOQRSAE+SbPpfsg1fLJUBquYc8Tk1u
	GcV/MGRtfm0LGm67rlrp9fPd+IkcNlss08ccEEra8OCIJ2dHLcho3+0gWHvwDAMcYCf2WCJPwdmDo
	wtTgSsew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWK-00000002Vn5-3QAW;
	Mon, 21 Sep 2026 15:01:28 +0000
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eZR-00000002Jmm-3pDG
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 14:00:39 +0000
Received: by mail-ed2-x0f.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so4859586a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999236; x=1790604036; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=;
        b=Ii1E8le0tJID0t4rRu+I2k7SZq3sZdBDLnTbzKCQoFuPI60YfNM01gXbuCDWWIW6iU
         fifXW/0r9oLIKMfYrrJcePYCD6dwGim8M3++ORSO1ojYx3Dq+zlvHJt32wnM6g5PhHal
         HkpiSK3257oLtCl1npSZIPmLVkA6O2O4GU6rb4vyzURdOxfJtSRjhgEtK2G5oNOwJUE/
         A6rMVgiK/0mtmLTQ85hnRMXs+ez2sSHcmSRQV8hIIyL3/37PzJIANlKWtV8hXucc6wF1
         aWQSadr7fe2YK0pf1c936g1A10BdrwRqc9MMyeDTp5hOlYzynrLNXfmLsYUaM8UVolMg
         6Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999236; x=1790604036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=;
        b=P7vPKcBGMgOCI5J+VPxKm0BPklloqjVLWaF9h9DLD2wy7YiymoqtMlIf1l7CwIEROW
         L65JcErj7gRJS9DD8QNOPOWD2K1+ZSk4vxKqFtw5kgZ1SlLbaGN5FfIaYA3klcP/aotC
         D5y101ZQeNk0PzjiQhxYJviEWxExzzaYUBuhJHOMjO8C3l/6ar8SazV2fIJ2mVUd6BJF
         oMvQjFcmcn5g+mAGe9Bs/+2ySEebt46/16JeqSPyCp+ALMnZB2Qr4PQQjYdYn2NqlWHg
         sZDFPx4rHBpQBg/nIhb1tELj1kFyFaG+CsSqJk2yleVgIbha/KriSPJ3ozfsxkY1JXGc
         UNNA==
X-Forwarded-Encrypted: i=1; AKwUvBzLWWA6vKogmgdUuci6GApT7J/bwyRHvOQwGDi7+i+8332aq9tQN+AxxIRzfbN4rTGbonLPggKGC1l3@lists.infradead.org
X-Gm-Message-State: AFuF++nrv29olWt5iVAaQsXj6p7T66L8jINXpttsi8GEfRFFiKA0jU21
	Xq22uuRhvisdwMUk8Cm7ObcZoNBT7ti/w/3yObBZ6JVANZQpKX+IaNYX
X-Gm-Gg: AYBFou0+IQT+kK5nHS3Ge3hIpgMgP2gH21rhbgDQdo235lIlbpBfuP7sT9uFVxugcde
	+d5QHJpuQ4zIpQFoI7/RWQRL+QWyiAiUtExDZwQNzdnOR2DtHr8Z/qIhCCgD4JkDC07uuSzIzj9
	O/ykMFCCBXq0R4Q/+yTRJhtRokIYgVYzHn7ki6PIjg8eCheDyKjpj//wvwAe59QQV2F8tVL4d/D
	AwKEu6chmw/MEevG15Mo5bvGO6yb5DR309GnX57MHqUHgiA4ySVPRm7HCpZujlBaPKw9WCuJRnL
	s4w724KOT1l9xSQWgzzX7QDy1TLoQ6BZQuIH4hCIbHTfj1bIhFV8P/5NeA1czSSmPqAmlPZbBxH
	veKaYTvQ+jck7dQxO1On8t6/gZSFFSw6ELBMcM6kVxRbC8MlbG4Rh+8eXuuMLpFoBzu3wjwjuMk
	385catbJfonAPDWCYu+42cJVa4oPjiUm8dehkfpyC5fYyMxnnLoMQQgvxUFfdxfpwDrHvW/ie+Q
	8Gxg87D9kRcY7eDBhbnC4EwwxsVZbC22BJqLvW0qQpc7otU+ax1PFro12WKGpew1FUWtRDV2pxq
	xhyjalOTkoxTNoSZwfbIQakvrw==
X-Received: by 2002:a05:6402:210f:b0:6a9:aead:4e98 with SMTP id 4fb4d7f45d1cf-6aa577f5cfdmr8223981a12.1.1789999236010;
        Mon, 21 Sep 2026 07:00:36 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e1a45esm4427483a12.25.2026.09.21.07.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 07:00:35 -0700 (PDT)
Message-ID: <14db93d0-b41b-43c6-8934-82d10cc50168@gmail.com>
Date: Mon, 21 Sep 2026 15:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [PATCH v4 01/14] dma-buf: introduce initial
 file I/O infrastructure
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Nitesh Shetty
 <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <181b08be-04bc-4ae9-bb88-15321a82440f@amd.com>
 <anPlbjhpPmj2VZxm@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <anPlbjhpPmj2VZxm@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_070037_975757_DB6C5C49 
X-CRM114-Status: GOOD (  24.51  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:23 -0700
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

On 8/6/26 02:37, Matthew Brost wrote:
> On Wed, Aug 05, 2026 at 10:27:49AM +0200, Christian König wrote:
>> On 7/28/26 23:29, Pavel Begunkov wrote:
...>>> +	/*
>>> +	 * There are no more requests using the map, we can signal the fence.
>>> +	 * It should be done before taking the resv lock as someone could be
>>> +	 * waiting for the fence while holding the lock.
>>> +	 */
>>> +	dma_fence_signal(&fence->base);
>>
>> Signaling fences has a whole bunch of very strict rules associated with it. E.g. you can't alocate memory for example.
>>
> 
> Yes, and the rules around signaling fences from worker threads become
> interesting as well. In practice, the entire workqueue (or any work item
> scheduled on that workqueue) effectively becomes part of the fence
> signaling and reclaim path.
> 
>> Are you sure you actually need and want a dma_fence here?
>>
>>> +
>>> +	dma_resv_lock(dmabuf->resv, NULL);
> 
> So this is illegal because code is allowed to hold dma-resv locks while
> waiting on dma-fences. See dma_resv_lockdep / __dma_fence_might_wait /
> dma_fence_begin_signalling.
> 
>>> +	ctx->dev_ops->unmap(ctx, map);
>>> +	dma_resv_unlock(dmabuf->resv);
>>> +
>>> +	dma_fence_put(&fence->base);
>>
>> You should probably set map->fence to NULL after that.
>>
>>> +	percpu_ref_exit(&map->refs);
>>> +	kfree(map);
>>> +
>>> +	if (refcount_dec_and_test(&ctx->refs)) {
>>> +		/*
>>> +		 * Destruction needs to wait for I/O and dma fences. Defer it to
>>> +		 * simplify locking.
>>> +		 */
>>> +		INIT_WORK(&ctx->release_work, dma_buf_io_ctx_destroy_work);
>>> +		queue_work(system_wq, &ctx->release_work);
>>> +	}
>>> +}
>>> +
>>> +static void dma_buf_io_map_refs_release(struct percpu_ref *ref)
>>> +{
>>> +	struct dma_buf_io_map *map = container_of(ref, struct dma_buf_io_map, refs);
>>> +
>>> +	/* might sleep, use a worker */
>>> +	INIT_WORK(&map->release_work, dma_buf_io_map_release_work);
>>> +	queue_work(system_wq, &map->release_work);
> 
> You can't guarantee that a GFP_KERNEL allocation won't be performed from
> a system worker thread, so you can't safely signal a fence from one. The
> pathological case is when all threads in system_wq are running work
> items that perform GFP_KERNEL allocations, enter reclaim, and then wait
> on a fence that is signaled by another work item queued on system_wq.
> Since all worker threads are occupied, the signaling work item cannot be
> scheduled, resulting in a deadlock. We actually hit this exact deadlock
> early in Xe.
> 
> So, as Christian says, think carefully about whether you really need a
> dma-fence here. If you do, then you need to play by the rules.

I started with moving it out of wq, which was a good idea anyway,
but as mentioned in another email, in the end I just got rid of
fences as I believe Christian was suggesting / hinting on. I cc'ed
you on v6 if you'd be curious.

-- 
Pavel Begunkov


