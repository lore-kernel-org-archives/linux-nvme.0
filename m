Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C33CC54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBl983Y0Mdm5g9gqXeiDWa85OZtgCVSkePm2IHniy74=; b=Watvq55UbeqiBcqrGa04OVrvfU
	igd8tR4G7hM8gG77k8Zxaz/cAlxgPyCrg0R1/SQvFUWitt0yOhsw9UYkTqPe0qFlqgnDx+MYaVwHZ
	PQMj3uYFt/DWG5Wte9BTjbKmaV+vphntSVkTemBJo6JYvY7saVjrK6GSFymSIDVWjAe9ektRSgRSn
	/+CYnyX6rckAaI57OoSx0Yr/iHW/I/A7A0ggms+NQCB+MKAYl9VXvGNgr1MD4XtRRgQ2qv4EmIMzC
	Lssp1srQ3JA/dS6Crd9KDyONuH9FEUkrXViybO9xxCdnM0Z2hFt1TvMinjqoeNMFlsKzWz1EnoL4W
	Nm5yV6LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXOg-004JUF-1y; Mon, 30 Jan 2023 16:52:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMXNG-004JCP-Gs
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 16:51:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0544868D0A; Mon, 30 Jan 2023 13:36:11 +0100 (CET)
Date: Mon, 30 Jan 2023 13:36:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Message-ID: <20230130123610.GB19948@lst.de>
References: <cover.1673873422.git.leon@kernel.org> <6f9da88c-f01e-156b-eb19-0b275c46c6b5@grimberg.me> <e37fe712-4e0e-229a-a07e-52a0d486819c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37fe712-4e0e-229a-a07e-52a0d486819c@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_085118_719368_BE2B160E 
X-CRM114-Status: GOOD (  13.06  )
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

On Mon, Jan 23, 2023 at 02:57:18PM +0200, Israel Rukshin wrote:
>> - what happens with multipathing? when if not all devices are
>> capable. SW fallback?
> SW fallback happens every time the device doesn't support the specific 
> crypto request (which include data-unit-size, mode and dun_bytes).
> So with multipathing, one path uses the HW crypto offload and the other one 
> uses the SW fallback.

That's a big no-go.  The blk-crypto-fallback code is just a toy example
and not actually safe to use in prodution.  Most importantly it just
kmallocs a bio clone and pages for it without any mempool that guarantees
forward progress.

