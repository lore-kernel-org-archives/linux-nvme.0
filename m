Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145BC64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 19:38:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDA5206E3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 19:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWhWva0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDA5206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GY+wYJ9Hni3zvtJ63UlrSDMyQhRYmIP6sCLm6XkeQ5I=; b=nWhWva0xpkoxj+g5Ydi101cez
	EiIK25JRt7EFdiRcrUbRu9RFjfui1SePGWNigVDIhz8fYbsrE/kQUjAVDaF0Pko5TH0s6ubcyhQEi
	3/MAB/jojuLng0djahWspj+fkvL/CKake3pD+u1t/hJ5jDVVLfZDnquk+GPjTbyqtYuAY25AXi79/
	/dZCsWC15y3Btbes91BKmKmuSxgDhLtCDYY4OXa6tvzwljtkS/KjPS5A0DGlLEc/R3KnT/zMX9LEx
	rmoz5WcKyym1UA/JravR1HAw+Rh9OHKiRnvBJUXj9ZT577VxbNZCfazV9/Ao+XMbl+fJNbLPo5LuU
	A7sdZznAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkBTp-0006kZ-C4; Tue, 01 Dec 2020 19:38:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkBTl-0006iR-P7
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 19:38:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7A23967373; Tue,  1 Dec 2020 20:38:23 +0100 (CET)
Date: Tue, 1 Dec 2020 20:38:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201193823.GA3522@lst.de>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
 <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_143825_974496_7FB04C15 
X-CRM114-Status: GOOD (  19.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Minwoo Im <minwoo.im.dev@gmail.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 02, 2020 at 04:30:02AM +0900, Keith Busch wrote:
> > > In multi-path, private namespaces for a head are not in /dev, so I don't
> > > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
> > > like it will make a little bit confusions between chardev and hidden blkdev.
> > > 
> > > I don't against to update nvme-cli things also even naming conventions are
> > > going to become different than nvmeXcYnZ.
> > 
> > Agree. But as I understand it, Keith had a good argument to keep names
> > aligned with the hidden bdev. 
> 
> My suggested naming makes it as obvious as possible that the character
> device in /dev/ and the hidden block device in /sys/ are referring to
> the same thing. What is confusing about that?
> 
> > It is also true that in that comment he suggested nesting the char
> > device in /dev/nvme
> 
> Yeah, I'm okay with sub-directories for these special handles, but there
> are arguments against it too. I don't feel that strongly about it either
> way.

I'd prefer different naming for the char vs the block devices.  Yes,
this will require a little work in the userspace tools to support the
character device, but I think it is much cleaner.

Devices in subdirectories of /dev/ are very rare and keep causing problem
with userspace tooling for the few drivers that use them, so I don't
think they are a good idea.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
