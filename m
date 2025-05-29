Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43385C54FB3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 22:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGPutEWDo5950O4FbUxjK979wbG+zFcdwBJS4P9aOyg=; b=lDXcVbrUwZpseTPiuCnkeGFZBU
	i3jQ5UdwGmisyPgvqC9cAG2YehoeaV1xoUpkMTvKdkRG14tYPIV31oMuD/RHwAem+OP/KNWzEJwj3
	0i0ICgE85uKTZSZVvBYlvfg0syWFWikyUPXead98K3DL0ECVFDmHP7zTxOLJoDYrjPE5jR7fRpzxH
	3hDFNEiUZEr02guYqzQfF5toW9/gl85aGyh9KIO2Y8O45ZyRH3j2Hgs9XZCPgkK1bDGIX1byQJfdy
	qNFpDzER9IdTHGQ9yp7MpNPVwW13Q064CJ7HdCJ1dk7DGPECMoBdoEVEZpv3m6dnO+7UCwAHZQowL
	6jLDs/eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKlVB-0000000GbqT-0Lyc;
	Thu, 29 May 2025 22:13:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKlV9-0000000Gbpf-09uy
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 22:13:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0BE06444BB;
	Thu, 29 May 2025 22:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DB5C4CEE7;
	Thu, 29 May 2025 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748556805;
	bh=q0eBMKlDwAs8NFjYwQFQjGfQ+gHCHGGcfAf/pDUAN48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGyIwl7+9CxWN2VRNXZPuCGH9ajEhdOoDdRtw/WiCsSLSvNknQ2XVHVkaflGEewue
	 TLQ0UykblHPvBzBXcnrg/6fwWBbNPHBDs1JPwZdiC4iWxR98mhOzxXHyI7KNPesrit
	 r+IGli3PbeL2gZAceSEWnk4n8Zuj+OGjFIC2YdeCL1TPpGmxXZFo4m+jt7Chhsq/GG
	 Mbrf5y0CkH8KT40ooqdScHKBBHaS7KurCPJFwHnCyWFo5p+GuTBzVzXaJz8B3qR2GC
	 YIjfljCcxGjmg+/QCNVaSFhZbZIlX9h+1YyLqU3J9rK9KBVfXHxkn+aL/lngc732Sb
	 B3MdRZX9izuWA==
Date: Thu, 29 May 2025 16:13:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout
 timer
Message-ID: <aDjcA_H7Ec9VICps@kbusch-mbp>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529214928.2112990-1-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_151327_102733_9C98FDDB 
X-CRM114-Status: GOOD (  16.07  )
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

On Thu, May 29, 2025 at 03:49:28PM -0600, Mohamed Khalfella wrote:
> nvme-fc initiator hit hung_task with stacktrace above while handling
> request timeout call. The work thread is waiting for itself to finish
> which is never going to happen. From the stacktrace the nvme controller
> was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
> We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
> because blk_sync_queue() must have been called on this queue before
> switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.
> 
> It turned out that blk_sync_queue() did not stop q->timeout_work from
> running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
> causing q->timeout to be rearmed after it was canceled earlier.
> q->timeout queued q->timeout_work after the controller switched to
> NVME_CTRL_CONNECTING state causing deadlock above.
> 
> Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
> q->timeout_work while queue is being synced. Update blk_sync_queue() to
> cancel q->timeout_work first and then cancel q->timeout.

I feel like this is a nvme-fc problem that doesn't need the block layer
to handle. Just don't sync the queues within the timeout workqueue
context.

