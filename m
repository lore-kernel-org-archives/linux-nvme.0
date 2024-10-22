Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB211D1CDA8
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zEbqDJ11Qs2Th2O6hHSd6h/CHFLdaf2eTAo70EQqhYU=; b=SBTmKqltVlkEcfNlWbaLWvMVE5
	ZmIKJbSy8QVFutA6qbt7okEHWS/GklJzn1ZvtDNbLrd92ls9tsdoStXqTYhEHBf2N4eBs/5NmDFdY
	ei8kNGuS+fkym+kXoMnPS9dHY7hySLgyRsZLwEtjR4m+3X+vcxKLphH7/+j5dNABMSjGFrA+ddkvg
	hVfvUaOgkh31qU7NXzr/GCirG1qX5X9vkWYK1XOXKmcXCzewxPU4KAkqufOi/TVNBw4UETtKNJ3Fl
	rr1m0sTaZcwB248uEk373Y54jO0Pniy4ibEw3EzeSN5c+TstOlA9MLfJOE650ELKatS7Qy2nnYw4C
	0dyLDKrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t38c9-00000009r0d-49pM;
	Tue, 22 Oct 2024 06:43:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38bp-00000009qsb-2KKf
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 06:43:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B52EE227AA8; Tue, 22 Oct 2024 08:43:09 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:43:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
Message-ID: <20241022064309.GA11161@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-2-kbusch@meta.com> <20241018055032.GB20262@lst.de> <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_234313_773536_05D26335 
X-CRM114-Status: GOOD (  22.19  )
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

On Mon, Oct 21, 2024 at 09:47:47AM -0600, Keith Busch wrote:
> On Fri, Oct 18, 2024 at 07:50:32AM +0200, Christoph Hellwig wrote:
> > On Thu, Oct 17, 2024 at 09:09:32AM -0700, Keith Busch wrote:
> > >  {
> > >  	*kiocb = (struct kiocb) {
> > >  		.ki_filp = filp,
> > >  		.ki_flags = filp->f_iocb_flags,
> > >  		.ki_ioprio = get_current_ioprio(),
> > > +		.ki_write_hint = file_write_hint(filp),
> > 
> > And we'll need to distinguish between the per-inode and per file
> > hint.  I.e. don't blindly initialize ki_write_hint to the per-inode
> > one here, but make that conditional in the file operation.
> 
> Maybe someone wants to do direct-io with partions where each partition
> has a different default "hint" when not provided a per-io hint? I don't
> know of such a case, but it doesn't sound terrible. In any case, I feel
> if you're directing writes through these interfaces, you get to keep all
> the pieces: user space controls policy, kernel just provides the
> mechanisms to do it.

Eww.  You actually pointed out a real problem here: if a device
has multiple partitions the write streams as of this series are
shared by them, which breaks their use case as the applications or
file systems in different partitions will get other users of the
write stream randomly overlayed onto theirs.

So either the available streams need to be split into smaller pools
by partitions, or we just assigned them to the first partition to
make these scheme work for partitioned devices.

Either way mixing up the per-inode hint and the dynamic one remains
a bad idea.

