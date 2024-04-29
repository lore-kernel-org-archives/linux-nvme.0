Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52F7C04FFE
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Czd+JNJcxdeyzkuqNbMEIOVd+NdWyuBvdnTa2v4uSi4=; b=ia0lyuA+78T1ww83KoEeITAdKb
	RWVnXIAPbq7jDYWCZNBxDfOPyUYR+dhbGSIgV9fd1bhi99qwRoP16inSux3e/q2VLrJ7TARyBjR4n
	kTMv2JfOhP+5nvovXfP6oBq70mGbPZVCrcWwTLIjKM0vWzhSJXkpUS3GhilLJyl2Cedw6RcVqWMVU
	B+4k5Ayp0BXyXKi6AVQPetEcgWeQE0Jgbg6Ss4GMzRW2U7ZDX/3Gc4Mn4wvM6tLQf6Slwqx+sN2Cv
	cMu0fCL/fMKwfSGSOa79T8Z4+Tbe6DA5blquDk8nRLx9mMiXP/tJxXt0qrJ3FuqY4N00D+oEE9CGf
	C7nE9o4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Mjp-000000020lA-3Ewn;
	Mon, 29 Apr 2024 08:51:53 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Mjh-000000020k3-3TGi
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 08:51:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DA1ABCE0AB2;
	Mon, 29 Apr 2024 08:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73982C113CD;
	Mon, 29 Apr 2024 08:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714380703;
	bh=qBitc4MIold+q8Yxf6bT5ciAbaS3kPvYJBQtrz8Wr7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkQF8TQqg5vK7cPvUsCOz0rULu3FYn9DSep/TUp4LlS53GKd0AWe2l4WuW1LNg1lb
	 FsfWCHtrdxYjBmEDzU3Pfg1Tmimgo2hRtICcN38NMJSieWER/7d/vJZAqAVTT0hzmu
	 yFGeoffXHQ18MTkJX6C6y8ZnKpb62PxWsOjCSKETxf7IF3EWFy2PFKlgQ8Kq/CkOw0
	 VxVtXwF+0Pe8d9KmgBL7+B8GmcahWlJqSNGR+EgXQqpX2Zg61DY6xcGOeSvvPn/21z
	 PeN01TpgSrfWmXvTFwoaW6qULhXyMaINgAhFQD75pnm4Do0TPc3RTT/CosFFU49h5O
	 +oi0Pj9S5i9ew==
Date: Mon, 29 Apr 2024 09:51:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de,
	gjoyce@linux.ibm.com, axboe@fb.com,
	Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
Subject: Re: [PATCH] nvme: cancel pending I/O if nvme controller is in
 terminal state
Message-ID: <Zi9fmr3wmcFlqxt3@kbusch-mbp.mynextlight.net>
References: <20240425140303.1599437-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425140303.1599437-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_015146_065995_3FDB6F31 
X-CRM114-Status: GOOD (  11.03  )
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

On Thu, Apr 25, 2024 at 07:33:00PM +0530, Nilay Shroff wrote:
> While I/O is running, if the pci bus error occurs then
> in-flight I/O can not complete. Worst, if at this time,
> user (logically) hot-unplug the nvme disk then the
> nvme_remove() code path can't forward progress until
> in-flight I/O is cancelled. So these sequence of events
> may potentially hang hot-unplug code path indefinitely.
> This patch helps cancel the pending/in-flight I/O from the
> nvme request timeout handler in case the nvme controller
> is in the terminal (DEAD/DELETING/DELETING_NOIO) state and
> that helps nvme_remove() code path forward progress and
> finish successfully.
> 
> Link: https://lore.kernel.org/all/199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks, applied to nvme-6.9.

