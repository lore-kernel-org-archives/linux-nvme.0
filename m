Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C16C5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 00:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoRjtfqDYasI1Rj/OxHe/CkU7sDiOoID0tyV4HOchxQ=; b=pWzPDshv3SbGWO0Uxsgob6u07w
	DB7cI6MSsR9a470I3sHtXn/5F6Vpr0gL4PUxG68xLftEcOox04hQhawIAip41z16PeK3Cot+6OX6i
	lOnqIDOe4l9AoR2wKD6eCF7esC9FZkY3miZwSgPtUWucxx90rAdI5Y3XjQ17ZMydAfrZQZZK8Hglb
	6EcQXPZg7UNJg6r5KjdQh2Xvr/9XdnD/9KUgPCkuRLrvFdeaJVnTp6IeKibLU42o6KnntfSXckn8e
	XSXYKrW+O0n2o27tKr7uhnKO4mPAwpPeCOUWQXlDtvCqX37jrqTCbGOfOmU6zbpeI4eOwEMl5frtA
	CPFAoj4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfQW-0000000HaEU-3yUT;
	Tue, 25 Aug 2026 00:54:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfQT-0000000HaEM-3qJr
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 00:54:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ECD1741692;
	Tue, 25 Aug 2026 00:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9711F000E9;
	Tue, 25 Aug 2026 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619243;
	bh=DoRjtfqDYasI1Rj/OxHe/CkU7sDiOoID0tyV4HOchxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1y8xfgqqk1mkjZ5HxVS4hMkg/mabEwXB5KEkYmrryvmLpbQhwByDZ0/y6wmoQIjj
	 lz70aMgmr/Xt/9WbwPNqw0tOeSS+TookcaJn+dLxG9Fa10IWoReNll3jfZAlz5C3ez
	 K+SczZV3a4kHJsP0BVIijg2mPAt8qgOxfHZ0AHBxMsE1reFJa3ZUuAZrYd8/dNN85s
	 gDPlfcGd845ymPvM5vMEKW7A+BoAl3jbgbjgVHgTTw9v9ZEgiQliep2Ppmu8S31AdJ
	 er7JaqOcjX/jtVFEqcuDepaW5vXPptnOPIzQibeKvykhjOPj0P5ZbDXOAg+VkROxfF
	 vFfxA4H3Tsz4Q==
Date: Mon, 24 Aug 2026 18:54:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander <csander@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] nvme: add missing SRCU grace period in error path
Message-ID: <aoznqfUpR3t-GpgE@kbusch-mbp>
References: <20260815001427.3148050-1-tristmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815001427.3148050-1-tristmd@gmail.com>
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

On Sat, Aug 15, 2026 at 12:14:27AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> nvme_alloc_ns() error path at out_unlink_ns removes ns from the
> namespace head siblings list with list_del_rcu(&ns->siblings) but
> does not wait for SRCU readers before freeing the namespace struct.
> Multipath code iterates the head->list under srcu_read_lock() in
> nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
> reader can still hold a reference to ns when kfree(ns) runs.
> 
> The normal removal path in nvme_ns_remove() correctly calls
> synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
> in-progress readers. Add the same grace period in the error path.

Thanks, applied to nvme-7.3.

