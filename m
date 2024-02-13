Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAF2C4829A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gh7C/WsGynZBSmQ6CbzWfF6c3VWR9eMjfpXj6Q9DbKI=; b=NNqSkTdaXiEoR7aTKy2n67pDyA
	rxpflCozAr2QsUS5J+CZgWytlqgO5KkHUHzlvYMAdj9EbSTPVX2JH1AoWO+xS0cJIpzLXYy1I6BB+
	X1aEFX1rjZBvbff++Ycq/1eBoTIJVBPyZJUefJJ6CUMxwBT6QPw8nWl+uiR7k4n3dkmU+DA0y+Ex1
	SpoH/UW73+KAV0+or7aK0V1yfGZ7Zl2bAxutOpWZQcS9TcLGcRsjM/xz3yaS34xkeXSvSPNTq47Kk
	u/pblN2pTpHKGuMXLD/YQWJ0AnxQzixQSwD180g8kYfX/WFNS5+WMaVsf5IJTocv1jHL9a3OGJQuT
	xlFRrkyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZvhc-00000009xRv-2csj;
	Tue, 13 Feb 2024 16:32:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZvhZ-00000009xQm-2e6W
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 16:32:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0D42561597;
	Tue, 13 Feb 2024 16:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B937C433F1;
	Tue, 13 Feb 2024 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841928;
	bh=F8MNRKTp972vnSsJkVVs0OzIAyfSqXzX33cFk3uSz7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Em5RJz2YQyutNlhhwN9XbhkEhS3qTSTF//F0W4f7bXeGbB4R99TBcugjsCDtSVBbn
	 G5QCrnzTF9prBdpLEjG0zN/SoAzgLNoBuo0plDVT+me7xPIyXLKnoZPe/L1LfX+qlS
	 qQnhrT9nCAyForXgNkS7qBpIMzy5ECboKt7IPMKA0buNZfDqNaKGrkDDGw4VkTTzb0
	 1AlbY4JCoVdtD5i8Hkrx2EqPrTIP3DWw7vXKhNwSIDa9vu2J7nYlm80x12NWkJ06lR
	 aErdx2Vtj4AENr3s8Eu/2EXMbTIy9YrNr5u5FKkwW59UNcSVQ96eFECX3tjr+jZAQs
	 gmrBe9sZ4UbYg==
Date: Tue, 13 Feb 2024 09:32:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH V2] nvme-fabrics: fix I/O connect error handling
Message-ID: <ZcuZhX4VtRNyeYKi@kbusch-mbp.mynextlight.net>
References: <20240213082646.49308-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213082646.49308-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_083209_745922_FA34D40C 
X-CRM114-Status: UNSURE (   8.10  )
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

On Tue, Feb 13, 2024 at 12:26:46AM -0800, Chaitanya Kulkarni wrote:
> In nvmf_connect_io_queue(), if connect I/O command fails, we log the
> error and continue for authentication. This overrides error captured
> from __nvme_submit_sync_cmd(), causing wrong return value.
> 
> Add goto out_free_data after logging connect error to fix the issue.
> 
> Fixes: f50fff73d620c ("nvme: implement In-Band authentication")
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks, applied to nvme-6.8.

