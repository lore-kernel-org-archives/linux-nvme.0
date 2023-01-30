Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1802C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qLfIaYqKY5h8p0flnUU+ZUSKaufFe4Nci0Ya2wtNYRE=; b=U33Pcn009OBKaBG/5/4dhDI0tN
	HKaDOGAYkQ2/J8b9WrWG6wMPVpP5IN0RmuqS2BZ8Wzpawc6kkIrzw7v2jx5oY4XJDkWdp0MGn24FY
	A2oX888ZxYfv9WkqC7WuJQCx3jEtdNkzUA56pFwj/Wk3Dz10cnUOkpXpf2SQ+EmYS4B7CpDkGbHn7
	QKEnhX6Y7Zb/pJ2hvO52CQ/D01An5s0BKMKYzu8fAoUVIBHXp06PWMpIyKWLrH4Gmv4NkaWDki28r
	iGQVcKPoWs0I6LmboprN8dlyxQvXy4atKuNRrodFx44uTF5G+cDxDx4/BUiAzP3kQA0uIwPXkSWob
	CZuwCszw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMWYe-00488n-JB; Mon, 30 Jan 2023 15:59:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMWXx-00487Q-NS
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 15:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675094296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLfIaYqKY5h8p0flnUU+ZUSKaufFe4Nci0Ya2wtNYRE=;
	b=eaVMwhKsIKSpZTB1Rxib2oa/Lg3NP/hBy2udtejZZg5kwP81HeNmAWmAz3vm3D7/osVVvj
	8Mw7KGqB8tYdqjYpI6epPvY6mRzBOVcT11R5lVjaVmzvijxb+ZzWPDnK51z6hx4PfCmPSz
	V7LmJ360IZ9MnftDsnTfum3devcs2j8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-LQbhBSgfPCWz-AZqI1IBMQ-1; Mon, 30 Jan 2023 10:58:12 -0500
X-MC-Unique: LQbhBSgfPCWz-AZqI1IBMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64B4B3848C21;
	Mon, 30 Jan 2023 15:58:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29BD5492B05;
	Mon, 30 Jan 2023 15:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230130092157.1759539-21-hch@lst.de>
References: <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-block@vger.kernel.org,
    ceph-devel@vger.kernel.org,
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
Content-ID: <3499862.1675094288.1@warthog.procyon.org.uk>
Date: Mon, 30 Jan 2023 15:58:08 +0000
Message-ID: <3499863.1675094288@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_075817_844407_50A937C8 
X-CRM114-Status: GOOD (  15.49  )
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

> Use the bvec_set_page helper to initialize a bvec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Howells <dhowells@redhat.com>


