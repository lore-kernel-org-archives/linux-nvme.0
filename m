Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E85CEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 05:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rV91KEll3rsmMiigjOO6hwThmuNYXZveP8u4gFdNpIM=; b=3kB6Uww9VNAqvCN1Il1TYz/k52
	ZF+LNb1dKUVgBmHRNtSYa28DSOOgnkjMKwIzOJazEU1MsIU88RxsyEUEeffT1Fp4ST5AxOwChr6Fc
	PBjsMSvuwm/zquTA+sQVPQVkrMPywv3liSd0GQIOf4Pe4XmFNTzJJI66qIYYMteSnNeNObnamtp92
	QwRa5qMUz1Lx2xvz/PZyV8hOcXBPwhntcXjXglr5xOnwmS1lLV8M+wFefv/Bk4fMLm1g0jcEspx74
	UOOeFFCBSFQLvki0YahWrBeWREItxyp/x/4bPp8jr2ImV9xMTf6HL9KHBhGMCWzwCSo2Xnnx7z6Uc
	mw8lxlOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKrRZ-0000000FRT2-3lR5;
	Mon, 17 Nov 2025 05:06:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKrRV-0000000FRSX-1sdJ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 05:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763355978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV91KEll3rsmMiigjOO6hwThmuNYXZveP8u4gFdNpIM=;
	b=M7rgTjl4isPl0pSvDRKYmVTg6VdenM2FxdKKWiCwvIahNDCo0YwIu3h713b6/OZ41XtjcN
	yubNHqSDs61vwLIHKUXRKFrwUWfJ3FeWeS/jdsEOGfobeDwzM0sdDgGyqKgDxrwhrHTCDC
	5id4R6lzTwldD56IyusNKiQvdPH26XY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-5X5tglTtMDqR0qvbQELObA-1; Mon,
 17 Nov 2025 00:06:16 -0500
X-MC-Unique: 5X5tglTtMDqR0qvbQELObA-1
X-Mimecast-MFC-AGG-ID: 5X5tglTtMDqR0qvbQELObA_1763355975
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DEB7195608D;
	Mon, 17 Nov 2025 05:06:14 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.89.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AC773002D0D;
	Mon, 17 Nov 2025 05:06:13 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id 4D1BAC37C3; Mon, 17 Nov 2025 00:06:12 -0500 (EST)
Date: Mon, 17 Nov 2025 00:06:12 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <ffe6b5c2-0657-441c-be10-b44435c5ec0e@work>
References: <21255200-a271-4fa0-b099-97755c8acd4c@work>
 <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <1529dc0e-bc1f-4672-98d8-f9ccfe5c1fb7@work>
 <CAGtn9r=n024waWZekDMwSRAM+JM13FYWhXjPuA18WyO6Kcmnyw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGtn9r=n024waWZekDMwSRAM+JM13FYWhXjPuA18WyO6Kcmnyw@mail.gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PkBt3qJqfydO07Sx0S0VWaGvEpcXH90B7P0_rDQWM7s_1763355975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_210621_557146_7DB9F2C4 
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

On Sun, Nov 16, 2025 at 04:51:30PM -0500, Ewan Milne wrote:
> Try running the test with the kernel parameter "slub_debug=FZPU" and see if
> you get
> a more consistent failure.  This will poison the memory with a specific
> pattern when
> the kfree() frees the object, a subsequent list debug message or stack
> trace with
> registers may show the pattern.

Will do.

> I suspect it is just very sensitive to the timing.

It is. Was trying to manually poison (memset + not freeing) with
different patterns and it was enough to not be able to reproduce
anymore. Will try the parameter anyway.

> My point was that doing a cancel_work() will prevent freeing the object
> with a work
> item queued, but if there is something on the associated list it would I
> think result in a
> memory leak (and possibly the DMA mapping, I'll need to look at it more
> closely).
> 
> The fix is valuable in any case.

Thanks

-- 
Aristeu


