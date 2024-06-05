Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D367C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dN0PkdKFOlVgXYg+yfnjvKHUUq2vSP7/QUgMWYomfk=; b=Pss7AYzpj2s6GUjmYWn5VDnXFz
	evEz/kvkL/qocrLS3MsfNKqPipnUsoEL5fKltNiCfYDZyvWVNDiWYrPmqdnwr5vQfJaah+qb1iVNj
	4EX8rNTzLKTDeGgdm+/f/H64BX6k7CzhzSyuZGJdmE0TMMRJHSQej+2gJX9bF+BrX2XzdF8xK3uYf
	W84TiuEeIv0YTqZMeaDxIGrfnh6Y4eZY8RGJdEeerW132hRL9rCU409UDFi2lqcPF0bPEO4tbHV1K
	fQENjjNINjagvhgsKa+TBZfgVvWHJwEfJuh2CjOqYaoZfPbQH+CMcsEui7nW0xyyb6L9wxDIaaH76
	tryuiLHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElmj-000000057vb-2FQ2;
	Wed, 05 Jun 2024 08:14:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElmg-000000057uU-3wNL
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:14:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14B8567373; Wed,  5 Jun 2024 10:14:08 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:14:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Message-ID: <20240605081407.GA18688@lst.de>
References: <20240604043242.GC28886@lst.de> <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de> <5441b256-494a-4344-89fd-ee8c5a073f8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5441b256-494a-4344-89fd-ee8c5a073f8b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_011415_141558_DA954842 
X-CRM114-Status: GOOD (  12.25  )
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

On Tue, Jun 04, 2024 at 04:39:25PM +0900, Damien Le Moal wrote:
> > But I wasn't aware that this approach is limited to copying within a 
> > single block devices; that would be quite pointless indeed.
> 
> Not pointless for any FS doing CoW+Rebalancing of block groups (e.g. btrfs) and
> of course GC for FSes on zoned devices. But for this use case, an API allowing
> multiple sources and one destination would be better.

Yes.

