Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76BC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 19:05:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7602073A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="myztKmFW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSdC+eP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7602073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aVEs4lwF+qS3uJOII7p6SnKwyRgZXcN8gzfEqTq0zXY=; b=myztKmFWL+vM+osyBBOTk++Gx
	QBCAR287GGCbNYON6tLqulD3lhP1hQSGus+ukxf0vwCqo+3oucJxj1TZxX8FaXVZu0Q+A/OqaMau0
	EOESEUHKPxyVrE9lb778Dd5ivAK4y1Xee9r2kouu/hZLcjyl3zsDzw0tQTJZnyTSAXxHB9iU5L6Cj
	FK92EDmR8LgKSR7hSOWgy/zk7EEi+B7stjkGXyfXKjH/+Igygon3Yo4tmFD8rvmjYr8KR0kBYq/wq
	QD42cOaImXsh3qJlyh3EBa1kaIJz0kPuhmNFrcD7aFV68bU0anQaviceMgbmybXPx8XfxxJaw3DcF
	xfy7ZgBnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS38H-00015A-A8; Mon, 12 Oct 2020 19:05:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS38E-00013R-8l
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 19:05:15 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 251A12073A;
 Mon, 12 Oct 2020 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602529513;
 bh=3sWDPhUldvwkCxuRs91ah0uEnlkPdLJE/igXUrgqNNY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rSdC+eP80SR4Eb2H8RcU06cKKDVIFoAobVDmG5vphah2sIUdS66iX2De9Hkae0WdC
 8ziR0XouzZwfDqA6Mcodw7IhFVIT2dvYVrEUOpkWKlpSahtg+w1sqdI8FoTMGB4oVt
 NzkOivmRulm4EEVL2aY//ls5XgYb4Xpdx5mOx9SI=
Date: Mon, 12 Oct 2020 12:05:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: NVME, isolcpus, and irq affinity
Message-ID: <20201012190511.GA1032142@dhcp-10-100-145-180.wdl.wdc.com>
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
 <20201012171333.GA1032168@dhcp-10-100-145-180.wdl.wdc.com>
 <00547cf5-0df0-d027-bffa-adfbe247f09d@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00547cf5-0df0-d027-bffa-adfbe247f09d@windriver.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_150514_565522_6207B696 
X-CRM114-Status: GOOD (  18.92  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 12, 2020 at 12:50:49PM -0600, Chris Friesen wrote:
> On 10/12/2020 11:13 AM, Keith Busch wrote:
> > On Mon, Oct 12, 2020 at 09:49:38AM -0600, Chris Friesen wrote:
> 
> > > Assuming I'm reading the code correctly, how does it make sense for the NVME
> > > driver to affine interrupts to CPUs which have explicitly been designated as
> > > "isolated"?
> > 
> > The driver allocates interrupts, but doesn't affine them. The driver
> > lets the kernel handle that instead.
> 
> Okay, thanks for the quick reply.
> 
> The interrupts in question have names of the form "nvmeXqY", where X and Y
> are integers.  Some of them are affined to individual CPUs while others are
> affined to two or more CPUs.
> 
> If no tasks on the CPUs in question do any disk I/O is it possible these
> interrupts could still get triggered by activity instigated by tasks on
> other CPUs?  Or would they basically be idle and inert in that case?

In order to wake the thread, the top half handler needs to see
completion entries on that interrupt's associated queue. If you never
use the CPUs in an interrupt's affinity mask to dispatch IO, there won't
be completions, so the thread never wakes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
