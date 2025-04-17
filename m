Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BBC369CB
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XAR7RaN+YoRF0TjRrYMzlXlKCsFm+M0dewFoc3m74k4=; b=hXnTn4nWQeOUv78ZJXauyufSas
	uW2QBaNn+SA93ZOrfFdVzWUkctzi4B0jgXUX9aDUTJ4XCU3Jc+S1YWz2hU7DoT3HmTdH/m1Ip9vdc
	etdP+v+DOFad1P8a7dRHNIqIlhaR9zLcM9VNK82PB2iMGek4Q2wNxga+BcT7n/Qd4GwJ48xAazXyS
	EnWmRENXYG7lPuqCjeLp9Pmmg4vCxmeusv5oiiLWVAHi/EpoZffFMjW+Nc8fBEIC00sORbG0Ocigr
	MHJ5H5u2ozhri7y8xXTJXiHD8LA3cqn8T0pLPgJ8ga+HkC+2Uk5Sh94RXWiyby6MUuj+fAGMf568l
	Sk7bEYDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5TxW-0000000E2R9-49hl;
	Thu, 17 Apr 2025 18:27:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ToH-0000000Dzfz-3EKg
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 18:18:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EAD805C4982;
	Thu, 17 Apr 2025 18:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B091C4CEE7;
	Thu, 17 Apr 2025 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744913879;
	bh=q8xF7h4VeJyGfIdCLJkK5eHW9pbqYpdeQU/w8FP1h+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3YGNMNR+SsoUHImMzH/uPK8/AxMFdJqZ9jseZ0Y6PST2vz03N1Y//bPgD1HlMR8V
	 p/bgnlr+jFC674EiRFhMP7vfvyb4z8i+6ldWTfZ0EA4TpmpiHdaNosWnR3yXYxPOdN
	 2lV3kMyCDjN5zZVlPSaHh4SEurNbOHNzH09nckn2H9YhbcdTLBJPGphz7Y1ex25wKs
	 8trQv5MEJ+pfQ/f4a8KwAwqRyf5dMZsue5JJNcNHm1TTK+Gh8Kk5tP9FSbety9XQKE
	 TBxZucZ0ACwyiF4PxuxPNjCfKkSpM3KbRwzyElIppSfpCGjCEGhEDGTaLF8pcGLMFA
	 BIDmPq9IqY/2g==
Date: Thu, 17 Apr 2025 12:17:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: DMA pool lock contention
Message-ID: <aAFF1b6Zld-Jln8j@kbusch-mbp.dhcp.thefacebook.com>
References: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_111801_860020_A7C58FC1 
X-CRM114-Status: UNSURE (   6.64  )
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

On Thu, Apr 17, 2025 at 10:06:11AM -0700, Caleb Sander Mateos wrote:
> Hi Linux NVMe folks,
> On a 32 KB NVMe passthru read workload, we see 2.4% of CPU time is
> spent in _raw_spin_lock_irqsave called from dma_pool_alloc and
> dma_pool_free. 

Just curious, do you have multiple cpu NUMA nodes here? Or do these CPUs
share a last-level-cache?

