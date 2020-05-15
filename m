Return-Path: <SRS0=rA+l=65=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E5C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 15:25:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B72D20643
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 15:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NoNEmhvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B72D20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gDHDVNp/PsfeSct2FEg6YsEbQLEHgUTZWJw2mTlUNVI=; b=NoNEmhvBY+BrKD
	W4uEymS+l8jwAzj0/SAC1r8Yen0VGinT9HvhbvFP7Bl1X6dmL/hgA8mHyqKAfzeV2sqDKPjNJQmno
	maA6rsd2cFbr4IB8Vt1g2223+n05q6TD+XBWjvcT+YZubsbjfbl6e6+0GDE5lco7/Fj6BvDC0IWx0
	FWRYWrBrmB3Nb8sMde3eLagsGjPS8OPS4AdOSiS+ro+xoTKiR+88NNYinR5WIUOVkugeAsOhmYLJe
	OywKTvgiCsJzrdo6tmGdVFVur330PJUupa/ohikNS+QW/u9h14TyN435skeCCUEUMNDkqdjSABuMW
	o8qo+ryf+DBV2FtgNRTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZcCy-0005Tg-9I; Fri, 15 May 2020 15:25:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZcCt-0004WG-7d; Fri, 15 May 2020 15:25:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DCFD868C65; Fri, 15 May 2020 17:24:59 +0200 (CEST)
Date: Fri, 15 May 2020 17:24:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 27/33] sctp: export sctp_setsockopt_bindx
Message-ID: <20200515152459.GA28995@lst.de>
References: <20200514062820.GC8564@lst.de>
 <20200513062649.2100053-1-hch@lst.de> <20200513062649.2100053-28-hch@lst.de>
 <20200513180058.GB2491@localhost.localdomain>
 <129070.1589556002@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <129070.1589556002@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200515_082503_464935_17D89C5A 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 cluster-devel@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 linux-block@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 15, 2020 at 04:20:02PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > The advantage on using kernel_setsockopt here is that sctp module will
> > > only be loaded if dlm actually creates a SCTP socket.  With this
> > > change, sctp will be loaded on setups that may not be actually using
> > > it. It's a quite big module and might expose the system.
> > 
> > True.  Not that the intent is to kill kernel space callers of setsockopt,
> > as I plan to remove the set_fs address space override used for it.
> 
> For getsockopt, does it make sense to have the core kernel load optval/optlen
> into a buffer before calling the protocol driver?  Then the driver need not
> see the userspace pointer at all.
> 
> Similar could be done for setsockopt - allocate a buffer of the size requested
> by the user inside the kernel and pass it into the driver, then copy the data
> back afterwards.

I did look into that initially.  The problem is that tons of sockopts
entirely ignore optlen and just use a fixed size.  So I fear that there
could be tons of breakage if we suddently respect it.  Otherwise that
would be a pretty nice way to handle the situation.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
