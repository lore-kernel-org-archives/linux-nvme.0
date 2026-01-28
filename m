Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4A7D3F07A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3GOVlCNvGMAEuEvpwco9PbQEceuiUVAGUNDmBJASB0=; b=Osw3vb6XhiLO47VtmRCoUNGhi+
	EXvPQEYzgNr9gNBmy4W9+BTR1Z4Xaf0bgs2u75NYTC3UJp7pNLIvaV6PDz1CTZMMzBLzZTdWhZPcz
	GnDVt0BpognYfH9LitBQWxgLAabY+2BCmQY/taPFeb+sIjzICzqopALYPiYeo+ViWVTPXO4pW0QZx
	syx2PJcRe9GSskNciB8TgupDChDFBaNlkPMGoInmpiwofyjjs65e8qCVAYdsfhtUPMumcZy11orj2
	tCx27Aouy4mggqrddyv9kmHRo0T7PXVILgVErBQiP8pKEv0tNC+uOnwzONoRCpM8UweeOvYj1Nnmi
	fjVEGRyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7DR-0000000GFWE-2mMY;
	Wed, 28 Jan 2026 15:12:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7DP-0000000GFVp-3ujK
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 15:12:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F31CF6000A;
	Wed, 28 Jan 2026 15:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED93C4CEF1;
	Wed, 28 Jan 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613138;
	bh=tN4nY6o2OcquzXHtdghuwNHaqXMTg6hLxZ+PIgKgO4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFwz8hIEzQlfjb+gjgppt3FKhpLu0SNuKv4NAQVejsq922pZ2BccppABFfKvX6a59
	 PP7VBlUoxgtRAo0x8NJ2hPhBXQpxNlffWM3Ql5d2em9AdYGvLmAmjKSb7EA+7Ih0GB
	 m8SOSG2pHozQcVRPpwyknMFM1blxkBnDitYEo1R915dW1QkUEln3Z5IUj2ZNnHonG0
	 TS4ONpQwDXbgjD76HZNM+bIfTzAnU0UofPMkEwhbj71Dbb1b6sv7Sh3GJR17/I1y0+
	 Y+O4/usVLmQwAS1iF4UdUSDaArOwkd7/FLgmGPA1mKIlYvP5VE13DjBzjurL/G1U+a
	 A1XsdA6Wf4ieg==
Date: Wed, 28 Jan 2026 08:12:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH v2] nvme: stop using AWUPF
Message-ID: <aXonUEatf3aQ4TUN@kbusch-mbp>
References: <20260128082623.3945303-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128082623.3945303-1-john.g.garry@oracle.com>
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

On Wed, Jan 28, 2026 at 08:26:23AM +0000, John Garry wrote:
> As described at [0], much of the atomic write parts of the specification
> are lacking.
> 
> For now, there is nothing which we can do in software about the lack of
> a dedicated NVMe write atomic command.
> 
> As for reading the atomic write limits, it is felt that the per-namespace
> values are mostly properly specified and it is assumed that they are
> properly implemented.
> 
> The specification of NAWUPF is quite clear. However the specification of
> NABSPF is less clear. The lack of clarity in NABSPF comes from deciding
> whether NABSPF applies when NSABP is 0 - it is assumed that NSABPF does
> not apply when NSABP is 0.
> 
> As for the per-controller AWUPF, how this value applies to shared
> namespaces is missing in the specification. Furthermore, the value is in
> terms of logical blocks, which is an NS entity.
> 
> Since AWUPF is so poorly defined, stop using it already together.
> Hopefully this will force vendors to implement NAWUPF support always.
> 
> Note that AWUPF not only effects atomic write support, but also the
> physical block size reported for the device.
> 
> To help users know this restriction, log an info message per NS.

Thanks, applied to nvme-7.0.

