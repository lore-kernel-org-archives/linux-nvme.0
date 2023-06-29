Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D34FEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 21:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vets7tG3ILEPoqG+7zzfJad8OpPNQJ5xWznjwspAC48=; b=uDb6nO78TAhgtEc5JFYBeiCey6
	vzQqJtblnmhjriLSKek6zDifiJ+O+81153kYChKQKu51zqgRAn60vb0TK663u3p8W1gfsahufy22Y
	MA17ufyeVdVuV1AxmO+4+51bQ+y9OUHjcioxER0V20ouCYlaD1ksas7nUHKfGWK+Efa02IwiiRRTM
	bPF87ZQkle8Yu2zznR0CUA83ZOI9qZdmOrw5ciBgv/hkjvj0yz9i0QGSosHjDdX8LaqNolPQe5n/t
	bNLyxpVf3+Ut4ubOttNeqL9o7HF921LYTqWpT56gekCV7kAO9hYulgeed9tIPldrVxvl/y0zXRbAw
	48csarZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEzIG-002FBF-2P;
	Thu, 29 Jun 2023 21:35:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEzID-002F9H-24
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 21:35:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688074508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vets7tG3ILEPoqG+7zzfJad8OpPNQJ5xWznjwspAC48=;
	b=YIcXqT+WfwcmRuTfS+lSYv2mQuEZCFs4LyLaAP6nQiB5IzLAGc3qgQrXf21sVIaTgxYbVZ
	wMy0QHnFJKotlEgcUvOu+x5trveEtsQH351L2RGYuvKqOk/nuoVqU6WFKSpxIVuhoVWNwy
	bTvtSoAVGivvTy5Fo9/TwW8PPAZ5SJQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-ygJyXz5vODysshN6s4CjSA-1; Thu, 29 Jun 2023 17:35:03 -0400
X-MC-Unique: ygJyXz5vODysshN6s4CjSA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 692412A5954E;
	Thu, 29 Jun 2023 21:35:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55AB0492C13;
	Thu, 29 Jun 2023 21:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Sagi Grimberg <sagi@grimberg.me>,
    Willem de Bruijn <willemb@google.com>,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
    linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58465.1688074499.1@warthog.procyon.org.uk>
Date: Thu, 29 Jun 2023 22:34:59 +0100
Message-ID: <58466.1688074499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_143509_757033_BAF5D4C3 
X-CRM114-Status: GOOD (  14.72  )
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

Meh:

                if (!sendpage_ok(page))
-                       msg.msg_flags &= ~MSG_SPLICE_PAGES,
+                       msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
                bvec_set_page(&bvec, page, len, offset);

David


