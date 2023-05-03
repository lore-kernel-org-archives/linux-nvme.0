Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B301C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jt72/U/O2SQlWeCz2t6Rk/abXZ1IZpCw5tKB9wTdBS4=; b=cmGLwoeT/o1CZrJKZap3vy48wA
	w8qFoRBfBZD7ne5oqLhp68bSd1RuxSoi5WeHkVcJKe75SpIK2pLcIi7+9iyD/4gHVCd49vReOwzgc
	ik6oSBURvkQDz30c5Zyii5LOsgyH7MRVyPOGJz7EZBEK39ejfxXiuc1cI2O1IJzGjsUQ7NmkrDpbi
	HLna3ieU8TAbOqLkYz1HSHp0YLbtcQ6urwa41UyrasmH8xl1nPIYsBhWae1dlKnPHRAlLQLjoKOFn
	Bz/GP+hdzcXItvlt8wiDZgwebdUZBPXeDVV6K5i2J6jbTEuEooWbt199l95CJ0x3LgihrVIu5J/gX
	S/ZQSc9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puEMC-004xop-23;
	Wed, 03 May 2023 15:25:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puEM9-004xnE-0b
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 15:25:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AF94D62E4F;
	Wed,  3 May 2023 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE0AC433D2;
	Wed,  3 May 2023 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683127524;
	bh=m5KN/uga1cR5DT3s6A2yKst0ppY6IrvIVVJeBzPUqDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXPhCMUysZP++jugHo0ckwJ7pEp371F0cuPyu1tF7IuGkBGqOIX/w/y+QV2ZoIuyn
	 TvWVtQwtq1qLv0WsHfXi0HXZzmWT1KUrWRykLe7dj4Y4ZWLua0gAC9DgfcMNkkfpqh
	 JvpcDM5i6X12WdCdNtNnYnXEKMu3wdz9n2Cz8wggf0difgeEtg10xATnoJu35t9UZU
	 MFoqozdegKEGRfLIn8os5T/xfaeioS2CiIrPeF6G7/1WwImyhzezGUcWZVBFH/jWBt
	 4ixtgAiZyOkcn6O2IgGiVY/bNeBNiILUWhxIo4ZNGtMDpZ8hxntcblD0DotVu0A796
	 RE8tVaxzG4c+A==
Date: Wed, 3 May 2023 09:25:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, axboe@kernel.dk,
	xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Message-ID: <ZFJ84dD1FRNXJIcm@kbusch-mbp.dhcp.thefacebook.com>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-2-kbusch@meta.com>
 <20230503050414.GA19301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503050414.GA19301@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_082525_271970_BA1FF7B3 
X-CRM114-Status: GOOD (  19.84  )
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

On Wed, May 03, 2023 at 07:04:14AM +0200, Christoph Hellwig wrote:
> On Mon, May 01, 2023 at 08:33:04AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Passthrough requests don't go through the submit_bio() path, so all the
> > overhead of setting up the bio's cgroup is wasted cycles. Provide a path
> > to skip this setup.
> 
> These days we should not need to set bi_bdev at all for passthrough,
> so I think we can just drop the assingment.

We can't really skip it for polling since that needs a bio with a
bdev. I'll take another shot at detandling that requirement.
 
> But instead of just optimizing for passthrough we really need to optimize
> this assignment and get rid of the cost entirely.  What is so expensive
> about the cgroup lookup?  Is this even for a device that uses cgroups
> at all, or could we come up with a flag to bypass all the lookup unless
> cgroup are anbled?

It's not super expensive. It's just unnecessary for this usage and
this seemed like the easiest way to avoid it.

