Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB71C432C3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:23:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B059520722
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m9tPQtf6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqNFbnCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B059520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ygf5jp2snAUfn27Bwui3s9fUvInVK6uceyX35gWwuPI=; b=m9tPQtf6PxUk7Y
	/sPy6ASUYkNQZsGNNQkgsSHBIC1Q6jnfvDjG6CsS1cnTO1vJjq/0NSMhQW1MUnZeKnTTazcwBEwio
	vptwsKSfrza8Aru0DrGOdyXEFeSPbAe/mu7eES3RzkMzt0cfi6EEKcUXh5RAU8IkTjpnY7ywdH4Xc
	5u7a0Q5O1wemY/tks0B1q0TbzL0sLXezu18lVJpUUJfpDaFH0vdYWyHexAvv3XZL/YqhAAcNvym6Q
	Tfq2bOzEwo2KavbAXd1zSnqZHKkbheywOPqG+Q7urzjpnM6e/wKTCTj2Tpa/i2YJkgJ+caAuA9NnB
	m3UkeGN48PdZXGCaOrEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iboTZ-0003eJ-O5; Mon, 02 Dec 2019 16:23:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iboTX-0003dx-Di
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 16:23:04 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5347020722;
 Mon,  2 Dec 2019 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575303783;
 bh=1W62lKAHoX5DFVxI9rx8bmsU7wU6WRiSLV5A7U3IC5w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nqNFbnCmu5370+RZw0nARYvEnKSc1g4bIs190QpCKRLz71StfxfHy0IEbjarkQYN9
 AaHn45/ZdBvgEiHWG3bY7gPr6oGqP9J2qhNuNHbFDH9CApMFKTotxuyQ5IHvEGqM5N
 W8pSmyOzV58AkwfgtUL0ENFojjTT5bpkhs9edaJw=
Date: Tue, 3 Dec 2019 01:22:56 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
Message-ID: <20191202162256.GA21631@redsun51.ssa.fujisawa.hgst.com>
References: <20191202155611.21549-1-kbusch@kernel.org>
 <20191202161545.GA7434@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202161545.GA7434@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_082303_484469_3FA61822 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: stable@vger.kernel.org, Ingo Brunberg <ingo_brunberg@web.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 05:15:45PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 03, 2019 at 12:56:11AM +0900, Keith Busch wrote:
> > Despite NVM Express specification 1.3 requires a controller claiming to
> > be 1.3 or higher implement Identify CNS 03h (Namespace Identification
> > Descriptor list), the driver doesn't really need this identification in
> > order to use a namespace. The code had already documented in comments
> > that we're not to consider an error to this command.
> > 
> > Return success if the controller provided any response to an
> > namespace identification descriptors command.
> > 
> > Fixes: 538af88ea7d9de24 ("nvme: make nvme_report_ns_ids propagate error back")
> > Reported-by: Ingo Brunberg <ingo_brunberg@web.de>
> 
> Why would we ignore the error?  Do you have a buggy controller messing
> this up?

I don't have such a controller, but many apparently do. The regression
was reported here:

http://lists.infradead.org/pipermail/linux-nvme/2019-December/028223.html

And of course it's the SMI controller ...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
