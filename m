Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6FC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:11:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEA121924
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jVdBRV7y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRNHum+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEA121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZhMTMw8IDYuVhLNR1yrqVslpbM8h1UsO9+BUXFnthlM=; b=jVdBRV7yeyuhqe+Xj4Zo6C0mn
	Ip3o1YmXRNYRY3DxKnfhXFKcY3F3A8jwujkAFxHjPGtViu58cEyeMm5oV0UH61H48/z19b0sL1a6a
	Nu/X+C+4azawHI4v75gzynP/NFN8FHVm6ogy4Hg720WZGfK+FDetsGZdrzO4tEUciYuE/aQA4BvzW
	vU3l/cuEhHyJrNM0AQxibuycS74N409kL1C8PGqy8YNJ+MtCz6S2WSTvrYJO3vPvKg3tKy/wf/vrC
	CGwbX/Sjm58/YG9KSF+2a8Vev72Ib0iT6bmRalFm4KuiPmrqYelZyQCxpYlgbpFvN5TDKNP4pTkEr
	f9IIJQ2Pw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMts0-0000LA-TR; Mon, 28 Sep 2020 14:11:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMtry-0000KH-5M
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:11:10 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E9D821924;
 Mon, 28 Sep 2020 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601302268;
 bh=kXztKg8kDY1O/WNv/Hqr4h+bnIyz1fnr2BCmQeyn2cY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lRNHum+q5olPtQ0Y02HsrefZLZSYdu1y8kfnfrg4l6P8fbb7rjwmoxGrwNL4mw9Nu
 gRgknEq797DrBHDDjtstGvjWizQ4ZGGEs/p63mUmbUInBC4+wLr7TjoeKhdO3tvDlm
 whSz5/HXALZUI23NQx4A9hOZYG0LK8XimkS+fZ5c=
Date: Mon, 28 Sep 2020 07:11:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] nvme-mpath: delete disk after last connection
Message-ID: <20200928141106.GA227320@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200925213819.224198-1-kbusch@kernel.org>
 <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
 <20200927060709.GA24024@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200927060709.GA24024@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_101110_266444_932F6020 
X-CRM114-Status: GOOD (  20.76  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 27, 2020 at 08:07:09AM +0200, Christoph Hellwig wrote:
> On Sat, Sep 26, 2020 at 01:16:51PM +0200, Hannes Reinecke wrote:
> > I'm okay with that in general, but then again we might run into situations 
> > where an 'all paths down' scenario is actually expected (think of a 
> > temporary network outage on nvme-tcp).
> > So I guess we need to introduce an additional setting (queue_if_no_path?) 
> > to be specified during the initial connection.
> 
> The original design was pretty much intentional as and all paths down
> even usually is temporary.  So any change in behavior should be based
> on an optional instead of a change in default.  And I think the right
> way to do implement this would be a timer when to take the gendisk
> down, with the default remaining infinitity.

Ok, we can let the timer be an option for fabrics so it can be specific
to the subsystem you're connecting to. The timeout for pcie targets
probably has to be a module parameter, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
