Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5558E6FE41
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baMqjfytW8C4SvrTSUAv4clouNeALD2OfiMCNsXX1Zs=; b=PS1c0gwvC1X8mGU5LG25R2AHfB
	rEKqZ6i7Izzu5kmZYeidzN1lSZVscWU9ZR5Dovo6D+uxFOx4uH+LPQxvN3TvWACag3Whfsd/OM4DG
	1/xcK5v8yCpfTri0mk/eiSPyknwBF3256UX0o77xQZXTFgDTChxQYr0pGKbIzJlDxRCnQglg92P7e
	zX25du4/jasedcRdQv+1Ix1ob9ncZr9Oxnu3bDWg7KH4L/T/vp0fweYxoMdu9mDB6fGY4n3AlhEVU
	bumXU/apuuXg1D/PNX/gM+S893XIf0hlt6wliD5zMJ6tEsxIpbLDNepQ/Sqw5XfiG13wvVzW9QbY1
	f8iPBsyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smdQP-0000000DEQ4-2nvx;
	Fri, 06 Sep 2024 18:11:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smdMl-0000000DCvf-31Rf
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 18:07:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 82CB35C5AA1;
	Fri,  6 Sep 2024 18:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F8CC4CED6;
	Fri,  6 Sep 2024 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725646046;
	bh=Afw3DB2KotuAbwG4IJBHjNy8qlGgNB/EnUFgiAsjLuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8Rn1WWFunoirpPXGZiEF4rJqJs6PIqlEO2n40iNV02u8AFjnMgHVQAiSmbsVmN08
	 0WbZY8BB8DfjhPUEGvPmMh1vqlGTjtiUfmROZM9DB1bwvQNDN8axeMlk0ykDjcjCYy
	 Sh6Wul0oeNPP9LAdQFQZMjZv+sz/+MDzqdtFO++C3ieHDu6pGFDrCVnZINpRh9ruPW
	 jKVzth2j5vIyKTreUrXsweetsT31rl61/2rcWspQCf8pJXBAQGW47vEBsmMTb52/lc
	 tVG33fhzKQNUv6vrx9MTP1tVC4zNBfw6B2v63VTG6Cfv+uocb5x+agB7pshIPL6VsP
	 jNO+Mf/YGEekA==
Date: Fri, 6 Sep 2024 12:07:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <ZttE3H199lIjN3ki@kbusch-mbp.mynextlight.net>
References: <20240827121701.48792-1-pjy@amazon.com>
 <20240827121955.GB1607@lst.de>
 <mb61pjzg2gneq.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pjzg2gneq.fsf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_110727_849382_34169C0A 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 27, 2024 at 12:28:45PM +0000, Puranjay Mohan wrote:
> 
> P.S. - It looks like we will need manual backports for stable kernels as
> this won't apply directly. I will send them after this is accepted.

BTW, the reason for your bug observation on older stable but not on
newer ones looks like was originally "fixed" with:

  d4aa57a1cac3c99 ("block: don't bother iter advancing a fully done bio")

So while your change is fine, the above commit possibly inadvertently
fixes the inappropriate "advance" because all successful nvme
completions are "fully done".

It still probably doesn't make sense to attempt metadata on request
queues that didn't register with the interface though, so your patch is
also fine.

