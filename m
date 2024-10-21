Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED55D17129
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/4aeuncZlA7Wa5Nb8LWHMPBcKKCB8OG8HdDjjFXxrck=; b=WBrPmEQDTitAsP31eKsMcQntKk
	KJronMRWABC2Fy69+HaX3NCeBi7tSynEFeOMVOVOB4cGk7qOPdzgPCiEbrLgdeG96p+NqX07Q0S29
	LrQYwXbgZgsW0mHlnLwFiePpgyamlCWUqCKwFuSCRuiNAKVOplMKUx2O3NiHxNWLIkvOzlDGt31tx
	TmSIFASpRonlWFJmdi/iwZsWwDXiJl5iYFrvc5NjEkG2fGEr2ZjOU9fZUb1oaje0cYzXjWBrX7a9Q
	Xpr2V8oYEOytayJptQaAgDAnsiA6RpofUZut9Ameih41h64FQ3DJQA6gOn+3aNHK1vVKq7PLu8sle
	7EpFDIAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2yCF-00000008SjE-38ir;
	Mon, 21 Oct 2024 19:36:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2yBU-00000008STc-1zL6
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 19:35:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0D8DBA438B4;
	Mon, 21 Oct 2024 19:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F80C4CEE9;
	Mon, 21 Oct 2024 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729539318;
	bh=S+eoZ9PsMFOj075TBAMfbklJrhMw50VOHQse4okNSPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i87kZedRPyejz9h+qiOBKWrrI2Whc6Xb01cPDQ/kj7/qwvJaLkvkgxhv5GL+bJH1c
	 xy1+Vo8vn2FdmizpfWFhUWLNOml0K/7bR57ZR/PlAp/M4AwQJ+kkbbBj1p2qNWk0GN
	 Y36wzVsmOYlnJaseXmmzx9OgUrHmZ5gKo4W16l12ejzYbXou2W/lctU6x7DpQqK0QI
	 o0JNDtEXYXDl9ZCl9hfjp6TnUZK+SPvNFltBBsA29zFE5aU7FcWj8bcefhntVRw6ni
	 IQrRelotOl5lnpQMNxj7B1WOGQrNJqMXq6MvTg+Jr6a1PNgabD2CCIx1Vok/YpIwoo
	 4X+JmF/7fYgug==
Date: Mon, 21 Oct 2024 13:35:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
Message-ID: <Zxas8xGoydNLGwsc@kbusch-mbp>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-2-kbusch@meta.com>
 <20241018055032.GB20262@lst.de>
 <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
 <a87c67aa-b1fe-48dc-9b5a-bc6732931298@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87c67aa-b1fe-48dc-9b5a-bc6732931298@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_123520_623527_B92755B7 
X-CRM114-Status: GOOD (  20.48  )
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

On Mon, Oct 21, 2024 at 10:09:57AM -0700, Bart Van Assche wrote:
> On 10/21/24 8:47 AM, Keith Busch wrote:
> > On Fri, Oct 18, 2024 at 07:50:32AM +0200, Christoph Hellwig wrote:
> > > On Thu, Oct 17, 2024 at 09:09:32AM -0700, Keith Busch wrote:
> > > >   {
> > > >   	*kiocb = (struct kiocb) {
> > > >   		.ki_filp = filp,
> > > >   		.ki_flags = filp->f_iocb_flags,
> > > >   		.ki_ioprio = get_current_ioprio(),
> > > > +		.ki_write_hint = file_write_hint(filp),
> > > 
> > > And we'll need to distinguish between the per-inode and per file
> > > hint.  I.e. don't blindly initialize ki_write_hint to the per-inode
> > > one here, but make that conditional in the file operation.
> > 
> > Maybe someone wants to do direct-io with partions where each partition
> > has a different default "hint" when not provided a per-io hint? I don't
> > know of such a case, but it doesn't sound terrible. In any case, I feel
> > if you're directing writes through these interfaces, you get to keep all
> > the pieces: user space controls policy, kernel just provides the
> > mechanisms to do it.
> 
> Is it important to support partitions on top of FDP namespaces? 

It's already used with partitions, so yes, it's important. Breaking that
as a condition to make it work with the block stack is a non-starter.

