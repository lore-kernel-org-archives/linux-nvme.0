Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82342CA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VW8ObY5diPHeDgTcUElWbMlWvmJezpLSHhFo8otRJ+U=; b=ORV8wSauatocFTMUNcwE0RY6D6
	XeiWXgNyuwJsDetVs4bawIXZi5KVQBKf+k1hNumrGhL1n4jlKm90AWVljosd5Rj5R/zuoFMYwqbmw
	D3EzWr5YGLP6pqbxzmQEHC0u1sQTnj4zhSgWjhX5Z6YdApjUEpFOEH5kNYN3uu8hqscyVOHS/5l8L
	6AOXaMNQjauIqrC3fnP2uluBGmKggiWgACMIHtq35pO7DjG44n27+WKFSBbU/rE5use6HWl+1GGfY
	+EgFm4RXoEjoqfViaco3k3BVBI+6bn2EOk2yHGpmPjEdmbmcSMQD+smB1kmbHYgLOtbV896wt1uzM
	KoAH/WbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kSr-0000000B9pa-0OXA;
	Mon, 22 Sep 2025 17:36:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kSn-0000000B9oX-1sQt
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:36:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D94E0227AAF; Mon, 22 Sep 2025 19:36:29 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:36:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 1/1] nvmet: add safety check for subsys lock
Message-ID: <20250922173629.GA14701@lst.de>
References: <20250921124405.30432-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921124405.30432-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_103633_631171_E4090E12 
X-CRM114-Status: GOOD (  12.78  )
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

On Sun, Sep 21, 2025 at 03:44:05PM +0300, Max Gurtovoy wrote:
> Replace comment about required lock with a lockdep_assert_held()
> check in the following functions:
>  - nvmet_p2pmem_ns_add_p2p()
>  - nvmet_setup_p2p_ns_map()
>  - nvmet_release_p2p_ns_map()
> 
> This ensures the subsystem lock is held at runtime.

Only if you enabled lockdep :)

But this still looks useful, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


