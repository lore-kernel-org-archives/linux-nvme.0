Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87E3D3F06D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elNKgz5DT3Y928/xD1nq4zPKJ2/vLIRnrJ+b8d5JxSs=; b=ZN52UvwzWLTehMVP9jlZtAzXvM
	Jr/CxomiD8CtsoyDqihCLj1UPhu+4WtgrpD69Ta9Vhdmr49qKgUAhZmZAyO8AanFt0QZNuPRTRuDz
	uk0TFsZHsUjVHuEqlmCp5fuVD2MeURZ5VlMCicl3izqUgVx9jXdREvfffZEhOwIuPpYA60LjFQXYi
	klorYcmyl1PkCG44a9/Jq196Yx3vVGD5oX++qofI59Fu8mU3W6B9cRCPoD5xXyls6xxX6iY2bb2B6
	XIS5HMoFCeEAjc1IF9l0lSh/zJ+U7V4oAJq4PWz8MagxW3en31yLtd6g+BCbxzbuYz11jrLMw1vsJ
	Ec36U/tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl6Rm-0000000GA8w-0xrB;
	Wed, 28 Jan 2026 14:23:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl6Rj-0000000GA8a-07W2
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 14:23:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7173227AAC; Wed, 28 Jan 2026 15:22:55 +0100 (CET)
Date: Wed, 28 Jan 2026 15:22:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>, xen-devel@lists.xenproject.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Message-ID: <20260128142255.GA3210@lst.de>
References: <20260127195907.34563-1-roger.pau@citrix.com> <20260128084958.GB9373@lst.de> <aXnScGiFkX7ZFFdE@Mac.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXnScGiFkX7ZFFdE@Mac.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_062303_269095_EBADBEE6 
X-CRM114-Status: GOOD (  14.93  )
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

On Wed, Jan 28, 2026 at 10:10:08AM +0100, Roger Pau Monné wrote:
> > > the root device as part of a kernel update is unexpected. Sadly 6.18
> > > already contained this issue, and no-one noticed, so its impact is limited?
> > 
> > This only affects non-IOMMU paths with a non-noop dma_unmap_phys.
> > So it is a very common setup, but very severe for those.  Because of
> 
> Do you mean a "not very common setup"?  Otherwise I can't parse the
> sentence.

Yes, sorry.


