Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDA4C3DA61
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLVP/oteTjKSXUtfh4JxBxzHuZDDIhDUNaCuoQtNRBQ=; b=gD/sX3mhWweXPrO/7CI3DnSnuC
	sUfIKl2Y9kdg0eFsSL+ZN4D7u9SRFRzSZuwFOMnadnZ3p0mDFS4yqemUtAfv7p1GEuE2ONnFRvzQZ
	rnsVG4O0yETvIjqwagOIsz7VlLu4LatDEbVxQafaKJrZ7qR5Hu0LWOEqqlZCN8zcZHDRiRmYZ3aBC
	nYg3xyIsqSkjLMCIyOZLSr/8BXKIEHC+BMxkBqptsceHdNFUbQwDt8DvRzvvyqvgjKBBeDKz7y/sZ
	2RNmxBan7LAj5c3DXyag/aWpjwL5whDViSo4yt/SS/H5gQ8bZjcKYLKm00FiTeKjo5gEBBywaNY+z
	AKCz3KJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUWci-00000000SRD-0gUB;
	Thu, 18 Jul 2024 19:17:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUWcW-00000000SOh-0VQy
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 19:17:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DCC8F61BAF;
	Thu, 18 Jul 2024 19:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88087C116B1;
	Thu, 18 Jul 2024 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721330210;
	bh=eDCnd5H5vIf/+mrtWj8r2mfvUhJRojFzzzsC79M3Bj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDg/J4k2APxYP+ro8Pnfgy7hs7GKaW2wtSAqXOSw4O5310y6jqJUugqZKuKUsXdOj
	 IuOPYvi1rkIaSOfmm4a2kNK9qmVex+vzA9MGp13UrF6BzynjJe3r/W7rXFd4y+xk7u
	 6nlh8bM9tkHBAUXQxpiNPVNs51otEBhQuXs+2fzZWSWtQeL32FrMiY0XnGVS1q9da0
	 5il/HpMZrkndiL98dMP7JnPCMdkoALw+4KDZ6i0VddHgLozOQSi3RjmmuWjgj2RYlD
	 uMEG+i92m27Odlyc8bv087y8e7h+xPdqA0FYsA0QiD9nmo7X0y0pVQD7zXnEYeoIkF
	 jhBEA9jVw5LAw==
Date: Thu, 18 Jul 2024 13:16:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <ZplqH6uNn4IvULMS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <64ec91e8-4ff2-4c56-a468-c194f803db6b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64ec91e8-4ff2-4c56-a468-c194f803db6b@t-8ch.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_121652_245010_7240F634 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jul 17, 2024 at 11:16:19PM +0200, Thomas Weißschuh wrote:
> On 2024-07-17 13:55:50+0000, Stuart Hayes wrote:
> > +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> > +{
> > +	struct async_scan_info *scan_info = data;
> > +	int idx;
> > +	u32 nsid;
> > +
> > +	idx = (u32)atomic_fetch_add(1, &scan_info->next_nsid);
> 
> atomic_fetch_inc() ?

Good call. Also, that returns an int, and 'idx' is an int too, so the
(u32) cast inbetween is unnecessary. The highest 'next_nsid' could
possibly be anyway is 1023, so int is fine.

