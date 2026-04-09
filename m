Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E124F31E22
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUn5YifqWCIg/f9bOOZeOOtnWoYlVpNNQ+2HPa7++yc=; b=foZmlnwRzuzwbhptp9AK5RN3x1
	Hynr59Rs8aLPJ4/qpzOLtt0j8eJxP5dMDSvk7WvWLZ2mFwrTdcRDq95wqzJv6g6h6thFKDEzgZGI7
	0gLU6Us7R7MDZNDHCHE2vlNQLkdnP4P7WUSU+LCBiTLCmAgn7H5zUhj8nsiAuY67Oadzhmwt5y49t
	P19JA32SnGSC2IWBkWnZiYhq2a3XEKr5+QyNwqAKhySISDEb4QovdQACKkxc+cEgCtur/7cbwhCzz
	6KiIIib7DzZHL77dnnLT3GnxilTAo8pEN+CUYa1JZa9DnE1Rqfbu+UekuYVnEqo4Qi9VF2E/LPAGL
	U+2NIsOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqev-0000000AjEV-1f5X;
	Thu, 09 Apr 2026 14:47:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqeR-0000000AjCk-1dyI
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 14:47:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B094560121;
	Thu,  9 Apr 2026 14:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176AEC4CEF7;
	Thu,  9 Apr 2026 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775745994;
	bh=MUn5YifqWCIg/f9bOOZeOOtnWoYlVpNNQ+2HPa7++yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8SwRb6GTDauslLQcjwHuxzsHVY6Mq3ZLXMWWCU+teWcVz0wY6j17KdiRmqb6pBQj
	 Sa/IOVGS0DosfTdIJsdCN7Z9ZoOB0EfFzwTAsSNDnHMSARiLM6BrjdJ8uAZd7Wn8yK
	 b8Ghv9zMjZbE0BSOTnd7Bb6dH5BOkIPEATyQGRwSSLvNuDfU/TZDGxu/TR534XTf3R
	 sHS0QAqri9gCsK1ma/ST4x9hpeJuBU/Jo14ktzFyDg6mtuBfhd3roKPL8G3YzmI/Se
	 GjI+ioM8dWZ018wFMh3ZhWMZGCL9LYH4YKHah5m1Edh/E1KmZfZO6ML8ghVRszl06T
	 DLd5m9ShT96tg==
Date: Thu, 9 Apr 2026 08:46:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-core: fix parameter name in comment
Message-ID: <ade7yBjmQzOaagIx@kbusch-mbp>
References: <20260408124522.2375297-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408124522.2375297-1-f.suligoi@asem.it>
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

On Wed, Apr 08, 2026 at 02:45:22PM +0200, Flavio Suligoi wrote:
> In the declaration of the structure "core_quirks[]", in the comment
> referred to the devices "Kioxia CD6-V Series / HPE PE8030", the
> parameter "default_ps_max_latency_us" is reported in a wrong way:

Thanks, applied to nvme-7.1.

