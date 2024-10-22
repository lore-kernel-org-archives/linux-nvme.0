Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7429ED2C55E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JX11Bsu21jkOYmdnRpDhL5PLbaQjS+Ys3mcGtOeVI+w=; b=Si6edC1hfLx2SmTGSk/Oiaspnu
	ZISpHemmRwYfNM4t5f7UXxzffbTS68iWvB6e/Gl8ol1+awS8gebW4xST8ZO3DYC7pc/ooilCwsoCu
	FCPDDN+RBzUmj5kSnMY0WhGNdPHl78t42hiRbj0rBEk06MyF2xul4L9zNJk3nyL7dzloZ86tgMNWz
	RpGz7c4VjeJUWx/glVQaeTyl7UuXsfplmbAyqPK9ZsLj8Wd3Vk/w2PguBdefXYlEwOyuevDr80da9
	n5Ss4QyFsqJRNw30NEqGgW/8ILQ3rfT7XLUy5zl4TCz8Psw9wr5hpueNrE/BdenQFk246/kQzYDgm
	v6z6gctQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3G1L-0000000B7uD-3LAo;
	Tue, 22 Oct 2024 14:38:03 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3G1I-0000000B7tZ-1sM6
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:38:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6D6C6A43A51;
	Tue, 22 Oct 2024 14:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C45C4CEC3;
	Tue, 22 Oct 2024 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729607879;
	bh=p8jy6tdnkz723LntVeZITPLHFVxOn5i0CPMPqySErvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivL/y0fEKyi7iD+u35NDeLqW0E6Lrz5NIplvCGuMqxND+xRNwNHrHvm6/y+WuMlkx
	 VlG+GuWFHDiF2y72ckcH0ZXfDuNlDq6UMIJAd7MLrvAJ7sz1phEoDVb86lucGIIKDT
	 GD9xXU1iY64Ii3YGGnjPVD0DPkCzB14WDYWiRk/Txoiue72azE001DVvlypP194JsV
	 ljFpCcmD7FR8y9YS/tf8z4pafahLex+fwjf0ptffHUyDwmet/dxxYqxjQRMircXORN
	 LTrYgh3r1ciNs7Nfu5iB8q3QTzyhvK0t4uePDYiL7ojlVgI2sn3XqZzvruY5B3GP4B
	 sO58BjR2qPI7A==
Date: Tue, 22 Oct 2024 08:37:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
Message-ID: <Zxe4xL-sM5yF2isM@kbusch-mbp>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-2-kbusch@meta.com>
 <20241018055032.GB20262@lst.de>
 <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
 <20241022064309.GA11161@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022064309.GA11161@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_073800_573908_F1726275 
X-CRM114-Status: GOOD (  26.02  )
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

On Tue, Oct 22, 2024 at 08:43:09AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 21, 2024 at 09:47:47AM -0600, Keith Busch wrote:
> > On Fri, Oct 18, 2024 at 07:50:32AM +0200, Christoph Hellwig wrote:
> > > On Thu, Oct 17, 2024 at 09:09:32AM -0700, Keith Busch wrote:
> > > >  {
> > > >  	*kiocb = (struct kiocb) {
> > > >  		.ki_filp = filp,
> > > >  		.ki_flags = filp->f_iocb_flags,
> > > >  		.ki_ioprio = get_current_ioprio(),
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
> Eww.  You actually pointed out a real problem here: if a device
> has multiple partitions the write streams as of this series are
> shared by them, which breaks their use case as the applications or
> file systems in different partitions will get other users of the
> write stream randomly overlayed onto theirs.
> 
> So either the available streams need to be split into smaller pools
> by partitions, or we just assigned them to the first partition to
> make these scheme work for partitioned devices.
> 
> Either way mixing up the per-inode hint and the dynamic one remains
> a bad idea.

No doubt it's almost certainly not a good idea to mix different stream
usages, but that's not the kernels problem. It's user space policy. I
don't think the kernel needs to perform any heroic efforts to split
anything here. Just keep it simple.

