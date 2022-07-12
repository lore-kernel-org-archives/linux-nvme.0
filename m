Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90396C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyODVdUHIxR/rNeN2DYy5LI+Hq5Bbkbyxr1e0BDZSjo=; b=rXdYB+atTxwU9YJqU4sYgQufIA
	QxEVImXOkaMW/A0rGsOyDTgHEq9fy8cTquxKJOzKDfTGJ6Bdo/tRbfH+yHhOn3GbIZrvtNBRHQRaC
	o0Td/QlrivJzL34S2y7i/vHCpDLJl80m++ihoeY+i/KkT0HdBaA+2r8unogJwsta7pQA1hbLaKD2f
	p3ZZf5kt1BhHvX8Ey6E4bvlpJvJVi3nhSut/fzMmaRgMtSVnnnAVE1cDgcF0uagZEzeP4lJakfpbc
	6YKhBtZhbogJ30gK3hAQqVn0oF5XZNeAo/t0ihYirkWdD63s+NY6RUtf1XPEAcTw55vMWvr1qwOnt
	MxudA5SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB9S9-0082S6-GE; Tue, 12 Jul 2022 06:33:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB9S6-0082Pc-M8
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 06:33:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A00468AA6; Tue, 12 Jul 2022 08:32:45 +0200 (CEST)
Date: Tue, 12 Jul 2022 08:32:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, asml.silence@gmail.com,
	joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH for-next 2/4] nvme: compact nvme_uring_cmd_pdu struct
Message-ID: <20220712063245.GA5908@lst.de>
References: <20220711110155.649153-1-joshi.k@samsung.com> <CGME20220711110812epcas5p33aa90b23aa62fb11722aa8195754becf@epcas5p3.samsung.com> <20220711110155.649153-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711110155.649153-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_233258_911100_3942A35A 
X-CRM114-Status: GOOD (  13.86  )
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

On Mon, Jul 11, 2022 at 04:31:53PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Mark this packed so that we can create bit more space in its container
> i.e. io_uring_cmd. This is in preparation to support multipathing on
> uring-passthrough.
> Move its definition to nvme.h as well.

I do not like this.  packed structures that contain pointers are
inherently dangerous as that will get us into unaligned accesses
very quickly.  I also do not think we should expose it any more widely
than absolutely required.

In fact if possible I'd really like to figure out how we can remove
this pdu concept entirely an just have a small number of well typed
field directly in the uring cmd.  This will involved some rework
of the passthrough I/O completions so that we can get at the
metadata biovecs and integrity data.

