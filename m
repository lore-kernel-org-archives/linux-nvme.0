Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DDFC19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+izRm+nvy6V49kyMynan7r5e5GdKHXlQH5TPJqqGe0=; b=iWAvEhvNFn3BJhVKEOvxh7Wv73
	xUMgQdr+6uEM/NrxoKddRtkOEOYInwkUkQyTQ1btKBjJFstDJ0LOLEM8mNjEFTCHuVntFrE8TRfMV
	+qfce/G/KpoGaIeJKHDDraeSOBPS7jafytwu2jTJ2/C2D6hmq8bmtzUpXtusOqE2OLaWs1PJzJlZ4
	uk8tjz2XPnUtGEuahADFy4+W1zgetTz5v/So2xO31CXQ/bqSqEZx28GvX+cdSBYZxjPQSEWeoz1+A
	z0F9fuWv0QzQHAhMV/huDVoqtC8k3s/CkAsBGAEy7WCfszDL3vW1RAvetTD/2S5qTMTOKr0HXyPsS
	DTE9+DoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLU8V-005aKk-Vw; Tue, 09 Aug 2022 18:39:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLU8S-005aHO-Pv
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 18:39:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5466B68AA6; Tue,  9 Aug 2022 20:39:14 +0200 (CEST)
Date: Tue, 9 Aug 2022 20:39:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <20220809183913.GA15107@lst.de>
References: <20220805162444.3985535-1-kbusch@fb.com> <20220809064613.GA9040@lst.de> <YvJsxZucjbQmEZP8@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvJsxZucjbQmEZP8@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_113925_015925_E8166078 
X-CRM114-Status: GOOD (  18.13  )
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

On Tue, Aug 09, 2022 at 08:18:45AM -0600, Keith Busch wrote:
> On Tue, Aug 09, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
> >  - the design seems to ignore DMA ownership.  Every time data in
> >    transfered data needs to be transferred to and from the device,
> >    take a look at Documentation/core-api/dma-api.rst and
> >    Documentation/core-api/dma-api-howto.rst.
> 
> I have this doing appropriate dma_sync_single_for_{device,cpu} if we aren't
> using coherent memory. Is there more to ownership beyond that?

As long as we only every support a single device that is fine, but
if we want to support that it gets complicated.  Sorry, this should
have been integrated with the mumblings on the multiple device mappings
as the statement iѕ false without that.

