Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94357CD4F39
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 00:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m8DtHMHpdZM4pY6VH+I4/Yx3x192CtVNTK/xzy7Lpvw=; b=XEZxyKXnMTOQr2doHuEqkpjhoG
	FNmO4aAnVx67J91M7522WZJAZgzq10nuRL0RemtOkpPr69RPdVeSThzuMvkCtNey/zhqYehg8qOk3
	h3bbcgCNCM3b7cU9fWTHYtJ3sW1txvQM8Lc/9nTnKTsyTgFQIRwV7IFop4lSrrOo8e0P/BpVLhLga
	W6FbFQ8MfaFvUjbxgy1zWvyzNpxqakk6i97GaCTTec8bEdJLYMKqo0cKXTV8gcHPjNfXcKv14l6AA
	MyueW/blhyi+hj67mDi9BjU5QL68xcx6bEr9gpXe+Q5KqyxZe/5OthC9dvHkFpKkVwgbmwnSWFcKs
	rzKhw33A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgM1-00000006uWp-0aav;
	Fri, 15 May 2026 00:24:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgLz-00000006uWd-3tKJ
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 00:24:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DAD360008;
	Fri, 15 May 2026 00:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4531C2BCB3;
	Fri, 15 May 2026 00:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804674;
	bh=k4W7/pJA6lvhQOEmxL4Uw4hNh3lzjA73mTSZz6L891g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tD2BIK9VBTnBncsoHz8hImJBJ3vlvh7QDgIdEffKwFpWh0uZadfLaadKAdX2eqx3j
	 1O1Q4tGiZOyD91QPUiLS+AJb1VVGvzk4bkrysSZSuu9T6ccr8NM0SN4/pYGMoPJBHu
	 AjE5BAOZuSMbBnRBtJ76U8gESt5i/B8vSKtGQYz4c0pOP4YcY6iFBJOxSIpORWYVMs
	 M88egYe3bRFdeq8/MGmTwPRrsqGlGerf1O8hP7/FhsWbrSLsXRCwbsxnYAHC1uH9Q/
	 DRVqD9qXy3GZ3FbdGLytphLbGeOSMuoDzi7yZ4mSjK/pWw3PZxhBFqXt+KVXF2IHED
	 5iWXIx1088evA==
Date: Thu, 14 May 2026 20:24:33 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
	hare@suse.com, bmarzins@redhat.com, nilay@linux.ibm.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, michael.christie@oracle.com,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] libmultipath: a generic multipath lib for block
 drivers
Message-ID: <agZnwW64PHRew_5l@kernel.org>
References: <20260428111105.1778008-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428111105.1778008-1-john.g.garry@oracle.com>
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

On Tue, Apr 28, 2026 at 11:10:52AM +0000, John Garry wrote:
> libmultipath: a generic multipath lib for block drivers
> 
> This series introduces libmultipath. It is essentially a refactoring of
> NVME multipath support, so we can have a common library to also support
> native SCSI multipath.
> 
> Much of the code is taken directly from the NVMe multipath code. However,
> NVMe specifics are removed. A template structure is provided so the driver
> may provide callbacks for driver specifics, like ANA support for NVMe.
> 
> Important new structures introduced include:
> 
> - mpath_head
> These contain much of the multipath-specific functionality from
> nvme_ns_head, including a pointer to the gendisk structure and
> a path SRCU-based array.
> 
> - mpath_device
> This is the per-path structure, and contains much the same
> multipath-specific functionality in nvme_ns
> 
> libmultipath provides functionality for path management, path selection,
> data path, and failover handling.
> 
> Since the NVMe driver has some code in the sysfs and ioctl handling
> which iterate all multipath NSes, functions like mpath_call_for_device()
> are added to do the same per-path iteration.

To get upstream this library needs an in-tree consumer. So at the end
of the series, it'd makes sense to include the NVMe and/or SCSI
changes that uses it.

Mike

