Return-Path: <SRS0=q3TM=63=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC9AC2D0FC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 13:13:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BA724CB6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2020 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="maYAYT84";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVn3KiDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BA724CB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:MIME-Version
	:Subject:To:References:In-Reply-To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pzJBXQA6oXVeMChXf8P1Hb/GsSyOb0H+4VGdPWFkGZ8=; b=maYAYT84749Iiv
	8WEwJ4hwBmfiuG0qrlod6emDlYUxd+ixGuaoJ5Ka8y1NoAOh0/ZCqCKLILh21ncrzT7Od8xBrty/K
	dI6R3fOucj45T9/8J3mbiw7ZraTK74p/+B1N56/iGuXo2lDl8EM/2K49QZFfHunIFXAaM0LT7ouzj
	i26oiauAUITPux0CC5SrfZpAfk4eFJ4NyUTXWlPnextLoWpfQ5NqpUndBEwtMi06cI0uyDNPBiae/
	bvFUSArS/fWcfXy6uHqTeC+m3Vfqy7I1T+sTrcNZOpywBQg9TT+JFmANVeZY9Uk3NQomi6Hes8Pyr
	32gYxDCTJOT59EbEzBAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYrCU-0001Ex-Tq; Wed, 13 May 2020 13:13:30 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYrCR-0001E9-Lv
 for linux-nvme@lists.infradead.org; Wed, 13 May 2020 13:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589375605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kC/Pwa8f1gD3R5LYjYmzPSPuGCXjungEBXbTdD/3zMQ=;
 b=FVn3KiDBR/Z87zcMojaI5R/KMMowZscceiaybmH1VDDh8rDDZimCXbLjmZlbp6yC7/R29H
 wg2QMvITvtzKooXg3JV1Ng4JbH0utrkFpB5SKE9IM7hNsn/yOtJb6wWpus1UwUZ/prJIgo
 iZUfxBGDCveooTjX5mpkt47QOmGfMio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-j5Rv_ovSOqaPeCLkWE73pQ-1; Wed, 13 May 2020 09:13:21 -0400
X-MC-Unique: j5Rv_ovSOqaPeCLkWE73pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED3780183C;
 Wed, 13 May 2020 13:13:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com
 [10.10.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 800786A960;
 Wed, 13 May 2020 13:13:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20200513062649.2100053-30-hch@lst.de>
References: <20200513062649.2100053-30-hch@lst.de>
 <20200513062649.2100053-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 29/33] rxrpc_sock_set_min_security_level
MIME-Version: 1.0
Content-ID: <3123533.1589375587.1@warthog.procyon.org.uk>
Date: Wed, 13 May 2020 14:13:07 +0100
Message-ID: <3123534.1589375587@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_061328_776866_8E054B53 
X-CRM114-Status: UNSURE (   8.90  )
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

> +int rxrpc_sock_set_min_security_level(struct sock *sk, unsigned int val);
> +

Looks good - but you do need to add this to Documentation/networking/rxrpc.txt
also, thanks.

David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
