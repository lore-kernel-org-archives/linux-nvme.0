Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58154C5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5LsewdHq8axGqdMclbgkFMG6QvZQzwFU/njGh+pE/4=; b=25JzsTaJNcngElxfYcAFmcYzC5
	EuH79yE4I8NDKn9nXjuEYi50/ONsbaEXa5yA4HTSkQi7Oc7xUj7LwnFv+2WFumh1I70519qHtodQx
	DFiK1Plbr+0Zk5zxsOuj88SVAiFwetnHPb1cK9cVEjkxmiBsGJEq4hZpXaIzwiJe5S8YOa+Gk3KCf
	zBL0fLVoEfTLcN4YSPiEK99zWBZuDKavGs9g42p8MgLBzgGvLeR3uRAlmU0qtvFbcD4AjoBku85Qq
	ZY0oqI6fyjRJ07ZPX0Lf6mvKMvnUnmtQfd1cJ+WKaGIzLpFR0EXW+TXBevQNSBZjLB8muWNQfbyL9
	uye5QzcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf0T3-000000060YX-2nsl;
	Tue, 27 Feb 2024 16:38:15 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf0Sw-000000060XW-03ta
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 16:38:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7F399CE1C92;
	Tue, 27 Feb 2024 16:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721FEC433F1;
	Tue, 27 Feb 2024 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051878;
	bh=8X5If0DWDBPBkHXSwgOtOM/mnJClbs/8aXQhYPr0l+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pb7lQkPPchQAkF5VVaRigqvkYrekK9oapRNk9HAUhvqctBiaGAV7pKFAMXIXoPAwh
	 /NietPV/hT1QG5HnbJBFT8O4zwiHFyLpUqJQqagCYJjO5GmyFLjhzVAsPtP6S5dJ5S
	 /sS7ltkR3D/cWA8S1iw/CumPMGf0ayXSksq2QuwPKhR3x0Mty8f+YtOVt1e10HTpi0
	 JPqHC524C2y0pGbq+8jMlyCfcdAiGQoxqefDL7s/WNUFDcwW6geuQHKYgkwIViiB6i
	 LK5HLlrj8ecXG/5Vj9eI7X99U9wRwXtKmOCR/63jArVc9yZUd+UjGpg/JCifBCOAyf
	 iRDfH9NuljRyw==
Date: Tue, 27 Feb 2024 09:37:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/3] nvmet: add some commands tracing
Message-ID: <Zd4P4xru8zcFUlBb@kbusch-mbp>
References: <20240227085408.130161-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227085408.130161-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_083803_065422_1B206F7C 
X-CRM114-Status: GOOD (  10.67  )
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

On Tue, Feb 27, 2024 at 04:54:05PM +0800, Guixin Liu wrote:
> Hi all,
> 	This series of patches adds tracing support for ZNS commands and
> authentication commands to the NVMe target module, as well as updates the
> tracing of DSM commands to be more readable.

Patches 2 and 3 seem fine. I don't care for patch 1 since that makes it
impossible to see if anyone is sending unusual attributes.

