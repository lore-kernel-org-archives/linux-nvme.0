Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E80C54EBE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rYpYJQ6ctnRoM85+QtVZVyo2jLn5u6XNjZl/i1FmhPw=; b=sSMf+a5JL8k7YzzWK9JP/VxYQO
	/o77dh6XOsz/LG0ItUTmUu0PR8nhFXCmGBTyI1OAEyaLo80aXcHRKDfDUwTZ/OwLUsjlOdnLJO2F5
	S09RfXrVJj9CeLntVddru/QZCnUkBXomwkcgjQVs1ht+iY+T7fD3E/7qG6qv9Tauy5y4dJlHcfvmV
	BnCFCP/61r9XCAsUgp1M4W8I+h6AQn0uZDdnh5eqcEAXuMxJb7XQi2ZH95v9IqH9fsisDkRjnz4pi
	KbNLis+qNWFpH2JON3DU5gxsEDRf7dtXZUuGB3goZrSX84Gg+YxoCT4E3TJ32usgnIEM0gI5Upk0z
	mDMbpPiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFBAI-006BeA-NC; Tue, 10 Jan 2023 09:43:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFBAG-006Bbc-2s
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 09:43:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D623968BEB; Tue, 10 Jan 2023 10:43:16 +0100 (CET)
Date: Tue, 10 Jan 2023 10:43:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
	bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
	damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 7/7] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Message-ID: <20230110094316.GA14143@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e@eucas1p2.samsung.com> <20230106083317.93938-8-p.raghav@samsung.com> <20230110065822.GF10289@lst.de> <35293c0c-2d72-c4ee-2296-079d56df7d5b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35293c0c-2d72-c4ee-2296-079d56df7d5b@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_014328_281655_EEA1068F 
X-CRM114-Status: GOOD (  12.97  )
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

On Tue, Jan 10, 2023 at 10:07:39AM +0100, Pankaj Raghav wrote:
> I just extracted the cleanup from my old series. Do you think it is better
> to send it as a separate patch instead of adding it along in this series?

dm and block have different maintainers.  So unless there is a
dependency it's better to split the patches out.

