Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2981BC54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CICRFAbCzChYD1znyWS61qGZqh3HfSsIj8zLg6AqEXc=; b=voE3yd81o+N2F5eah25J8n7XYG
	wxsnyt6qUj+D7JPxsHuNPrOffLxmuU7+PQYLUd5rqTe+LPoHx45AzPxenAgDwEA+tLu9G1bfitJzm
	3awbkbE9k9S6U5Z/OucprbzOS2QVSLv3tV3i3YqaOzszDWXsGfzNoTnTIr11JJIyEERPUh86usygd
	g8wbuisUXZlzsf9wFoD8qFzx7fYFpdgrgbQBMu1u8qZEVbMQo/V4RJ2nRMm9WbK7RqtZvDi0cZTe2
	fgTCKVIURt23qVaHZlzV6hVg9pZrbYGcNswvoZO6giQmmjEZyetGHDfTRjAURZb05s100vdueVATj
	+9SCy07g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRUJ-0038sJ-Av; Mon, 30 Jan 2023 10:34:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRRs-0038L2-2j
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 10:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675074698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CICRFAbCzChYD1znyWS61qGZqh3HfSsIj8zLg6AqEXc=;
	b=ItHefssCp+5bXcU5cUb1TOM+KuEjdDSjpd/odABuMwGUabY8WlHPsi7gF6YTBIuHPtcy3H
	fknDFcm3Mxqlehw3AFgl/xhKhuLxhK505tLz1bAIoRx234lgLk+Q+Y576anK8FB4X1XUxe
	1Oj7tfyhtXWlemgNdqR6CDp5sGyYGJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-m7rZ0bd0PKa4hu7tOJYsfA-1; Mon, 30 Jan 2023 05:31:27 -0500
X-MC-Unique: m7rZ0bd0PKa4hu7tOJYsfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 408462999B26;
	Mon, 30 Jan 2023 10:31:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AA28C15BAD;
	Mon, 30 Jan 2023 10:31:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230130092157.1759539-21-hch@lst.de>
References: <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com
Cc: linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
    virtualization@lists.linux-foundation.org,
    linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
    target-devel@vger.kernel.org, kvm@vger.kernel.org,
    netdev@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
    linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
    devel@lists.orangefs.org, io-uring@vger.kernel.org,
    linux-mm@kvack.org
Subject: Re: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3347458.1675074683.1@warthog.procyon.org.uk>
Date: Mon, 30 Jan 2023 10:31:23 +0000
Message-ID: <3347459.1675074683@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_023140_220951_28DCB128 
X-CRM114-Status: GOOD (  14.11  )
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

Christoph Hellwig <hch@lst.de> wrote:

> +		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);

Maybe bvec_set_zero_page()?

David


