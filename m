Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE66D462C6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cy+jSUTMXro6VYXKHWbl9DF98Ptc7tThWWlkeQ7jyDE=; b=OGTr9Ifjbvj6icmHLg2Bae8qc/
	KzJ52nr96NJm8r4GQy5v2ktC8dRqJem7j5MMrl9JiBx7B+bY7VObwJUX7zidtaMTsds/ff7lR+Mtm
	9XktHbPiN7bv3nfyv8JY5YBUDEcBqdQBDccgoOAScLj2ENNpdPtV6j08PwTc1JWO0sspDWn8b/yPH
	d7T2wU8Bsy/UT9ZfALKG0sonjuTBnaHCJFBkGe2JHc0DVJgLDb1hAD6dWd1k7oRrPBXscLACBkuNL
	Lqn7/hiQlvUNOe6/2+gh3wfkpVMNDqTSCRhcfvQau6cXdWxcNsl9gCqUmFQcVNvA3ACSRQsdEet3T
	cf61qCew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFez-00000007MmM-3wH9;
	Wed, 13 Nov 2024 15:52:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFdg-00000007MaD-1o0f
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 15:50:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 763225C5848;
	Wed, 13 Nov 2024 15:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A43C4CECD;
	Wed, 13 Nov 2024 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731513039;
	bh=UKQ46QMwz1oaIvDWxUek0wgv0FVO4dZNEm4Es+G1UE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txXLc8ZHX/niXZQ29yvVXarwQxwmRWha42DAvgd9l/YDumkPAvR2fy92Upno6sS8J
	 8YsiMwJ1oLUpCIyZWaWbrprEo93RBvuBcGozzvU/Au2bn3r/xZMVTC3YGh0SORAd5B
	 jzGkNIItDjieJve+QBIx0bqG8aEGvcoT+r9Ldp3ndsqYANU8N7FoPhUHyiFuIrQmDs
	 6ceVL/Y3WprG7ryr3I7iXDQP4oDnMPIheA7L0OK7pnKpF7P/orVEMvZoeWc79hzpNh
	 5snRxWb/6ioBYACxMmtvFlM8hNtlxEiQC/pbhMFtRLyFtlvc0HU6NYToIjMDfMdgeB
	 bx5Il0l0bXBYA==
Date: Wed, 13 Nov 2024 08:50:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 0/2] Using SGLs for userspace commands
Message-ID: <ZzTKzVQCMZQFWpGG@kbusch-mbp>
References: <20241112210620.2650523-1-kbusch@meta.com>
 <20241113045012.GA20379@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113045012.GA20379@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_075040_543792_359456AD 
X-CRM114-Status: GOOD (  16.27  )
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

On Wed, Nov 13, 2024 at 05:50:12AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 01:06:18PM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Changes from previous version:
> > 
> >   Merged up to linux 6.12, which had some necessary blk-integrity
> >   patches
> > 
> >   Dropped all the initial "cleanup" patches. This is instead the minimum
> >   patchset to satisfy using the feature.
> 
> Refresh my brain, but where was the previous version?  A quick
> grep for " Using SGLs for userspace commands" on my linux-nvme mailbox
> and an internet search don't find results.
> 
> Are the previous cleanups the fixes to the block layer metadata/integrity
> code to actually properly deal with splitting and merging?

It's here:

  https://lore.kernel.org/linux-nvme/20240904183818.713941-1-kbusch@meta.com/

This series follows on the block integrity series that fixed up the
merging and segment accounting.

Much of it is not necessary to get SGL metadata support. It was just
cleanups in this path I did along the way.

