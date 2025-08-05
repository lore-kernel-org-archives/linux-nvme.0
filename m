Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6899C87FD1
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 20:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnVkz1tRq5ryBcA63zdBB9QFXgdqvRSitXM7g7aHXsA=; b=nDCftbNY74WEXhwTxuycj0CJwt
	XNzPHGqWt3Me7yB1PAfio+BppskeY7pIDV4JMrVltuZxpAHjddjZXPtnOQ7rEONPHcBg86l2jC/83
	RPyYGukJbhT1kmyE2+pVHTks1KZo2/2MZNlFaDJh6T+3Blcdpg+N/hKt0KzzIVcF1ygrTbvSb4Kbh
	heTcCBIJBNFU+JJU8jwqd4q/oXqOsr6LnPdMKIDUmafaPlkHNfrA/wFqmHdn3rYS0UJQE9+CuPD1X
	uMmWWAkfkgane1D6XXPXNmSRkyn92rUQaZFVDP6yqjJoVQSjrwQ0WsWNvznvZZ5p1xHTCIuhI4yQp
	j2JOAckg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujOe3-0000000DmV6-0muP;
	Tue, 05 Aug 2025 20:52:27 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujOe0-0000000DmUh-3HyJ
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 20:52:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CB687A56794;
	Tue,  5 Aug 2025 20:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB0C4CEF0;
	Tue,  5 Aug 2025 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754427143;
	bh=9rX8zWbrBvapgXZlzmK8Wkfw1bZZ/pmiNIsbxNBaX50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/98kjdUJOd+z4CW63KVXost5ludFicYpgYa+23dSVwC0oC8UNV+eD4ZieU2c9V3U
	 Wn7G2Ewzq4lXNZ+E6yNiGph4BDhY3ZHsEGqAq3gsu++EFNLBGQr+HUfuhk3BSls5y1
	 NE4XPgNHnctLwhTlJuR7zGj1pCcnxCmoWQjFBNw4h5gDLfNXj3W5iN9hjhxcl71vv/
	 pZVAyE3cLTQoMednZlrqJz9UzBtyHXxKI/Vlez5sY7QUPQlbThJo/cvNUbwG759tNf
	 WH6onf/AoceWV59ZOqU69Yc/RXSklIM/98SATGpg3x3usTtgxiArX/a/I9tgNuVjXL
	 Vnm3lNJaDMGRw==
Date: Tue, 5 Aug 2025 14:52:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJJvBPg1t-JQAXh6@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <CADUfDZpv0e_wZ-RPn56rqm6Tz7YvZrwiKK+F8iW8jXYO4puMZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpv0e_wZ-RPn56rqm6Tz7YvZrwiKK+F8iW8jXYO4puMZw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_135224_894685_904F2C05 
X-CRM114-Status: GOOD (  10.37  )
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

On Tue, Aug 05, 2025 at 04:32:22PM -0400, Caleb Sander Mateos wrote:
> On Tue, Aug 5, 2025 at 3:59 PM Keith Busch <kbusch@meta.com> wrote:
> >
> > +#define bv_seg_gap(bv, bvprv) \
> > +       bv.bv_offset | ((bvprv.bv_offset + bvprv.bv_len) & (PAGE_SIZE - 1));
> 
> Extra semicolon and missing parentheses around inputs and output. Is
> there a reason not to make this a static inline function rather than a
> macro?

Using onstack bio_vec's made sense to manipulate with macros rather than
functions. But I suppose a static inline function won't push copies on
the stack either, so sure, I can change it.

