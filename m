Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060CBC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkZKKOE9n47WldW6B5NecvYoxPfEPs2aOPOG71cpu7M=; b=HpfVYdHwKoaw+g5ZvYrcWL8U44
	EDJg+NLV2p9hgwD+SJi2Dt2eBocGqc4GR2Z7UNTvL4oYf4QgAbbSW32uUshqVXvcRFKHcaY9hboVY
	KdMXranYJYR+2BlvD58WQsi7t2s/xK1N6/nWC7XOqy+Vuyhio6bQNb9vKpIXj544fkbkh1HwF+Snl
	5AOpfKOkarBorv6waTlxwly6i+Y975CwVPMq3ndzTcGCmt59BrI1tN3BfFCNmeH9NBWCNNbwyXuM7
	iGLS90YvYVCUXnSnl2yByvUNd15KHc1EgEI3WpIIcsydHjRk4YIwU7UZEYjRVTVaaMv74IFYjpDyJ
	vEnVxAFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLrFs-000FKP-2D;
	Fri, 05 Jan 2024 20:57:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLrFp-000FJx-07
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 20:57:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2FF7FCE1DEF;
	Fri,  5 Jan 2024 20:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30E8C433C7;
	Fri,  5 Jan 2024 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704488238;
	bh=gAD8bxOLE5Ams9cdsSGbh8+d7ypMq1jhYSonntHU1zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLbb29Hh0929kqeCl2us54wEX8aRCCWeYJqib0/xcASz3L+bpsRSinR8COEBw76gr
	 PC76G6WeAGQFq9piiWdgkvZTmr6p6saVUSHOoxfyNfTZW6IqN/wvf2wscJKKJwIM/F
	 BsdhUGRz0yIgEKMjEfQwJ683TZPDzGlnbRZrCYHxhQNu3gx5k1YYCPKmPiLZqaLLBC
	 MsV7LJdibxxGn1gKJQFbJNN8LXk7/Cew/qVKq0H3lyAA4ghJII+qPigKEx8BDvfSpd
	 cUKv354IHzPHkIc93FxMYMeZCW3mqYdyZZV1GaCduy1LYje7aLY5U5pMFkqT0f1rqe
	 xqxtCiMMsKNdg==
Date: Fri, 5 Jan 2024 13:57:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Message-ID: <ZZhtK6vjk5UD7pxi@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <ZZhli2FWXwP1XSRG@kbusch-mbp>
 <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_125721_270155_C521FBDD 
X-CRM114-Status: GOOD (  16.23  )
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

On Fri, Jan 05, 2024 at 09:36:38PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 5, 2024, at 21:24, Keith Busch wrote:
> > On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
> >> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
> >>  		return;
> >>  	}
> >>  
> >> -	strncpy(name, req->ns->device_path,
> >> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> >> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
> >>  }
> >
> > I like this one, however Daniel has a different fix for this already
> > staged in nvme-6.8:
> >
> >  
> > https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3
> 
> +       snprintf(name,
> +                min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
> +                "%s", req->ns->device_path);
> 
> Don't we still need the zero-padding here to avoid leaking
> kernel data to userspace?

I'm not sure. This potentially leaves trace buffer memory uninitialized
after the string, but isn't the trace buffer user accessible when it was
initially allocated?

For correctness, though, yes, I think you're right so I may just back
out this one and replace with yours since we haven't sent a recent 6.8
pull request yet.

