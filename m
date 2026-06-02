Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D48CCD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5bGGCKK0SAG7oNONyGiKu3RuVwA8SILABzID+g2CFI=; b=eXL6P3eXljba4yzKorj0241N9/
	I5X9nHHk6K/FECNXYKbD0wJMhOuqwCbs9U0qHJr2w0RXtPKKcrJF0DM6VZjAwfeR8fZEFvM97mPd9
	7iWTERSegFbnWv5vdzX+QZbExFy7gfL2Cfqd81E+lCz3Qat6d4zeuDK5Tae2KTP2MtRt1e4B4lnMP
	28WjvTRQPTvgNlgsCYuQS0ACmlZkDVdOdPqwQXCNwQ43nq/9iZAAgiQHqCSY9xlM6uY9exBEwmFjo
	Z+Blbg8DTku+4FBww+9NQOy+Hx+0d1kIM3lIHZvklCzNVLmhDe+UfXXNBPK3R5VOhjvPR5+fgx6yH
	P5X7u1rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKvr-0000000Cbvl-1hvB;
	Tue, 02 Jun 2026 08:57:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKvp-0000000CbvT-1apf
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 08:57:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 703BC60098;
	Tue,  2 Jun 2026 08:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED1F1F00893;
	Tue,  2 Jun 2026 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390624;
	bh=A5bGGCKK0SAG7oNONyGiKu3RuVwA8SILABzID+g2CFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OmxNfAfA00B6RVFNvLgpFOqPKzP6U+GtC+yXcVjuPtix7FcJPA94F9L4W6PtmM8C7
	 ocZT6q9BPqkDwNquiCPvtxvHzzrVf+DvnflPPERBMULLWV6ZKXHmoowq7N6DdtisoC
	 F8M4oVYrq/RXtQux+gao72ic7+4SyMvXs5b+CsggptZqXtxVbKLrbtrugYwWmYP+Mb
	 VMa/eA30uTyEc1Tl4VKTRHSZSbCbYxpWoY2azOxXCl2prNZVdY9BMpkWFwlDbdNUtz
	 U189FYwq2/X26IrZJJ5skYiDj2jyGa21AUDDPVA+B3x+msffNqaBTB9Poam9wFFGWX
	 25MYhuJva4z7Q==
Date: Tue, 2 Jun 2026 09:56:58 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <ah6a2mdIfZ-aId8r@kbusch-mbp>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
 <ah6ZXmX1anVLrr76@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6ZXmX1anVLrr76@kbusch-mbp>
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

On Tue, Jun 02, 2026 at 09:50:38AM +0100, Keith Busch wrote:
> On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
> >   @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
> >                     __func__, ctrl->cntlid, req->sq->qid,
> >                     data->hl, data->cvalid, dhvlen);
> > 
> >   +        /* Confirm the transferred length actually contains the
> >   +         * rval payload the message body advertises. The host
> >   +         * response is hl bytes; with cvalid set, hl more bytes
> >   +         * of challenge follow; with dhvlen set, dhvlen more
> >   +         * bytes of DH value follow.
> >   +         */
> >   +        if (tl < sizeof(*data) + data->hl +
> >   +                 (data->cvalid ? data->hl : 0) + dhvlen)
> >   +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> >   +
> 
> I think the fix should change the ternary condition from data->cvalid to
> (data->cvalid || dhvlen):
> 
>   if (tl < sizeof(*data) + data->hl +
>            ((data->cvalid || dhvlen) ? data->hl : 0) + dhvlen)
>           return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> 
> But this is a bit of an eye-sore, so let's make this easier to read by
> lifting the ternary computation outside the 'if' section and store the
> result in a temporary variable.

Oh wait, this is also a duplicate report:

https://lore.kernel.org/linux-nvme/f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev/

