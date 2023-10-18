Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2474ACDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QOarRXq/53NrQdEjyF9TR6JUPUGqurBiakN5nxyJZ0=; b=vIGxUxe9whRKdPOe4Ys8kYCpPL
	W04lkJFM1QtnqAClnDD7gIVEmu0dQxoF+HsR3AsRJMjAiPa3sgudvWxezP1yOqYA9pO1Xvqy94h0q
	p+yW85o4ynWwNLpRzyNPXWTKqy8xaO9xCcDesw3g06qocYTWyM0vj4KALsHQpJ88Jx5QMNcpkKBvc
	j8lrs0J+K3ZyrchUAK+E4ngsiDFgmyg6QyMRcdLEm8l/LS8ljz5kge3DnXAHPCzDJWivRX4ViJrVp
	JyaRvtCtSFAFErqElaalZU9td1xcBNvow3m49NSJjsDbTl8IuazESsVEDPQUIfmT8z4dcrX0CMM9j
	sRpl3RFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtDkr-00FhaB-0j;
	Wed, 18 Oct 2023 21:07:01 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtDkj-00FhZs-39
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 21:06:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0E964B8236F;
	Wed, 18 Oct 2023 21:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2464C433C8;
	Wed, 18 Oct 2023 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697663211;
	bh=8QOarRXq/53NrQdEjyF9TR6JUPUGqurBiakN5nxyJZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Axc76gtz31i7rJKz0XtBHgVcOtQwf+XFywPcBvEK7x0kYUXmN68zYEtB3+VMYwr60
	 x2xboRpI3CPCGKzwa9vjDB4H+uOVmEE3RU9TQ3tVv36yFn6/W782j4dECJTj2IRLVz
	 hfphukJf+yObZTJDGMXVvNPS5ek2OZkHLil0W0vgwOZ8rRF7swGvgropdz+d24tJ6G
	 7Qsz0tkuP/RG3aAVQuJpjDsq1isYliCxTQoBmydWVPei+X2ynzFqMf7SqfdRfB2WtS
	 uMkl+Rtr+h1qn7VZPTSaPv0YwYPUpZyuOC/M8B093jr5ET1zV8+yaB8NIteUT2fJYp
	 nG2l8660arxBw==
Date: Wed, 18 Oct 2023 15:06:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Message-ID: <ZTBI6FRVCH4Czu13@kbusch-mbp>
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
 <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
 <CA+1E3rLF7ZRoo8hPPPLp19FvT7ae-3aDfBy_+hjgNGT9pRnk1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLF7ZRoo8hPPPLp19FvT7ae-3aDfBy_+hjgNGT9pRnk1Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_140654_174658_4DF6D780 
X-CRM114-Status: UNSURE (   9.81  )
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

On Thu, Oct 19, 2023 at 01:29:46AM +0530, Kanchan Joshi wrote:
> And if not this, what should be the solution to have non-root
> passthrough?

I agree we need non-root passthrough.

Could we restore what we previously had, but fence it off with a module
parameter to opt-in to allow it? Like setting a silicon chicken bit, and
taint the kernel if that helps convey the responsibility taken with such
a parameter?

The only other possibility I can think of is start a command allow-list
specific to non-root users, along with your earlier patch's decoder.

