Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE3DC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 19:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A062053B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 19:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQZ4MSYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A062053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+NxbKGuQFQtmrlfoN+og4wrEQ4ehjFfeo9grr67vX+g=; b=ZQZ4MSYrmqubOT
	68yKRAFmvxq6BjyJLUF89w9QYyOO6KF2PzOe2pNTfC4KFN2hV0D9mqLGVjLclxeEBPy/mFhMTz2uv
	edkX2cBntnh24jK6R67NuGG95k/wH3Tb36xg54419nwwO87lhukU4O/2dJ521/77IRHODKOEZNxaT
	xne2IdhP6XBTNetQVCx3dbdYb5wQbJtM8rjACcOGgVABMUxum79TBtrLBYMps+QDdEdpDOARnaGAu
	OSvKgPyxhbe7/sHC/gCUfWuMrafUDwBzqOuM/mqw7RcmJLiUIZDCdSi5GS4Sa39TtxYkR9rAzRmaG
	q0vzwCGCd/GUkcDgLDow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZJdk-0003fe-0v; Thu, 14 May 2020 19:35:32 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jZJdf-0003fM-JH; Thu, 14 May 2020 19:35:27 +0000
Date: Thu, 14 May 2020 12:35:27 -0700
From: Matthew Wilcox <willy@infradead.org>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [Ocfs2-devel] remove kernel_setsockopt and kernel_getsockopt
Message-ID: <20200514193527.GB16070@bombadil.infradead.org>
References: <20200513062649.2100053-1-hch@lst.de>
 <ecc165c33962d964d518c80de605af632eee0474.camel@perches.com>
 <756758e8f0e34e2e97db470609f5fbba@AcuMS.aculab.com>
 <20200514101838.GA12548@lst.de>
 <a76440f7305c4653877ff2abff499f4e@AcuMS.aculab.com>
 <20200514103450.GA12901@lst.de>
 <c2034daa0a23454abb5e5c5714807735@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2034daa0a23454abb5e5c5714807735@AcuMS.aculab.com>
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Eric Dumazet <edumazet@google.com>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 'Christoph Hellwig' <hch@lst.de>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ying Xue <ying.xue@windriver.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Vlad Yasevich <vyasevich@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
 'Joe Perches' <joe@perches.com>, "David S. Miller" <davem@davemloft.net>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 14, 2020 at 11:11:34AM +0000, David Laight wrote:
> From: 'Christoph Hellwig'
> > Sent: 14 May 2020 11:35
> > On Thu, May 14, 2020 at 10:26:41AM +0000, David Laight wrote:
> > > From: Christoph Hellwig
> > > > Only for those were we have users, and all those are covered.
> > >
> > > What do we tell all our users when our kernel SCTP code
> > > no longer works?
> > 
> > We only care about in-tree modules, just like for every other interface
> > in the kernel.
> 
> Even if our management agreed to release the code and the code
> layout matched the kernel guidelines you still wouldn't want
> two large drivers that implement telephony functionality
> for hardware that very few people actually have.

Oh, good point, we'll change the policy for all modules and make every
interface in the kernel stable from now on to cater to your special case.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
