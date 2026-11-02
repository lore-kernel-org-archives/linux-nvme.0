Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51552606E02E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W3kLqfp9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZudVGusq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P9QOz6y3xfqVjgcaci9v480+CGZcm/1tKOJFlnBqKrw=; b=W3kLqfp9DbYvGYstnJyoP7MJrs
	/wktNoyTA/KfPxpCLpuJOcBTJoZcAr/khOAn+ac+wT8bVRXQd4jabnQV96qce31KEmliT4ye4ezNN
	zVDy5ZODPI7RAZJ/6mRMLxc7mHRswNbHHwKc4/tBzxI44jCWXALNXvR6XKP6xebFWWa8NXf2kuFfk
	Lqgxas9ij+E4lwPcv48QNwkAQIqUY9pHCvduO7MI7XO3I/O3qy3gOYnu22VJ7GjzcIRYRxjkSxsJ1
	8ohjcqe6s1d/aixEe13TjuHRatTkjt05GAcDCNGLCTCKh8hu94ZqYHjpOrec7n7JEqueEMw+cp8g1
	E6nz9r1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvqG-0000000HSdD-03ge;
	Mon, 02 Nov 2026 17:29:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvqE-0000000HScy-3MMP
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 17:29:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 63AA243902;
	Mon,  2 Nov 2026 17:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6FC1F00A16;
	Mon,  2 Nov 2026 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640546;
	bh=P9QOz6y3xfqVjgcaci9v480+CGZcm/1tKOJFlnBqKrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZudVGusqLYGAx/e8LMaMBzz7M6KkTZ78umyHo4OiN9jvTnmgkfRa1+z4UkCPRJFb2
	 bC6XoRVhIwzAxjZujKBKTDGS8UxYGY/3FAI/hAnMVkRgROjBAS9cBe+d5+aG50hCuM
	 Q15V6hTCqgpJrlJsUvvdcfrNJkbA7NYJrY+gfSWqT7mIPIwseV4P17OnQXe4j30822
	 BWn66180U50nNi1QTXJ6RT6NFAM9KphUql29xB5YKKKHeI1fqLw3K0CyobZG1rAxEW
	 X34/qdz6lU3IqtXVFpt55mBs2tQ1AfDU590+VkVZu2epRTWa8gR5KmN+ZeIKBsz7XK
	 TzQpY1UnRsSHQ==
Date: Mon, 2 Nov 2026 10:29:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, john.garry@linux.dev,
	nilay@linux.ibm.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Do not drop the cdev reference twice when
 cdev_device_add() fails
Message-ID: <aujIYJZvZzJrTrne@kbusch-mbp>
References: <20261102095015.36448-1-izaiahsun@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102095015.36448-1-izaiahsun@gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 05:50:15PM +0800, Yuqiang Sun wrote:
> Since commit 9952f3882ecb ("nvme: fix cdev lifetime"),
> nvme_add_ns_cdev() and nvme_add_ns_head_cdev() take a reference to the
> namespace (or namespace head) before calling nvme_cdev_add(), to be
> dropped by the char device's release, nvme_cdev_rel(), and drop it
> themselves when nvme_cdev_add() fails. But when cdev_device_add()
> fails, nvme_cdev_add() has already put the device, and nvme_cdev_rel()
> has already dropped that reference: the caller drops it a second time.
> 
> With one allocation failure injected into cdev_device_add() for a
> namespace on an NVMe over loop controller, deleting the controller
> gives, with native multipath:
> 
>   BUG: KASAN: slab-use-after-free in nvme_put_ns_head+0x21/0x140
>   Write of size 4 at addr ff1100000a4ea078 by task init/1
>    nvme_put_ns_head
>    nvme_put_ns
>    nvme_remove_namespaces
>    nvme_do_delete_ctrl
>    nvme_delete_ctrl_sync
>    nvme_sysfs_delete
>   Freed by task 1:
>    kfree
>    nvme_ns_remove
>    nvme_remove_namespaces
>   refcount_t: underflow; use-after-free.
> 
> Take the reference in nvme_cdev_add() instead, right before
> cdev_device_add(), and let the callers neither take nor drop it. Add
> nvme_is_ns_cdev() for the check that nvme_cdev_rel() and nvme_cdev_add()
> now share.

Thanks, applied to nvme-7.4.

