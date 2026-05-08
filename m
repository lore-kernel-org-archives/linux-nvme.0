Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A2FCD342F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8YKQYe2OUeyLaNsv9j7XPOkywAHtF8fx+B3Eai3hD0=; b=xWCjns784FJ5bm+nzPKmBjY09J
	Emm73EPSJvw8nRMDAbYtU9Zw/PM1Vf+6uO63ObJ1XJn65Bo5dhUVM2rnGOsL7MKdU+xOjmT48v2Ns
	dsYbZFARFAseRZrpudLPjsNMhvbdCiSHjB9ANzHQIeaEfJeyUyvG97VY06nCmeC4CHApWwNz2suL8
	/jAHHI0KiiagLkuIOW+GV/ThnJrVP31YQW/1jnFklPqx97SQQuujmSmG9J0rG6f1u9u9MArGxvCHi
	lT0TNa7HFTFSzALGlC96VFcT/qBWzSHV45LTN2wE1ETSSUAmfyDEIJq4oece4wZSxe97zpqQpyzCk
	UtIrwrow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGAw-00000005wLk-0a4V;
	Fri, 08 May 2026 08:03:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGAs-00000005wKW-25mi
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 08:03:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ADDFC43F04;
	Fri,  8 May 2026 08:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A483FC2BCB0;
	Fri,  8 May 2026 08:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778227384;
	bh=G8YKQYe2OUeyLaNsv9j7XPOkywAHtF8fx+B3Eai3hD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocK2D4B5AaKfEtbjkWPR971EjQwNf4LiQ1374u9TiqzBUuL93eC53r5R3yROC7IT3
	 Ngttwwb+tRRU3eNqBn/266LSJSVQB28jOt5gDh0g4ooKqJCIsoLdPltgGF5doj5OH6
	 V9lxJvYBNCz9JZMx01ucutLSIq9BhMwBTHjIngEKwQmLOGtjyQC1YB+VcZmJ5wF9WN
	 CgTRAcxCXu4hsiVfvK08kmeUPDb9wNkr0Fo4KNV7TQJyUv8ZyVPc5wTdZ/GlJcVZbw
	 UP6IFyAuLOrhza5JMKkjFYdv435ltoIwq+fbNCzEPrI62/FviHJoPAPMxA+Ts2PNV3
	 0+0JQZFc1f55g==
Date: Fri, 8 May 2026 09:03:00 +0100
From: Keith Busch <kbusch@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: linux-nvme@lists.infradead.org, Pascal Terjan <pterjan@google.com>
Subject: Re: The wrong usage of NVME_QUIRK_IGNORE_DEV_SUBNQN
Message-ID: <af2YtHjq3mhWiyJA@kbusch-mbp>
References: <EgTEZ7GYRxSc3ZRAxjIuBQ@alancui.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EgTEZ7GYRxSc3ZRAxjIuBQ@alancui.cc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_010306_631146_5929AA87 
X-CRM114-Status: UNSURE (   8.40  )
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

On Fri, May 08, 2026 at 02:20:30AM +0800, AlanCui4080 wrote:
> Sorry for my bad, but the prior patch which is merged into mainline may
> be a mistake:
> nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808
> (7f991e3f9b8f044640bcb5fa8570350a68932843 at mainline).

Okay, please send a revert. The number of devices that got such
fundamental things wrong is truly astounding, so I generally just take
such reports and patches as a reaction to a real observation.

