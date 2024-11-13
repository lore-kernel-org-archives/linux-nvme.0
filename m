Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743B5D42BBF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 04:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/iILI8A+abiOP15hQZV61MdKSjUvwhPEmGxN56HpjiI=; b=nCQCJ9OhVAN8Mqf+MrnVwGHAYF
	JuvwnDsiVUQolWueMrO80+XMR+DWDNr918itSMaJI97oMTiDb5Y/SC4FGPqGuiKFfy8yNqBXkMWy5
	zsU3msC8nRx0yWSea9yiqVckzWQMNr1ZMlQnh8Dq+hOcZcWR3YVbUIeIOOurdRyYms5xoX4+ZSCDy
	BEuY56e1/TY7lAAKsR0caSQPEN3I5OpiG801IHxQJXUW4KeZ/uIrXua3cVpNpH7dNMRoHNPASCq0a
	duTBREe/EVP9ql013tWCXOjrak6Qp57QIL4wYJW05glefyonviZreq6q23wungYAmlwKeSXLgE3hu
	Yvpj3UmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB52w-00000005jbR-2zyN;
	Wed, 13 Nov 2024 04:32:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB52t-00000005jaZ-25KT
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 04:32:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7421568AFE; Wed, 13 Nov 2024 05:31:51 +0100 (CET)
Date: Wed, 13 Nov 2024 05:31:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <20241113043151.GA20077@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_203159_699409_196A448E 
X-CRM114-Status: GOOD (  15.01  )
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

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> We initially put in a quick fix of limiting the queue depth to 1
> as experimentation showed that it fixed data corruption on 64GB
> steamdecks.
> 
> After further experimentation, it appears that the corruption
> is fixed by aligning the small dma pool segments to 512 bytes.
> Testing via desync image verification shows that it now passes
> thousands of verification loops, where previously
> it never managed above 7.

As suggested before, instead of changing the pool size please just
always use the large pool for this device.


