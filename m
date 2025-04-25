Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52CC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJiqorv5974toGlbcU/YqhPnmjYn+bcdD8FOFbffkv4=; b=mmNDQ6gIqm/nFx/SUdOiBAKbMQ
	EHe/SrNKGC6pakruid0ws0lI8WV1igCHpO/lUN+irqCjhPmejXI9go0pN7bCcZF3KazaBpKQvWFuT
	oZlRyVBsLxF9XPeKdUKIIdLRjfPY+7uSxxAUTSQmCpUf7Lx4ZQmEYNHmx+qK59ccy5uSE+5yv4ljJ
	2T1YmHGaIHw+bHyGe/iIQu6tomunBEw51D1oEXNlAMxI2+jqMUDXvuDUYj+YB/hhULGXEIL8GIxpL
	Gn5AWNJKCfuVNRFtgecAgBiWeiYLymVB/7jXztDM1ImI+t5mxAb+vKTwTfRqpM5SI8IRVRt+ypG7b
	1EBYNY8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lv5-00000000DTl-1pHW;
	Fri, 25 Apr 2025 16:28:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KS8-0000000HUzS-2iOH
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 14:54:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6494568BEB; Fri, 25 Apr 2025 16:54:51 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:54:50 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Waiman Long <llong@redhat.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Message-ID: <20250425145450.GA12664@lst.de>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com> <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com> <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com> <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com> <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_075456_826669_74B82C8A 
X-CRM114-Status: GOOD (  12.12  )
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

On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
> >It should also be in v6.15-rc1 branch but is missing in the nvme branch
> >that you are using. So you need to use a more updated nvme, when
> >available, to avoid this problem.
> >
> Thank you for finding that commit. I'll look for it.
> 
> Christoph, Sagi, Keith, Others,
> Can this commit be merged into the nvme-6.15 branch please?

What commit?


