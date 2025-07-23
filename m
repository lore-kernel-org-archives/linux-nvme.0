Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B4CC83F17
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jul 2025 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdpMysaxb1YPzIpvrE8XkNbERlu8FRurskkGfsNLE+A=; b=TIZboDVjcxGejzT6Tg20eS/57A
	4XaaVLKA7UPl/VxEPJP5oAKT24iPOyBP3xgt3luXDic/WZalYzyW4/vuyMCqL7Imx6rf3Y20XsMf5
	XpXfyzMPPe5rytIgPotDrRx1V3+B4a4A4V9caeR1FGfKDF4GvT/35qN62PPwHMRWx+xp79RhxoCoe
	9xPzgOWQfFGAr0Rc26iMXRf/0R8/BgGLURw0zcnyfoH4cE6TuSfOR3agaq5feUEho6JlnpHLKHhs7
	b7alz/EaRXQA4IETBYjmkcc93YPQSitirbOKdHzZm0UBiJEvSnmr7em84Id0IL8FB2++Fl+5p+n1a
	TlxtzNBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueSgH-000000046QZ-1Xqn;
	Wed, 23 Jul 2025 06:10:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueSgB-000000046Ow-2hwe
	for linux-nvme@lists.infradead.org;
	Wed, 23 Jul 2025 06:10:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CAB1D67373; Wed, 23 Jul 2025 08:10:09 +0200 (CEST)
Date: Wed, 23 Jul 2025 08:10:09 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
Message-ID: <20250723061009.GA18943@lst.de>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com> <20250718001415.3774178-2-kamaljit.singh1@wdc.com> <845e9caa-093c-466b-9a9b-905359517568@suse.de> <BY5PR04MB6849799468BC4F5118343015BC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6849799468BC4F5118343015BC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_231015_822138_04A627DE 
X-CRM114-Status: GOOD (  14.34  )
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

On Tue, Jul 22, 2025 at 05:34:56PM +0000, Kamaljit Singh wrote:
> >One wonders why this is done for admin controllers only; surely
> >discovery controllers also don't support I/O queues, and should
> >therefore have the same setting?
> I agree. That was my patch-3 in v2, which I retracted in v3 based on
> your comment below. Is someone taking that action item to discuss at FMDS?
> I haven't attended it in a while.
> 
> If everyone agrees, I can add patch-3 back in and create v5 or since v4
> patch-1 was accepted, I can issue a standalone patch just for this change.
> Please let me know.

While forcing it won't hurt, we had things working for almost 10 years
by relying on userspace to request zero queues for discovery controllers.
So I don't think it really matters.

