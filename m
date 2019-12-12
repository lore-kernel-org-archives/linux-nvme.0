Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E1C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 08:30:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8232077B
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 08:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JwJXCuXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8232077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hXPWPHzDNYmNs3V1950iQUf/v9DbcnGWpMmRAoozMRk=; b=JwJXCuXMkm1QcN
	xC7G6v8ne26ijYqu4kbYD0YL3oGXQvdVmef8q8el+nXYRaylxcZ3LoKXf2yQF4Juom/KqJJw76U8Y
	X/x7mR/JFFrzJT6VvjRCRVaPt4gLbk9iBILFQnJwhFtmqLOk5/udXTj3HrLzurj0bXI/S3opat6ML
	is3Gr1PQlmgDQgTu8LYcTVuxu8+8ZFJLV2fgDj6pjaXP8taZid1vm4QUbm8Vx2M2CqOhH68YQ7fM0
	JW9m2KyRL6VJtwnjWoRIw+rPyCeLviNHRp4S268bULUNDk4raeSYJ8k341bEIGR8K3D6LCd5QHWU8
	zloxVIn4ODK3DXtWB+Fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifJrP-0006Oi-MS; Thu, 12 Dec 2019 08:30:11 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ifJrN-00069O-Kq; Thu, 12 Dec 2019 08:30:09 +0000
Date: Thu, 12 Dec 2019 00:30:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC PATCH 0/5] to add more nvme reset functions
Message-ID: <20191212083009.GA18522@infradead.org>
References: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
 <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
 <d4583505-d3f2-238b-c323-94216c910e29@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4583505-d3f2-238b-c323-94216c910e29@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Keith Busch <kbusch@kernel.org>, tsutomu.owa@kioxia.com,
 linux-nvme@lists.infradead.org, hch@infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2019 at 04:50:23PM -0800, Sagi Grimberg wrote:
> 
> > > Any comments would be highly appreciated.
> > 
> > The majority of this series is at the pci protocol level, and the pci
> > driver already provides the requested capabilities (but with a more
> > safe implementation). Let's not reinvent it just because one nvme
> > transport happens to use the pci bus.
> 
> This is messy. Everything here needs to live in nvme-pci.

I really don't see any good reason to have any of this code to be
honest.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
