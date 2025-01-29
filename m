Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC61CC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SeZspGMtd29bXBRJEo6j1b1maNPj6nnM3pShwptmW2A=; b=u9FhjQKEnSXCVrju41c1RFJWuV
	4l27UmkKIknvkUsekcXhL72wrTPw73st9G4URbynio7JOcNsoQiun3wDxzL4E9iEDe5MOh3CgSm54
	JVxQW2rz21FnDs+FNz9FT86jYz28DR3TSX4uBC9V/YL454/4sEvoFzor9+AEKsYEB538WVKE8qxa5
	Zs9jOe+OCC+VqgXIKT0ZcHd7DUxGAZE7be2gX8t/DsgIRHf5bIzlpn9FkHarL0mSUX6SW1xftFWxN
	tCoFQK7D/1CC7PjIhQyYnJHMyMW3C9WMpgxhTGENN2jV1JWm3GWeIPvWoKR3fM4E+FKbgrXU50ZQ/
	NnfabTbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td9zS-00000007F9Y-1hRx;
	Wed, 29 Jan 2025 15:28:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td9zP-00000007F9F-3q7Y
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 15:28:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D26F5A41A20;
	Wed, 29 Jan 2025 15:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBC6C4CED3;
	Wed, 29 Jan 2025 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164506;
	bh=SeZspGMtd29bXBRJEo6j1b1maNPj6nnM3pShwptmW2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YElx4xGBKbiZmg/exChiKs++JAtGnxXODnvPFQa5wutbWImPHv1PuvB9WfYDr+97b
	 sWYFohrvpcIW4NN7mJhDA1pW9x2VAfcvXgTDqp0aE/R3S1FsYciLUSbPW9J5lMx0YK
	 uqGjynyy1FQgR+0ho/v3YZLB9MuAwVtMpemx51Ss2OKLcG8H4X4dYXRUqf+8BlulbG
	 RO2k+5l/P+L1tJs4ha5c0BI+Apar/T7EYK9xO9v6ND/BpTVoqv0QuFkKXpNAuuffgo
	 i3yiTcsI3VkziJ4ycdUI2pg5ckG/4PrJaU/Z+LVOXVj2mqu3yAKL7JrfRPTLlWTeq+
	 UlWr5/5QR2Oyw==
Date: Wed, 29 Jan 2025 08:28:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <Z5pJGHAR7AWCC0T4@kbusch-mbp>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_072828_017506_B6117CBC 
X-CRM114-Status: UNSURE (   9.03  )
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

On Wed, Jan 29, 2025 at 07:32:04PM +0530, Kanchan Joshi wrote:
> There is value in avoiding Copy-on-write (COW) checksum tree on
> a device that can anyway store checksums inline (as part of PI).
> This would eliminate extra checksum writes/reads, making I/O
> more CPU-efficient.

Another potential benefit: if the device does the checksum, then I think
btrfs could avoid the stable page writeback overhead and let the
contents be changable all the way until it goes out on the wire.

Though I feel the very specific device format constraints that can
support an offload like this are a unfortunate.

