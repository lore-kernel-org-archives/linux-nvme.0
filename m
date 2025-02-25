Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7E2C021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 00:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqJarPXYSwglVqxyO/7QYkAw3t/BrmJQJNV3TllQEvU=; b=u94RBUJVAskIwNqbajf/UNdpwc
	D3E9981Su0L9xHG1J57vOz9l/3l80w9XF20j43oRcPO7maiiKsGsLSMVPsv3f34XuYimNIolhimXJ
	e3JKtkX0SQK4VdNMhWIoTsv1h/RdCd/4oQi791rxJBRUc8OoPEhUMSR8aY8i829t6+8w8sInNxLyu
	7wOAmWaPtohZ2EHeAw+bqD+OqeLm5eJAlCKTvSuOFiFooSAmA3fEbdpGyovoQyM8Omup0sM/ns7ku
	+ntdPaczWnwKvWEUR+koer1ytx5XsMN9kxhC+MN5UGLqK53jc5AKDjkoPjy9QxJghsTpoxS4K/wSw
	bUFAyOZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmidU-0000000FbUU-2apJ;
	Tue, 25 Feb 2025 00:17:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmidS-0000000FbTu-3D0O
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 00:17:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2065B5C58AD;
	Tue, 25 Feb 2025 00:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC33C4CEE6;
	Tue, 25 Feb 2025 00:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740442637;
	bh=UH6tcp8VxWyeHOBxoFlbV8+a/iGzWX4jL92wfV+tevQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJb+GdhI3nHMOnyUSReZev4MyxHrkOS+DyhYVqL3gyx71PVuz7hD+X4pJdLLQzo0I
	 HHsadj6/GfAvoOcTB+exRRLCKs0LQ0P7Aj1eXO9ZeFSvhin3D8t0eMFcfyrqRK4sDu
	 1aBGzTdayF+mmtqYroIdqsWH7ECgbNeUfkEI3Ox9DzU0BNEqYmCz9PHbetcUpgPI4C
	 6t/M88yT/UJhGo9TMK87nD3RYEcK8aQx3nrJ8DfV1T8Zoon8z8H1NSh4oWYxhdJ/gm
	 d5Kbs1JB4qjsX9mS8v6kfhho84qYCy28HrzNHZXsgoNgrE96VRPKP+YtGaTvRrL+G7
	 MEpihvJircIEg==
Date: Mon, 24 Feb 2025 17:17:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Icenowy Zheng <uwu@icenowy.me>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Message-ID: <Z70MC0zoC0L-tOgO@kbusch-mbp>
References: <20250212170444.16138-1-uwu@icenowy.me>
 <20250213055449.GB19370@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213055449.GB19370@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_161718_864361_D3485D4D 
X-CRM114-Status: GOOD (  11.60  )
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

On Thu, Feb 13, 2025 at 06:54:49AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> > Here is a small patchset that is developed during my investigation of
> > a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> > SSD), which is because of the SSD's too-small CMB block (512KB only).
> 
> Hah, that's certainly and odd CMB configuration.

Should be okay if it's just for submission queues. The driver has an
arbitrary requirement that the queues have at least 64 entries for CMB,
and 512k allows us to create 128 submission queues like that. That's
enough for most systems.

