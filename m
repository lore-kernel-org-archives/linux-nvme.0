Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D0CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ViVk/UJdTZ8NQ5i6JGNkTMSAT6XRO2LDCoE6DGQFLI4=; b=ksSHuJWDEsJCB+wPOeAotpTGsD
	w7LG0Ji37MbgPgcjPYmDAyoEwRznVbinqCF2Jf3WrxC6WbhozJzjVVwzuIcG4SKDEDV6hn4EQXBii
	NMeNUbJ8lvHR54TmywIfWhdnoRmOpnIorSPzIg6q6Ez4rFtufI+hNZ44O+dOS/exOUS9iuNGBQ6eF
	pE2M8t6HMkltbVQDc7x//KU8HD4BISFgryaGF3QFjxmdBa9G4sEKoHKAC7SGImZszWW7QYB/ia7U9
	To0BSHioVetQIEPLxIV8dyUlrthWF4RxO+0mrqpXa/JJ9cqQdBwwoP4yCkYFu5F0Kjo5p77KxZw9J
	OxnDcwnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeXf-0000000DMet-16WC;
	Tue, 13 Oct 2026 15:35:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeXe-0000000DMeg-1VDd
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:35:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB3B860A59;
	Tue, 13 Oct 2026 15:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D31F00899;
	Tue, 13 Oct 2026 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905749;
	bh=ViVk/UJdTZ8NQ5i6JGNkTMSAT6XRO2LDCoE6DGQFLI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kcxDw81HQ7HejwIfhHp+87ycVc/7AdrPPBtFePGGbgtqN2cRTdqa+V5oJGzCXxQj4
	 y02gXEKbNNT00q6UmLwKs2FSIQaw9S3ru+Jar6cpyzixBlVmyLHuhrVjwk/gsIiCa2
	 nJq9dDshCVW3zx3UgIMi6Lpd5fCVHTP3X5QxTOGACepXEbBPXiz7UXyVMqZelS43cu
	 0jMrRkCQbTredUjL4fHGORPEdNGWjVICcKpv1Rnb+Hxo/FdKp6IUeoUtra+cZ1thlH
	 gZuvtjqci8J4CDnyoufjPkw62nw5MCG8JZCQG6kWO2xBL2OjTDE9N7NcAHO9OFnSJS
	 OSLNvNb6UOyFA==
Date: Tue, 13 Oct 2026 09:35:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: don't complete a request after a bogus remote
 invalidation
Message-ID: <as5P01gemus69jzJ@kbusch-mbp>
References: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>
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

On Tue, Sep 29, 2026 at 12:38:11AM +0900, Yehyeong Lee wrote:
> When a remote invalidation names an rkey that is not the one we handed out
> for this request, nvme_rdma_process_nvme_rsp() logs and schedules error
> recovery, then falls through to nvme_rdma_end_request().  The request is
> completed with req->mr never invalidated, and nvme_rdma_unmap_data() hands
> it back with ib_mr_pool_put(), which only puts it on a list.  The rkey
> stays valid and still maps the pages the completed read filled, so a
> controller that sent the bogus invalidation can write into those pages
> after pread() has returned.
> 
> Return instead, the way the local invalidation path below already does,
> and leave the request for error recovery to cancel.

Thanks, applied to nvme-7.4.

