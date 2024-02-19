Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F7EC48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UxfTKIn6yWDwNX7YKV5wOrfYSX0mIP6ZZ57MU6OWuxQ=; b=Cu3gOGj7f4bwxD+Q4Q/4V4pgln
	poxSiKMoT9Im/IkBF0zDJsLTNxuyGn1ENq6om7S/IdSGde5xwbkq2zDC2R/LxprJT7qc9EzUas3Yn
	p9Ix/VvURRj/JeET9sNSdeMMmDSTVv7MYcxDk73gFr1PIs03o0a4GXRfkgJlO22Q2W3JKiQ9PsX0x
	hRnxLJpZ9SkMRzdog8zTJCWHq1ubRkFSg+1znmC9RplnA+VGQt7ZsI/yqpaiBtLItQitw+PECPuNk
	dbWCgwJSTgeTAM+QbSFKwl49Q3o4vGbEQdaQhFfH7rZOaS7YbeyUIXopRIZ6iTwNrYCOrwlGp9bXC
	sKR1leOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc9Cc-0000000BsDe-0vym;
	Mon, 19 Feb 2024 19:21:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc9CZ-0000000BsD5-1gET
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 19:21:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF5C860DCA;
	Mon, 19 Feb 2024 19:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BB4C433F1;
	Mon, 19 Feb 2024 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708370478;
	bh=BU7vmtS91LW14umqdRks1US1wmoCN7BfyNRskJ+lpzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDI2Tw7lYr17vYfRVT31/CFWOTvQvw8vu8Kd10WZDkZAfAUrzH8Df4KP6kxyUwmrK
	 rGFpMcWC60IsJ/xONKcoIBQHrAldlZdG91Eo5stQQ7g0kxVAFfd9FHlI499h6X/V9X
	 uV3aNuG/f+xnORzGFBi12Jq9+lalxrUM0mCfg2eSqcmNxdvWWWj0HLY4KndwAixZ5R
	 QrIt0Synm8G4YerLcrr4Ta1M2jUeYFvwJyqYGsqzjANrsTGlgG6z54InG3nSN7NzBy
	 lWYK1LwZxKgM45/cm2HfebVej40pz17i5AFt4n/v5CPx9+emInzhElr3yhPEDIr6p7
	 ynArQJ8jnkTMw==
Date: Mon, 19 Feb 2024 12:21:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v4 10/11] nvme: Atomic write support
Message-ID: <ZdOqKr6Js_nlobh5@kbusch-mbp>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-11-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-11-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_112119_572960_FCFAB3D1 
X-CRM114-Status: GOOD (  22.77  )
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

On Mon, Feb 19, 2024 at 01:01:08PM +0000, John Garry wrote:
> From: Alan Adamson <alan.adamson@oracle.com>
> 
> Add support to set block layer request_queue atomic write limits. The
> limits will be derived from either the namespace or controller atomic
> parameters.
> 
> NVMe atomic-related parameters are grouped into "normal" and "power-fail"
> (or PF) class of parameter. For atomic write support, only PF parameters
> are of interest. The "normal" parameters are concerned with racing reads
> and writes (which also applies to PF). See NVM Command Set Specification
> Revision 1.0d section 2.1.4 for reference.
> 
> Whether to use per namespace or controller atomic parameters is decided by
> NSFEAT bit 1 - see Figure 97: Identify - Identify Namespace Data Structure,
> #NVM Command Set.
> 
> NVMe namespaces may define an atomic boundary, whereby no atomic guarantees
> are provided for a write which straddles this per-lba space boundary. The
> block layer merging policy is such that no merges may occur in which the
> resultant request would straddle such a boundary.
> 
> Unlike SCSI, NVMe specifies no granularity or alignment rules. In addition,
> again unlike SCSI, there is no dedicated atomic write command - a write
> which adheres to the atomic size limit and boundary is implicitly atomic.
> 
> If NSFEAT bit 1 is set, the following parameters are of interest:
> - NAWUPF (Namespace Atomic Write Unit Power Fail)
> - NABSPF (Namespace Atomic Boundary Size Power Fail)
> - NABO (Namespace Atomic Boundary Offset)
> 
> and we set request_queue limits as follows:
> - atomic_write_unit_max = rounddown_pow_of_two(NAWUPF)
> - atomic_write_max_bytes = NAWUPF
> - atomic_write_boundary = NABSPF
> 
> If in the unlikely scenario that NABO is non-zero, then atomic writes will
> not be supported at all as dealing with this adds extra complexity. This
> policy may change in future.
> 
> In all cases, atomic_write_unit_min is set to the logical block size.
> 
> If NSFEAT bit 1 is unset, the following parameter is of interest:
> - AWUPF (Atomic Write Unit Power Fail)
> 
> and we set request_queue limits as follows:
> - atomic_write_unit_max = rounddown_pow_of_two(AWUPF)
> - atomic_write_max_bytes = AWUPF
> - atomic_write_boundary = 0
> 
> The block layer requires that the atomic_write_boundary value is a
> power-of-2. However, it is really only required that atomic_write_boundary
> be a multiple of atomic_write_unit_max. As such, if NABSPF were not a
> power-of-2, atomic_write_unit_max could be reduced such that it was
> divisible into NABSPF. However, this complexity will not be yet supported.
> 
> A helper function, nvme_valid_atomic_write(), is also added for the
> submission path to verify that a request has been submitted to the driver
> will actually be executed atomically.

Maybe patch 11 should be folded into this one. No bigged, the series as
a whole looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

