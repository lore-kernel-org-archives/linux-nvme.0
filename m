Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73298C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3dHRBWBn8BcERYAXSOwLXyCWYZHtzNUwTnA2tCnQwEs=; b=pZnI5z4duNz7rsZwxa0MpTuORT
	VLlTMkg4xFODXUrqBpaC9KjxRQMwMke5pxWwmH0jaV00APmuBek/VsAk64SUneSA/Yu+uwSQ8GbgH
	OmDWE3TyX/6L6qvI7XoPyXOlAlGy15lMJ8WFB7EE2mbeyBNEN1GYMBRYcQ9DouhYdZQ/V/kDGPSdG
	Sedp90wKLdr+Z0zweQVClvuYiPcSOrH6Bv+q3TZlK+EtnZakjqbTUVwzurjslucw/qG6DiUP6kvGF
	8bHX8fqZOoC3HjcKoFSqg7xMOwuifwjAt8po5FM8dU89t/glOOTQ270K6nyK9JW/urNKMEWZKAZ9K
	UEW5L+qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1Kb-00ExQK-NP; Thu, 27 Jan 2022 09:44:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD15o-00Eu0A-Ti
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 09:29:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D790868AA6; Thu, 27 Jan 2022 10:29:21 +0100 (CET)
Date: Thu, 27 Jan 2022 10:29:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 joshiiitr@gmail.com
Subject: Re: [PATCH 2/2] nvme: add vectored-io support for user passthru
Message-ID: <20220127092921.GB14431@lst.de>
References: <20220127082536.7243-1-joshi.k@samsung.com>
 <CGME20220127083035epcas5p3e3760849513fb7939757f4e6678405a0@epcas5p3.samsung.com>
 <20220127082536.7243-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127082536.7243-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_012925_206603_935DDAC1 
X-CRM114-Status: GOOD (  10.78  )
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

On Thu, Jan 27, 2022 at 01:55:36PM +0530, Kanchan Joshi wrote:
> wire up support for passthru that takes an array of buffers (using
> iovec). Enable it for NVME_IOCTL_IO64_CMD; same ioctl code to be used
> with following differences -

Flags overloading for a completely different ABI is a bad idea.
Please add a separate ioctl instead.

