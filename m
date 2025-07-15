Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A20AC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rtW7FstOSMrZ2c9NVo42LaQgHPXJpgqSxvz9Cl8TWFg=; b=QHUxZ7QMsd/KsXEiSKBotbElIA
	uCszPpDgRRN6+fj75W3O9thzsyUHYYXGedj6fAIMBno2VHXKXDx33jkxifOzru55pUoXQTJBIXLeq
	WwkGKn8yFKn/3vij1ig5m+dLUVLykbXrmTJ80BOPw1qbFj88/2Fh9BCjXf7yLORHPX4zXrYNoagwI
	EFc5+XptHCgVtUF8dcBoQC2RGcjJOhrOIpy8t6yHCTE79qUXFREK91r+HWUa6vf0xUfyBIp3OmOW4
	IvTJoE/AkJSprali1PjjOnxglV264kAkzrkaMH91dvWIpGXro10C6+EBKvsh3ZjSECBrXnzOy6Mh4
	QEmYIOgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ube69-00000004yUW-0kSm;
	Tue, 15 Jul 2025 11:45:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubdrG-00000004wgS-2N8q
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 11:30:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB097227AB3; Tue, 15 Jul 2025 13:29:52 +0200 (CEST)
Date: Tue, 15 Jul 2025 13:29:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715112952.GA23935@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <20250715-rundreise-resignieren-34550a8d92e3@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-rundreise-resignieren-34550a8d92e3@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_043002_751614_C63D6119 
X-CRM114-Status: GOOD (  21.08  )
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

On Tue, Jul 15, 2025 at 12:02:06PM +0200, Christian Brauner wrote:
> > I'm not sure a XFLAG is all that useful.  It's not really a per-file
> > persistent thing.  It's more of a mount option, or better persistent
> > mount-option attr like we did for autofsck.
> 
> If we were to make this a mount option it would be really really ugly.
> Either it is a filesystem specific mount option and then we have the
> problem that we're ending up with different mount option names
> per-filesystem.

Not that I'm arguing for a mount option (this should be sticky), but
we've had plenty of fs parsed mount options with common semantics.

> It feels like this is something that needs to be done on the block
> layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
> entry that allows to turn atomic writes on or off. That information
> would then also potentially available to the filesystem to e.g.,
> generate an info message during mount that hardware atomics are used or
> aren't used. Because ultimately the block layer is where the decision
> needs to be made.

The block layer just passes things through.

