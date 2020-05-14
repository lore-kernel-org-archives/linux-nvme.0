Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE0BC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56D7206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="texipuvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56D7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pgq9feIGn027yIXgi6rEDGx2vJSDj4uGBa9mZ5lOgrM=; b=texipuvnffIm74
	dQVddXfE7mf0fTcfsYlQaKeE5G2jquFKAq5DUWkDX/zwtECNmrFd5C8wrEq6uVjuIqs905H0qjL0I
	+Be/DyyLE9kSptEVD/t/m1XOOmNh+hFz42w2ipvi7ArSmSWGlAbRGlF/8cF4u2aUtZ6CqsaerwJPO
	8AgchFulUSFZjKiPUvgA2f3/XvIKyvXnWAKpxuiBZf5Iou5BAsX0sFNelPM3qkMz51HvlwvkXR96N
	+/0VzonP2zQFc6pRr3Gr4G41C36NggHxP+l/sT0dFXhsUdFjnbwTcHGkg8AV9149nClyM7MYJsDTH
	z3uy1P44horijqlTzdkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ7K8-0001QR-MJ; Thu, 14 May 2020 06:26:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ7K6-0001Q1-3C; Thu, 14 May 2020 06:26:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8B05468B05; Thu, 14 May 2020 08:26:22 +0200 (CEST)
Date: Thu, 14 May 2020 08:26:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 21/33] ipv4: add ip_sock_set_mtu_discover
Message-ID: <20200514062622.GA8564@lst.de>
References: <20200513062649.2100053-22-hch@lst.de>
 <20200513062649.2100053-1-hch@lst.de>
 <3123898.1589375861@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3123898.1589375861@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_232626_284365_04505702 
X-CRM114-Status: GOOD (  10.34  )
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
 cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 linux-block@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
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

On Wed, May 13, 2020 at 02:17:41PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > +		ip_sock_set_mtu_discover(conn->params.local->socket->sk,
> > +				IP_PMTUDISC_DONT);
> 
> Um... The socket in question could be an AF_INET6 socket, not an AF_INET4
> socket - I presume it will work in that case.  If so:

Yes, the implementation of that sockopt, including the inet_sock
structure where these options are set is shared between ipv4 and ipv6.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
