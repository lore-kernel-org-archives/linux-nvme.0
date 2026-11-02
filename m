Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF5606A324
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W2JXCh3p;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N3zh5s1o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BsXw+czBIaD5ahRcLhBvUcJXLDKn9snEMWTHOIglfVg=; b=W2JXCh3plLL32j
	E+Ve8yqrhP5wkWmPd22vQEGOBdq47bUU6smjVGYlB7WzQfz+r3yRI871sRXyTBBexW50CJpal8Rzp
	QjAijhDudAuAzSYRIqsNbvqxNJQOeFDI9ReLBWBCfZN3vUMHAXzgLaVz9XOsaSn/jTXupruy6apcD
	fnk92xqP2BXEKUeFWmHBOKV/j3BQ8OCwRj/JDv1fKWvF7w8MamWUZF0QI2aNFiwcgUqoUQEgD9aPn
	wqIfa9gKQzGht4mwbhLzhLkc33gFQqNJ/PP55SKKVbV4HUcBlj+3jk5rkdXpAXGSGtYagW7zpENYN
	lZdvzF6QAA1MO1wW6UAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNo8f-0000000FyB7-3qfu;
	Mon, 02 Nov 2026 09:15:37 +0000
Received: from out-55.mta1.migadu.com ([2001:41d0:203:375::37] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNo8Z-0000000Fy6S-2QVq
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 09:15:36 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=E9eY0rmbdkTqFFfuwggONOMkeaiFYztsdlVJOi00Sbw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793610928; v=1; x=1794215728;
 b=N3zh5s1oYmiFhYt2aLg1o0jd/05WJ0tXLnmb1UBCQoEWyPkD2uOpj2rj+q/vQk1s4W8+r0ZN
 C5nTXmMzbwRM6BuEfk33j5WyCbguczy3cZRah0Zgm2wbwX9i8GHpW22i188PSVxcd024d+qHdfw
 GgtLIjA9fLi0LbC4pgt2puB8=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id c8e4aa2d386a5ce6;
	Mon, 02 Nov 2026 09:15:25 +0000
X-Mizu-Trace-ID: c8e4aa2d386a5ce6
X-Migadu-Flow: FLOW_OUT
Message-ID: <be048b16-c286-4d1c-9539-7ae4a322f0d7@linux.dev>
Date: Mon, 2 Nov 2026 09:15:24 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Do not drop the cdev reference twice when
 cdev_device_add() fails
To: Yuqiang Sun <izaiahsun@gmail.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: nilay@linux.ibm.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261101173400.98931-1-izaiahsun@gmail.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261101173400.98931-1-izaiahsun@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_011532_124366_3AEFF675 
X-CRM114-Status: GOOD (  36.59  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 17:34, Yuqiang Sun wrote:
> Since commit 9952f3882ecb ("nvme: fix cdev lifetime"),
> nvme_add_ns_cdev() and nvme_add_ns_head_cdev() take a reference to the
> namespace (or namespace head) before calling nvme_cdev_add(), to be
> dropped by the char device's release, nvme_cdev_rel(), and drop it
> themselves when nvme_cdev_add() fails.  But when cdev_device_add()
> fails, nvme_cdev_add() has already put the device, and nvme_cdev_rel()
> has already dropped that reference: the caller drops it a second time.
> 
> The namespace (or head) is then freed while it is still in use.  With
> one allocation failure injected into cdev_device_add() for a namespace
> on an NVMe over loop controller, deleting the controller gives, with
> native multipath:
> 
>    BUG: KASAN: slab-use-after-free in nvme_put_ns_head+0x21/0x140
>    Write of size 4 at addr ff1100000a4ea078 by task init/1
>     nvme_put_ns_head
>     nvme_put_ns
>     nvme_remove_namespaces
>     nvme_do_delete_ctrl
>     nvme_delete_ctrl_sync
>     nvme_sysfs_delete
>    Freed by task 1:
>     kfree
>     nvme_ns_remove
>     nvme_remove_namespaces
>    refcount_t: underflow; use-after-free.
> 
> and without it, a use-after-free of the namespace in
> nvme_mpath_clear_ctrl_paths(), the namespace having been freed by the
> last close of its block device, followed by a general protection fault.
> 
> Take the reference in nvme_cdev_add() instead, right before
> cdev_device_add(), so that it is held exactly while the device can be
> released, and let the callers neither take nor drop it.  The earlier
> failures in nvme_cdev_add(), ida_alloc() and dev_set_name(), return
> before the device is initialized and so before the reference is taken.
> 
> The problem was found with kbound, a static analysis prototype that
> checks whether callers rely on an object after a callee returns a value
> for which the callee may have released it, on v7.2.12; it is present
> in mainline.
> 
> Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
> warnings.  Run-tested on QEMU (x86_64, KVM) with KASAN: a loop target
> exporting a null_blk device, connected through /dev/nvme-fabrics, with
> failslab failing each allocation under nvme_cdev_add() in turn, with
> nvme_core.multipath=N and Y.  Before this patch, every failure in
> cdev_device_add() (7 of 7 with each setting) gives the reports above;
> with it nothing is reported, also with lockdep and kmemleak, which
> finds no leak either.  A failure in dev_set_name() gives no report,
> before and after.

Please ensure that you test my original issue reported. I am not sure if 
I added a blktests case for that...

BTW, I think that the most of the text after the KASAN stackframe, 
above, is unnecessary.

> 
> Fixes: 9952f3882ecb ("nvme: fix cdev lifetime")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>

Apart from small comments:
Reviewed-by: John Garry <john.garry@linux.dev>

> ---
> 
> Notes:
>      The bug was found with kbound, a research static analysis prototype.
>      The patch, the changelog and the test setup were written with the help
>      of an AI coding assistant (Claude); I have reviewed and tested them as
>      described above.
>      
>      The runs were on next-20261030; the code this patch touches is the same
>      there and in mainline, which it is based on.
> 
>   drivers/nvme/host/core.c      | 13 +++++++++++--
>   drivers/nvme/host/multipath.c |  2 --
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af71d02b8476..f9d23e9d35ec 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3978,6 +3978,17 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
>   	device_initialize(cdev_device);
>   	cdev_init(cdev, fops);
>   	cdev->owner = owner;
> +	/*
> +	 * Held for the lifetime of the cdev and dropped in nvme_cdev_rel(),
> +	 * which also runs when cdev_device_add() fails.

I think that "which also runs when cdev_device_add() fails" becomes too 
verbose.

> +	 */
> +	if (cdev_device->parent->class == &nvme_class)

We have this check twice now. You could put this in a helper at this 
point, named like nvme_is_ns_cdev(). This would make the check clearer.

> +		nvme_get_ns(container_of(cdev_device, struct nvme_ns,
> +					 cdev_device));
> +	else
> +		nvme_get_ns_head(container_of(cdev_device,
> +					      struct nvme_ns_head,
> +					      cdev_device));
>   	ret = cdev_device_add(cdev, cdev_device);
>   	if (ret)
>   		put_device(cdev_device);
> @@ -4010,13 +4021,11 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
>   {
>   	ns->cdev_device.parent = ns->ctrl->device;
>   
> -	nvme_get_ns(ns); /* Undone in nvme_cdev_rel() */
>   	if (nvme_cdev_add(&ns->cdev, &ns->cdev_device,
>   			&nvme_ns_chr_fops, ns->ctrl->ops->module,
>   			ns->ctrl->instance, ns->head->instance)) {
>   		dev_err(ns->ctrl->device, "Unable to create the ng%dn%d device\n",
>   			ns->ctrl->instance, ns->head->instance);
> -		nvme_put_ns(ns);
>   		return;
>   	}
>   	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9e0a0fd77c56..ae8059366b57 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -681,14 +681,12 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>   {
>   	head->cdev_device.parent = &head->subsys->dev;
>   
> -	nvme_get_ns_head(head); /* Undone in nvme_cdev_rel() */
>   	if (nvme_cdev_add(&head->cdev, &head->cdev_device,
>   			&nvme_ns_head_chr_fops, THIS_MODULE,
>   			head->subsys->instance, head->instance)) {
>   		dev_err(disk_to_dev(head->disk),
>   			"Unable to create the ng%dn%d device\n",
>   			head->subsys->instance, head->instance);
> -		nvme_put_ns_head(head);
>   		return;
>   	}
>   	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e


