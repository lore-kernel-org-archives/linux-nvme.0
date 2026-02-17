Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE1BE9A02A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JtVQJznWcMU3EtQip6TH1B2G2S7st0X3mSN/8xMUz/w=; b=Y5gT3eSF4601zrAKvBI2oGgx9+
	rJBAD706ZF7D98SQTTcAKJHz1aR9mTSL5fvtvB6C40Nx0QyJzdEtBdll3yEKCdMUdIuF9ipj5Vnv9
	80fjmpNr6FixJbHaA+JGAMUNAPRqBQcKbL9dk8BD1BhtrS2T3NKDVfkOZG+VK4Ugyw+o4JspksA9M
	yFZMHRb4uSP2r7eZ9j7uoihSBmRj53RMlwyyUBK5mcX0euH5nh+Rp97/8RanuA1ZngtBazyunrAtv
	3TC5gpof3n4ieQtH4B9s6fJ5WrGcn+GnE55cmU+uMAqn0pCCWREl5/CuPlX661xUlEwCt1BUfx3xv
	236Y0ZwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPcs-00000008hWx-0A4Q;
	Tue, 17 Feb 2026 18:16:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsPco-00000008hWQ-0xvu
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 18:16:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 403B1438BE;
	Tue, 17 Feb 2026 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C4FC4CEF7;
	Tue, 17 Feb 2026 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352201;
	bh=7Kkx2FT+QPwYCHNPkbBayVFbOUk66ixqklHB6vS5Lj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgdUwTojIm8NvnsFjtTTJln/KD0QDJFHpDXo9BdBLx0xrlbPL//Vh13OZyqtup5lL
	 6ibzQ0XFNpSesDqzFbSikMDQfw+AETvkxTI/ySGSYDA7Lc2oupvsAT+DZjBbjL7LGH
	 y384M0SFt7GYjdWZFkGNVpDSPUVh6KcP/SM5umW0hu43tQ0zfchYTnAxDVWM68e4Du
	 st0md2qfCpf7gfFKnE7g498b1pRRlI75f6fGqXU8H2YHSXTpGg6qYkaLj3SswVBVYq
	 vA0xWmjQ4QCrx48ffBXIU+cSvmNvfaWj1V1zQQDBeMZW77iMWCvdlESrkSpFL+vZW7
	 ZQYDRbyp+hgUQ==
Date: Tue, 17 Feb 2026 11:16:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: move async event work off nvmet-wq
Message-ID: <aZSwhqJHPmAFcvd5@kbusch-mbp>
References: <20260215012151.11684-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215012151.11684-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_101642_309831_56537D00 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
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

On Sat, Feb 14, 2026 at 05:21:51PM -0800, Chaitanya Kulkarni wrote:
> @@ -26,6 +26,7 @@ static DEFINE_IDA(cntlid_ida);
>  
>  struct workqueue_struct *nvmet_wq;
>  EXPORT_SYMBOL_GPL(nvmet_wq);
> +struct workqueue_struct *nvmet_aen_wq;

Looks like you need to export this new symbol since rdma may be compiled
as a module.

> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -2088,6 +2088,7 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
>  	mutex_unlock(&nvmet_rdma_queue_mutex);
>  
>  	flush_workqueue(nvmet_wq);
> +	flush_workqueue(nvmet_aen_wq);
>  }

