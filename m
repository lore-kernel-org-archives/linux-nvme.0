Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33737C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 14:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08363206A5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UDp5bLkf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi+IfXbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08363206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+t690cSerap3RRejVm9VvI3dNfjvG8mCV0UAHb6CFIg=; b=UDp5bLkfD2yeup
	gmrpsebatBkG7yAKPfiJCp1Rja4eqlDxI20NrFM3pJFACWn7YWwGmDeX67cuWyC2KH30NLXhKhnjb
	zXii9ZBn1V6Nx0oS6IcIgHGvEcHRwpfezMa7TXNDbKw2msl1pQnA42OS3EZdL9KfTIfXphRnr/I72
	P9Rp6Lc4TI5AovofQR2/V4ZJYm6fXZkxJ11L+QARIirL9uK08k82OhxhEyJAA5vW+CqzS/+L31fKS
	Luwi5+gUnK8fLF/U1uF2gIXxTEaYiRgjktUZZfaxiu8ogeX1dqlDyG7WoRY0+rotZ6s8BskTpTpoM
	PNW3nDkiDr9TxSPs/NPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZEoY-0002Zt-WF; Thu, 14 May 2020 14:26:23 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZEoW-0002Yx-Pz
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 14:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fGWHZrRoLExAS3mHwk8ufZ/s4MYBxFdJolCaEnLqA8M=;
 b=bi+IfXbIguDNtjnhvxRZ9gaFbYNQcgh/81HTIbk6pWr6izZn+P7QkqUC8hOxoGbCIZPV/+
 yPETJEMOw5NThTD/VrMsNaR/RkJH4ebJ/mQaNNHyI2OyVrRDpmE7k5dtSrFoZjI+H5GkPV
 Ubg9CmDjUO350Sm4xSDM8TkHBT6XdoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-gDkumX-iOmOMry4mSLa6sw-1; Thu, 14 May 2020 10:24:17 -0400
X-MC-Unique: gDkumX-iOmOMry4mSLa6sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5F8800053;
 Thu, 14 May 2020 14:24:13 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E42045D9CA;
 Thu, 14 May 2020 14:24:04 +0000 (UTC)
Date: Thu, 14 May 2020 09:24:03 -0500
From: David Teigland <teigland@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: is it ok to always pull in sctp for dlm, was: Re: [PATCH 27/33]
 sctp: export sctp_setsockopt_bindx
Message-ID: <20200514142403.GA1447@redhat.com>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-28-hch@lst.de>
 <20200513180058.GB2491@localhost.localdomain>
 <20200514104040.GA12979@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200514104040.GA12979@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_072621_028841_F36B0BEA 
X-CRM114-Status: GOOD (  15.30  )
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
 rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Christine Caulfield <ccaulfie@redhat.com>,
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

On Thu, May 14, 2020 at 12:40:40PM +0200, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 03:00:58PM -0300, Marcelo Ricardo Leitner wrote:
> > On Wed, May 13, 2020 at 08:26:42AM +0200, Christoph Hellwig wrote:
> > > And call it directly from dlm instead of going through kernel_setsockopt.
> > 
> > The advantage on using kernel_setsockopt here is that sctp module will
> > only be loaded if dlm actually creates a SCTP socket.  With this
> > change, sctp will be loaded on setups that may not be actually using
> > it. It's a quite big module and might expose the system.
> > 
> > I'm okay with the SCTP changes, but I'll defer to DLM folks to whether
> > that's too bad or what for DLM.
> 
> So for ipv6 I could just move the helpers inline as they were trivial
> and avoid that issue.  But some of the sctp stuff really is way too
> big for that, so the only other option would be to use symbol_get.

Let's try symbol_get, having the sctp module always loaded caused problems
last time it happened (almost nobody uses dlm with it.)
Dave 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
