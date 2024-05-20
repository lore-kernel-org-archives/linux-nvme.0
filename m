Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1148CC04FFE
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guKnOQaYcck3gIy9ZWMzFJIBFpiFj2ii6L3g585Cg7Y=; b=KWh3ha/pK/1RQjb6j5LKx6oUOX
	FVsXHSOhNAIR9zauv7Xtz97Y3zfZroRPSif5OiqLXXga++emupieEgZxoFuO1iZYz1AtQhQ/IXysA
	I9ZnJhugQpImDsTwwpwNy0Gfevgitu6bd/3k1/HUProS8wQ9TfsCuNes8AG5R1o6P3eDdHQwphG55
	/hc46rjknaDHo3Akk5xaWNYWzFfF/FN/MhnXfYl9lgyDCmeeZ2QxsSkVJU25qnKqunzOuawasZPiW
	vsJEa5g2w6XEumxN0BmCiehK2MwS83EEy9AxVdHGjfKlPVk06IaxYo5gA5YaUdEkaPMCAjhxtwoZZ
	g7nTKliw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s92WK-0000000EVYf-1Wet;
	Mon, 20 May 2024 12:53:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s92WH-0000000EVYG-0G7m
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 12:53:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716209615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guKnOQaYcck3gIy9ZWMzFJIBFpiFj2ii6L3g585Cg7Y=;
	b=DJz3XyNwJmyXdnW376kjZfoQJVCI5T7u33XFXjqkGkV2vhaKC7WgD4AD/EkdfwXSykvRo0
	+q2vcs+RyFHcUUkgbkT+4hLdSHEJZstKOc3a4J5C/03CSj6tTwolXEKul33brWgg2KMUD3
	iBz0c6Ucx2k6BdZfXKXSUuQXr4Z5fiE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-GaszafM6P0WzLQz6Ql74_g-1; Mon, 20 May 2024 08:53:26 -0400
X-MC-Unique: GaszafM6P0WzLQz6Ql74_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A4898008A4;
	Mon, 20 May 2024 12:53:26 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 412C2200A35C;
	Mon, 20 May 2024 12:53:26 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 27DF630C1C33; Mon, 20 May 2024 12:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 24F9C3FB52;
	Mon, 20 May 2024 14:53:26 +0200 (CEST)
Date: Mon, 20 May 2024 14:53:26 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
Message-ID: <e9df49b3-f113-342-f1f-96ecce46c357@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_055337_192741_1CE8CC64 
X-CRM114-Status: GOOD (  14.78  )
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



On Wed, 15 May 2024, Jens Axboe wrote:

> On 5/15/24 7:28 AM, Mikulas Patocka wrote:
> > @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
> >  	return 0;
> >  }
> >  
> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> > -	return NULL;
> > +	BUG();
> >  }
> >  #endif /* CONFIG_BLK_DEV_INTEGRITY */
> >  #endif /* _LINUX_BLK_INTEGRITY_H */
> 
> Let's please not do that. If it's not used outside of
> CONFIG_BLK_DEV_INTEGRITY, it should just go away.
> 
> -- 
> Jens Axboe

It can't go away - it is guarded with blk_integrity_rq (which always 
returns 0 if compiled without CONFIG_BLK_DEV_INTEGRITY), so the compiler 
will optimize-out the calls to rq_integrity_vec. But we can't delete 
rq_integrity_vec, because the source code references it.

Should rq_integrity_vec return empty 'struct bio_vec' instead? Or should 
we add more CONFIG_BLK_DEV_INTEGRITY tests to disable the call locations?

Mikulas


