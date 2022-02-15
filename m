Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965DEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNXXSrPoGPJEDjqcbNsdzREIzKgOpDhpYBDle/OA5bY=; b=KRAOctejb5Ot7uTuo+zix2gTaX
	hqbSj1pIu0nyKUHBzbhlImyQjrMb2o3yhZ3imTiVckBwsOdtwTvyRqdmLMcJqZqIxDzGw9nFGAVeU
	dxNkKpikuyDnrk3DgoGfLr7D4Fs39v7yNyHjOW1Zp9Ph8vW9joPuciVjjQkkKTemVSY+wmKpre/CB
	4XTDzAEI58/2DiK562XxLjs6aOehq4eW806ZzpyfZf7c8blQm3lDUSsP0PXaViYEa1LFESGaCzS0C
	cUnbU74xbiRSPmGt7J6ttMtcT2BaKoEMO2UDoLRhiMSdY9a4uROwhICDUENTVEgMGMqu6ZTDJkryr
	rS+hvzDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK2r7-0049E7-G9; Tue, 15 Feb 2022 18:47:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK2qy-00498b-I3
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 18:47:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7931068AA6; Tue, 15 Feb 2022 19:47:04 +0100 (CET)
Date: Tue, 15 Feb 2022 19:47:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215184704.GB24543@lst.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215152240.GB1663897@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_104708_769651_57CA8395 
X-CRM114-Status: GOOD (  15.52  )
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

On Tue, Feb 15, 2022 at 07:22:40AM -0800, Keith Busch wrote:
> I can't actually tell if not checking the DYING flag check was
> intentional or not, since the comments in blk_queue_start_drain() say
> otherwise.
> 
> Christoph, do you know the intention here? Should __bio_queue_enter()
> check the queue DYING flag, or do you prefer drivers explicity set the
> disk state like this? It looks to me the queue flags should be checked
> since that's already tied to the freeze wait_queue_head_t.

It was intentional but maybe not fully thought out.  Do you remember why
we're doing the manual setting of the dying flag instead of just calling
del_gendisk early on in nvme?  Because calling del_gendisk is supposed
to be all that a tree needs to do.

