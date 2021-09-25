Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC15C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 08:37:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4297060F70
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 08:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4297060F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jC02dsz8NpuVz7eeeGiswuB/98Fj6YN6P+IvVq1hMow=; b=MkqNfwE6KVIcjG
	YF0HMhtmBuxGxCMYB2TKcc5nMYSFM2KnCv4PEH3W2fZz752r+7Sei9R7sWD1on9Tu/PZtfH9hef8H
	8Lfj7tMnC9e5FX8949jKY++o/jklzxh3XXe/GCc9iYGD0RYWhRKCuxLvgJEdo0tJV2AHwI1/i6Vwy
	rSzMVoxxW4t4aAhed7yD8BNA1Bi08OXLyAQOzfTaSKj2j2YQ0kOCXjuxwI5kaBLf3doBY8ofSnLmK
	F0BwZr123EoR3rZvn1GtFYxcULAoUo1VdiIe9OfNgtKZlPaFbSf183CNnwWKsugJ7rYzCHe/Nm+PD
	vYqzTtkbKNUdmRwarUjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mU3B5-00GIyq-0W; Sat, 25 Sep 2021 08:36:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mU3B3-00GIyj-UO
 for linux-nvme@bombadil.infradead.org; Sat, 25 Sep 2021 08:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=StgiqVvzYvvcYGkPsgijWPfPh4tFTA+W5zpqd7GAsYo=; b=KBtItcqkSA9AI6758jMUW45Cx8
 yGdXWcK/fqgPhVXQBzzMMOwjnI19+Btap7k1anTRW0Vjp3bIyOfhHcOsZh5vCD1gUHSPDSVhuQH4p
 bLfext3x0IaCg+DcZ+TFHvyrd5q6ArgYJaDljXWt+/V4mak2VtzyIFauV3Nc6d6Xah0RQ8J76CcU9
 VQBUMuzxV0vjS8dVoexhMkDj7isdu3tYaJ4Xfy6JReHxu9xwKOXs+dGuScBsSwScIyanyRywbKUOc
 DpidlAaxzWz4NP7ZN7FF279U5bSbMxiHuNtr3Qjv/g2hTgxvh1wZ4KrlyEaVupjerpyOLML8GApHq
 //qHoH5A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mU3AL-007xbZ-CX; Sat, 25 Sep 2021 08:36:31 +0000
Date: Sat, 25 Sep 2021 09:36:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Keith Busch <kbusch@kernel.org>, Andrey Nikitin <nikitina@amazon.com>,
 linux-nvme@lists.infradead.org, davebuch@amazon.com
Subject: Re: [RFC PATCH 0/3] nvme sq associations
Message-ID: <YU7ffdxOYeUTY/0P@infradead.org>
References: <20210924210809.14536-1-nikitina@amazon.com>
 <20210925030207.GA20848@redsun51.ssa.fujisawa.hgst.com>
 <de8f41b03ff2c82f7013ef3b9e7dc3b044c2b69f.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de8f41b03ff2c82f7013ef3b9e7dc3b044c2b69f.camel@kernel.crashing.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 25, 2021 at 06:31:58PM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2021-09-25 at 12:02 +0900, Keith Busch wrote:
> > 
> > Different submission queue groups per NVM Set sounds right for this
> > feature, but I'm not sure it makes sense for these to have their own
> > completion queues: completions from different sets would try to
> > schedule on the same CPU. I think it should be more efficient to
> > break the 1:1
> > SQ:CQ pairing, and instead have all the SQs with the same CPU
> > affinity share a single CQ so that completions from different
> > namespaces could be handled in a single interrupt.
> 
> Can this be an incremental improvement ?

Honestly I'd rather not merge this whole patchset at all.  It is a
completly frinde feature for a totally misdesigned part of the NVMe
spec.  Until actual controller in the hands of prosumers support
anything like that I'm very reluctant to bloat the driver fast path for
it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
