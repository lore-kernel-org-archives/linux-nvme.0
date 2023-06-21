Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79725EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCx8PTMmZcxpFBZC7QtJlHTMWJ1OP5pNiL5E71UNtkQ=; b=uQ5oPpJ8tl3ZG1MCQhyG/5nXLR
	LHubAj2juIolP+xJBerf2bVqSj11f78ENYjXyt2/aDFL1701f2APTgtyfWtiEZ0wOQI3ne5FRALN0
	cv5mV1ibexU8r2odb4kIetZt8A1SWTpStrlrUTL2Q9iiu0k1ecwWlPn7vOX9qbf1YD9Eu9SH6/P4S
	vovPFE+shBNRDmWd700GpkP4RN5to9SLzbzyZFbKdLasksXih1MGlGqCoYfypjQDDuzAzeaxDnWIe
	tgj90UUJBUUGw10jV8atW1reg5dlF7LmKqzxB1VIQWxSgWQW1o9vK1ZmJWVGlt25WrRYGWDAyljqd
	ps4QvP9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBx3k-00EZ1C-0q;
	Wed, 21 Jun 2023 12:35:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBx3g-00EYzv-1m
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 12:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687350932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCx8PTMmZcxpFBZC7QtJlHTMWJ1OP5pNiL5E71UNtkQ=;
	b=OcOfbGCwVYTouRmWl90H8eWPh3xxePxkG/UNZ3FVitNiLffD+i9LRQvYAux4kwIPFqcYj3
	C5NvITMcSkXld1oU0cyZ3GzZ6m3ynjWKE32PhTWfnLiIdzEfcLzQ4DbD2/E9KuczKHqcip
	ggk7b7O1bxQ6+U9LXE9ECvlywcJhReQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-f6KGKq15OqmRtG5q1VsCLg-1; Wed, 21 Jun 2023 08:35:24 -0400
X-MC-Unique: f6KGKq15OqmRtG5q1VsCLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA7071C08784;
	Wed, 21 Jun 2023 12:35:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93FBC1121330;
	Wed, 21 Jun 2023 12:35:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87f547b0-7826-b232-cd01-c879b6829951@grimberg.me>
References: <87f547b0-7826-b232-cd01-c879b6829951@grimberg.me> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Willem de Bruijn <willemb@google.com>,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
    linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1733832.1687350914.1@warthog.procyon.org.uk>
Date: Wed, 21 Jun 2023 13:35:15 +0100
Message-ID: <1733833.1687350915@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_053536_690469_7472718C 
X-CRM114-Status: GOOD (  16.40  )
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

> What tree will this be going from btw?

It's aimed at net-next, as mentioned in the subject line.

Thanks,
David


