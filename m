Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9617DC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6691720708
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CtVSOOgd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN3DADJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6691720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1D00HypG/KpYX4DLiN97K6JNLFuLgkq+LKZAOd6501U=; b=CtVSOOgd+IkO0T
	8kUxI/F6R/cYua1T8Gs5XlIQfeKe8sejPgW0/0Gw3GzarpCRGOh9g0wxxwYN/86Y7Fmz20AAovouQ
	bID46J0XiVTQohQi+i3bGcJlvHPe4agCmo4xrUO2t3o1wZ2iw2wnfjsjWqOpGW4oDNd99Mhjr3Su1
	qtz4TJCS4bQhNcssRg7VhW5x0bswbql2Jtd/ok6MgC9fb1T+FQEY93sh0oUkvGvw94Yaf6P18ADQT
	uhu/FrTFUGjaNLj8qsLVDYnZMnIUFJ9vNJ2SmXlGlsFtYkhQ1f41BTU5izhZb/COqRisBmwaTf+p0
	7kBIhFUd+UoVIedh0Axg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY5VC-0000gQ-Gb; Fri, 22 Nov 2019 09:45:22 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY5V9-0000fx-4P
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 09:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574415916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EZdhFp2nyPuvY0dt4SK2+76zRnKIR/9jOBh5em9Ya8=;
 b=iN3DADJrtkFqirpfdKo6u6DR9FbeZsOhSEwZB0eALBpq5997fqUm/m61Jk5VUGdN3ELSbu
 SSEjMT+2bHibDSFagPvaDCGlCj3i4Rv10Y6tuwNeDBA6vwPpZ5qA9XrxQ7HfD9yPoAqN/f
 Z5phVgOLglPlfNG4pVByYyKcwC+w1Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ST52AdsFOmK-6U2L8yMj2g-1; Fri, 22 Nov 2019 04:45:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3436100551C;
 Fri, 22 Nov 2019 09:45:10 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5AF75EE1A;
 Fri, 22 Nov 2019 09:45:02 +0000 (UTC)
Date: Fri, 22 Nov 2019 17:44:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191122094457.GA23632@ming.t460p>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191121031154.GJ24548@ming.t460p> <20191121061431.GA22886@lst.de>
 <20191121074643.GB4755@ming.t460p>
 <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ST52AdsFOmK-6U2L8yMj2g-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_014519_245264_EF09C881 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Nadolski Edmund <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 22, 2019 at 12:45:31AM +0900, Keith Busch wrote:
> On Thu, Nov 21, 2019 at 03:46:43PM +0800, Ming Lei wrote:
> > On Thu, Nov 21, 2019 at 07:14:31AM +0100, Christoph Hellwig wrote:
> > > On Thu, Nov 21, 2019 at 11:11:54AM +0800, Ming Lei wrote:
> > > > Hi Guys,
> > > > 
> > > > Ping...
> > > 
> > > I think everyone has told you that it is an invasive horrible hack
> > > that papers of the underlying problem(s).  I'm not sure what more
> > > we can do here.
> > 
> > The problem is that the NVMe driver applies aggressive interrupt
> > coalescing clearly, that can be addressed exactly by this approach.
> 
> Can this default coalescing setting be turned off with a "set feature"
> command?
> 

At default, 'get feature -f 0x8' shows zero, and nothing changes after
running 'set feature -f 0x8 -v 0'.

BTW, soft lockup from another Samsung NVMe can be fixed by this patch
too. I am confirming if the Samsung NVMe applies aggressive interrupt
coalescing too.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
