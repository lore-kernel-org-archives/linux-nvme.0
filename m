Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5359C0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 07:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BuNkhA4U2EXzY3UIav9rX8ABnEiVHzXbjByWKZyeJio=; b=TeVAn789EDElSKEXGMOp1ZaqRL
	Ua5V++1k89e11Kfu88iSkxtyxfgVm1YrioSc/5tBz9UANPZvLCHr1tnAwoZea8DDrVXgAZLM0SkO8
	1MSbJ6xHdaNL/OmMv4ZBzxfePHbKdGFghHWaFvqKX5xM4uyTcrkM+UgjOaN+KmvHymPKS65mnNEkV
	WPE/F3bt6+FdNvZK9TjkY1T6NUwfMTHRlWaVEI/lNoaWYePDuQxPJcbEnDW2QIHw6IXRPVzDQBIGy
	gBes7oTKyH9fTOPVNgA1n8T4ktkSjtA7O1xlyO1PeZ6XUOpjQK93Cskm5aJgmRzEg0YBn0Xlxtcqn
	iTfgjPdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdl80-0000000A5JH-45ww;
	Fri, 31 Jan 2025 07:07:48 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdl7w-0000000A5J4-1JuT;
	Fri, 31 Jan 2025 07:07:44 +0000
Date: Thu, 30 Jan 2025 23:07:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z5x2wDP1Y6l1FVr5@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
 <20250131044015.GB416991@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131044015.GB416991@mit.edu>
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

On Thu, Jan 30, 2025 at 08:40:15PM -0800, Theodore Ts'o wrote:
> On Thu, Jan 30, 2025 at 03:39:20PM -0500, Martin K. Petersen wrote:
> > It already works that way. If a device advertises being
> > integrity-capable, the block layer will automatically generate
> > protection information on write and verify received protection
> > information on read. Leveraging hardware-accelerated CRC calculation if
> > the CPU is capable (PCLMULQDQ, etc.).
> 
> So I'm confused.  If that's the case, why do we need Kanchan Joshi's
> patch to set some magic bio flag and adding a mount option to btrfs?

Well, as stated in reply to the series there really isn't.  The
case with a buffer duplicates the existing auto-PI in the block layer,
and the no-buffer cases reduces the protection envelope compared to
using the auto PI.


