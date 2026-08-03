Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFB9C55822
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2026 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVBgpTAPx0QaWF/iESlvF9lQKXld+lgSa5L4KQZMoqQ=; b=vB3plWI+iJ8mdQU0c7q0skEops
	v2T+uB8z3T99qUkWObTRvBX0K2p7c2ala+i/fDUcSigG5PpVYRKDYpRZ8Lk9DZ4y0d7/cWDKemF8D
	7ircr4hc7M+E5liEUWyd308tTjCI83Ld3hWWr9etXztfm+5pS7Qc9grAqgCRmNrYH9nKiSGuTyvZi
	9YYN/H3Xcd9XbGQ53nNlX8sZU0trxSCw6oZZk6VuQooGs9e+Ty54LxFWI/6YdvNLtVcHZaAZATgIF
	uSvccoOVzdpXhA8PF4Oj6F4ZwS4KgeEkc1avHNXg1z2UCPo4hKnVt3A1QsehOQKClk1IInms3rfzC
	nRtMjOJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqx4N-00000000KEx-43Xa;
	Mon, 03 Aug 2026 18:07:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqx4N-00000000KEl-0czI
	for linux-nvme@lists.infradead.org;
	Mon, 03 Aug 2026 18:07:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 90FEB42A05;
	Mon,  3 Aug 2026 18:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BB21F000E9;
	Mon,  3 Aug 2026 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780442;
	bh=RVBgpTAPx0QaWF/iESlvF9lQKXld+lgSa5L4KQZMoqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhLl/M/1qKiYFjOcU4GCcarv8EbNmI8hc6N95BUMpYPtFrQsc5Xc2aeGhVK/V3KVo
	 J3AjzdP89AumfqhOzwFGLEMjBVE8pPZwI920/xThkmFEKW6tZ9FFuMkq1K9dWR05dx
	 yPqNpUL0cVvsBFqLvJUAov6s7OUkYNtwOd9CXRbRPY63FZZo0Ktrj9EeZztApnj0f7
	 PFbH/vOCAXcts9j5XIjm6gvZmSYKUsZkgTN8lWGPykFNnqKoMOj5VlrO9FWmjYL0D4
	 hHj7M16cTiVPhIR9hXSvkR60cGb/EI/Rn7NEpv3QPkVaPozut5wjt4O+/K+14DdLZt
	 uDAOZ7/zAZizQ==
Date: Mon, 3 Aug 2026 08:07:19 -1000
From: Keith Busch <kbusch@kernel.org>
To: Daniel Colascione <dancol@dancol.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make sending wall-clock time to NVMe opt-in
Message-ID: <anDY10XMfeRmAiFN@kbusch-mbp>
References: <20260713203443.322748-1-dancol@dancol.org>
 <alVQCljd3a0dRRPw@kbusch-mbp>
 <87qzl6k3bx.fsf@dancol.org>
 <87ldaoh08v.fsf@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldaoh08v.fsf@dancol.org>
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

On Sun, Aug 02, 2026 at 01:59:28PM -0400, Daniel Colascione wrote:
> Daniel Colascione <dancol@dancol.org> writes:
> > I mostly care about having *some* knob to turn this off. Right now, it's
> > unconditional. I'm happy with either opt-in or opt-out, although I have
> > a weak preference for the former.
> 
> Ping. Is there anything I should be addressing in the patch? Thanks

The historic behavior is that the timestamp feature happens. Making an
option to change behavior usually leaves the historic behavior the
default so that anything using it isn't suddenly having to scramble to
restore what they had before.

