Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03C61093183
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I3rzS+WbHNtJPq+lO5BF7RusjsCZFbsKKVJSEUf3SRk=; b=X0pYd7ZS/ahqpLrKnLkyHACYgm
	lpBLvcY9xB8PDZ3nSRZdIoo9v+XxCR/O5hDr1UIuQ6luDzjSfJj86jjrlh3DS/N/E0wr9BG9mu/c0
	ifMU9CLZr5FMFS8WiIOJLZL/PBBvW24J4XOry82kDyI9lomtMFRsDm/a9RckmPRVnMNCkF4XolOLb
	qRZrdS13XvYb1XB//5bkLTvqhrPaJzWisr7E8qFOf1HmkUG6KmIfmciZREARLBEPUgZmYUUldi6c2
	7+12oMoe6jnA3vXLL4HvJBGXUtO4Lsda0qE++nV/BsyvXCu+7i5723mOJ9qucnI5qgPSiFoD/oAJL
	pR+yKSNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Udi-0000000CI5Q-0uig;
	Fri, 20 Mar 2026 07:51:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Udf-0000000CI4b-3lX4
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:51:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C88146732A; Fri, 20 Mar 2026 08:51:20 +0100 (CET)
Date: Fri, 20 Mar 2026 08:51:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Message-ID: <20260320075120.GB14616@lst.de>
References: <20260304053500.590630-1-alistair.francis@wdc.com> <20260304053500.590630-5-alistair.francis@wdc.com> <103c958f-d5f9-47d3-9be8-dd7225368fd5@suse.de> <CAKmqyKPdJ2bgT2JaXi_38obyFTjRQ_rR5EdGmP81so8MEJNRVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKPdJ2bgT2JaXi_38obyFTjRQ_rR5EdGmP81so8MEJNRVw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_005124_099757_5DF6B51D 
X-CRM114-Status: GOOD (  14.98  )
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

On Wed, Mar 04, 2026 at 09:37:22PM +1000, Alistair Francis wrote:
> > I think a simple 'if' condition would be sufficient here, or do you have
> > handling of other TLS record types queued somewhere?
> > And we should log unhandled TLS records.
> 
> I like this approach as it makes it really easy to handle more types
> in the future. I don't have any more record types queued anywhere so I
> can change it to an if statement.

Agreed. OTOH having more than a handful of lines in switches like this
is a always a bad idea, so factoring this out into a type-specific
helper would be much preferred.


