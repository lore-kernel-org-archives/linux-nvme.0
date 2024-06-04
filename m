Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0159C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dW8kDUiWv1a4BNKFcv8PNWV+19665yDTaUr8bUH+HN0=; b=BvB5ijv2syw1I8wfGHKz1yJlu6
	kzx4zkIw6MeKCtufsQY3mvLK+eov6t98uqVRYhV82uKuejwMDas2eyHy5Ww/MlML97r1BZiNFmc0+
	47jyAeHFl0hFgOINmRuUh3aXgBCrA7CjvygWdM3hYdbE3ztDBAIVBb0krN20YdCW7mmFKvIj4MdWp
	+Y1Y7+EsBC1J/9QobGArafHsgOkz9qMmsZFP29OFsom60GiwKnn02loRvCjDkDBYu6JsHnjt24MkI
	/GQF2Dp9eRYyk+63LdWmqZCj3peGhgx9NalmMPjWJAQcXOe5euaOmiNOJ8FvFijAqu9QLqvkqxrc/
	1AEPxAKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEsVR-00000006bcj-0R84;
	Wed, 05 Jun 2024 15:24:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELqn-00000001BYk-2YDa
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:32:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3F6168D12; Tue,  4 Jun 2024 06:32:42 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:32:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Message-ID: <20240604043242.GC28886@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_213245_888486_B1BE21E5 
X-CRM114-Status: GOOD (  14.97  )
X-Mailman-Approved-At: Wed, 05 Jun 2024 08:24:51 -0700
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

On Mon, Jun 03, 2024 at 10:53:39AM +0000, Nitesh Shetty wrote:
> The major benefit of this copy-offload/emulation framework is
> observed in fabrics setup, for copy workloads across the network.
> The host will send offload command over the network and actual copy
> can be achieved using emulation on the target (hence patch 4).
> This results in higher performance and lower network consumption,
> as compared to read and write travelling across the network.
> With this design of copy-offload/emulation we are able to see the
> following improvements as compared to userspace read + write on a
> NVMeOF TCP setup:

What is the use case of this?   What workloads does raw copies a lot
of data inside a single block device?


