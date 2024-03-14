Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0EDC54E60
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Mar 2024 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=srLPANAbs/p/0UF95xTt1D5vuAaV/msB8JnZJ+offmY=; b=ogPLvLFuiJUrhrQoOn4tSjkSeT
	3RDO9DbvY7K6+oO3UHF2Z+eSh+p58SIth1u/PQ0SQrlegyP/lHejs67NBOENKYpX5DhevQxfs/jVx
	7SzoJVFmQOb/wsl/KysJewX6SdSNAsoSu3lL6wiELRmulWMLdD0kfHstz0/aSVD7SCUEo3wlQb8gP
	GEgFU8IYFPBj2iOV4sj3+TFuy8FOJwg0z6gsSEksPYtxz5exvqDZ1RhnAN0YA7YBLvdkDP0NKYOL/
	YYKjQT0fbwSfLlL1HCWEPMzt5aXbwFgHAm8wlAt4iQ/Lw1W2WwruHrbP01Pl1nmvyzD8OqmwgwhIf
	o3ClBW8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq1m-0000000FLI1-3rdY;
	Thu, 14 Mar 2024 18:42:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq1j-0000000FLH4-2GHW
	for linux-nvme@lists.infradead.org;
	Thu, 14 Mar 2024 18:42:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 71CF26152F;
	Thu, 14 Mar 2024 18:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DC9C433C7;
	Thu, 14 Mar 2024 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441722;
	bh=r8X+a8VjCDwCFNK/1/Fik/WAJH8MZUF5GNOlx/xr1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAs6ih/jwZG3omUuI8MSuo/Pr1i6aE+qvUzZfis2mZDB1TRgDEqIp8Vmj+qwv27Y2
	 nWqFTrdxTkLcDisHjQIrhuU2+WHPhm+TvOkhCrvTHFFFYQI0OjEH8KmUdBKMpeuadw
	 0/mwa1OzZsPrqOyuD+naHrZNWU1i8sT8hSBNwPWuwnwB3/yD7JyBblaZUni0nPLceN
	 E1yx9jJP0eQOr33LG3VI/5EqJAsGUvK4SVfjm6gSf1agD4ZQujY4so89mTQgU/r0T5
	 48usk+qXHyigFcW2VK6H6CP2KYNOQiDobNw0AP05XmXIb2RVV2lAet2GvUefMeNTuH
	 WDaVmC0AEurow==
Date: Thu, 14 Mar 2024 12:41:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/3] *** nvme: add some commands tracing ***
Message-ID: <ZfNE9nRxAlqFICs_@kbusch-mbp>
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
 <559d9283-449c-4135-b4ca-168417e56ee1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559d9283-449c-4135-b4ca-168417e56ee1@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_114203_639069_9FD7B3C0 
X-CRM114-Status: UNSURE (   8.62  )
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

On Wed, Mar 13, 2024 at 11:51:49AM +0800, Guixin Liu wrote:
> Hi Keith,
> 
> This series of patches has not been combined yet, could you please
> 
> take a look?

Added to nvme-6.9, thanks.

