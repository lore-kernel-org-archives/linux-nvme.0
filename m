Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8C1C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 06:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G347K8ch7DKtnnionzJYqI/mw+RIFh2ZHCKOcU9zB74=; b=EIfmYfJzsX+bqkWxgqCuud82ad
	LvLqsZYjjwEYg80otngEoHvWkDLPQFNHzszFjnkFKRULsU7g8sJX7EYw926fzyITQRJqqvA5xCXQW
	aItygt3dgoKn1Kilnfs5exPZUGC+S0I+4hmsVU9QJQ5lfcrbIKCmSrC0xqj2glzWWKYaTBkH61l3c
	UTralS8i6U4h12vFfATWMfAC6oNhw0OKyzkaofJcGaNCSQI2E628XhWe8NFwbA+4Z7w0fwL3TBFRy
	+PCC7XAxToKgRGpDkgVznlX5Qon0i5vti/I9/+zBeVf0hW7h0/TBThQ6ydi2xmMrjjeIMgtL8bpc3
	iGsOH1UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI9f-0000000C5MI-3JIP;
	Sat, 01 Jun 2024 06:23:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI9d-0000000C5LB-2lP6
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 06:23:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 876E668D1C; Sat,  1 Jun 2024 08:23:43 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:23:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH v20 11/12] null: Enable trace capability for null block
Message-ID: <20240601062343.GA6347@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2@epcas5p4.samsung.com> <20240520102033.9361-12-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-12-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_232349_949976_C2520DB4 
X-CRM114-Status: GOOD (  12.42  )
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

On Mon, May 20, 2024 at 03:50:24PM +0530, Nitesh Shetty wrote:
> This is a prep patch to enable copy trace capability.
> At present only zoned null_block is using trace, so we decoupled trace
> and zoned dependency to make it usable in null_blk driver also.

No need to mention the "prep patch", just state what you are doing.
Any this could just go out to Jens ASAP.


