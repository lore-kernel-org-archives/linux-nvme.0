Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D4BC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vvpK7KrH4Mt79vaYm9+D0FXPEXKw6ebDT8nG/5H1qg=; b=RBqoBzoYROTNE2hocu/H9xCbAu
	U0+I0XapR0F4c5uENC06hh/y7mhc1BgY8n/AivbKI+KSk2JaMUBFsld/AY8OXQ+GqDHRX9SQX7SjL
	BpGLOEcZ/z9C57Y9IkMeAGvOhYo31MKWeM6Ea8Fn0fJAURqNsakwPR3qIt7ZoZLBlB35yGF8+gXYC
	JS8/tlgYheaLn1BfKqpkUL6Lhtbk+zz1sP/wRAGbFXct1BQLfM3shZnQ5D39S2zLRx8m2tgRnZOOq
	DOwQ3X08SVFNLj82m8ZX0gfqp/FTPAB4+XuRnSvhYuqW6LUmNjih4sLN+DltrBNvKtdInUeAYorUp
	KE2eH3KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAXbr-007nAJ-0i;
	Tue, 05 Dec 2023 15:45:19 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAXbo-007n9U-2U
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 15:45:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5F605CE0B03;
	Tue,  5 Dec 2023 15:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1299C433C7;
	Tue,  5 Dec 2023 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701791113;
	bh=0Y2l+6X6yAzUwntjk32nri6/kEK8xQ9ERpsa5g3ublU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOllAY9qdJbBqLupXffhTZZMX0SZMUbRY4e1fkbgI0Lqyup8GE3P0tsEEJub86t+g
	 PBuu/6EZewsAPPHzyVcGD8DaHwTuFGZ2QZp2n2Jzq7I81MWQEx5xRRIn19prZvlwAM
	 42VHYYq0j8LAIJOMVfyWRiKhsWXqhWvAcg5cVMzMLrDCNmMb3vk7KM9eRXf4AWiE4d
	 r3tOk8SPsXnwd9iJYHFbNtGXFJm3GP8VgHu7pM90Kv/ZJwepcWpaFvPT09Jn4yjpIK
	 PCq3FaR/lepelX2IJx3ADAbvd3f2y3TYKn6Oqx8OD+vw6T2pXUXeyXQL646dMpnCU5
	 1oIhkddlEmJhg==
Date: Tue, 5 Dec 2023 08:45:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW9FhsBXdPlN6qrU@kbusch-mbp>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
 <ZW6jjiq9wXHm5d10@fedora>
 <ZW6nmR2ytIBApXE0@kbusch-mbp>
 <ZW60WPf/hmAUoxPv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW60WPf/hmAUoxPv@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_074517_019003_FEC63B0F 
X-CRM114-Status: GOOD (  24.28  )
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

On Tue, Dec 05, 2023 at 01:25:44PM +0800, Ming Lei wrote:
> On Mon, Dec 04, 2023 at 09:31:21PM -0700, Keith Busch wrote:
> > Good question. The "capable" check had always been first so even with
> > the relaxed permissions, it was still paying the price. I have changed
> > that order in commit staged here (not yet upstream):
> > 
> >   http://git.infradead.org/nvme.git/commitdiff/7be866b1cf0bf1dfa74480fe8097daeceda68622
> 
> With this change, I guess you shouldn't see the following big gap, right?

Correct.
 
> > Before: 970k IOPs
> > After: 1750k IOPs
 
> > Note that only prevents the costly capable() check if the inexpensive
> > checks could make a determination. That's still not solving the problem
> > long term since we aim for forward compatibility where we have no idea
> > which opcodes, admin identifications, or vendor specifics could be
> > deemed "safe" for non-root users in the future, so those conditions
> > would always fall back to the more expensive check that this patch was
> > trying to mitigate for admin processes.
> 
> Not sure I get the idea, it is related with nvme's permission model for
> user pt command, and:
> 
> 1) it should be always checked in entry of nvme user pt command
> 
> 2) only the following two types of commands require ADMIN, per commit
> 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
>     - any admin-cmd is not allowed
>     - vendor-specific and fabric commmand are not allowed
> 
> Can you provide more details why the expensive check can't be avoided for
> fast read/write user IO commands?

It's not necessarily about the read/write passthrough commands. It's for
commands we don't know about today. Do we want to revisit this problem
every time spec provides another operation? Are vendor unique solutions
not allowed to get high IOPs access?

Secondly, some people have rediscovered you can abuse this interface to
corrupt kernel memory, so there are considerations to restricting this
to CAP_SYS_ADMIN anyway, so there's no cheap check available today if we
have to go that route.

Lastly (and least important), there are a lot of checks happening in the
"quick" path that I am trying to replace with a single check. While each
invidividual check isn't too bad, they start to add up.

