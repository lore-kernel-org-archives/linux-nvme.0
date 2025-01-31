Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CC3C02192
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slhd+pBfVFgZUfnjxPceEESrduykA8ih8gE2QWQFgfQ=; b=Z3YIBOgn//qJsmplIHoxxbzTet
	O3Aq0CgTWsc7e0+yNBA5rzXAQBxkR9mruWGMmJSRaMy3hejf95uEnjda44O+aMFxXn1KILfAaOVxu
	OKEqQ7pmHK2r4dm1JThReAxK7ICC3FhPL0zI4WZUoULKwD9vFTmSnNUTx4cnSMhixhea/9G3dsK8m
	ev3cPqko9mODqlb+3gxM75NVNEDOFtPkqfaAdknSj2MQ9vJiElKXOZVXlJncqwN8NQg3oLnsw/8Wr
	PBkbwiFgkj6X6gv85pbdBH6L+Y7L56b5ZL6YfEywkWSEx6SDWJ5O97hMz4pXOHt2SpX7AedFKZr11
	khu7/9kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpqF-0000000Aa7q-0hYU;
	Fri, 31 Jan 2025 12:09:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpqC-0000000Aa7S-1XVa
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 12:09:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62C4868C4E; Fri, 31 Jan 2025 13:09:38 +0100 (CET)
Date: Fri, 31 Jan 2025 13:09:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH RESEND] nvmet-tcp: get rid of a high-order allocation
Message-ID: <20250131120937.GA22109@lst.de>
References: <20250131120509.796198-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131120509.796198-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_040944_554049_500A30EA 
X-CRM114-Status: GOOD (  14.04  )
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

On Fri, Jan 31, 2025 at 02:05:09PM +0200, Sagi Grimberg wrote:
> Allocating the queue commands array leads to a high order
> allocation.
> 
> The current size of nvmet_tcp_cmd is 704 bytes. Allocating
> 128 of those (default queue depth) means that we are allocating
> an array of 90K bytes. There is no reason why this will be
> a single contiguous allocation. Change the allocation to be
> kvcalloc instead.

Should we still aim for non-vmalloc allocation if easily possibe,
i.e. use kvcalloc?


