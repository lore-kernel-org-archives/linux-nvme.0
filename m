Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BDEC982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKWPGMsMKj0GVrpPMSrMp1tLyzvLfx5MyUbcQt0JUKs=; b=wvokj7PePsT35yWeeg0/xRum2V
	vhAdQrSOaDfO5aTQ66i0/MS4ePRMfl0mEBm5H8vyIm9iPmTIeppO3izPcnoMNACgnrthk68w2Bm0S
	189ytak6blh3w3nQyvGwaThRJG8tcnWBJ8bVZTMBNld3OXNvNspXgmfmoNKYc50fBvK/ZdlQI4oTq
	G+YOStRdJbIpD1ZkMzMYUGid+AaJj4xuYca8pgqxw9hTjj/xFywgD6Yj/jB7peFi4GWrqINDIJK8H
	F+X+2HU0S+30ZqmWtHTp/9eazOGmHCTGy8Pc4YX43b77r0qfqF+pVCsqOacwawxIr09eEzexTuYTz
	K2Zp7Ybw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9235-00000005mUB-0ZgN;
	Tue, 22 Sep 2026 15:04:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9234-00000005mTc-05uc
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:04:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C3DB94051E;
	Tue, 22 Sep 2026 15:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5F61F00893;
	Tue, 22 Sep 2026 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089485;
	bh=kKWPGMsMKj0GVrpPMSrMp1tLyzvLfx5MyUbcQt0JUKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KSnIAh1Xb4nrdYcdXu4DSdelq3J6n3K5U23TDvHJnn2eySdltOx2/xcUzLVGW6XJ8
	 wZ3hnZvyCviTherXI+Yfw4jEaIWwfhRKwZs0dqwz62E9gUakvbysL0jWUrhpHP6ClY
	 u9vMiyfedBzNBZkCvNF0kPhGHI/OyVI4EJ31bErnTUWo96S87CJM15zWLfRDiyGuFq
	 qaBMCn47BpMFKnlEIJ5QCcuaanLIEGPpRZMIzR9zTqyu2nB13xLdN+eJTv1tm2Ky3H
	 CX2g7oTIeAjwGAPFwL/pkuvVt6SRiYhwob1WhH9rzYCRhzHy6ZnWmh1uXl85x9vG5Z
	 1QkMJHkuytSDg==
Date: Tue, 22 Sep 2026 09:04:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH v2 0/2] nvmet: fix subtle race in I/O processing and ns
 configuration
Message-ID: <arKZC8bhV7TwaDCc@kbusch-mbp>
References: <20260918162736.802665-1-nilay@linux.ibm.com>
 <arKX6rZq_CLz05X5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKX6rZq_CLz05X5@kbusch-mbp>
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

On Tue, Sep 22, 2026 at 08:59:54AM -0600, Keith Busch wrote:
> Thanks, series applied to nvme-7.4.

Err, I mean 7.3 for this one since these are fixes.

