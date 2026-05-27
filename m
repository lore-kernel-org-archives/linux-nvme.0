Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2501DCD6E44
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqjCjeZHrmiswZMkLzOZmen5SdH45oBHZzIwkf4OipM=; b=GY8qwI5BneT+UPQpfufXBctlXk
	MfJ4tOWjUVc2UHX/LEpRAGBy6z4tp46vJEJGa6KxaxAcgw075c51/fjaRTSwdhg9jev/jZzHNIaua
	VZHCsfx0u6/RfGc7bIkQcppLdkjmkB438b5UWgKxT705SFnAN5wTBqmpkrVBz80YJ7ZWbjIPSGQC7
	oe6r7qhCljB4ntjXTfzGku8wGYWvW2aBmO9fJ/8cBZlQNDlTsXEyI5l7jv4Yjy5Vm4MwZmxrt5NKg
	b+bfN7PCYibckOt1Mco1T/2hQk49toqOYVEbtxO1+2l7VRn1PEDxrt8tbMTs5jgbvGAIXa8zt4Tm3
	xeONZkyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGOD-00000004QPk-3S4q;
	Wed, 27 May 2026 15:41:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGOB-00000004QOZ-1J0l
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:41:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CAE7A436A8;
	Wed, 27 May 2026 15:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617C61F000E9;
	Wed, 27 May 2026 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896506;
	bh=sqjCjeZHrmiswZMkLzOZmen5SdH45oBHZzIwkf4OipM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQJRZ2oy2oTZ8hbKO/wmJJOisEfzi5H/mHK9aKikfVSaQ7QCNdYeoQD/2ylqxtFO1
	 FCsly6FILsu9balidKhsNmBwh40WNTqd5urRRmAMy74Dn3zoUNGxN4FMp6L/N/dSFP
	 31tU/NcaGXAoc7JkvKF2s/YD8jA/3CHtvkBVOTRiPMdw9Jtyv4t1Wu/lqKnhIv9eTM
	 nKGXb/7EevCmBC88kpbRyHOC5ZSeVoZ1xvPeQ0pBLPM/ILtowkXVIi//qI48aRNNIl
	 8a1iDAbsSZkr9rC20TmnFMez7WDP+9vsoqhYW9ab1pmEH47L5ygDlzf+fELVXnGJn6
	 IUfly1BamrgAQ==
Date: Wed, 27 May 2026 09:41:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: target: rdma: fix ndev refcount leak on queue
 connect
Message-ID: <ahcQuBUf70pBZcdg@kbusch-mbp>
References: <20260527084544.864221-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527084544.864221-1-vulab@iscas.ac.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_084147_375018_BB61AEEE 
X-CRM114-Status: GOOD (  10.14  )
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

On Wed, May 27, 2026 at 08:45:44AM +0000, Wentao Liang wrote:
> nvmet_rdma_queue_connect() calls nvmet_rdma_find_get_device() which
> acquires a reference on the returned ndev via kref_get(). On the path
> where the host queue backlog is exceeded and the function returns
> NVME_SC_CONNECT_CTRL_BUSY, reference of ndev is not released, leaking
> the kref.
> 
> Fix this by adding a goto to the existing put_device label before the
> early return.

Thanks, applied to nvme-7.2.

