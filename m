Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136B4F47CC0
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQnejZUqfuh0xFCtcFY5rJTRdDaXW9ccP039Sbk1qKM=; b=HM1nTY7thy2O41W8kLCO3pQeU2
	K1YlvbW0ABsM5WCjy1TgA1ETmgNa7Sn8GzpTDI+G3uu3QesVaB7ec3hHU9vkkHYAwLzbHG/mdpHkL
	Ax3K18RBXbL/WWKVVmECQS1LTMXQnftvVLpedVnoPFcayUUAiP+Rs9ejOtuUNgVwe5MLX824pN2Oy
	sNaa8jY/YONutv4f5wlqUZ11weUOAkdLKDA2gxUo/fUDSJBhf4Fwou3Jdbs6gT4hERivis170P7Yk
	11txY6LJBco4UqktT775qCJ5Ujw0pksvt7SRSc3A7fxlLKmgrtL8ahJ39gGYQc6bXcdoKuwkVVFnZ
	A+M0qLBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEUL-00000002SvL-1tgs;
	Thu, 05 Mar 2026 19:36:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyEUI-00000002Sux-2cr3
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 19:35:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 621084454C;
	Thu,  5 Mar 2026 19:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEECDC116C6;
	Thu,  5 Mar 2026 19:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739357;
	bh=qR9Ij/FY34eHSXXTcCk/GeK8X2a0zFTqLCAWPVyb0rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP4RLTuBIUFpwwk876uF1ZcO3ahkW65xMWEDbV3v3kYQO5zXp8HTk0v2nGmoqTicm
	 UaDvPi70FuMpEvVWBmptSJjlOfx6ROOOp6ANdDvWjMYVqDG+rOMZchZoDOaq1w6jOd
	 9ie3CtqaZZnhsJenyEiZ6PLlge2AbhMOT2mTjJJgywo3A+Wag4ZLKiHGRbUIIPQX4u
	 fQT95spfZABECyxBRgCusBohyq3EhkQmoqI/p8J61uRk1150lNJF6FMf5/Aq8F/m4i
	 2dtLWm9m99p4ysaTZACC2jsF+KPSg/56ZKZUp+Tn/lmXtahoG9cZ264t6N601qh7wz
	 4j7jFsOWy7ywA==
Date: Thu, 5 Mar 2026 12:35:55 -0700
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
Message-ID: <aanbGwda2pHmMTMx@kbusch-mbp>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260304132327.GA15515@lst.de>
 <20260305193150.GF2796@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305193150.GF2796@quark>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_113558_684588_CC4F3B97 
X-CRM114-Status: GOOD (  11.91  )
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

On Thu, Mar 05, 2026 at 11:31:50AM -0800, Eric Biggers wrote:
> On Wed, Mar 04, 2026 at 02:23:27PM +0100, Christoph Hellwig wrote:
> > Thanks, this looks really great:
> > 
> > Acked-by: Christoph Hellwig <hch@lst.de>
> > 
> 
> Thanks.  I assume Keith will pick this series up for 7.1.  Keith, I
> forgot to include you explicitly on the recipients list (I must have run
> get_maintainer on drivers/nvme/target/ instead of drivers/nvme/common/),
> but I assume you received this series via linux-nvme anyway.

No worries, I'll start up a 7.1 branch and get this queued up. Thanks!

