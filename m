Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26453C3ABB6
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppEJ6EAIMkDOyqB6xqFAox8o6u0nXB7YagpYxgppZz8=; b=PZFf83Rp04yrCQnxZ4DOvTF5lj
	ly0jJqIQ0FegAixF3xB7f8j9DYyZVnIof6qvrTH1IFjsypY2lnctsOv0O9yINehSVxhggYS/H+QCb
	ohxGJyvYh9Zdqcb4oyiK1PbaWJEbsO04XH+OBlXCnPoi2lXRCdGgRPhnwcQvPjnrB1tl+N1LkHVaW
	FhEYAo/ZcILliOBMbR9yc1gQEbZ2nTt13Rs357lOQy52zLs3ANo58WN5HK4rQ3ZOBJdTHl/TSMdEJ
	YQUf4kaBqgIY4IY3JrCAE8IgtnTHGEZr4f0FRVdxBAkCWGa7tGY8aHJ4R8alwZje4bvqY7XMht4LY
	HYPmLwoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBtjM-000000077TU-2SN4;
	Mon, 05 May 2025 11:11:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBtjJ-000000077Re-1tsj
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 11:11:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D24A668BEB; Mon,  5 May 2025 13:11:12 +0200 (CEST)
Date: Mon, 5 May 2025 13:11:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Hannes Reinecke <hare@suse.de>, "hare@kernel.org" <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, "wagi@lst.de" <wagi@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <20250505111111.GB11508@lst.de>
References: <20250414111916.GB13225@lst.de> <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de> <20250414114128.GA13822@lst.de> <PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM> <CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com> <eee8de0a44074dd3bfb0fc6ec425b647@samsung.com> <20250502102505.GA13055@lst.de> <27a99b458f0144fba094726e4f470552@samsung.com> <aBWRfiwJkeYGB0Og@kbusch-mbp> <r5b5gwy6vf56ropgbcx6fyi6qvgnwtzvdz5xjnofln3jvcx2zm@d4dvfkawab2x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r5b5gwy6vf56ropgbcx6fyi6qvgnwtzvdz5xjnofln3jvcx2zm@d4dvfkawab2x>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_041125_629161_0199CB44 
X-CRM114-Status: GOOD (  13.27  )
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

On Mon, May 05, 2025 at 11:51:39AM +0200, Javier Gonzalez wrote:
> I think we should let HPE distros carry this quirk for drives where they
> would not want to roll a FW update.

Or just goddamn people to upgrade the broken firmware.  Without it
their data is at risk, so they'd better do it.

Also maybe this is a lesson to SSDs vendors (and I really mean all of
them) that if they can't push back ob broken "features" due to market
dynamics they should at least OEM brand the devices in the identify
data so that the blame gets deflected to the right party.

