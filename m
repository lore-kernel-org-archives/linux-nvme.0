Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4DFF8DFD0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YksySc+MLwdBL18tbEVLsMQ4qIFGwQzhQh2fwU7LCtA=; b=ZmpJxeRkNp7nTdUWcYstDqQeC/
	vxx83d6qYCDOv59/sIoj9lNDU+iztDCw0z2U6nLn/b8ANb6gQoAJIaW0648c9IoK9+9+8FLNOBMcs
	33IWCHS1ceLONcxuZ3+Y+8luhK1K85puvI22MR8iYg+iXsNIlwsa+ME+47doV+NBLUQz3fpu+EFmV
	j/Ec0qkIXZDFXIqevuJfuVvRufP1hXyiaDVDnAjuk4laNziBxmDHpDpFbE00kLVJPZ4El4D8neeIe
	/JOWKN51di7PxM5a6dZnGjVKHKDYIhzMCSmW9Ed0/wgCet3leVNZrnQmeR0adiRTlvW62FjM2n/jZ
	vWRsRpSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUtJ-000000037ik-0HFY;
	Thu, 16 Apr 2026 22:08:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUtH-000000037iQ-3VdF
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 22:08:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C119B60128;
	Thu, 16 Apr 2026 22:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E56FC2BCAF;
	Thu, 16 Apr 2026 22:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776377330;
	bh=YksySc+MLwdBL18tbEVLsMQ4qIFGwQzhQh2fwU7LCtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeKmmYIFSUzdBSXfzRh9VRdnQRRrWXBcaKKpB2/wA0N95qMuGVSE3dCyRQkXSteJC
	 W7tDt58Yu/Dc/C/B38JefalUNifnQ1/3e9SbspDPRtTz/f3EYRCTELQvqcqslmJKN9
	 R5wzJHTooDgJsgG8AI2ghuLTHM1QesJ3ow5+Y5iRu4RYWQNe6LXoIK1nooUwKJxPtL
	 DV9XC9/svGDMvoWDk5xAvsN1J0m8KroLfPAoDMxGG3DWdRoGhc7HetRF+jSjciM0nR
	 I92ULD8a91VcIiOd4BDGr/h1FWk+FYR8i3QVrMj4cBq6WHsWreAfLPCWAvJOIoRgCw
	 PigthFm4Ufnqw==
Date: Thu, 16 Apr 2026 16:08:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, nilay@linux.ibm.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: put module reference when delayed
 removal work is canceled
Message-ID: <aeFd8HcFpu_KpBOj@kbusch-mbp>
References: <20260415155358.1517871-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415155358.1517871-1-john.g.garry@oracle.com>
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

On Wed, Apr 15, 2026 at 03:53:58PM +0000, John Garry wrote:
> The delayed disk removal work is canceled when a NS (re)appears. However,
> we do not put the module reference grabbed in nvme_mpath_remove_disk(), so
> fix that.

Thanks, applied to nvme-7.1.

