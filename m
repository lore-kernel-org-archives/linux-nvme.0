Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A7BC28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8KnrqXNNBUTc5Jec8MPd2TL2vtPwdAe5qRwu8dF1m4=; b=gZyxTOMungn4aM81ekCqEVWW6T
	KfYI5Qe4h6BLMiOdoolbOgT1NUdwj5+X8qMmUnT/HA6VpCxqjQRVlRQNIFwLH04Y20d6Vp1IvOZFf
	di4UaM18d3fryp4JvsfdXd+2ZIF0Q6zUxGRmFdmoIBOjnJ+/DsiHl/9Pr9PPvFRTtYPSc6+Pa/5aE
	/fnLMBeneCVRVs4ZLIRT4aGDx0CxSX5ejZerYRxrfDyQ7ajBnC7fw3NqjjRjFM+36DMWOheYI9ni3
	zLAS9nv2uor3axAoMxCUKzQCw8jBEgCX/fNJIM2CskjqbHyBd+9LCMdtmp/ikpf31cogVh9W9NFK+
	c3FZHrLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyDVy-0000000E0Io-1z0o;
	Fri, 28 Mar 2025 17:29:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyDVw-0000000E0IO-0wc7
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 17:29:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EF69843659;
	Fri, 28 Mar 2025 17:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E237C4CEE4;
	Fri, 28 Mar 2025 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743182943;
	bh=Z4OkGV5PLg3tHCFfRZZ9DrAl5jieNwlZj7RZwLHOBz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAAkLQD73ttzGlDFxpCemiRcQuDTf9x8WNxfCWgzeG1HmhMP0/cbWZpcmsT5+qUqi
	 xMXGqrbRobHjOKdLNEHi2oRj0aigwWSJCLTa6PH1dbJSsjnjT6pIryAkYYZLtV1WS9
	 f6/W7x94QjGZx+fTS85iKB8RgHJUyNIwkr9UJncv88v5AcI6cdAIOlUvKC0UCuSpJm
	 AXY9aBM5FhkQJwtUobfXtbhX0WzyXgrhxpcD2mEpJV8lj1i+jo7ap2Rh1H8ZB3YEaP
	 MPvsWfbhhifWnPGqs8qcpobF+c6puyf42wH11rX3TJzyVdFNLpF2jiTtAnvmilhOFE
	 e4uldHCqhwn8A==
Date: Fri, 28 Mar 2025 11:29:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH v2 0/3] nvme: make core.nvme_multipath configurable
Message-ID: <Z-bcXHLwqU8aI_Ug@kbusch-mbp.dhcp.thefacebook.com>
References: <20250322232848.225140-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322232848.225140-1-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_102904_281406_ABFFFF7B 
X-CRM114-Status: GOOD (  11.54  )
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

On Sat, Mar 22, 2025 at 07:28:45PM -0400, John Meneghini wrote:
> These patches propose an alternative to the outright removal of the nvme
> core multipath module parameter. Rather than deleting this module
> parameter we control its appearance with a new Kconfig option named
> NVME_MULTIPATH_PARAM
> 
> Note that the default kernel config settings produce a kernel
> with no change in functionality. By default both NVME_MULTIPATH
> and NVME_MULTIPATH_PARAM are enabled and there are no user visable
> changes.
> 
> To remove the core.nvme_multipath parameter simply compile with
> CONFIG_NVME_MULTIPATH_PARAM=n.

Thanks, patches 1 and 3 are applied.

Lacking a better way to handle your situation, we can add patch 2. But I
recall you wanted to invert the logic and option name, so I'll wait for
that.

