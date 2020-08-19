Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26230C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 22:11:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C4320658
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 22:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hUIfF8Ki";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2KAf9hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C4320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wakzn6tq1J1nlhpCtUYqov9A0ED3GhSlYClcL9ogH/4=; b=hUIfF8KiWDtVxXF7zWLtDC+oJ
	IB8KBeOZwzcYAwBKcOnPoKR6m6o0Rex6vKCnVZMI8JTP117xHMhI9ix8/y+6d0r4iCVpY2XiEz4HJ
	gXdOREO/g8H3syQIsEwaTNmAnpj0+sGcLdM744WMa7YHIUeyiPYEbXXwbNvCHX7wKfKFbiUNv41M/
	DDvun6gepW4ZJeJ/EOVsg/w6OkbJB3qr/sl9g6Hq4UXNcASdSrv7i89XSfyu3GhhNaSEaAie9rtjF
	fKPLcLh41CFy3z601JaV3XJ9PE3LLD2amn4rVfjqW/6hQu+wW3z+9IWnIn+HDX35XpTg1ZwMD1bnp
	h6ReLj6dg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8WIN-0008EV-Jn; Wed, 19 Aug 2020 22:10:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8WIL-0008E2-Of
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 22:10:58 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A70A20658;
 Wed, 19 Aug 2020 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597875056;
 bh=YCqLLdMlClmtbX7ozswq1RrxODCoI7jS14uTBQkK9lU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l2KAf9hWOD5P1WCcGocpelxUAm0L0iUSL1V2bOxQE1gPLzi7zcPtv7wFPSjDiaZlm
 O7aZKNAhexykXE80reGA5RIoIXt4WoUx46s8mFjd3z3IYD6psCgA3YpS+yYWYJc+17
 DE/HtAqlkkDW3zRIEliFkbN9IeIVVxczRyDqtqXs=
Date: Wed, 19 Aug 2020 15:10:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_181057_887160_E27FA867 
X-CRM114-Status: GOOD (  17.66  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, david.fugate@intel.com,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 03:54:20PM -0600, David Fugate wrote:
> On Wed, 2020-08-19 at 13:25 -0600, Jens Axboe wrote:
> > It's not required, the driver will function quite fine without it. If
> > you
> > want to use ZNS it's required. 
> 
> The NVMe spec does not require Zone Append for ZNS; a *vendor-neutral*
> Linux driver should not either. 

The spec was developed over the course of years with your employer's
involvement, and the software enabling efforts occurred in parallel. The
"optional" part was made that way at the final hour, so please align
your expectations accordingly.
 
> Agreed, but this standard needs to be applied equally to everyone.
> E.g., harmless contributions such as 
> https://lore.kernel.org/linux-nvme/20200611054156.GB3518@lst.de/ get
> rejected yet clear spec violations from maintainers are accepted?
> type of behavior encourages forking, vendor-specific drivers, etc.
> which is somewhere I hope none of us want to go.

You're the one who left that thread dangling. You offered to have your
firmware accommodate the Intel sponsored feature that makes your patch
unnecessary in the first place. Your follow up made no sense and you
have not responded to the queries about it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
