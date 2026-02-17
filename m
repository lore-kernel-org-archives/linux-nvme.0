Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A33E9A03E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 20:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O3KNzwdv/fZolh9vEe47GHGiaeS4Hpe5Gsp1brWunUU=; b=llqqBEWDxpRZhl9okfzpzTj2SJ
	iuzGeoV7sXzcZG3SXDAvllNW/8As8KG51WAO/l0FvCMNKyWskSNDRFeAxd3nEyvdvoHXWl75qZtAn
	JqcZAXT9QRBNhGqRN03ofL4PgmSfWkO7nMqN38LLXQ/G35WgKpWtfmaBPrELQubisVbimcYpg+38I
	zCSlV4/5GdTOpuUl2wNkSb9chdXGzoqCUlI4q35v82rAidiQ5WX9gSmXrcTNF5P7HNfY0GUNPgKCW
	6jdLcSLQx2QHv8eMP/OcKoPPGBk2+Kqy/AEOmXHZ2oxPXt12q5tYdWND9lt9yqEXffk6jNW5oh+bO
	/zeZGBsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRS4-00000008qCN-06Ir;
	Tue, 17 Feb 2026 20:13:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRS1-00000008qCB-1FjN
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 20:13:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BBA0560053;
	Tue, 17 Feb 2026 20:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5CAC4CEF7;
	Tue, 17 Feb 2026 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771359220;
	bh=O3KNzwdv/fZolh9vEe47GHGiaeS4Hpe5Gsp1brWunUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=go5nyuTkw3Ac1hUXhYVUndWAXOiKYJtszHh1P9R2ACAHgkhM7pToXmL8alG0lOSsv
	 O5V/rrSjAZQkpT2diAPlhAmNGX3Trl7M9m1wajgozmuuRyLDqvbkdhjp7YCRFHs+4t
	 fLnQNrSexcp8U0sX1jVYnSE5x+xE9IeQuGPXZPO2JnhU07Y17XemWPGux8F+mDr4Gd
	 sYOSmkz/i24+izPybQRX23xyP8w9WMzPSKHaHKB7EoRD1Vh0lARB9Nkv9SOyfK00t8
	 wR6EElkoxYpbv95s91Ww73C7quHjPvuE4wWDOMTyNE4dc+Xart6U/p6qBcuf5QZ5e0
	 h8S6TM2IEpQ2Q==
Date: Tue, 17 Feb 2026 13:13:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
Message-ID: <aZTL8srSowTU81Rz@kbusch-mbp>
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <049a177d-85d6-4c9d-9a9a-f07391046101@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049a177d-85d6-4c9d-9a9a-f07391046101@acm.org>
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

On Tue, Feb 17, 2026 at 11:33:12AM -0800, Bart Van Assche wrote:
> More important: what will the performance impact be on SCSI devices that
> do not need multipath support? UFS devices don't need multipath support
> and soon (later this year) will support more than one million IOPS per
> device. Further performance improvements are on the roadmap.

For nvme, we can detect if a device is multipath capable. If not, we
skip the multipath layer altogether so it has no performance impact. I'd
imagine the generic library version would similarly require an opt-in
approach that UFS simply wouldn't subscribe to.

