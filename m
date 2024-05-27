Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B65EC25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NeXGDE1Zd3UVqjc71kTNguAEIXxiL/niwqnfN+tZYHo=; b=lhbz8S9XfBBZcVA9LbVRs8Q+te
	0OvDOb40xUNfNO1+HOy1Xx9MTBMUHKv1ybyZwRsEGJ7bcXGXN56f4pcvQJIExRadGDvxWDN5NPq7u
	E9M1y0KmnjR8aKYuY/m3/wuUWk0GaUmHfkxaa7rKqCVJLy5/ajpRHaTg3YI6lOpcmE/+0B/tFh5gF
	xxbEVlLaO1fe8iHg7oEpCPbHRf4r70JgukYbhsVU6n0fWzhg10qvvLhj+6w3m7iM9gOQe3b8TR//Q
	aZ+s1SJ5pTjPHEGlP5eLdaakhOcV3ludxEZ+g/pgpWzhdnXsztN8TTaYXcpBlH1eNeCaU89djM95o
	VVqrQutQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBcPt-0000000Fcis-1huB;
	Mon, 27 May 2024 15:37:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBcPq-0000000Fchw-3ErC
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 15:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NeXGDE1Zd3UVqjc71kTNguAEIXxiL/niwqnfN+tZYHo=;
	b=WvxJaGsNysRLONzpNGzRLxFlxhkPaV8JSzA8PaP1fqYigFNTPXAfCeOMS4r+uaGUVy4eLd
	GEs5y94x0ULziVINP5A8mKnuK7z2NDNr5dNv0181wtWbKtycsPNDxvB0QqB1UBkenVJtlo
	3vQ64kECvgWSas06NIcb0n7fT4Dl4Q8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-DwAo0QayNdKrhUU9T4FZLQ-1; Mon, 27 May 2024 11:37:30 -0400
X-MC-Unique: DwAo0QayNdKrhUU9T4FZLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA56800169;
	Mon, 27 May 2024 15:37:29 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C65105480A;
	Mon, 27 May 2024 15:37:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D2BB930C1C33; Mon, 27 May 2024 15:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id CEE993C542;
	Mon, 27 May 2024 17:37:28 +0200 (CEST)
Date: Mon, 27 May 2024 17:37:28 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, Anuj gupta <anuj1072538@gmail.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2 v3] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <20240523171922.GA5892@lst.de>
Message-ID: <34bda7d9-378c-5d2-6fd-138a71140cf@redhat.com>
References: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com> <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com> <20240523171922.GA5892@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_083738_916502_D8618477 
X-CRM114-Status: GOOD (  22.53  )
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



On Thu, 23 May 2024, Christoph Hellwig wrote:

> On Thu, May 23, 2024 at 06:54:47PM +0200, Mikulas Patocka wrote:
> > 
> > However, the function rq_integrity_vec has a bug - it returns the first
> > vector of the bio's metadata and completely disregards the metadata
> > iterator that was advanced when the bio was split. Thus, the second bio
> > uses the same metadata as the first bio and this leads to metadata
> > corruption.
> > 
> > This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> > instead of returning the first vector. mp_bvec_iter_bvec reads the
> > iterator and advances the vector by the iterator.
> 
> mp_bvec_iter_bvec does not advance the bvec_iter, it just uses the
> iter to build a bvec for the current position in the iter.
> 
> Also please fix the commit log to not use more than 73 characters,
> as-is it will be unreadable in git show output or email replies.

OK. I thought that the limit was 74.

> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> >  	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > +		return (struct bio_vec){ };
> > +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > +				 rq->bio->bi_integrity->bip_iter);
> 
> The queue_max_integrity_segments check can go away now.  Once you
> use the bvec_iter the function works just fine for multiple
> integrity segments and always returns the one at the current iter
> position.   That should preferably also documented in a comment.

Yes, I dropped this and I am resending a new version.

> (I'm also pretty sure I've already written this in reply to Anuj's
> version of the patch)

Mikulas


