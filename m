Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C061C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 21:31:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB48610CB
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 21:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB48610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=82aFQpUobYlDoSJDQT+H+u93TZN9rmsvgbH9zYs7r+Q=; b=I3gI57Fd619SAN
	l3rIXSpkxcHOWD+GUPCBUHPjHZJyZBEWeq9Dz+DlHdeNcj0qorwTN0Za8bK2b3BixcN11kRgxGQI3
	G/6WJiupci0uo6LSxvVP+TxUiI39lEafP9MU1yUG0msYBVwt53l2534+mBRj1zLxGj61SkUqGQrLq
	/Fu4hLIlICBdp/1j4dZ75sNXzz+OZ81MNpdWoefJjVKjAkLh9sBDkSaz41H7I2cNLz+eyMPlYk1ZI
	2EBrZDto953w5d2rG4i485MdNYbL/WhOW4vU61GF1YUjSVud2eHnI7RY5mW7cyzUaTgNeXKrWsnCc
	rITz4GXW697aPZLErvAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llI9b-001wwp-GF; Mon, 24 May 2021 21:30:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll4z7-000k8b-4T
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 07:26:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1676267373; Mon, 24 May 2021 09:26:43 +0200 (CEST)
Date: Mon, 24 May 2021 09:26:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 14/26] md: convert to blk_alloc_disk/blk_cleanup_disk
Message-ID: <20210524072642.GF23890@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-15-hch@lst.de>
 <e65de9e6-337c-3e41-b5c2-d033ff236582@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e65de9e6-337c-3e41-b5c2-d033ff236582@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_002645_346805_55FF7EE9 
X-CRM114-Status: GOOD (  11.67  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, May 23, 2021 at 10:12:49AM +0200, Hannes Reinecke wrote:
>> +	blk_set_stacking_limits(&mddev->queue->limits);
>>   	blk_queue_write_cache(mddev->queue, true, true);
>>   	/* Allow extended partitions.  This makes the
>>   	 * 'mdp' device redundant, but we can't really
>>
> Wouldn't it make sense to introduce a helper 'blk_queue_from_disk()' or 
> somesuch to avoid having to keep an explicit 'queue' pointer?

My rought plan is that a few series from now bio based drivers will
never directly deal with the request_queue at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
