Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF88F9EDF6
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4pq+ICDtSfSbUFJgYP7vPhdb8kzBlxjqK4bcatTf4A=; b=r9u40v9gVidBa0MdiTeLYXoui0
	tVJ0Oyn33/vo8mIBAjpJmXVgvZ+gpNqjBY8dWvX7vHOs1P8ARn0l8LWpuwsTGCPlD8cJHY5G/rjlf
	Kvj6t+LHXiGBuVAXZTVjF8r2uIVlaQs7q4YcNBf9Uu6ySzLbLDlCcxeVdRko2v2nW68wnle59vjKR
	63oI+4J3MJKanlfheNnMg4EP/etJOpsLtNrsp4L5/MLzAhV7evP3kgrXzAlkaGDdLpcE7gVMBLnHq
	uoMSbQdtChx/dwgP4It7ARmvrbb6Ja360DfVm2qjGHF1xbq1bGfveCFuYWNy5lyMpgsZcgvb+ixD4
	06IY7QRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYqQ-0000000ANtm-2lYA;
	Wed, 22 Apr 2026 14:46:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYqO-0000000ANtf-47Fv
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 14:46:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D755660128;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E640C19425;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869183;
	bh=QB7yVFQbGxs8Fs3ycEaTdzD+hrSDArI8p2AbV3glGjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcO1eDJosw3vOyxt9HXOG8R++28Ff+gi9mbiOwNVDXjNjPJ6YPzldY/fyy/hUlINZ
	 sbGIfCEqKrHe1W2aRN3Hy+ESnnlttG7w0M7sBtrf5ZSI7MzkmQMUK8WTk7Iep7dnBb
	 vl79PDY9In5RLLgzJDl6PDeKpXADssyu4THylQIWKI+o++pHPBlhVVzUGgs34N1L3t
	 s0idZb4WY+EgcOlqPCHhfVhcw6HZpHtYnCOmoT6iG+WVG/LpgXAeOKzntqYPpuzQDZ
	 wrj+rJ0Cx00ijly4HHpTBf3w5mrsEy0MnFEmGPAa4xw6CMfmFAXU/BSqKFctVLznA3
	 tJ+8/uuY7ZthA==
Date: Wed, 22 Apr 2026 08:46:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	joshi.k@samsung.com
Subject: Re: [PATCH] nvme-pci: fix missed admin queue sq doorbell write
Message-ID: <aejfPUSHppFE0xJU@kbusch-mbp>
References: <20260421161855.3980034-1-kbusch@meta.com>
 <20260422060155.GA5391@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422060155.GA5391@lst.de>
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

On Wed, Apr 22, 2026 at 08:01:55AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 21, 2026 at 09:18:55AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > We can batch admin commands, which means bd->last may be false,
> 
> How do we end up batching them?  io_uring passthrough I guess?  Can
> you expand the commit log a bit with that?

Exactly, io_uring_cmd passthrough starts a plug. The "Fixes" tag is a
bit subtle, so I'll more explicitly state this in the commit message.

