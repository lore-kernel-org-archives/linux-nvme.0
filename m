Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA34DEB64D7
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jun 2023 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:From:
	Content-Transfer-Encoding:Content-ID:Content-Type:MIME-Version:Subject:Cc:To:
	References:In-Reply-To:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccXraZTQ7XryyK5LpNAR74GJ0dtmJGkdhwIEf8RJTcI=; b=Mp4wyk6baV+n92NkdHwZPHXzHG
	p8FWWL9YECFhbSDELCvv6f/dDx45EVC6/OyrjYUXjCH5NuCjVryQT0Gb1gjPmUQYe2Iz2QwtxV/Sf
	6uge3aW0gE17LMqL0EiDwrVu4ZYHx/+z03Z4aRuqFxXXlPOficcmyJ1ZgSaqey5OZl7BMSgN00M8k
	BFY6PBg4UH5nQEK6zP7x/hb+SDfec/QFMN663vctimuwq9kxIdx8VXWVTBwbqgtjLqvIVHgYCaTnl
	4+1u16tHISSocmjy56SinPBimAgqLIMSmesrSaFgrYcdfCv46ukn00zlSUNnvWd9e3Tg2jzqpM8AT
	Nx9Wrwmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAwCt-006Nvf-0u;
	Sun, 18 Jun 2023 17:28:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAwCp-006NuC-2q
	for linux-nvme@lists.infradead.org;
	Sun, 18 Jun 2023 17:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687109329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccXraZTQ7XryyK5LpNAR74GJ0dtmJGkdhwIEf8RJTcI=;
	b=CESG1HZwOGn2jWOc35a3s0M5X2iQY9+tliAULQEC2qeniCuJTB3+G6BukyVa8+l3mjStlF
	c640Huv32WMGdwgOD4MRHbc3FjyYUi7XvZ3dJIiANrt7K4n8A2EXP6kCwkSulWgbetUvW9
	XD+APAK7Aqi1XARwtJ6KtL0RLxRtNvA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-QbA_4gTuPJSb27gVyaPZjw-1; Sun, 18 Jun 2023 13:28:44 -0400
X-MC-Unique: QbA_4gTuPJSb27gVyaPZjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D77563804A4C;
	Sun, 18 Jun 2023 17:28:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB45F40C20F5;
	Sun, 18 Jun 2023 17:28:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch>
References: <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch> <20230617121146.716077-1-dhowells@redhat.com> <20230617121146.716077-11-dhowells@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
    Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <754954.1687109273.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Sun, 18 Jun 2023 18:28:41 +0100
Message-ID: <755077.1687109321@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230618_102852_012295_B222CBD7 
X-CRM114-Status: GOOD (  17.64  )
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

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

>     struct bio_vec bvec;
>     struct msghdr msg =3D { .msg_flags =3D MSG_SPLICE_PAGES | ... };
> =

>     ..
> =

>     bvec_set_virt
>     iov_iter_bvec
>     sock_sendmsg
> =

> is a frequent pattern. Does it make sense to define a wrapper? Same for =
bvec_set_page.

I dunno.  I'm trying to move towards aggregating multiple pages in a bvec
before calling sendmsg if possible rather than doing it one page at a time=
,
but it's easier and more obvious in some places than others.

David


