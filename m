Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42FBC54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:
	Content-Type:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9A1bVyZb4er6cTd4zzjsltmhyvgIyU7DAJ3a6jVt6A=; b=nzydQubVWPvaBOyYkXRYl/RrwM
	QvK984a5eUj3Ftc85CVKYQRnSpypwSlL074zS1Gi7XWjNxryE9WpHVTz0Q1P7Kl3F3/FdhzW9D1l/
	BIVH5wEz4I+AJLBF9wOJv2MxhCC1ZXlD0uNG/0GiMUftVPbhqvaCjzO+gScGSWkG63Z/Jsbjok2w2
	bHxPmWtGMZHbTp2uzT3vrcUukK9JNkZ+nzxhcZJOn714pF79OovVNPPccWwo9OkomRE+4cv8RhDMi
	aDm7Xr32YdhSg8jk1QLlHihTozVlRMFSNdQozmWfo2sD/VSb+XeQQiG+rmdNDEiFqsbFYobgOy3x+
	x3YI9xNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMSHW-003HSr-BM; Mon, 30 Jan 2023 11:25:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMSGv-003HS6-SX
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 11:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675077865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9A1bVyZb4er6cTd4zzjsltmhyvgIyU7DAJ3a6jVt6A=;
	b=dn/5Nv8e5/rCMrnoD+N+nCxODDGHVMfPpYqPsw+JwYKRpkJ4QarRmOSA/l23xkQop/u4Sn
	0m67DS+wgHHazRxqr0/sLu7PyXp3xWXJC83g3UIq+G+t6LuCGiHOrwOfmIaCQGx+XjYsmI
	SqpzEFSMdfhs4LKpFuxtVS/P3F7iNwc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-JYIlhA5gM_SRvbpUiBK1og-1; Mon, 30 Jan 2023 06:24:18 -0500
X-MC-Unique: JYIlhA5gM_SRvbpUiBK1og-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15A29382C965;
	Mon, 30 Jan 2023 11:24:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27FB8492B05;
	Mon, 30 Jan 2023 11:24:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230130103343.GA11663@lst.de>
References: <20230130103343.GA11663@lst.de> <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de> <3347459.1675074683@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, linux-block@vger.kernel.org,
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
Content-ID: <3351917.1675077855.1@warthog.procyon.org.uk>
Date: Mon, 30 Jan 2023 11:24:15 +0000
Message-ID: <3351918.1675077855@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_032426_003290_492F8394 
X-CRM114-Status: GOOD (  19.42  )
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

> On Mon, Jan 30, 2023 at 10:31:23AM +0000, David Howells wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > +		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
> > 
> > Maybe bvec_set_zero_page()?
> 
> Why?

Seems to be something people want to do quite a lot and don't know about.
I've seen places where someone allocates a buffer and clears it just to use as
a source of zeros.  There's at least one place in cifs, for example.  I know
about it from wrangling arch code, but most people working on Linux haven't
done that.

David


