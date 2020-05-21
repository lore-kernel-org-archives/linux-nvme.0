Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 09:08:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D07C2070A
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 09:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QkbkoeUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D07C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vNdG6/4rpEPyOzM6T1uHunzJZgkUwjk2gLslzNUgHfU=; b=QkbkoeUcdoedym
	6bgVXsiCo+ztb3f79qgDuCFp/YAG9cgPEM5NMpG7/Icksaxq9maoYvKnVn2sTVyogGo6+UC/xjujY
	Iv39Tn+zyxsOsxCiBOhhsWXGmulfgyBR7/KKhSjZ9qjT6eppDVSI49lXs24Px4cKp0BlKgmVn8FpN
	UH1C/jhssIgrf0ErPbqU+9nxkiKd+FPRsgfBsUJvbU56184MwJugRAnlIVjjX8JMD2YuWXpye6jKk
	JOV04h1SIaTwGraI7j3d/vXR8XtX7pIhEmL9C4vzqLUIi3fzhfdylCYnstDZqZ1UnJQ031lYwt5tF
	awYAsgc91N0QU3p3/9fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbhBb-0004MO-L1; Thu, 21 May 2020 09:08:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbhBY-0004Kw-0H; Thu, 21 May 2020 09:08:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B08C668BEB; Thu, 21 May 2020 11:08:12 +0200 (CEST)
Date: Thu, 21 May 2020 11:08:12 +0200
From: 'Christoph Hellwig' <hch@lst.de>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 31/33] sctp: add sctp_sock_set_nodelay
Message-ID: <20200521090812.GA8330@lst.de>
References: <20200520195509.2215098-1-hch@lst.de>
 <20200520195509.2215098-32-hch@lst.de>
 <20200520231001.GU2491@localhost.localdomain>
 <20200520.162355.2212209708127373208.davem@davemloft.net>
 <20200520233913.GV2491@localhost.localdomain> <20200521083442.GA7771@lst.de>
 <0a6839ab0ba04fcf9b9c92784c9564aa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a6839ab0ba04fcf9b9c92784c9564aa@AcuMS.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_020816_203899_F782D989 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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
 "edumazet@google.com" <edumazet@google.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 'Christoph Hellwig' <hch@lst.de>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
 "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "vyasevich@gmail.com" <vyasevich@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>,
 David Miller <davem@davemloft.net>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 21, 2020 at 09:06:19AM +0000, David Laight wrote:
> > > The comment still applies, though. (re the duplication)
> > 
> > Where do you see duplication?
> 
> The whole thing just doesn't scale.
> 
> As soon as you get to the slightly more complex requests
> like SCTP_INITMSG (which should probably be called to
> set the required number of data streams) you've either
> got replicated code or nested wrappers.

None of that is relevant to setting the nodelay option.  If you actually
read through the series you'd say that whenever there was non-trivial
logic it is shared with getopt.  However sharing just for purpose of
sharing doesn't make sense, so where the kernel API ended up just
setting a flag after taking the sock lock I did not opt for it.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
