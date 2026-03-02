Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5032EEB362E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGufjOX1LXNIcwArCE2DV4aZpPYijXW/y8p9m7e+K2Q=; b=sZ4dTfcLS9gEkx3dQ3P5ero5cQ
	44jyulUr0nxzTrd+ZXZrjcw3muzUTS+Pli020bByF5QZEtbgGSLVNvzcDNSwsDXRabzww01IkwLkx
	tseP5u5hCmld+YEAZgbysIwRbjcZN1Ak4bTbfi95ssllJjeglXOAMN6qPAZTCW4liOfgwtviGNgcU
	KVP0E53wYYV44M2xgnVlzb2UP3UTTnCcJHQWE657QMk4Ghm4M5ySqhsicSskK6fmxc9YetiGqlyoS
	PI2sIHyi+TLzzjeQGK7zEOZfwxoopnVLaEeNDILohskUuaRVp2+BxWPM7p+ZxM67qtBCXAH4vIoVw
	VrDgx3VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx8Pk-0000000DhEm-1Wm8;
	Mon, 02 Mar 2026 18:54:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx8Pi-0000000DhEe-2Tuo
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 18:54:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 840B860008;
	Mon,  2 Mar 2026 18:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE09EC19423;
	Mon,  2 Mar 2026 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772477681;
	bh=B6RABV+2sKmH3UJl17RfkN2Nlrsthhw/oriEucsl2XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8fjlZa+jBlpVsZMeHHL28R9KWa46ataY8bulVnAsAy7OdmbAtrF4PVc5ctzBx/P1
	 vtDD5mxKNEvU/TEhQguOwpzhnXV+0bO3HSP1It6uyp1H5FsGQgWuQXBaE8SLPGa9VX
	 AGTOxFidOtgw38QtIY0ZiJNGrS08+Upr3ton+QX0Th5So+nu8A6fo5l9EqPxEvH13l
	 rK+dCpcwW9t56h9pWMc8FiH8souTIC+XmpNgjHGycth6SxSDWvxDgCPhGyo33jnT/M
	 8AwL1J77g00YYnr5LQEdwq7GC7vNic7AkGxbIU8XxY+xSN9vAVztJKJ2YF10IKUAOv
	 x7Em2GQvJVDjw==
Date: Mon, 2 Mar 2026 11:54:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] nvme: set discard_granularity from NPDG/NPDA
Message-ID: <aaXc7oun2IgjJ21F@kbusch-mbp>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
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

On Fri, Feb 27, 2026 at 01:23:45PM -0700, Caleb Sander Mateos wrote:
> NVMe block devices always report the logical block size for the
> discard_granularity queue limit. However, more accurate values may be
> available in the NPDG/NPDA fields of the Identify Namespace structure or
> the NPDGL/NPDAL fields of the NVM Command Set Specific Identify
> Namespace structure. So use these values to compute discard_granularity.
> 
> Also fix the use of the OPTPERF field to better comply with version 2.1
> of the NVMe spec.
> 
> Update the target side to report NPDGL and NPDAL as well, in case the
> discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.

This series looks good to me. I'll queue it up later this week. I just
want to get a pull request for my currently way-behind 7.0 nvme commits,
then rebase the tree for new stuff.

