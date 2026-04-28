Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1762EFF885A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 06:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4VBDagW4aweo+iZH0qQhRxEESp37ni3JZlBA6aeVe8=; b=XnANWVPui33QVTr9QKKGvZ934E
	nzyeUOMzXMmeg7KfYOk2UiaVCklQnCfe2FYgtDQUI3gNe6uolJS7U17CklxKHVCWLcOZ1aXFq0e2E
	a31GtEbRHtqBWst7doRfPkw2d7tk7NpWXB2pihf0gaiGPdVm2M7DQLOmvu6oxgSBZ7M+BE6WHSJ3P
	TUP8Ctq3DqKzRYsIEAV+ZdlVc6aXP1R//9kGx3/nqNMoPnHITZKQeIuF/N30IJyeTfDRegElyr3i2
	PrXWvOdS/7/2R8iCtzmWutGTRlWCyJrZky+zKNOUliwmJM5yIPngKLaj2Dx4MjdMH37oMEZNz8l+k
	tAtrgT4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcEg-00000000eEA-0Hya;
	Tue, 28 Apr 2026 06:47:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcEd-00000000eDo-3MC3
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 06:47:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D57240417;
	Tue, 28 Apr 2026 06:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953ABC2BCAF;
	Tue, 28 Apr 2026 06:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777358874;
	bh=3VxQk+Tk2oer+AyPfMEcqUa0f45bZsgjE56+xlDSZIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mN5lud5xIebowaytiGtCjd7qdmkM9RlmngFkdS3VrYBtwlaXelfhlmtY5TUAOzU2U
	 uNTYCCva8ZyebF3H2W06fEJqlix4U19Xz82cfeeZK7HqZdqJo0Ab47zI4QI/RrMqIW
	 H7f9L/+5ZRwhUAPUyGx/Yh/GoQ4KHi6BstX0eUI7Rtw0e4aR8x0h6JhuS1R2sAllZt
	 e82TIKedLKLBrn9elUdLUpI26fESkmpRNYO1Q+snYmmcwWk950sjg5ZIQLhYcnsStS
	 4RmvGt0OdgwnOmRYBM8zTk8wUSLw0Sp5RQisUKNJ+TUS4tnYZ0brJ6aC7Bb1Z3SElR
	 NcdxRwaVNGi0w==
Date: Tue, 28 Apr 2026 07:47:49 +0100
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
Message-ID: <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
References: <20260428022911.1288485-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428022911.1288485-1-coshi036@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_234755_861220_FA009F49 
X-CRM114-Status: GOOD (  12.99  )
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

On Mon, Apr 27, 2026 at 10:29:11PM -0400, Chao Shi wrote:
> nvme_keep_alive_work() always allocates with BLK_MQ_REQ_RESERVED, but
> nvme_alloc_admin_tag_set() only sets reserved_tags for fabrics.  Since
> commit b58da2d270db ("nvme: update keep alive interval when kato is
> modified"), userspace can start keep-alive on any transport via Set
> Features (KATO), after which the allocation trips WARN_ON_ONCE() in
> blk_mq_get_tag() and fails with -EWOULDBLOCK:
> 
>   nvme nvme0: keep-alive failed: -11
> 
> Reserve one admin tag for keep-alive on all transports.  Fabrics keeps
> two, the second being for the connect command.
 
> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
> 
> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
> 
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
> 
> Reproducer (run as root on an unpatched kernel with a PCIe NVMe device):

You have a PCI controller that doesn't return Invalid Field In Command
status to the KATO feature? That's weird, it's fabrics specific feature.
I think the right thing to do is simply skip the driver's KATO start for
PCI.

