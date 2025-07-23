Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C914C83F25
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jul 2025 06:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkPCYgSXHy/hnIwxtpumUW3yOnsYnvAh3/VMRYeqg1E=; b=KCOzFz5GujQZFBv0lKlYmxtxKS
	psaFE6ziVqh0A0bZnEGyYi7v6HknMukDOij6w7+NaWBIbZVYSStcgy+HyZ9OZ0JAG+g8PTzirRXcl
	AdcR9ejLFqMrbRrYFyTA2wze18Nsm47LuO2wOPzfCoUnWft9G9Ds8dv4iGSUEEENy4LqaXDAEaod7
	6sRdeZTDCqd5kCZMpqRuYgVv3rdNihKDuxwqPCZlpDjqpX8+7os1AXJLv7kjH9MA647IK+YNQnXz4
	XelyGe054htITfKl6oP1Z93Y1amHRaCMA/ju2K33j0GjqW0/cjjgihsLkF6zWM4BtBDxB6Jc8Mrck
	BQVBq8Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueShC-000000046d3-2iXB;
	Wed, 23 Jul 2025 06:11:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueShA-000000046c6-02on
	for linux-nvme@lists.infradead.org;
	Wed, 23 Jul 2025 06:11:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA74667373; Wed, 23 Jul 2025 08:11:12 +0200 (CEST)
Date: Wed, 23 Jul 2025 08:11:12 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Message-ID: <20250723061112.GB18943@lst.de>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com> <20250721173700.4153098-3-kamaljit.singh1@wdc.com> <20250722063015.GC15013@lst.de> <BY5PR04MB6849574654806676E024F16DBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6849574654806676E024F16DBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_231116_189316_79369726 
X-CRM114-Status: GOOD (  11.99  )
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

On Tue, Jul 22, 2025 at 04:34:05PM +0000, Kamaljit Singh wrote:
> By "let's leave this in", I thought you were referring to my patch. But now that I re-read
> it, seems like by "failing a get_log page is fine" you probably meant to let the driver 
> issue a get_log for LID=2 and fail.

Yes.

> Process wise, can you ignore this 2/2 patch and we call this patch-set done?

That's what I've done.  Patch 1 is queued up in the nvme-6.17 branch.

