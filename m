Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F86C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 07:20:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A242D2068E
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 07:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDWRsin7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A242D2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9MkemcxngAXN4r1hwaw5OyQ5dZI+FfmfPe9w7IDJB0=; b=mDWRsin7+EG/iA
	6PWhGLeP6LcCYF8AxpH3jTY8tepW68wCCACpFZy4OFKF1l+dfFm7gSu3+B7a+84msjNH342tPZ8iS
	lTGGL2qrK7vSIGWRi6ya0YRKa1qkRsIqLZn9IkuD0RUFx8OQzc5sKvO58iVMOIoIpDgnYiiCoqSqf
	5frmSw0VuGhYzBJJW9E+gTDqWfHAnP9N6pBdONF0VkxUFUFjPSq7skw9IxI4BpuXKO72KkTxZ2QOL
	IuyQq89hu807fVJ1/JGEwOtIlR9BpZO8RpM3SCZYbcPevWhX328nC/K7dShVJi4GN9yCoNNJ6+Zbe
	1G6ippaPmOGUdnS8kyTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkjQ4-0003bg-N5; Mon, 15 Jun 2020 07:20:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkjQ2-0003bC-AZ
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 07:20:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4B56E68AFE; Mon, 15 Jun 2020 09:20:31 +0200 (CEST)
Date: Mon, 15 Jun 2020 09:20:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH] nvme: associate stripe size quirk with D4512
Message-ID: <20200615072031.GA21903@lst.de>
References: <20200611033836.45701-1-david.fugate@linux.intel.com>
 <20200611054156.GB3518@lst.de>
 <e2c46dfec9e779d945088b025f833bcd4e29cc1e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2c46dfec9e779d945088b025f833bcd4e29cc1e.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_002034_520053_327D2EE1 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org, david.fugate@intel.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 12, 2020 at 08:43:15AM -0600, David Fugate wrote:
> On Thu, 2020-06-11 at 07:41 +0200, Christoph Hellwig wrote:
> > On Wed, Jun 10, 2020 at 09:38:36PM -0600, David Fugate wrote:
> > > Intel's D4512 dual-port SSD is based on the older Intel P4500 SSDs
> > > whose development predated the NOIOB feature. Based on a customer
> > > request, the D4512's device ID was changed from the P4500s'. This
> > > patch associates D4512's device ID with the stripe size quirk to
> > > improve its performance.
> > 
> > NAK.  We've been told Intel forever that we need a standard quirk,
> > and we actually do have way to expose this information in Identify
> > now.
> > Just kick your firmware engineers in the but to set the trivial field
> > in Identify.
> 
> Thanks for the feedback Christoph. Our FW engineer for this product is
> currently on vacation, but I'll relay your suggestion to see if it's
> viable.
> 
> In the meantime, I'm hearing your rejection for this is simply Intel
> standardized the driver-assisted striping feature as NOIOB and failed
> to realize it in any Intel product. Other than this, was there a
> technical reason for rejecting this patch?

If you look back in the archives we have been unhappy with this quirk for
years and thus helped to standardize it.  So we very much expect Intel to
use the standard way to any new product instead of adding more and more
quirks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
