Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69A9C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 04:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCXWaTK2cT20XJ2gH5tKnNoHz1rvmd5jnRMvdwguqmM=; b=PxsY4TYND6rC6QCfOXHN1hDQXK
	tjuNMemxpvGhtXiDnk5bLvKadc0irf7wZ5hI7SRCytCdslj9ZgugWi8mIwnPkvzv6AbMEwAAOjJWC
	xOLoFC/G5/ZkCGcowJc0H1HrLqIFK+pRoN2jxVig0c0UZ4ElMB9IkFZSjWJBcLEtNeE2gCW8KLCEM
	v9mgyxMWwi5vQ6weBX63/2GKPlbelX0BzfC0Vb6ue3hBIGbnv+g/qKiJvGIEjzf17rQN8NmNbNmzV
	alR9El+Xpj00UQznnOCFwMs/nK2tk4m/GXJHfQjEAHUcmRN6TrN1HkSCjJWzi/OT7seEjDCz/ZaF+
	M2E8+kMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAMpY-006CSP-34;
	Tue, 05 Dec 2023 04:14:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAMpW-006CRr-0L
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 04:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701749677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCXWaTK2cT20XJ2gH5tKnNoHz1rvmd5jnRMvdwguqmM=;
	b=g5NTyIbkCmRfGKTZAb6jboDO85HY0LiF3H/ay9JQX0b7erAAUCCpqRaAREFBud30bE57r3
	CMguK2AI6Nnd6ASER4YGKWvEilGOenetAJlf5uRZfZJUX/2dyHFbKT7RhSJHqYkcSDscym
	2l01mLiuS2/2J9Qd9d2m0BD1sdlCaCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-TNjQEJEQNHGBd5ntzJrjVA-1; Mon,
 04 Dec 2023 23:14:33 -0500
X-MC-Unique: TNjQEJEQNHGBd5ntzJrjVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E15F73C0BE2E;
	Tue,  5 Dec 2023 04:14:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2104C2166B27;
	Tue,  5 Dec 2023 04:14:26 +0000 (UTC)
Date: Tue, 5 Dec 2023 12:14:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW6jjiq9wXHm5d10@fedora>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4hM0H6pjbCpIg9@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_201442_241221_AD787096 
X-CRM114-Status: GOOD (  19.25  )
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

On Mon, Dec 04, 2023 at 11:57:55AM -0700, Keith Busch wrote:
> On Mon, Dec 04, 2023 at 01:40:58PM -0500, Jeff Moyer wrote:
> > I added a CC: linux-security-module@vger
> > Keith Busch <kbusch@meta.com> writes:
> > > From: Keith Busch <kbusch@kernel.org>
> > >
> > > The uring_cmd operation is often used for privileged actions, so drivers
> > > subscribing to this interface check capable() for each command. The
> > > capable() function is not fast path friendly for many kernel configs,
> > > and this can really harm performance. Stash the capable sys admin
> > > attribute in the io_uring context and set a new issue_flag for the
> > > uring_cmd interface.
> > 
> > I have a few questions.  What privileged actions are performance
> > sensitive? I would hope that anything requiring privileges would not
> > be in a fast path (but clearly that's not the case).
> 
> Protocol specifics that don't have a generic equivalent. For example,
> NVMe FDP is reachable only through the uring_cmd and ioctl interfaces,
> but you use it like normal reads and writes so has to be as fast as the
> generic interfaces.

But normal read/write pt command doesn't require ADMIN any more since 
commit 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands"),
why do you have to pay the cost of checking capable(CAP_SYS_ADMIN)?


Thanks, 
Ming


