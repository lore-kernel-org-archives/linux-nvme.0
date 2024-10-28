Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78454D13593
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fc/XDftvJ+7HBv6RjHGjnxsCLTztrnnL+kcGkzdrZOY=; b=VN/VQwtJ7K0m03yR0eA2GVbw4a
	q53sCWWt3AxgWJAY13gklp4QtcxkHgx8AlDYDmPKN80Kv47K/FLFpInunSjJMVP4rBU7FO/R/+L4d
	8zJ0esHPuH+QTwLl0i4iyg1uy5kaLCvJRqM6uHeJQ8JZlWdAKTdBFnGvILdXAXrIGUd1Wz5u+0Sm6
	OZx2trBX4s3/VtL0oQ5QahNk9y0HSWapn37OsHdDaKvLXQCBSGeTT1WkhazD2B5vi2Egb32qeKFmP
	U0gDV9jCc1007GVkzZCBbnUJ2xsmH2ImKLnuV2dsOxzYE+ISyOeZrndX6Oh9i76T6UqYRDepN3cgR
	sorkqaqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Lrw-0000000ACUb-028c;
	Mon, 28 Oct 2024 09:17:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Lrc-0000000ACR7-1FsL
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 09:16:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8875568BEB; Mon, 28 Oct 2024 10:16:36 +0100 (CET)
Date: Mon, 28 Oct 2024 10:16:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>,
	kch@nvidia.com, shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v19 0/2] Implement the NVMe reservation feature
Message-ID: <20241028091636.GA28999@lst.de>
References: <20241028015844.111210-1-kanie@linux.alibaba.com> <20241028085543.GB27771@lst.de> <3489ffea-05cc-40af-ad61-63750ecc7923@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3489ffea-05cc-40af-ad61-63750ecc7923@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_021640_498467_C3C2989A 
X-CRM114-Status: GOOD (  11.34  )
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

On Mon, Oct 28, 2024 at 11:14:03AM +0200, Sagi Grimberg wrote:
> Did you try to use it with your recent pnfs-nvme support?

Not recently, as I'm way too busy with all kinds of urgent projects.


