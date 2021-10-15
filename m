Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC7CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:25:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4872761053
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4872761053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MvbA7kTsF9/tbr7wEn78TxelJbCe347iyFKb1L4m85E=; b=P7jh+zYED120K2iCoqrEFuxsmW
	G0JKdTKiMC6m3wUsp++6CxYZR5eeM05Kzp7RHBlWFbOuLdApjXAwzfM4OqxcDJMXTfg4SCI0JjPIw
	9cEyAfKb8OyQkxSeIIy3eVcv2S8muFKiF4X53MTgsQNX5+DXazIqgtpDhBVDhRf5BWQL7qwmY/tJZ
	ZsPRhJDDInWK++lAYZS3KYrva4p4tZLYR89mLE54Jp06ZW4QWCyqAQXF2LWzmE5WnyJhy71sel8Da
	Y6Q6ViuJK51O0L70wp3LfIvlXVZzxTd7uyfoAAJAeesHWvemFswE058Mv7AWvJ+PHhqzcMBzpgIZK
	tSVxODfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbNCn-007BvQ-RX; Fri, 15 Oct 2021 13:25:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNCh-007BuK-7D
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 13:24:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6D9E668BEB; Fri, 15 Oct 2021 15:24:49 +0200 (CEST)
Date: Fri, 15 Oct 2021 15:24:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211015132449.GA30212@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
 <20211015083026.3geaix6r6kcnncu7@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015083026.3geaix6r6kcnncu7@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_062455_432145_94DE65E1 
X-CRM114-Status: GOOD (  13.10  )
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

On Fri, Oct 15, 2021 at 10:30:26AM +0200, Pankaj Raghav wrote:
> > @@ -568,7 +569,8 @@ blk_status_t errno_to_blk_status(int errno);
> >  #define BLK_POLL_ONESHOT		(1 << 0)
> >  /* do not sleep to wait for the expected completion time */
> >  #define BLK_POLL_NOSLEEP		(1 << 1)
> Minor comment: Could we also have a flag #define BLK_POLL_SPIN 0?
> It can improve the readability from the caller side instead of having
> just a 0 to indicate spinning.

The above are flags, so adding a define for a value is a bit counter
productive.

