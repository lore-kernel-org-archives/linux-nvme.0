Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D280EEB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZ67eYp0xidD7yf0q5E58c4Opw2pRmvbtVhqjrSnPYE=; b=smS820hp01gCtvFSeLThmxVF6m
	yIv5r2Y/uyuYhZsOMeQM+37K1wGeKlDSsvEUsvz0glqer7q/J38IqnmvRm+q35r7ehx7X4L6Isq/8
	n0VuSIA1pzr8voWGDhl9rvbZq7wkydWj2ZRcpYFpvEzkJfMb7mU/Z0VsKGYsrfUSewuL4QAkop4GJ
	oC2jfeUNPjjgofGe2n9l+AkkF8aD8soZhqHwT3jqC/KDyrJppaCOWjG4FI4BcJPSViDWYry6UNJs9
	MK/22Ed4LmeorO4RvmOThzB9Ez/CtVyJsILICBTfZ63wFK08mDj4o0mCg9G6MSjiG8z5Hx583Lxr2
	fdog4D/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBBBc-0080CU-1N;
	Mon, 19 Jun 2023 09:28:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBBBZ-0080AY-0L
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 09:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687166911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZ67eYp0xidD7yf0q5E58c4Opw2pRmvbtVhqjrSnPYE=;
	b=M772NuO1mgQOiFzdobOvHbgLSoL76F8oxWtSpf19HMY5bPRN60gKF09xkforigzoAwnO2Q
	IuvK8Rz3J6KgFNDiadGj1ltSF5c/q8hAKFHeqKFqos6jnyUDJc/GkcWHkbMlJzfOGgzRGp
	xrbE+cHhl1Y2kpN9JgVSCHl9I3mXJsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-wy7vn5_rOYuWr0fZ_lhqeg-1; Mon, 19 Jun 2023 05:28:29 -0400
X-MC-Unique: wy7vn5_rOYuWr0fZ_lhqeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05F2180067D;
	Mon, 19 Jun 2023 09:28:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1AC6112132C;
	Mon, 19 Jun 2023 09:28:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <55e7058b-07d0-3619-3481-2d70e95875ea@grimberg.me>
References: <55e7058b-07d0-3619-3481-2d70e95875ea@grimberg.me> <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch> <20230617121146.716077-1-dhowells@redhat.com> <20230617121146.716077-11-dhowells@redhat.com> <755077.1687109321@warthog.procyon.org.uk>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: dhowells@redhat.com,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
    linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <775803.1687166903.1@warthog.procyon.org.uk>
Date: Mon, 19 Jun 2023 10:28:23 +0100
Message-ID: <775804.1687166903@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_022833_223532_3FE6C428 
X-CRM114-Status: GOOD (  17.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi Grimberg <sagi@grimberg.me> wrote:

> The patch looks good to me, taking it to run some tests
> (from sendpage-3-frag branch in your kernel.org tree correct?)

Yep, but you'll patches 1 also and patch 2 might help with seeing what's going
on.

David


