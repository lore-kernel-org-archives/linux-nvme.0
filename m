Return-Path: <SRS0=PPGx=2I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50761C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 15:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108D20717
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 15:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8pirex0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRXrp2tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oG7K6XtA/RTRPZj78vIhtgbj2uZgxrgCBvaPzoGQqRI=; b=l8pirex0WcpTnV
	e8elxRnHTqddHnzp04YXRr3U03JO0CydHlmxHK6GGTvao2ST9ZKUqE7tmI3nrybTyip7YikpZwRc5
	oaBOwomZthclsXExb8U5QX39jbl4YqeVbIST4fqMHE7fxUWQLdReQ0+YsApErs3lLrdIiojN7qXXs
	xx2jvnI6X57aIrdfFQsufgyAgHiF7ZLgO9KlPm0uns75/E8ed/H14Fd4SgzNQq7w96Uhm3W7UVWMU
	bVM+l30iP+355L4VhPvup3gJCarI2jfoOY38EutLAJZ4m0qOeDaDOPrfRPLwG4HdWswJV81Muvua1
	NelWUhBgpNscSaMxfI/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihbbL-0001qY-Lj; Wed, 18 Dec 2019 15:51:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihbbI-0001q7-01
 for linux-nvme@lists.infradead.org; Wed, 18 Dec 2019 15:51:01 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5EC4420717;
 Wed, 18 Dec 2019 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576684259;
 bh=/55wRoJeGbmcYhycKyvTeJ5mt8CkBl6XTWSdgK2e3/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tRXrp2tYBug8T67Nu4gwoZuK5m+0/uMzVJ8VCaw37M7W1yX+IQYyUg/ExHtO5Lapp
 b18WF6fLevuEII27fOihwzPz1DfwTSC/6V1SDR7D+nQLTv6inEpTsxWtvM6gjnqMDR
 OUfh3xfJrbFF3buZwT96B5dRPaqKcRHoqvYtOO1Q=
Date: Thu, 19 Dec 2019 00:50:50 +0900
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 3/4] nvme/pci: Remove use_threaded_interrupts
Message-ID: <20191218155050.GA6625@redsun51.ssa.fujisawa.hgst.com>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-4-kbusch@kernel.org>
 <20191212091433.GD2399@lst.de> <20191218072946.GA23166@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218072946.GA23166@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191218_075100_064223_DCBEDA4A 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: bigeasy@linutronix.de, tglx@linutronix.de, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 18, 2019 at 03:29:46PM +0800, Ming Lei wrote:
> On Thu, Dec 12, 2019 at 10:14:33AM +0100, Christoph Hellwig wrote:
> > On Tue, Dec 10, 2019 at 02:56:21AM +0900, Keith Busch wrote:
> > > The nvme threaded interrupt handling provides quick completions for
> > > latency sensitive workloads, and threaded handlers for more IOPS intensive
> > > ones. Remove the use_threaded_interrupts nvme module parameter since
> > > leaving it disabled should not be providing a benefit.
> > 
> > I think we need some careful benchmarking and numbers to justify the
> > switch.
> 
> The patch can fix CPU lockup on Azure's NVMe, however, IOPS drops to
> ~600K from 3M+.

Compared to current mainline, or is that 3M+ with the poll completions
from submission?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
