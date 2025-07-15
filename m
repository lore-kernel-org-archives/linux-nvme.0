Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D7C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0wqt7wBTeOckA4f1B3zE0rpBjhHmptT9HlxUnx1t5w=; b=KUw151kyiPFSiWONGI0XRA7IMA
	6W9fA+P/beVvfcMTMPtrenU88t0C4D5lU+p12n7RzvOkQj4voTVJ30LcNKlBCkTj68j0uqqq2KrSA
	kXQ+yEASEklx/hy7Q5lwrd1QcUrddULelr8kxsNd4sOSjdn+qj727Ta57bp3PE2ZSLDcjINMcB3X5
	hzNUzDBO6BQgyGP5HSGE+1Aszq10CyznEtZ+L+gJAWWBynndZajma3r2IbvbnZDcj8IG0+F6+0uvP
	tEU+8DKq1MPXj6Wbs8P4FlZnHX0o43M9P2d26vV+hV9yQHDWNc859al/RxSQJw3CPDfrogJfgTH+2
	N4hHgT2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubcZL-00000004nPk-20QP;
	Tue, 15 Jul 2025 10:07:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubcUF-00000004mld-3Qmr
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 10:02:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 40B9561140;
	Tue, 15 Jul 2025 10:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223DC4CEE3;
	Tue, 15 Jul 2025 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752573730;
	bh=SOfcU+iTyg8H0Sg4mB6xITzhMhY8+TF6KRQHztAOU9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpKqz9sHm/8RPY1NnA7PM38L2AwywOS8Ht3k9v+hLM7o7fePXsi0FMK3HPHRqxYMz
	 9RrhUH5yI07atCTRlirLbOzr/LUQIbpaisoyMXlbzkZ6ZdHE/5kZi1yMzUCmlky6k8
	 qfosfeEgVQEl2IvSrtTZAbENnul6w+fqmFrs238KwuqG8VXeauoBrLk2/GxWgQloFB
	 ttfOykGyKXnIyQHnIbgf9ZtWbSLgEZkDlmalj5LqtWuiCvotMvGHLu7kyjpiIg9+NI
	 iZy5AIkMpIHzJRGuci0jc4OiemW+6haUQdgZ/8QXNAGqeJkR6rEiNxKJ5lRxRLTpYM
	 hVQO3ctrWenIw==
Date: Tue, 15 Jul 2025 12:02:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715-rundreise-resignieren-34550a8d92e3@brauner>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715060247.GC18349@lst.de>
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

On Tue, Jul 15, 2025 at 08:02:47AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 04:53:49PM +0100, John Garry wrote:
> > I see. I figure that something like a FS_XFLAG could be used for that. But 
> > we should still protect bdev fops users as well.
> 
> I'm not sure a XFLAG is all that useful.  It's not really a per-file
> persistent thing.  It's more of a mount option, or better persistent
> mount-option attr like we did for autofsck.

If we were to make this a mount option it would be really really ugly.
Either it is a filesystem specific mount option and then we have the
problem that we're ending up with different mount option names
per-filesystem.

And for a VFS generic mount option this is way too specific. It would
be extremely misplaced if we start accumulating hardware opt-out/opt-in
mount options on the VFS layer.

It feels like this is something that needs to be done on the block
layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
entry that allows to turn atomic writes on or off. That information
would then also potentially available to the filesystem to e.g.,
generate an info message during mount that hardware atomics are used or
aren't used. Because ultimately the block layer is where the decision
needs to be made.

