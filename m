Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2E8D15DB1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Dk7qzPQcSpRUN0BpEanRswj8mWNdfGtRYMWP2yypnE=; b=omDPJpwZjzGbcVSPOTgS20tNZE
	3NjX9B0z16r8Xw5Rj6tJve54kVk8bCPFvYoqvDFZPkEdU6PHJx4dyFdB1hjZ/eothjBvYRXYKFiRW
	OAnPkMZ2Z+oinrTGF3JN7R8OzAUgQep900gbbXuScPbzkWBu98ElYd0LurTZ1Yvshjr7rsGAKO4mK
	O2wtw7bYCiaAi4gvrUNZ5aImi0/h5tj2E5qODcwe5wxugmiGZVXXxjxfoUSgpAg4LkF5NIiJ+k9F1
	tqwSi91CnY4nh29Pag2ne66E9Q14dwnnDejB1JvxrXPuW4BDqcjuosuGfoTyAsuhEaEnMkloSnGU5
	bmCoWu/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uKS-00000007miI-3Ynb;
	Mon, 21 Oct 2024 15:28:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2twH-00000007if7-0GL1
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:03:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3916FA4334F;
	Mon, 21 Oct 2024 15:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCD8C4CEC3;
	Mon, 21 Oct 2024 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523000;
	bh=uMevaMHFfOwTKWvSaEBMTX9OYA7bYlx5LsL/xcy9+ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0U1WzxuKdiRGmZu42rxm6Fq364mLH68aZor8wFJPKif5QSKycTCEHddIrqTi+fRK
	 uy8k4Th82SLFmNH93knciXQgLuaiCogF2qsn+UIS7FBIJ/IrBtRlWlfzTs1bk+wdtY
	 pThOMz1lv6W+nnHIu9ScwLM+0p4T7EKkn3B5TvK4vLK9ySULTNY9bIo/EqTr+4S8Kr
	 hjl/K/ZSkb4wQ0FeeR/leluSEd+7iXLxttrJ5fT8JKwiXFsb221G+vtgEy/T4WINMf
	 hw/Yba9C8Du6UVhX02Qp1PJQHN68In+bw4XcaEqVTEYO77RD98rDPiQUpgjE+BUKF2
	 JPuvjFCVjzUvg==
Date: Mon, 21 Oct 2024 09:03:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCHv8 2/6] block: use generic u16 for write hints
Message-ID: <ZxZtNR5fGlbwD7T9@kbusch-mbp>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-3-kbusch@meta.com>
 <d09efed0-c1d2-4c7b-a893-0c7367d1a420@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09efed0-c1d2-4c7b-a893-0c7367d1a420@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_080321_205347_0B978D82 
X-CRM114-Status: UNSURE (   9.06  )
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

On Fri, Oct 18, 2024 at 09:12:20AM -0700, Bart Van Assche wrote:
> On 10/17/24 9:09 AM, Keith Busch wrote:
> > @@ -156,7 +155,7 @@ struct request {
> >   	struct blk_crypto_keyslot *crypt_keyslot;
> >   #endif
> > -	enum rw_hint write_hint;
> > +	unsigned short write_hint;
> 
> Why 'u16' for ki_write_hint and 'unsigned short' for write_hint? Isn't
> that inconsistent?

It's consistent with the local convetion of the existing structs. Some
use unsiged short, others use u16. It looks weird to mix the types
within the same struct.

