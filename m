Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8FBEED603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wtgi72iuYtGZ9IDF1f6CCII4BRCc85UODAgzqjvcCpg=; b=sRxkLt348E5jd+NN+QaWvptGuM
	jFLDz5RN3BZKT0rmNejBqo3p/VXrCsa48BR9mD0VOSnc7c8txm46mxle4LqoEETCFCkonsP31RfP9
	GfNPVuR13L4/dkmoYW1J+lNi1I6lP9SPR/OXhAxbX4cAgRO1bZTVBPmE3vr25vsfKpgd9f7O9BclZ
	W9rOg/B1T06sOZVG0HdigZ2JAUU1w67mzNfCidb8oGNy2+X1HCd4LoXX251BUJkKox5lWxRVrbyeE
	oVJQCwIyhDOks9sNRWqAfkyx+zSYd+YNnjXh1dshf5rpPUbNOx0xdbVekde5mkysAUiGMs2hqbmm0
	EVEzszkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soji6-0000000DAyo-1hKz;
	Thu, 12 Sep 2024 13:18:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soji2-0000000DAxG-0ZTp
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:18:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88577227AB5; Thu, 12 Sep 2024 15:18:03 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:18:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] md/raid0: Atomic write support
Message-ID: <20240912131803.GD29641@lst.de>
References: <20240903150748.2179966-1-john.g.garry@oracle.com> <20240903150748.2179966-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903150748.2179966-5-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_061806_339705_1EFE7341 
X-CRM114-Status: GOOD (  13.47  )
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

On Tue, Sep 03, 2024 at 03:07:48PM +0000, John Garry wrote:
>  	if (sectors < bio_sectors(bio)) {
> -		struct bio *split = bio_split(bio, sectors, GFP_NOIO,
> +		struct bio *split;
> +
> +		if (bio->bi_opf & REQ_ATOMIC)
> +			return false;

I guess this is the erroring out when attempting to split the request.
Can you add a comment to explain that and why it can't happen for the
normal I/O patterns?


