Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27227606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LAMC0ezY;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0odHC5c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lBVErfdaD5I5AYIMyeYZ8mUmOaA4TcHGsRCFrhmCtDY=; b=LAMC0ezYV7uAAX7J6+k5SWX/eQ
	K3qaV8gDE1IJ2IsFMiKapjHGzyH4jYWEaEsSPZoSFsuGTM5GmUxVRAKtNZ456xI3JpPlvVWEZU0dT
	aPoalJIhPMAuy4pZb/4YyITxKYZOj/1cZSsFfscYh2VZWxO++SC2EOMs5Ab3OVk58v8qmiJ7lIUqB
	mbGivNdfzU5DGjuYf3Gx5eBOHi7rHhxiuiMgERMxlFT8VWke8ZqLLqGzKwlNZxAZpeGn9qMc/APkn
	a/a8NuWrcxCntW8Qp4gle0apibyw8YLIM2dgU9z8I8DqrWcZDzUL76vfxo2pBvlkyTB/wuzQNacRL
	4k8vKDUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5it-00000007QDr-3aXm;
	Wed, 28 Oct 2026 15:37:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5is-00000007QDR-3hMq
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:37:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BBF4660207;
	Wed, 28 Oct 2026 15:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B2E1F01825;
	Wed, 28 Oct 2026 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201873;
	bh=lBVErfdaD5I5AYIMyeYZ8mUmOaA4TcHGsRCFrhmCtDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0odHC5cdHs7S4S9WvYGAyaVxd0JegzvuCgXuI2E+RBR+CX3/N8LbO9G7S3Cza0b6
	 AvZ8zeVPuhc9vbWPD5PAV6Dxx+Xlggs4dIoQDGHOYi5KYRSNpmH2J8Wq+Ct6raBwbI
	 OYxwCblXb75ocwNYFrh2FLxvx7dH10cmTQw3AGWmL2g4iRwdOBjvb17zASV43M6CUo
	 vN4aprO5tOwxX0cgr7KX2qSj8HiDzZz4F1hlb7tQkxDFFJBHBGp4SjATBYv58/GVSE
	 Ekq4qP5SzL7WNAtOmaDp2s4ovOObXCX+1CHpV+IviUwisTXchhVYm6Tk24ArBKBZpR
	 aNUVkDyufySNA==
Date: Wed, 28 Oct 2026 09:37:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Seiji Nishikawa <snishika@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex
 is held
Message-ID: <auIWzzvH28ubRoF5@kbusch-mbp>
References: <20261014064524.4015025-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014064524.4015025-1-snishika@redhat.com>
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

On Wed, Oct 14, 2026 at 03:45:24PM +0900, Seiji Nishikawa wrote:
> Commit f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
> added a check in nvme_tcp_io_work() that sets pending to true when the
> queue has pending requests and the socket is writeable. The check is
> placed after the mutex_trylock() block, so it also runs when
> mutex_trylock(&queue->send_mutex) failed and io_work did not send
> anything.
> 
> When .queue_rq sends a request directly from its own context, it holds
> send_mutex and can give up the CPU in lock_sock_nested() when another
> task needs the CPU, for example the io_work kworker of the same queue,
> which runs on the same CPU. Then io_work cannot take send_mutex, but
> the requests are still on req_list and the socket is writeable, so
> pending is set to true. io_work loops until the deadline and queues
> itself again on io_cpu, without sleeping.
> 
> This is a priority inversion. io_work runs on the high priority
> nvme_tcp_wq and cannot make progress until send_mutex is released, but
> it keeps running. The task holding send_mutex runs at normal priority
> and needs the CPU to release it. The scheduler keeps giving the CPU to
> io_work, so the task holding send_mutex may not run again, and the
> requests on the queue are not sent and time out.

Thanks, applied to nvme-7.4.

