Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0F5C43219
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kj1iOpz2/JDfzuW9bhsBO+rW/3gQn7pkVAvESiZ4F1k=; b=SF//dc058/m+osU/y5alvsqOd1
	XDEzQpaYrjTYdAKVeJeT7n5XdPPBqGEWtQpz6NanU5ZOUwsBUdgr3lncRmIbcL48sY4SeaGjYiZxc
	RHGK5zBjjeAtvaWfXx+HvOJaFG5B5I46JkuK0bYcfm6PgdpUfQjC20MJXMzcFPiGjBQNa+BKGV4YL
	jUbLmH7bt74c7oKz2qV86ZQk/v10nFQCh3IYQMGQWKqup5tVHvQpJ7ifw7A+lB5WPgQkV1nHZqOC5
	scghNYkGIY/+2UKnw6iXXyX8avmtN0xnooRAJOjpkYVZTCioUn1Xh7fuTrNhzibIaRhdotGvhTANW
	+LJjV8rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq9WB-009FsB-GJ; Wed, 02 Nov 2022 08:54:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq9W9-009Fq9-3b
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 08:54:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6320467373; Wed,  2 Nov 2022 09:54:33 +0100 (CET)
Date: Wed, 2 Nov 2022 09:54:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/6] nvme-auth: use xarray instead of linked list
Message-ID: <20221102085433.GA14462@lst.de>
References: <20221102075224.70869-1-hare@suse.de> <20221102075224.70869-4-hare@suse.de> <20221102080319.GB10816@lst.de> <c1e10a5e-eab1-c49c-4377-54a94457df5e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1e10a5e-eab1-c49c-4377-54a94457df5e@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_015437_315348_9DC5F72D 
X-CRM114-Status: GOOD (  18.74  )
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

On Wed, Nov 02, 2022 at 09:52:24AM +0100, Hannes Reinecke wrote:
> The control flow.
> Entries are only deallocated in nvme_auth_free(), which is called from 
> nvme_free_ctrl().
> By that time all processing has stopped, all workqueue entries are flushed, 
> and no further commands are accepted.
> Entries are allocated from two call sites; one via ops->create_ctrl(), and 
> the other one via the workqueue function nvme_dhchap_auth_work().
> 'create_ctrl' is synchronous, so the controller will only be deallocated on 
> the final put() of the create_ctrl() control flow. So we should be good 
> there.
> The workqueue function is flushed during nvme_free_ctrl(), so we're good 
> there, too.
>
> Hence I felt additional protection is not required.
> Do correct me if I'm wrong.

I'm not up to speed on the auth code.  But something like this
needs to be clearly documented in the commit log, and preferably
in the code as well.

