Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED8ACD98F2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ja0p50F7XChqnFn6APbgGzJj7PMR78TrJf/t4sYtQVI=; b=tOJeH7ZeiYT3dhAyN+E09GkYZ9
	KraWKNz7yuFXtnq5jfC63VwvzIkYszsJxe84LqwFU+WFMGaxeauLUQxGIrNVKF5K/DdVOpBi/PMx7
	L5fFDHYfGtAz9OVLduLC2OunCHxaEABhIGIoVU38D8L7S8GdBfmhnov+6xjLP4t9eVdxK51W4AMdY
	Y7uc/2/RRu0L9Ito3ajlzRX5XRER0uk4eUjMEH/uD8mpjzeSFiOtcoEjoyS7g2Ag7IVgCMUHYEeQ/
	wBJhlEg4DU4aK6VbPGAVeLsqFyJtKsfI76r2bxwE4ZMSoypwW0Kao/mD3aPv/3//omLk+lsLbF70/
	zuG+YB0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc05w-00000006FPp-2OBd;
	Tue, 23 Jun 2026 12:19:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc05v-00000006FPj-1S4x
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 12:19:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BCC25416A2;
	Tue, 23 Jun 2026 12:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5C91F000E9;
	Tue, 23 Jun 2026 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217150;
	bh=ja0p50F7XChqnFn6APbgGzJj7PMR78TrJf/t4sYtQVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WVRPEz+RcGsNNrOno+xhoQIeIOEdADcYf6Zm9JTbRx8olYkpJ9emGI1f2OG6QIK8i
	 mip7pIUmG1bhaxufPYalXUnSggvYUk7uc8rqIs0ySZ+O67VCoeakvnDMVQcmRBoUlu
	 WPjFHFZZ6t9st+kMH0lgXUxU3O2k3Pv8nR6pyBwa+UMNxfdtX4mbtBDywn3yL0klsM
	 hCnVj1XyFKPgRqKdlP7InwHkIdX7hzTbf42PJLMal2qZRQyDXmE1QMAJ8oEwTHk5XN
	 2sR3ibVPMDN/9Kai8TvZxziTecBF688DdHvVSGZLgjBcd9LOyRlLmEOIJ/ESfHBgCD
	 uSpsI+1IfTXAA==
Date: Tue, 23 Jun 2026 06:19:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Epping <david.epping@missinglinkelectronics.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <ajp5vFaVB4wOHjpf@kbusch-mbp>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
 <ajlNFpz5977PzLvb@ubuntu-server>
 <ajlRnLI8OdaUVOZp@kbusch-mbp>
 <ajphNQIpfIRYZg_H@ubuntu-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajphNQIpfIRYZg_H@ubuntu-server>
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

On Tue, Jun 23, 2026 at 12:34:29PM +0200, David Epping wrote:
> My question is, and maybe I should have put this in my initial email
> explicitely, is there interest in having such functionality in the upstream
> Linux in-Kernel NVMe driver? An interface and mechanism to request and
> manage IO queues that are not used by the Linux NVMe driver to perform IO,
> but handed to a separate entity for this purpose.

Partitioning device resources to assign to special purposes should be
under a well defined framework. Unfortunately the only thing I know of
approaching this is SIOV. :) Not sure how other maintainers and
developers feel about it, but that's the route I would go for this. It
at least provides memory access on a queue granularity and neatly
separates the control plane.

