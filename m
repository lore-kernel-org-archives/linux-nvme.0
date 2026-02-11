Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60F3E9E2FC
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VuM+qL0C+60Bd9H10wEKdBT1Gglecj/eSfmJk7qLhS8=; b=rA9kJzGykZasCUG8lZbgxvar4z
	tzdOlLsHhtE8dCINN/G4opsyF4NQvsaz8JlXMGDAdsoX8NjO/QpMmRXxVMKabBbMIkhlKHiE/rPwb
	burNw8M9C432RHg6Me6esXEwcn2/W/8FlxFNpf01X+i6wpYzxRutH9etTfT/fZ5rBTIjUG/z9cCkm
	N1yMMtk8a1kR8HtvZjZQCjKYOkjFfDspcF5Rfd0lPuB9OyM+HR+Wb67dPohOw9KfBEru7RNlKb8xf
	UO9uSFvWT93SatRynTAr8RaLj671RAWA8TEEz9CV09XSbv/b+oUrB7vG61lDFQuqhaQnYkOIe3MWt
	ulI/3Ynw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq9Jz-00000000cHf-3tVF;
	Wed, 11 Feb 2026 12:27:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq9Jy-00000000cHS-0taN
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 12:27:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 57C6E600AD;
	Wed, 11 Feb 2026 12:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89052C4CEF7;
	Wed, 11 Feb 2026 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770812873;
	bh=w7GQWxpWfMH/EJ1S8C6A9RnWp8YSIVRkPxwYTRA0GbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGkjKUmh6mQvczwkjjTWqa5kFIIyqjB1SHTUVJeOyVRlpGvTeEbZEckVD290AgZIy
	 zJttEbdwgjZvEOKrjRm1xCsspJrmKo167EQ5lkdWVuGAkgXkBJkmSNyH7LI214CwLP
	 kT/L8O0F74rHrmqT/+Nfnb5RMuVnwAeW4cVDFJWftuONpttrz/U8/cM+QENwCysx1g
	 bopr184QGPB+JzvJyfufTQ8IqACz/eKb4QU1bjVKBIYD3hg9I98kvM6SqKl5ng0TUx
	 r/PyusynBtRC72q2tpS6L2SqHAfPn84FDDH/Fs0UzCgqCDJUl3Rw14Kv+ehAlUG4JL
	 ud7X4REhThtBg==
Date: Wed, 11 Feb 2026 05:27:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Junnan Zhang <zhangjn_dev@163.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, liuyx92@chinatelecom.cn,
	sagi@grimberg.me, sunshx@chinatelecom.cn, yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn, zhangzl68@chinatelecom.cn
Subject: Re: [PATCH] nvme-pci: fix potential I/O hang when CQ is full
Message-ID: <aYx1xoY_yeNvTtF2@kbusch-mbp>
References: <20260209121020.119853-1-zhangjn_dev@163.com>
 <20260211094744.32366-1-zhangjn_dev@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211094744.32366-1-zhangjn_dev@163.com>
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

On Wed, Feb 11, 2026 at 05:47:44PM +0800, Junnan Zhang wrote:
> On Tue, 10 Feb 2026 16:57:12 +0100, Christoph Hellwig wrote:
> 
> > We can't update the CQ head before consuming the CQEs, otherwise
> > the device can reuse them.  And devices must not discard completions
> > when there is no completion queue entry, nvme does allow SQs and CQs
> > to be smaller than the number of outstanding commands.
> 
> Updating the CQ head before consuming the CQE would not cause the device to 
> reuse these entries, as new commands can only be submitted by the driver after
> the CQE is consumed. Therefore, the device does not have the opportunity 
> to reuse these entries.

That's just an artifact of how this host implementation constrains its
tag space. It's not a reflection of how the NVMe protocol fundamentally
works.

A full queue is not an error. It's a spec defined condition that the
submitter just has to deal with. The protocol was specifically made to
allow scenarios for dispatching more outstanding commands than the
queues can hold. Your controller is broken.

