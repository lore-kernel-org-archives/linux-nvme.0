Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E909C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCTI8nob7YubsijKhZbYGkeqhzFBtrjs44QVd5r3paM=; b=yi46COhVOKTInMMnEKR8zRebps
	qwshpmoUAFHM0nYIZaBiRqp9MEVCZ2jcwCxo7tRdC3iWGJERSBu1s6tIQ7kFy5282WWMYBSXx2HnA
	+l+bZr0g8Qcy9zfzy3fgl6d09Xdy9N8mdaXGoSgx4gjy5kgR1PuEGPiWyI5cYBvzGxt7PR9YWWa3X
	vmgh+H2/31rKHyuK1ODc0uwvTExmzRjqu8PrQwS7nlP4AObyGxHrzPxH31qQLlzQzJsX7G1AdnC5i
	pFg0m6cvGBJvUM/0DnCwdjRHX47YzhYYrlxJZ1MWHYld6cLEL0Nn3KUFIPTq9U9zKz9Lmn/UTvT7M
	Jniakiag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uVg-00CBHR-MB; Wed, 21 Dec 2022 08:31:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uVG-00CAzU-R4
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:31:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7C5667373; Wed, 21 Dec 2022 09:31:02 +0100 (CET)
Date: Wed, 21 Dec 2022 09:31:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: August Wikerfors <git@augustwikerfors.se>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221221083102.GA23826@lst.de>
References: <20221116171727.4083-1-git@augustwikerfors.se> <CGME20221116172324epcas5p3d9877249797ac741ead5785cba27e00e@epcas5p3.samsung.com> <20221116171935.GA24524@lst.de> <20221117031951.GB392@test-zns> <20221206055928.GB24451@test-zns> <a80857cb-e3a0-74b2-a7c4-a1afb34e5082@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80857cb-e3a0-74b2-a7c4-a1afb34e5082@augustwikerfors.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_003107_118707_D0EE64E0 
X-CRM114-Status: GOOD (  12.32  )
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

On Tue, Dec 20, 2022 at 12:30:39PM +0100, August Wikerfors wrote:
>> Took more time than I wanted. Firmware team mentioned that issue existed
>> in this firmware. This is fixed in new firmware, but bit of travel time
>> is involved when official release from OEM (Lenovo) comes out.
>>
>> Hope the information is sufficient, and quirk can go in.
>>
>> If required, Acked-by: Kanchan Joshi <joshi.k@samsung.com>
>
> Ping, anything left for me to do before this can be merged?

We don't want to add quirks for things fixed by firmware updates,
see the recently posted features and quirks policy.

