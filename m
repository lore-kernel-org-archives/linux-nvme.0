Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F148109C05D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vi2bdJY7/Ltc4GZUSD+NKYZWTRK073ecyeFSOXQRINA=; b=VRic3CEcvvlzOdhb04/zC31+Pk
	1fJ3ZWWGNL505zvoBWTQBuP6wjOaNSoZf2f0xV48srJHD5xGUJkcYfdHduoUNFRSLkZTeqB5CcnVs
	lehvnv/iRT3bO6ft4bdB/fgA8HxIUycmACBkQ7NKtlU4yBA8aSqdXw9nn2T/raI3K8Eln32RTOf2T
	LrRi+suzVRvWfYM+WAjPhqXv2Tdj96nAnpEgmr5DOo5htztXa5kf7Oo2VYla5ZHaCF2dZsXzHyWSc
	f9Ck3asHGX8txg+zDTLsSyz07fD2cKc/xYTD9q80+L5UYmM/0qvQsHlVN8f9PyZPWoyb6dshyrcT3
	3pXDFxjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5VUB-00000004FpT-2606;
	Wed, 25 Mar 2026 21:09:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5VU9-00000004Fp9-07W9
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 21:09:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4456243EAA;
	Wed, 25 Mar 2026 21:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF5EC4CEF7;
	Wed, 25 Mar 2026 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774472992;
	bh=5hyCtszn78xanL3/NAItzF/R51/fZ06Mwx7h3Z1IvlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUCQnJyoZhUt4VnYhJ8veC05VFp9zs8kQa2c1wzAm+I/r95r3fOHJjFJ4QrUOV+OQ
	 AJ1GEXBIMy+vi2BNW+A6QL88gNMmZwyUbeMdGRxRRQK/HrYhQfWtVJNuSS9Hsi/Bcv
	 IKKZgLI1Vc4vYdzJMjHRVORuUGxWgKWgui6QHgfJJBzajti9HYugpYs6z4JZvhiwEJ
	 n147CnMBhQ/ZvfuD+1sanPvpEAu6W8C4LHAR6OW/V3AySeF4HL07UY6SPLI8vRt7bL
	 1ub7P0dQqq+IQ4SfMby6Tkl5HkIQt3zSulWcOLMgpoR2Ni9c+knm4kCWKjNsP1cgjy
	 2pMe06tzHVsVg==
Date: Wed, 25 Mar 2026 15:09:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/21] nvme-auth: use crypto library for HMAC and hashing
Message-ID: <acRPHRZs_hZYDj4O@kbusch-mbp>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260304132327.GA15515@lst.de>
 <20260305193150.GF2796@quark>
 <aanbGwda2pHmMTMx@kbusch-mbp>
 <20260325202053.GE2305@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325202053.GE2305@quark>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_140953_090392_52BCBFA0 
X-CRM114-Status: UNSURE (   9.85  )
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

On Wed, Mar 25, 2026 at 01:20:53PM -0700, Eric Biggers wrote:
> 
> This hasn't made its way into linux-next yet.  Is that expected?

It's in the nvme-7.1 branch, but linux-next doesn't pull from there.
I'll need to send a pull to Jens' block tree for linux-next inclusion. I
suppose it's about time we get the first one sent this week, so I'll
just double check everything and get something ready for tomorrow.

