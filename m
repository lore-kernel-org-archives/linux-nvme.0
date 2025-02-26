Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A126C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmH1S/Rzq0FxLgrO/eJfpYA5Zf/HpcpQ6JQLKa/UX3k=; b=cY/3M5HerMg0ymMFkOmswPqxub
	bX3NU7L6HoVc0NGq7tpFMfD0n5EheoDAJvYazSEbebF1t/7kvzj+mtPeAAKT8FaarHJuawpNLtaC6
	OHXyinkoFrSxAlHg6JWwYJwAxVurL7hWRDk/oLCFiWhYQ3ix6nOOGN9UHLCY9RnXxXjlLYaFvoKu3
	X0gR8DPqK2tpB85CBuArpZ9f3xT0ysdYb3wCuMVyrd7s6NNVN2+4zQaMbCJB4t8UwCl5rBp9M2lDg
	GW98XCav4MnKcg/ttxU08/1E1pFaKn2k8HNR72JEUb7J41yaRKMbx5qJsDc0qXDhAOMky6SKCbLCF
	E/Zm3hnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNaF-00000005Fke-3lAe;
	Wed, 26 Feb 2025 20:00:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNaE-00000005Fjr-0PxD
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 20:00:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B70DE5C7421;
	Wed, 26 Feb 2025 20:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3280C4CED6;
	Wed, 26 Feb 2025 20:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740600041;
	bh=s8TR3mzU4dAMr2KyS/iGUHeMjkOW+Z7uBLL2Cfc8pv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/8mBCQ41anFup23sLTi2aX6kI1lAvfNfisC4VpALVIUdEdyqz1s/RnGg2Gb0m8By
	 BhGak0lQ6yLccO52xvYlgpkvy6j34JYqx8v9jKBln0uUPLVtau0fVmGKH1+IyfueLZ
	 AAe3vmi3ajnzEMG/d4KcU3Ak7PISIxRRdA3j6TwLNiScj0GwrufM/EEsD8aPWdvAr9
	 hEz3nMXGnbf8se/MR/U3Gagjys9Hslf01IB5RmeRNZHK8/W/K+d9aSepbvAHjMFPgx
	 XQhROwkwuHJFESs5lROHb58sICPYDdvLVuzdMUuDvoK6GTHCmKgb95mmvK6tdbIM0q
	 IuD9DR2ZPeNhQ==
Date: Wed, 26 Feb 2025 13:00:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
	asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
Message-ID: <Z79y5hdS6EjuTEr5@kbusch-mbp>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
 <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
 <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
 <5f46cba6-0a11-457f-8591-732f709e7fea@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f46cba6-0a11-457f-8591-732f709e7fea@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_120042_180742_76B6368D 
X-CRM114-Status: GOOD (  12.29  )
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

On Wed, Feb 26, 2025 at 12:58:21PM -0700, Jens Axboe wrote:
> On 2/26/25 12:43 PM, Jens Axboe wrote:
> > Ignore this one, that was bogus. Trying to understand a crash in here.
> 
> Just to wrap this up, it's the combining of table and cache that's the
> issue. The table can get torn down and freed while nodes are still
> alive - which is fine, but not with this change, as there's then no
> way to sanely put the cached entry.

Yes, the imu can outlive the table it came from, which means Pavel was
right to suggest I not tied the cache to the table. Thanks for pointing
this out.

