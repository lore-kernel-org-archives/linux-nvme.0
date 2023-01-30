Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E19C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZ6AL4GsCeFM3+MBoAuF6dEdidiwCj9P54Gykw2PgZI=; b=05Ski2Sns8ybalOQKKyh1NBlWS
	oYozTvehACHu8NAT/TQblsjj/NMXIsH7Dr0tMKJ/tNQknttlMYg+3kGQa5Ez3aeuwyE3SdUIe6kIl
	HrvoemWm7rfD0VXDYrtcXFJ8kErBswu10WdUm1uXCJ0+5rMBLcHd1oIzw4/ByuHyi28js/MxX2rOj
	h8fp+eOl1PU4EipJ5jyDc9DK6aCWuxf8V2Nq+u644/xt5Yz+ru2NdTX/w6cOARuq+JG6DGAF7RdAW
	bWIN0m6DtI0N+XIdnS2uuC+UVrcrCytDpSdhJK0WdQffh3Ws8/Ii2dLYxeqAOESxRgM+04BOqtO7c
	07r0JBjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXuZ-004WrH-8s; Mon, 30 Jan 2023 17:25:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXqI-004UYe-DG
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 17:21:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1ED3168D09; Mon, 30 Jan 2023 13:35:06 +0100 (CET)
Date: Mon, 30 Jan 2023 13:35:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Bryan Tan <bryantan@vmware.com>,
	Eric Dumazet <edumazet@google.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Message-ID: <20230130123505.GA19948@lst.de>
References: <cover.1673873422.git.leon@kernel.org> <20230118073654.GC27048@lst.de> <ac48766a-b861-4fc0-3171-7b23f175c672@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac48766a-b861-4fc0-3171-7b23f175c672@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_092118_637179_208E009E 
X-CRM114-Status: GOOD (  13.19  )
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

On Wed, Jan 18, 2023 at 04:20:27PM +0200, Max Gurtovoy wrote:
> Today, if one would like to run both features using a capable device then 
> the PI will be offloaded (no SW fallback) and the Encryption will be using 
> SW fallback.

It's not just running both - it's offering both as currently registering
these fatures is mutally incompatible.

