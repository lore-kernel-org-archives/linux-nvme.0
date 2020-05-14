Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE6C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 10:30:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E0520748
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 10:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TAfMd9ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vH865pfJpFYlf3dh1/Jo8HtsoKk58ohlQaUm86TVR4E=; b=TAfMd9owr58/BN
	qpPQBdaSsLLR61jMVl+/5bCik/juLazVlEplSXWWQZPni+4Ovji8Pwpq6MzP9k405p50n+9cIvQzD
	YP7hBZGYVzXRve//Evrx5O6NAzQfAnXcf/7ch0ocPjqAoP6qfG6SJXSc9dx/6xrC7egF2eIp2oyOD
	dJj1AvTbQhWwh4a7NvV+Ci0TE4cVcem2ptFnGeunRbFnpaDwRoxpevujth+HAgK8JP/muoh3OUr5f
	SBmep6LKi7G2lrYJ5hOzg90gCNwJZZL/Y6JbyMFms9ex3chPDgK6VTFS2CNOyY9OVMAnH9PeHrqe2
	SlFY84/I5ExHPRCpOk6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZB8J-0003Z4-Bl; Thu, 14 May 2020 10:30:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZB8G-0003WK-99; Thu, 14 May 2020 10:30:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5131B68BEB; Thu, 14 May 2020 12:30:26 +0200 (CEST)
Date: Thu, 14 May 2020 12:30:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 20/33] ipv4: add ip_sock_set_recverr
Message-ID: <20200514103025.GB12680@lst.de>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-21-hch@lst.de>
 <0ee5acfaca4cf32d4efad162046b858981a4dae3.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ee5acfaca4cf32d4efad162046b858981a4dae3.camel@perches.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_033028_470692_5A723094 
X-CRM114-Status: GOOD (  10.04  )
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
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, linux-sctp@vger.kernel.org,
 Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 13, 2020 at 02:00:43PM -0700, Joe Perches wrote:
> On Wed, 2020-05-13 at 08:26 +0200, Christoph Hellwig wrote:
> > Add a helper to directly set the IP_RECVERR sockopt from kernel space
> > without going through a fake uaccess.
> 
> This seems used only with true as the second arg.
> Is there reason to have that argument at all?

Mostly to keep it symmetric with the sockopt.  I could probably remove
a few arguments in the series if we want to be strict.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
