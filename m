Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1CCC41513
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h70wislF5H5vVhmpbDBrzyHNf6DCqzPCb3Cn/TLgT/8=; b=fc3D7FoIpb2kGbyCkNVKNQnII7
	kZvXortIquX/XEq4QXVlk0SkmTcVVjlq91nR4W5WJWScUSopw/z6H3oYWRBgX6nnOFJ6tuVUkUKuJ
	ywFbgcAjXDsSw64097nlgv7ZeLIqPeEliSTq2pxoetmtPGs5lMSNuQJ+5pKPjnRxCBlFVzMVxyi7S
	/MRSV4Oi2ehUg3X4yI4PlZfvshbbdTpqAZQXPflK9Q5Hb6VfUxBaO6MK0TdBls0sl/YVW/MpM3J9v
	m6HLX4NioZe0JzbHbO3d92uAJi/L474jlXbNRugfKDzA1fnZWvSvX9B2qsSb7KXff3q7dMvUxdvE9
	UYVOvH7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLtx-00GOpE-0x;
	Thu, 19 Oct 2023 05:48:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLtq-00GOoC-0i
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:48:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B21D67373; Thu, 19 Oct 2023 07:48:46 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:48:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com
Subject: Re: [PATCH 1/2] nvme-pci: meta-transfer via sgl
Message-ID: <20231019054846.GG14346@lst.de>
References: <20231018183003.41174-1-joshi.k@samsung.com> <CGME20231018183625epcas5p4d79f229a097cc083c2a2d2c77f6a5bb9@epcas5p4.samsung.com> <20231018183003.41174-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018183003.41174-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_224850_429435_D7646A20 
X-CRM114-Status: UNSURE (   9.17  )
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

On Thu, Oct 19, 2023 at 12:00:02AM +0530, Kanchan Joshi wrote:
> Introduce the ability to transfer the metadata buffer using sgl.
> Also add a nvme request flag 'NVME_REQ_FORCE_SGL' that mandates both
> data and meta transfer via sgl.

That's really two different changes, that should be separate patches.


