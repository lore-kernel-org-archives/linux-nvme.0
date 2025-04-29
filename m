Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A6AC3ABAB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RfGirvq3Z4ov8T9sFHKLNvN85Dwpz08FqY7lI54ZqBc=; b=mvp2Hug0EqKHkpSTQR7GIZQ++G
	IuobB5D2HgcXxh/g1WccIv1NEIozbJqP3gcf2NQAbaGAAf6PCEzMtuxADlOlEqk3ULW5SXxrMdImj
	SBcHk1HyOk8k+87xE/ump1BO11iFqV7VY1BYFtj8/08422MxEhjMfWzA5kB//lnnCtew717PZlGoz
	GwF82y5muHxsUne2G6lTXM+NHZ4ksq3NSB6fmZK+h1mu03ewaUExL6WRlVjffwLih6dSGrL7DN5Gx
	+KtDz3i43O+sGJhsAHuFMAOC9473/c0IVXP64X2/fcSzQCVv2XQVZDE1393dPtDcRgUFUhl9nRu/O
	PrpZB17w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9liJ-00000009shq-0IQa;
	Tue, 29 Apr 2025 14:13:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kW3-00000009haZ-2fKq
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 12:56:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E69A68B05; Tue, 29 Apr 2025 14:56:48 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:56:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.opensource@gmail.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, dlemoal@kernel.org,
	alistair.francis@wdc.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
Message-ID: <20250429125648.GB13574@lst.de>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com> <aAo5xgVOgf0HeFl6@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAo5xgVOgf0HeFl6@x1-carbon>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_055651_811508_AB1627B7 
X-CRM114-Status: GOOD (  13.48  )
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

On Thu, Apr 24, 2025 at 03:16:54PM +0200, Niklas Cassel wrote:
> Perhaps it is a bit too harsh to say that we are non-spec compliant.

It is not too harsh but simply a true statement.  If the spec
compliance matters or not might be a different question.

> We don't implement every feature in the NVMe spec in the Linux drivers
> on purpose, because there is a lot of feature creep in NVMe.

That is a valid point for optional features.  Sharing a CQ for multiple
SQs is a mandatory feature in PCIe.

This should also get us to the point of running verification test
suite on the PCIe nvmet code, which I'm really looking forward to.

