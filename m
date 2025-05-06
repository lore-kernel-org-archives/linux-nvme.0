Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC18C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKTQ6VcTSG2BiHjkFAOpXRBoaP0pGPvg2c/QjLyuhek=; b=wYWPQTOZ/UQKbn8Xn12GBBXuTq
	17cIsXqF42p7xBjbOBGOc9V4g4emKPnFDsJRzxhCgJ8usUqAxYJpUlxoF+PrND3g2eVBbJMQgntI7
	JHidMjRjQCgqf5ZJBFfRwzTZBXKYXLmGFukrS6a0I9BngawTfu5QdjfXopWKHozWUQhQ7gJ2ZS8RO
	Sw+E/bTEYQDHub9jdMblWHwKHsMa84RteQGbIoNVPnu8fLQqQL9cIkLGEuKZo1bq5mIKQ1WOn/KWz
	n7q4qTBALZ6yqnvUOv8VVN1hyV7jHkG3B/ew8D+bgULuwuJEKOt7lkXDkeWyEn+dnH72H+xYOrt1C
	sKW/TY5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRvG-0000000Dj0k-0C9m;
	Tue, 06 May 2025 23:42:02 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCNfr-0000000DCAI-2NuQ
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 19:09:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BBDA0A4B9EC;
	Tue,  6 May 2025 19:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BE8C4CEE4;
	Tue,  6 May 2025 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746558590;
	bh=oV8ggCP65igJYRgUaYqei7WOxkp+hAjecNa0WNiomWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FooJy39GjQyA+I0kYX3R99gO5bMDgiBQeXgi4Y1cVZqh1sl4BIKAoGwjjZqFEVpgW
	 u/SVLiT2g6YWSKPc4Eoq3K0jgTLE0Iow7bOc6tMLKtmZlyfJgg30waCNUoniD/9yY0
	 eLV4///PY9Jj881bHkPPT1zHoVcHHEu4AV1m/Ln4s1RePgDG1jv5q9f3fWSUP51c+5
	 D5wZ+vzM0u22EO32q2sEnpkaLZDDOUG6IySkkAXY2s02lth4dKy/s6GlvrB0ixsNQH
	 CcqhsmeocQ7MoRUR91Et2L2TW7IQvkB48XNqUiGrljQNGjCyiBlNVJ14ZLqeic1/jI
	 NAn6RX16q8ftA==
Date: Tue, 6 May 2025 13:09:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix write_stream_granularity initialization
Message-ID: <aBpee6L-UXEDcH_h@kbusch-mbp.dhcp.thefacebook.com>
References: <20250506175413.1936110-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506175413.1936110-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_120951_679949_698455E7 
X-CRM114-Status: GOOD (  10.25  )
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

On Tue, May 06, 2025 at 11:54:12AM -0600, Caleb Sander Mateos wrote:
> write_stream_granularity is set to max(info->runs, U32_MAX), which means
> that any RUNS value less than 2 ** 32 becomes U32_MAX, and any larger
> value is silently truncated to an unsigned int.
> 
> Use min() instead to provide the correct semantics, capping RUNS values
> at U32_MAX.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")

Looks good

Reviewed-by: Keith Busch <kbusch@kernel.org>

