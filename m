Return-Path: <SRS0=rA+l=65=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF27C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 15:15:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969C320728
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 15:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S2eL7d6/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLTMg8Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969C320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:MIME-Version
	:Subject:To:References:In-Reply-To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JvHG4/EgUxzQbpmn4W2ugsaJtPDMTWCoDCHxMMf1f7g=; b=S2eL7d6/R9fcKM
	9+zJ9HqqXLuYe3S+0qOvjD5JNVUuuYu/Zv+jT6OJplxbo9sjE6/2uPNFfBf9X1EsxX9OsipM9w/5P
	bsqBUbw6+GA1WzLAT/adXIurz1nBFZTTNS4pmswODlc8hOUqf+eWY/sOtPMTva0I6YOoQI4YuC+tl
	uU6z9hxm3DUEyJYQwnLngVjsc9UOdGDgEWRM/lZ0YPiLY6TyKxqTlcod2wTkZPz47dZkCLxHPmdYZ
	grDnW+F0FaEQRaowr1CKVu/LR3JQ1xasBiOyeBr156PUDOhIrce3XtFiZtflvZIRFzeyApr0wZg2Q
	+Y5MnfsM84mHNNWnAQDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZc3r-0005nC-Do; Fri, 15 May 2020 15:15:43 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZc3p-0005ko-Ex
 for linux-nvme@lists.infradead.org; Fri, 15 May 2020 15:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JreAY7MKMl9fHBBX1SskPW+QiLkeoSeDm7rQFvd/Pn4=;
 b=aLTMg8Tbdu6nCFlS3ZMY1KUIuBS8S+H3M9NWHXvnUJt2E4g9GyAGj9tRwMzqDpH1HufW2E
 9rPwa4ljUvoolMlWtDW82IBD4//msuWl/7JTO8drVUwjXrQwlLoO+ASuO4i9do5+ij9+QV
 k5khCXcPT4PxZ/E5f2ntjdAjkDC60C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-szRU-cO-O-uHE_tEFGhqcw-1; Fri, 15 May 2020 11:15:35 -0400
X-MC-Unique: szRU-cO-O-uHE_tEFGhqcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619438005AD;
 Fri, 15 May 2020 15:15:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com
 [10.10.112.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE21960C84;
 Fri, 15 May 2020 15:15:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20200514062622.GA8564@lst.de>
References: <20200514062622.GA8564@lst.de>
 <20200513062649.2100053-22-hch@lst.de> <20200513062649.2100053-1-hch@lst.de>
 <3123898.1589375861@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 21/33] ipv4: add ip_sock_set_mtu_discover
MIME-Version: 1.0
Content-ID: <128699.1589555724.1@warthog.procyon.org.uk>
Date: Fri, 15 May 2020 16:15:24 +0100
Message-ID: <128700.1589555724@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200515_081541_596622_D101DFA0 
X-CRM114-Status: GOOD (  12.16  )
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
 dhowells@redhat.com, linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-block@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph Hellwig <hch@lst.de> wrote:

> > > +		ip_sock_set_mtu_discover(conn->params.local->socket->sk,
> > > +				IP_PMTUDISC_DONT);
> > 
> > Um... The socket in question could be an AF_INET6 socket, not an AF_INET4
> > socket - I presume it will work in that case.  If so:
> 
> Yes, the implementation of that sockopt, including the inet_sock
> structure where these options are set is shared between ipv4 and ipv6.

Great!  Could you note that either in the patch description or in the
kerneldoc attached to the function?

Thanks,
David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
