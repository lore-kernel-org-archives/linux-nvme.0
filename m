Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A26C41513
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 05:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QB/QY3IZEAJCnuV8VPwHDzUxBys4xUty8xpNZlp5G+E=; b=gBpWnX7EYF5nMdf9XKLRmqWlLG
	4n2C5TOYUyuipHX3DzmkN/0JdiqjpUWxWT9ThIrthugq1b9Dev+uNvcmTGBlS5HWQZg3cyfWsXwN3
	71cuCBJRJKNEQRh7xWEpS2gGGjmAl8FC9gqMXydoxStqlZc8yzvi5rQAqqYeWmlKMHauyMOBvXgwt
	z4ejaFiCmp3rNMCBzAYw484jxWcyjmprD8I/VXxql1xej010O6eFgpyCxgYVYjYsLJyaHyAtJFqgR
	oqiLn9nb0ZVDHEJvGUd856R8Eum3qYFHnnsRjENY+yUlRUzWLzyq5OTq3dOAcN51qzMyVNuNujgkE
	//3c+g9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLyIn-00000001csA-3b0L;
	Tue, 25 Jun 2024 05:01:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLnB2-000000002js-1mEB;
	Mon, 24 Jun 2024 17:08:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5EF2B60E16;
	Mon, 24 Jun 2024 17:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682D2C2BBFC;
	Mon, 24 Jun 2024 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719248903;
	bh=c5IMwi2AkSm61J7nCdd2EBXV6o3vo+7AANeGa2JN45A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8C/s3NgDhBmDzX7X6Z3a8NgLG1XRNWm3AVon41eJewAqY4XNmD50+AdQpjukysaA
	 0+c9peZEcs8AURzleAxgVmV3zaxrAP0+WMQxnkR3oNoVdRegLrw7QTozLmVentUZPE
	 P0BMSL1dkoExQoFoaBFFudfcpEmdYCHeKJ0irUoLxUFwgxCKTvfHLKHNHL2RN4iLoh
	 ki4NFa+liGK52kKToNiMhO53pIJVSGFwHndW7Uw+1UTH4eb3kjlEU/UFxvZz4PM4y3
	 BbdO/dVn76ts+09ZmrGp9NorxeNYJ2cNYzLcTNejNMPSMmam7/bl5ZZAKhBMTTCFIl
	 W6hH1Idyq3vZQ==
Date: Mon, 24 Jun 2024 11:08:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 14/26] block: move the nonrot flag to queue_limits
Message-ID: <ZnmoANp0TgpxWuF-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617060532.127975-15-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_100824_613741_F9A35BF6 
X-CRM114-Status: UNSURE (   7.39  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 24 Jun 2024 22:01:05 -0700
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

On Mon, Jun 17, 2024 at 08:04:41AM +0200, Christoph Hellwig wrote:
> -#define blk_queue_nonrot(q)	test_bit(QUEUE_FLAG_NONROT, &(q)->queue_flags)
> +#define blk_queue_nonrot(q)	((q)->limits.features & BLK_FEAT_ROTATIONAL)

This is inverted. Should be:

 #define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONAL))

