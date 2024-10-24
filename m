Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808CCCE8E8C
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Q7UYkv1ilAxo+welFofXqtGasKfMoC234V42aPBRec=; b=EtA7SlpbOO6C7ns/8QC7PC4IYK
	zPjE3Op2PqtFPnZ8/AUU+LiMHUSDeE5+iQje340SM6jtdNtv93a9v3me8noEdke1qVRALPyIYcaLq
	wXiM+rM1bGAb46nalhNGC7FLn+0oZpFAAifLhDNjTpCcE2K0HLMG9qkhINREj2Ejj8zWf4OoUCKPQ
	ELmUA8z9YYkKZAGIPMnQURws2SuZtD2DZYWrQASuRR+/TywIeXc5m+65cY7s/fx3P8mv1quvFdrIf
	k6DUZ0x8e4yX0h3qoN7Lk3bhSb37i3bhZe5T/NuFS5Wyobt/vOIly7kg2bOMaSTo++m4KPrCpkx/x
	pYMp6cvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zzT-00000000xp4-2Wkv;
	Thu, 24 Oct 2024 15:43:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zgW-00000000trD-4B0r
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 15:24:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E01CCA455EB;
	Thu, 24 Oct 2024 15:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F776C4CEC7;
	Thu, 24 Oct 2024 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783415;
	bh=uPO4T/ClA45bn+hdfc9MFdV53LmddB6YVgTOh+bdYt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lh4DOp9ZOVrA7DdNokburLWeF+nLNj/6J5rS45p6qcvzLaVU2adYX/EB/oY6wzt8G
	 tILNlobwHJUxn29tXN03IU+MsUzKpLGq68oEcmPfljWKuj3oJRdR4//RZT2BHK5+E6
	 VvX7cYcs8JdwatXCB84mukR5QdlKBZsIqGXIMy66Eq9olZEL1TegJZGnnIIJ9fD7NM
	 qyOhYPgLtHBNCcLMCUTACWLQv9BWF6qFtDRnostqirRES6t2+rcjYEISdjlBqnzVVT
	 NI/WyoNm+KasedncZRPeX+FCAK0F9MLfoPR+BHvoUfKwuJkWfYRKC+m7bL20Bx6cLm
	 j4pSeh4bsxgpg==
Date: Thu, 24 Oct 2024 09:23:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com, joshi.k@samsung.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
Message-ID: <ZxpmdfxsS8ZsY5hi@kbusch-mbp.dhcp.thefacebook.com>
References: <20241023155048.634988-1-kbusch@meta.com>
 <20241024050239.GA30705@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024050239.GA30705@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_082337_123534_6F39D300 
X-CRM114-Status: GOOD (  20.01  )
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

On Thu, Oct 24, 2024 at 07:02:39AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 23, 2024 at 08:50:48AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > A recent commit enables integrity checks for formats the previous kernel
> > versions registered with the "nop" integrity profile. This means
> > namespaces using that format become unreadable when upgrading the kernel
> > past that commit.
> > 
> > Introduce a module parameter to restore the "nop" integrity profile so
> > that storage can be readable once again. This could be a boot device, so
> > the setting needs to happen at module load time.
> 
> Not exactly a fan of module option, especially with such broad scope.
> This will actually disable PI entirely as far as I can tell and not just
> for the PI at the end of metadata formats.

I don't like using module parameters for either, but I think I'm stuck
with no better option here.
 
> Can we at least restrict it to those formats?  And maybe add a few
> comments in the code why we have all this.

Yes, that's a good idea. Come to think of it, if you had a mix of
formats, some with pi at the beginning others at the end, the
"beginning" formats that were previously working would get incorrect PI
on subsequent writes.

