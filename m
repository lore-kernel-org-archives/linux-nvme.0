Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1F1C3ABCB
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2/p25Da4s7N42qO7vxm3TT1D2ubjL2EI9wyiIt12Eo=; b=woGOS5ONi+ymSz/b/Gd808YA/j
	9aIcFq2j5Hz3gM5yeN+/Z6Jbz+KpSSLssGm4ZqU9Kki+luEHCt5/fbM7ztb47Vt2rJ9DhtY/2wLeE
	Ofx632ao4937khWRLGpuQX2p36xlCJXlPcF5/fQTZ4duwmHD9ABpV1pWoFQ44NkRrc/Oz4NXVL2Jp
	qIzjIz1yS1Qp69L9k1+GbYmXPCZbZDTMYf5+fBA47Ylp9l8Wwyx0cUAkyCazhL7HNvjc9uPsg264i
	ZpHrzpwoljBdALa+dO4G2KSNxxthLL3KiipcqaeiLaxTUVW+2ByelC4F3RWGizoOB9qH851mfItu7
	Nbhq60uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEWFq-0000000A5ny-3Gt5;
	Mon, 12 May 2025 16:43:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEVlZ-00000009zIk-2Hel
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 16:12:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3A6445C0C7D;
	Mon, 12 May 2025 16:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C0C4CEE7;
	Mon, 12 May 2025 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747066352;
	bh=QCA/41hXxhIQ3wHaEK8abj7pW5P/aCkYjpUHk2tEWYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRFZwAdM9kOIx6KqluX2pqDD3fzRDxE58Uj7zx4YfK/vV0LkX5Yz+wufM2Q7MFg/t
	 d7IN/lZiqoTq+0L4S1hfFQUnBUUpdIfGixvD0+ql1WATSVLN+cAy73QWu498bHf6nd
	 rVefRL1PzScKj1TaZAMhGDQHJjaOgjsVxguw/XtYBftFsbnMHNnbxkCVrkkIigevfG
	 C++I4b4znuv5JwYte3b2lS3AeBfLrM4y0tpjX9HHrqLOHkN3mrK0OF8gx7OMeIqonZ
	 ejgwYviAqartuvW/6iO9nrsffN4lamj6Vme1OCYsKgYeeyWLp/KoSF/qmm7jOhVMgr
	 TpCVnnaz8yr+Q==
Date: Mon, 12 May 2025 10:12:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
Message-ID: <aCId7XmLnrLWZPdk@kbusch-mbp>
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
 <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_091233_622289_4849D3B9 
X-CRM114-Status: GOOD (  10.71  )
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

On Mon, May 12, 2025 at 11:18:58AM -0400, John Meneghini wrote:
> On 5/9/25 11:33 AM, Keith Busch wrote:
> 
> > If those are not unique, they need to be blanked out to make sure we don't
> > expose these on the namespace's sysfs attributes.
> 
> OK, we can add another patch that blanks out the lower precedent/invalid IDs.
> 
> Will that work?

I think you'd have to blank out the non-unique ones, otherwise the
driver would export them.

And while I think that might work, this proposal didn't go over so well
last time it came up:

https://lore.kernel.org/linux-nvme/20250414111916.GB13225@lst.de/

