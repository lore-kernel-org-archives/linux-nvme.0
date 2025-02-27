Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9C4C19F32
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 22:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wyWZOf9xnYfnqsnZGEAHx21Cj25YdeHLADaBGaGqrqY=; b=1+MOBtyVfu+185FQMgod+lz1mk
	99VqvpcWaahuS/GnqModYbcifQzCfLcjPGKl6weJZ9ZLfMBJXNskJziyD+9v5a7q1b4nBVURhXHI/
	iELkCntRJJ0DCotiSbxckHp+wdexf8rC7JHwhaD3HYQqUHKVMl7vAguQ0+hqV+1bS5DkKDWBvql4N
	VsRa/aw6KIi2Bu6IuO/aXgrWhHG7djfckwsnx4OrtRCny+SG8YZYxcnHXcbRrNDSYbfX0V0Yfz3F6
	OX532yK6BAyTRafIN9owaE2pd+h5LS2SEkQeLw6DO0fGUv81hFtXu/679XkrEteJJUQuBOUaKumhE
	7pvkng8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmdi-000000094fz-0sU2;
	Thu, 27 Feb 2025 22:45:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmdf-000000094fF-0Ota
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 22:45:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 69F535C54E0;
	Thu, 27 Feb 2025 22:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A63C4CEE4;
	Thu, 27 Feb 2025 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696353;
	bh=+p5E0lo3u03fgQR50E6wq/mHsi3IrLUxGn3iMOUgeNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjKMkSclpnSw6gXgh1+crh+wk4ZiQ992nr25s882P3SWo5BDxvTBsfDaZ23ehm93r
	 dkbBlmZMFq9NdRKv5+HQ1HswNxKQOGvLMkq+u0UWdu+1gEJOWKrZS2bzitBJ5ObqV6
	 7ogD4sBJoXhQqI2J/O2TQTc2yq5CbRyllbz8RCMEVN6j+dQ3x+27203304lFawbRKO
	 5boclL4BMfc1swiyeA+hfOz9F0WZkeOcvHlXPDcClhcCH1NSJFdCXCa8vCvxKDvwnJ
	 z4cXgJyQvYz2sSUAy1pOkwrh7HJmRISHsmkPtaATaGbCCZt/6bgtAWAN0a37ku6bv3
	 kzhNNIqV0UhdA==
Date: Thu, 27 Feb 2025 15:45:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	bernd@bsbernd.com, csander@purestorage.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
Message-ID: <Z8DrH7sBSS752Z3o@kbusch-mbp>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
 <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_144555_178963_3850E781 
X-CRM114-Status: GOOD (  14.59  )
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

On Thu, Feb 27, 2025 at 03:54:31PM +0000, Pavel Begunkov wrote:
> On 2/26/25 18:20, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Provide an interface for the kernel to leverage the existing
> > pre-registered buffers that io_uring provides. User space can reference
> > these later to achieve zero-copy IO.
> > 
> > User space must register an empty fixed buffer table with io_uring in
> > order for the kernel to make use of it.
> 
> Can you also fail rw.c:loop_rw_iter()? Something like:
> 
> loop_rw_iter() {
> 	if ((req->flags & REQ_F_BUF_NODE) &&
> 	    req->buf_node->buf->release)
> 		return -EFAULT;
> }

For posterity: the suggestion is because this function uses the
file_operations' .read/.write callbacks, which expect __user pointers.

Playing devil's advocate here, I don't see how user space might know
ahead of time if the file they opened implements the supported _iter
versions. I think only esoteric and legacy interfaces still use it, so
maybe we don't care.

