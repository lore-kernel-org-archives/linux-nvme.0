Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6471FC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 04:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jInxvd5KGPTK0UzbTxqy4niIXX1piXEaGtA5dJxSNDY=; b=U9cTJ4oZe1XWAzM92QA0Du34fj
	HiKrjelCwPOef49Q10y/ZyBfAAHXR7OE70n5tERDDSFXNfFZZFQqbsdWKtowR6FfG4TdO6zdCfrku
	MzalulrvZ2U13L/RlI86zmQNilTqtifAoqMy/nRWq0jW7y627mPvkgnn1ZZewJyBiJSd5PAEFOsT9
	IsEz9f+GNH4NLddKRVpwk5DcGg9F39oy6l8/XYv+6O47gb7EWnoLyVHNNyurm685MLqbVQUqDDm/g
	f3Use5jct5028BIi+MBXZvglqFvsU/Z2r78d4R2yT7TbTblIpXEBrMxsxgcMknV5SbtjNYCPIGqAw
	9j/1z+xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkY6-00HXje-3U; Fri, 22 Jul 2022 04:46:02 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkY4-00HXj2-QS; Fri, 22 Jul 2022 04:46:00 +0000
Date: Thu, 21 Jul 2022 21:46:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Message-ID: <YtoriAQGW8+p4pFe@infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
 <YteeHq8TJBncRvZu@infradead.org>
 <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
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

On Fri, Jul 22, 2022 at 01:13:26AM +0300, Sagi Grimberg wrote:
> The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
> for the socket threads, that does not need to be MEM_RECLAIM workqueue.

Why don't we need MEM_RECLAIM for the socket threads?

> But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
> queues, and that must involve flushing queue->io_work in order to
> fence concurrent execution.
> 
> So what is the solution? make nvme_tcp_wq MEM_RECLAIM?

I think so.

