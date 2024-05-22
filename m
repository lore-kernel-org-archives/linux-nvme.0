Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E11C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBhe2gu7520hWKwLCulEZUATJ0WrSoU6x9CoAkjRFAM=; b=AwRS0N958N9/Fx5rOBQ8c9Aygs
	bWsmxGxk9eYzc673d9dxbt1eiAL/pj+wpJtgGNKZSFWdh5t6n/A/peAWgTvAxdCO1eT/IFMZOOfDb
	WMAJaU4oXFP4keeG+hZXHQEHImS/4umwwXZZgCDNpiOjTkk7RBFZwM7GWpGjUEhfkYWvK/DcFZwRl
	1Uho6jNqKc2GwnRiq8E+EVvcOTqSYfrbtbkKEqldW9qGUb5pUP7Uyd424byleZYdktV89JKJ27CpK
	FT70BOtUq4pHd2QCx2J8zXkARb+QRLLZpXB/wABATQyS6AO32tU/NEyRY4/rpcbbwnCM6/INhWGyc
	TWHyAMGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9pzI-00000003gom-3Byg;
	Wed, 22 May 2024 17:42:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9pzF-00000003goE-2gxU
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 17:42:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 13A1262A53;
	Wed, 22 May 2024 17:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59020C2BBFC;
	Wed, 22 May 2024 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716399768;
	bh=NxEUGyPEGGL/151BSs8K3CgOL6AlKg6+QmYz57bsvyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgdX25CyAXBcc93jViRjdk3nnTmdTih5ZVtWNdeZCxNy19/bnCGK8lyw8ma14pfsD
	 2GLl3L9TrkSOqCTt3EX9rjhBynKnXRJcXyn3Qft+bkxerPDU+5e+4Hwj6EelWR9fiZ
	 JAg9fpPVcHLCgRTDNwhmo2vQ+83pu7zV5Ac5x91RhGF4/wvafGAIV2lBcNba8BkmXF
	 vW20eFFMgklae+q+uLK9ORHfimpD7rMIBjlumRLTb98gmBEr9D5EsMQU/ewbPdCrJ3
	 rLEiWiar+keXtnOYZmqqiTWPBqFGYq8P7AbkylTzkedDlN1WwhYMFdWsQZEArREBUg
	 NTF36pEZ6UO3Q==
Date: Wed, 22 May 2024 11:42:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Nader <dev@kayoway.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/1] nvme-pci: add quirks for Lexar NM790
Message-ID: <Zk4ulsDpokA-1RfB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522155614.191849-1-dev@kayoway.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522155614.191849-1-dev@kayoway.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_104249_744486_3D14F697 
X-CRM114-Status: GOOD (  10.45  )
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

On Thu, May 23, 2024 at 12:56:13AM +0900, Jason Nader wrote:
> Hi,
> 
> This adds Lexar NM790 to the quirks list.
> Other drives in the model line-up already exist in the list.
> 
> Kernel logs before:
> 
> nvme nvme1: pci function 0000:03:00.0
> nvme nvme1: missing or invalid SUBNQN field.
> nvme nvme1: allocated 32 MiB host memory buffer.
> nvme nvme1: 8/0/0 default/read/poll queues
> block nvme1n1: No UUID available providing old NGUID
> 
> Kernel logs after:
> 
> nvme nvme1: pci function 0000:03:00.0
> nvme nvme1: allocated 32 MiB host memory buffer.
> nvme nvme1: 8/0/0 default/read/poll queues
> nvme nvme1: Ignoring bogus Namespace Identifiers
> 
> Other info:
> 
> >sudo nvme ns-descs /dev/nvme1n1    
> NVME Namespace Identification Descriptors NS 1:
> eui64   : 6479a74b40200c00
> nguid   : 00000000000000000000000000000000

This quirk is actually for the nvme subsystem. It has nothing to do with
namespace descriptors.

  nvme id-ctrl /dev/nvme1 | grep subnqn

I'm not even sure why we have this quirk; it just suppresses a harmless
print message; everything works the same with or without the quirk.

