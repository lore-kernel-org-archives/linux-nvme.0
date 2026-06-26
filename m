Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382A4C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZA6LNO4zZPmcBNly3QOqtFTnOggSxh3G1dGlSf4qG5U=; b=w1XmdgcpGT/YPE/OO0nJmMTYn8
	4XejA1AO6L+a0VLf6ULeqSUvxe05lfROFcQJlOT3o3eUzqsV8iSMLiXgNz0sNNPsm3hBKYgCYosrV
	GEsioYKa02N9+IFCl408S3veOhIHEzSGZ14xV7hoA2oaAjr9Qx0Nh5ViJhomnzZjrLuK/5aq/nMF4
	6K2c33de9JG6sUCh+S5yrDZUZhnl3wN1VcKcNbiUWPxv5CnnkQwSnJD9p26NrQXJ7HndAeEGxqYX4
	woRCjwVxsRIkhsD+ouHKP+IZyqUH+7RNbdNgqbwBj3NJiuLBnj8+koChM+lgqyW5J1j4Fjb8QeJ3C
	WGujpn/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdAmI-0000000BjPt-2NQ1;
	Fri, 26 Jun 2026 17:55:46 +0000
Received: from smtp.missinglinkelectronics.com ([162.55.135.183])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdAmF-0000000BjOu-29OV
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 17:55:44 +0000
Received: from ubuntu-server (ppp-88-217-75-1.dynamic.mnet-online.de [88.217.75.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id A0C9320150;
	Fri, 26 Jun 2026 19:55:38 +0200 (CEST)
Date: Fri, 26 Jun 2026 19:55:32 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <aj69FEOLH82dLErr@ubuntu-server>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
 <ajlNFpz5977PzLvb@ubuntu-server>
 <ajlRnLI8OdaUVOZp@kbusch-mbp>
 <ajphNQIpfIRYZg_H@ubuntu-server>
 <ajp5vFaVB4wOHjpf@kbusch-mbp>
 <20260624074045.GB12649@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624074045.GB12649@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_105543_726539_115A63EC 
X-CRM114-Status: GOOD (  17.77  )
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

On Wed, Jun 24, 2026 at 09:40:45AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 23, 2026 at 06:19:08AM -0600, Keith Busch wrote:
> > Partitioning device resources to assign to special purposes should be
> > under a well defined framework. Unfortunately the only thing I know of
> > approaching this is SIOV. :) Not sure how other maintainers and
> > developers feel about it, but that's the route I would go for this. It
> > at least provides memory access on a queue granularity and neatly
> > separates the control plane.
> 
> Yeah, we can't just hand out queues.  I/O to all namespaces can be done
> on queue, and any queue can address any IOVA, so this is fundamentally
> unsafe.  Add to that fun like abort handling and it's just not going
> to work at all.  We had at least to previous public attempts at such
> schemes (Damiens' libvnme back in the day, and the Mellanox nvmet
> offloading) that were rejected for the same reason.
> 

Thank you both for your feedback, I get the point. I'll definitely look
into using SRIOV or SPDK to migrate the system to an unmodified upstream
NVMe driver mid-term.
Thank you for such a stable base to build upon, David

