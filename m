Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664BECA0EC4
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 22:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNm1KYyvrY5RwXk57EprjhK4UePkystQbrEihFe5+/s=; b=Qpd4vIYS9OlaBNnAzXHn3Pwojw
	S8ldnkDDybHioZpVGDk00e3eQ6zE4RtLywKrq+UbsFeeHxXRtNeOMNJchMHhPsArIA+Q/L+Sm8ynx
	f0B+LbLl1MBI6ustee17JvxJ8nh08t4qQx75pdPhJvWr7f67UtyDBBWYZg2f/9aOJSkgkOrHUSKtB
	u2NpHxx1MXQ1oXMCRmqUuWNhr2pQQA5KKdPtpKpDI7VtaR+7wLcLBthyT6GUmxEewyUw/UBSEUaKY
	NlbGRMQG58xDecTH7FIrynOyKT7+e2ipY+DwBFILRbRRbz2YMpEHXbnLW/RfFvSQmUUF17RYVCQ0c
	OtRCwJRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulaar-000000099hU-3P8K;
	Mon, 11 Aug 2025 22:02:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulVDq-00000008Myf-1u6H
	for linux-nvme@lists.infradead.org;
	Mon, 11 Aug 2025 16:18:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57E0D68AA6; Mon, 11 Aug 2025 18:17:56 +0200 (CEST)
Date: Mon, 11 Aug 2025 18:17:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250811161756.GA25496@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <20250806145621.GC20102@lst.de> <aJN4b6GS30eJdQLd@kbusch-mbp> <20250810143112.GA4860@lst.de> <aJoL1rsvI5bXkod_@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoL1rsvI5bXkod_@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_091806_635766_EB05230E 
X-CRM114-Status: GOOD (  15.68  )
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

On Mon, Aug 11, 2025 at 09:27:18AM -0600, Keith Busch wrote:
> I initially tried to copy the nsegs usage in the request, but there are
> multiple places (iomap, xfs, and btrfs) that split to hardware limits
> without a request, so I'm not sure where the result is supposed to go to
> be referenced later. Or do those all call the same split function later
> in the generic block layer, in which case it shouldn't matter if the
> upper layers already called it?

Yes, we'll always end up calling into __bio_split_to_limits in blk-mq,
no matter if someone split before.  The upper layer splits are only
for zone append users that can't later be split, but
__bio_split_to_limits is stilled called on them to count the segments
and to assert that they don't need splitting.

