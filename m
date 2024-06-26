Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB56C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMmhAqVKhaT/I70GcaIET5tzZPjOLHwmjcqLYp1YnDU=; b=1Xg3rnvA8qlOO/nSVf13Xy7hKj
	nH44vJYimD5Sb6XqX1sOy+MxsWP9dM2VXFtZiEa/q7ZEbg/9Asb+zQ/xrTp6DP6vrTfVl11hbPdEn
	BJhYpCeEF8UytQQPsVWpMrFhFJldBAJiW+14Qggsgm2M/97c6IpQwf/RxS7PlVw2KlIB/v6MVhdRG
	AgGWoDi2VvSJPOhyaQETFqOJeiN5ftpSJFmKBnx7BKTCsqZCdPAjtQ/aY+OmnW7ZwppPKf+kD/i8Q
	yFPcKHDkOMrC9cgPpJ1hNuv3lt6NJFyTs4OBiMhQarLedYZMdYD3Y1vbBVTJfgeBPwpKT+Ina8NLs
	za6A/7cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMZ2C-00000008Abd-1JIi;
	Wed, 26 Jun 2024 20:14:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMZ28-00000008Ab7-3pKJ
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 20:14:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E97F26198E;
	Wed, 26 Jun 2024 20:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E605FC116B1;
	Wed, 26 Jun 2024 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432863;
	bh=CMAaGZ+AZHbMdAhaJIFZn5YNhfegdNBmB1wWg2nw8vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ArW/+NlHnuZ3Do1CbYyRZbIjNh2yRnRRsMPT+uEzUCdw5soSdlwfh2Ogj8wRLjQlY
	 SnZZ4YvqkLuyrYkqIxDHFy6kZrTeBBuKcAn4mm0mP1rhOw5eUIvo10IU1LPmM6w0nt
	 hc+flhKHm0/5g5osGG2ulEQMb9XZ+i/vUc/9hWVWypp3GIs4ZaletnHXK7WVuOsyL/
	 2+kxdXEFPznMZU7OwWYWl/LqtEQBqaFI5laiEvMfJqJA+nHOa5QlShc+eVD6SwM5IO
	 eXvwhfErvu1uS3RfLxrkTplSK9WUOqRir6hRHwjhA13sP4cd8IPx/FShktdMVDqduR
	 Q7baKX1XcITRw==
Date: Wed, 26 Jun 2024 13:14:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Shai Malin <smalin@nvidia.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Yoray Zack
 <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Gal Shalom
 <galshalom@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240626131422.1d39738c@kernel.org>
In-Reply-To: <475934b5-4e41-44c9-92c7-50ad04fa70d6@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
	<20240530183906.4534c029@kernel.org>
	<9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
	<SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
	<253v81vpw4t.fsf@nvidia.com>
	<20240626085017.553f793f@kernel.org>
	<d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
	<20240626124301.38bfa047@kernel.org>
	<475934b5-4e41-44c9-92c7-50ad04fa70d6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_131425_033590_745D7691 
X-CRM114-Status: UNSURE (   9.09  )
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

On Wed, 26 Jun 2024 20:10:41 +0000 Chaitanya Kulkarni wrote:
> My other question is how can we make progress on getting this
> code merge ? (assuming that we do all the above, but it will take some time
> to build the infra) IOW, can we get this code merge before we build above
> infrastructure ?
> 
> If we can, which repo it should go through ? nvme or netdev ?

Let's wait for the testing.

