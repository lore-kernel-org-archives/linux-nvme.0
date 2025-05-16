Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C692C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gY3rpcUD2W81uEOhYTbJQucDAiDD8EgsKemJzAgy1A=; b=Y6HVmEuo0If2KXPt5a1PuN4uVr
	CodspCdnVMtyR/ZU3cL/CRqb+8zZ6aR/OPVWpN2a0OApgQqZH5gdzCcvI+8XwrCE98Oc78KZvYjhN
	Bqalydi6ipM3uMvAxSetLkrfFgQsD/BFH7nxb1EoG6glWX+zMHe3zBwvuW8YX/9pN/AeZ4Pm5UgsM
	uVbQ8C/UnfT3Jt7DWmz9RenzF0RZDzPEaOk20oajnAg97f3hJAc0b8zSXBDSqk8kxDSFl+b0SO5B9
	6C3A+8NeCtn5UQIHcH4vRXS8b85hvqPZAyE9qOkvzZ/d9PHKDfJwd4PHlFyipvwDdhxj+SllZGHGY
	/jf2WzWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFx3y-00000003rlW-3XVS;
	Fri, 16 May 2025 15:33:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFwoS-00000003pE1-1a28
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 15:17:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 162C243552;
	Fri, 16 May 2025 15:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E2C4CEE4;
	Fri, 16 May 2025 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408647;
	bh=f2+JDC+lqO6oIZa4Bsrci6FCmgQw5v42YL7XJNb94BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mn8TaeSrN+4osVEM/BDS5FbAKTeK5VStn3v8exwRvXEzIIY6kod51ronyJfTSfaGl
	 nQurMJkjQDhcfALgOTrtQh3Cf797N1dedqB3jiAs0pQC1u4MvnimIBW15u9II2KfAb
	 dwja8MvroQEHfrde0l1j9cGRfQkrAR3n+UiAHpusLS2Bi5ij7mgh1ocaLvBFyj+xMw
	 NoU+qharOmTf3B8mwKcMMPsW52k13oxv61ySW1j6JdIxamn1fWIvad5zCIxurkBsZx
	 1/yrS25g6PpKavd+uAGfpxyGdd3oHSOi9JL6Ff7JSQhnPHbJaat1TJJm4bYVMCesCT
	 oJTqTnSfcZ6qA==
Date: Fri, 16 May 2025 09:17:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: derive and better document max segments limits
Message-ID: <aCdXBS6wrnXDQKca@kbusch-mbp>
References: <20250516072152.166131-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516072152.166131-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_081728_434139_D0015691 
X-CRM114-Status: GOOD (  13.70  )
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

On Fri, May 16, 2025 at 09:21:52AM +0200, Christoph Hellwig wrote:
> Redefine the max segments and max integrity limits based on the limiting
> factors without changing the final values and add comments explaining
> them.

...
 
>  #define NVME_MAX_KB_SZ	8192
> -#define NVME_MAX_SEGS	128
> -#define NVME_MAX_META_SEGS 15
>  #define NVME_MAX_NR_DESCRIPTORS	5
>  
> +/*
> + * For data SGLs we support a single descriptors worth of SGL entries, but for
> + * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
> + * scatterlist.
> + */
> +#define NVME_MAX_SEGS \
> +	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> +	    (PAGE_SIZE / sizeof(struct scatterlist)))

If your page size is >=8k, this should change the value of NVME_MAX_SEGS
to 256. I don't think that's a bad thing, but the commit message doesn't
reflect that.

The diff looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

