Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD9606D81C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pppHsYwZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jObjKbD3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VwRipOt2v1Wu+ih94hGyTqjHldEuWpMzFu2G96qaATo=; b=pppHsYwZ+GBxNgZLxRnk80KeDS
	8inDNzv2CMESEg01qV1RGJB+OevR4DFSKvNWB3kLQ4TvawhHfYbJ4iMGVzZp+mwc6pHzD9Bs3RMFD
	QmmSZMQekQRAIF9syVL83w+PnGSTMcHci6/g7PvEQ4c2Q/5lFZkoZkAg6a0554XFJhuVyaAREhtmC
	D/vgNdceDY9qNQVar8KQQJQwXBz8bFMvO9KJwTD5bXi+YYqtff2X4Cj36ArFx01+8xnb2FdiIlvtj
	3Mzx4XfPjwEw2sD+z2JkKXItwc/JTU+fHbj1vV1IkjaCFfz50TEimnnd6gkHp60Y/MZKtYchBw7an
	27bPDbSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvoq-0000000HSFn-2vRS;
	Mon, 02 Nov 2026 17:27:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvop-0000000HSFc-36hZ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 17:27:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 482D741975;
	Mon,  2 Nov 2026 17:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2991F00A16;
	Mon,  2 Nov 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640459;
	bh=VwRipOt2v1Wu+ih94hGyTqjHldEuWpMzFu2G96qaATo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jObjKbD34vnvxMS0T0D0vyB/Pv2KKp0hTIAL3hJxf61hVwja4ydGnk5qaeW/gR1Du
	 g/XZhnzftPadlZ2CaCVFmBjSNGXLUV4RJXQU4EqFyEWVD8bwxKqivbE5iXImTY7uMd
	 ron9vQQWxNoBU8/NQdzeLkOA1Yt1JQN6janbV3g/fktDb44I7JysFhfVRo9HQBRuav
	 qcS+Ded8BMTmA/k890UqA61yiryAwHPPc5edOie6G1L03r7ioqOjHdrRM2L1tHqvJy
	 eDhd4ou2qhP1NGtDTqk2mghyXTOHVKzGirN2lLg/CvbM/LLfrtrhQjaJPFF2MAQes3
	 /CyS5hisUPGxg==
Date: Mon, 2 Nov 2026 10:27:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, sgogte@purestorage.com, hare@kernel.org,
	nilay@linux.ibm.com, wagi@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-rdma: fix NULL queue->ctrl dereference on
 reconnect
Message-ID: <aujICaAOXU_yx8K7@kbusch-mbp>
References: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
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

On Thu, Oct 29, 2026 at 11:19:57AM -0300, Christian Aurich Zanettini Martins wrote:
> Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
> and startup"), a reconnect that gets more I/O queues than before grows
> the tag set before the new queues are set up. queue->ctrl is only set
> by nvme_rdma_setup_io_queues(), so I/O submitted in between reaches
> nvme_rdma_queue_rq() on a queue that was never allocated and
> dereferences a NULL queue->ctrl:
> 
>   BUG: kernel NULL pointer dereference, address: 000000000000034c
>   RIP: 0010:nvme_rdma_queue_rq+0x52/0xb90
> 
> Set queue->ctrl for every queue when allocating the controller. Such
> requests are then requeued like on any other queue that is not live.

Thanks, applied to nvme-7.4.

