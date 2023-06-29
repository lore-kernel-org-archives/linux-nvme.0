Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC835EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:
	Content-Transfer-Encoding:Content-ID:Content-Type:MIME-Version:Subject:Cc:To:
	References:In-Reply-To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEvn4mNBJjxGCfxtSjAM8jMyMTbXVbbppuQzIKpSf88=; b=AzR6qHZtRvE0gIFNY57Bfhx1B3
	sTQE5PWw0dDZLogmE7MUS14Sto3zx0pSGmWJ1CgagVbavockLzy/2FBVtCfmTvZIGfDdhM8vpHmva
	ffvUMIVokot4nuf5cLCEA0AJV54IqXf1fgcAhCIRcrWDTf6FMplQXF+h1JafRmJUeUblRcVsiQPhJ
	1yxzRQ/DSuNllK1wX6G9MsaxlenQTPIviiY4I/9Gf/yCWbTT6+WpeM33HZITJqhCy9L2egur3f/0f
	50NLVV/WgpmjNfCGdEY4TLl5erhnSVuef9lR7fujuW7ciqCo/VKOxT0CRGCsWqSFe5LpWN5g4i83E
	9hLYVmRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEz6g-002DXc-2P;
	Thu, 29 Jun 2023 21:23:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEz6d-002DWO-0V
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 21:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688073789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEvn4mNBJjxGCfxtSjAM8jMyMTbXVbbppuQzIKpSf88=;
	b=g2NDTPW9eJqTM9r0n9wEd+GFhChfcyF6+WIM86kD6qzEEzGSJz5fHLd08uS7KoB5cwkOoE
	QujRXJ0bBSOpHsfmQrVZlNy/P8xyEd13Mm35PgTMHmLT6ZHan46P6e4lrvreLSZziaoj7Z
	BlnxA0/laAb/QcpMEjJRGPNsK+AE1yI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-Mn4whvRiN6qoD5RPWRCUAg-1; Thu, 29 Jun 2023 17:23:05 -0400
X-MC-Unique: Mn4whvRiN6qoD5RPWRCUAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDE381DB6C;
	Thu, 29 Jun 2023 21:23:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3ED20200B402;
	Thu, 29 Jun 2023 21:23:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
References: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com> <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: dhowells@redhat.com, Aurelien Aptel <aaptel@nvidia.com>,
    netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
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
Content-ID: <55022.1688073781.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 22:23:01 +0100
Message-ID: <55023.1688073781@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_142311_279509_699FC8EE 
X-CRM114-Status: GOOD (  19.94  )
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

> simple way to check is to run:
> nvme_trtype=3Dtcp ./check nvme

It says a lot of:

nvme/002 (create many subsystems and test discovery)         [not run]
    nvme is not available
    nvme_trtype=3Dtcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [no=
t run]
    nvme is not available
nvme/004 (test nvme and nvmet UUID NS descriptors)           [not run]
    nvme is not available
nvme/005 (reset local loopback target)                       [not run]
    nvme is not available
...

I have the following NVMe config:

# NVME Support
CONFIG_NVME_COMMON=3Dy
CONFIG_NVME_CORE=3Dy
CONFIG_BLK_DEV_NVME=3Dy
CONFIG_NVME_MULTIPATH=3Dy
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=3Dy
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TCP=3Dy
CONFIG_NVME_AUTH=3Dy
CONFIG_NVME_TARGET=3Dy
CONFIG_NVME_TARGET_PASSTHRU=3Dy
CONFIG_NVME_TARGET_LOOP=3Dy
# CONFIG_NVME_TARGET_RDMA is not set
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_TCP=3Dy
CONFIG_NVME_TARGET_AUTH=3Dy
# end of NVME Support
CONFIG_RTC_NVMEM=3Dy
CONFIG_NVMEM=3Dy
# CONFIG_NVMEM_SYSFS is not set
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# CONFIG_NVMEM_RMEM is not set

Can you tell me what I'm missing?

David


