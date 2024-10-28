Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F1AD33995
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=duhZPGVucD9+ULqmRsn+01gnRtOe5s05yR61ao6W+90=; b=ZertoHnE2gdQwRoxRK70AG5XjE
	p+hp8Ag+qPPrneZ7DOv8Ksm3yJCVIkrHzKBiogxaN2UC9EMrnNlVhaBYueot6CbLSTMuTxHI80RTV
	VB0GDQEXiH8bYAA6UYIHZ1RdBj/YsDg+PBnmCedEnVjjnVRt4qaeGTsJhrlmDvv5VcxMggKZSFgh8
	aen05Yu8b0lm+8LK7KAl5lhaZc2cKwrwXIcSKIKsZ7in1y74DR8R53tnXGWmUSJInEqwa8XRKHe+4
	mxMjy1cYTXoptBpZ0BOsoIm6x28jHLh0t9rx4IQNibD/Hh0dAGDrCTFN7IB32Z8j+bvQis5OslLj4
	OyLE0N+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5RSt-0000000BGz6-2ukW;
	Mon, 28 Oct 2024 15:15:31 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5R46-0000000BCBP-0zrL
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 14:49:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 36EF3A426C2;
	Mon, 28 Oct 2024 14:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68628C4CEC3;
	Mon, 28 Oct 2024 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730126992;
	bh=ul4FrUoyTM3eKMpUlfF3PIljQyXaWGzKT1GGKNK0tak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKPg/yRGtLNyL4aEfn9s0bwut8kYW1Njtk9aiQdYWsGOXQF1xoShKYeG1bzNcaHJD
	 qsix6/5YGv7/9a039tLdMy/YksesxdLpd91QpE6LTiqJagUqEpImTPBdF6onUFXuDO
	 mbkYYlJa7tp9aXZzL/lG8DsNf0aFZmN4fCMiM6pNLHO5+gf4iPmL5c2wRHwANn0aWm
	 hAy6DnWgLB04DyMd/D+NxRLts2h3jjVTJbYUKMEKgcE6nMq+3Tii2u+liHZf9+3scA
	 5N/KxtluvFUb5fZWEMnsmPEkxx6Np7SM/nzmHZR3oKSYbJnI7vigo1qYOgEX5rRvLJ
	 eu9slgJHd77bg==
Date: Mon, 28 Oct 2024 08:49:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv9 3/7] block: allow ability to limit partition write hints
Message-ID: <Zx-kjh8VOYHmQCyH@kbusch-mbp>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-4-kbusch@meta.com>
 <20241028115805.GD8517@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028115805.GD8517@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_074954_407699_C348DE5A 
X-CRM114-Status: GOOD (  14.46  )
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

On Mon, Oct 28, 2024 at 12:58:05PM +0100, Christoph Hellwig wrote:
> On Fri, Oct 25, 2024 at 02:36:41PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > When multiple partitions are used, you may want to enforce different
> > subsets of the available write hints for each partition. Provide a
> > bitmap attribute of the available write hints, and allow an admin to
> > write a different mask to set the partition's allowed write hints.
> 
> Trying my best Greg impersonator voice: This needs to be documented
> in Documentation/ABI/stable/sysfs-block.
> 
> That would have also helped me understanding it.  AFAIK the split here
> is an opt-in, which means the use case I explained in the previous
> case would still not work out of the box, right?

Right.

