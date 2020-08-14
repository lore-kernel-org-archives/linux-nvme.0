Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8BAC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:28:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7749F20791
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0oFodwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7749F20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gCd/OVfx2v+WmliaYPQ4F0bnaBVFITKIkJ8S8QlE7jc=; b=d0oFodwLydBU2lYxQqhdPa7MT
	l05NX5OPXgkYUgY8qZ4tmgZ2KhK9yGUqVZMKxQB8E5ygjW+oy9BHkvbZm/cDJZ5K3cv7Ft+6Qdwnx
	paeibOTQrjQ9Mrqe8IRrutk62hcXB0Q5PE2fFjrXIcp4sMmSpkxNhIMUoTAw4I/7o1Q3r4NJqBtev
	a+NwGcK3sYujB3VV6gTfdgTL6jKt44NNK0rk/I0XIBkJTPUaZoJk0Ra7YVvYqk5UgF5L54bMT3SA+
	DHeoTfYgk0tk2pOvP6UXSOHy6s691M6v0dUwRvc+Sx0lGyOsY1FskXLGvMWmzBP/r/Y7YZNXaUC9e
	PbD7Ig8fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TCr-0004Hi-3Y; Fri, 14 Aug 2020 06:28:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TCo-0004HE-J5
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:28:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4613F68CEE; Fri, 14 Aug 2020 08:28:44 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:28:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: skip noiob for zoned devices
Message-ID: <20200814062844.GA1656@lst.de>
References: <20200807163235.4155607-1-kbusch@kernel.org>
 <20200810123313.GA20069@lst.de>
 <20200810145622.GA4159317@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810145622.GA4159317@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_022846_763152_B4A2311A 
X-CRM114-Status: GOOD (  15.80  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 07:56:22AM -0700, Keith Busch wrote:
> On Mon, Aug 10, 2020 at 02:33:13PM +0200, Christoph Hellwig wrote:
> > On Fri, Aug 07, 2020 at 09:32:35AM -0700, Keith Busch wrote:
> > > Zoned block devices reuse the chunk_sectors queue limit to define zone
> > > boundaries. If a such a device happens to also report an optimal
> > > boundary, do not use that to define the chunk_sectors as that may
> > > intermittently interfere with io splitting and zone size queries.
> > 
> > Instead of skipping shouldn't we use the max of noiob and the zone
> > size, even if that is mostly theoretical?
> 
> No, I don't think so. If noiob is larger, we'll return the wrong value
> for blk_queue_zone_sectors() and blkdev_nr_zones(), which will have
> undesirable consequences.

Then we at least need to warn about a larger noiob.  And add a
comment that we are ignoring it deliberately.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
