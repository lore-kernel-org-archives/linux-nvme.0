Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441AAC27C52
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/f9ERk5E8Kinjldjve5YYHagSWiCZ9m7JRxY182KBq8=; b=yYb6PNDTs3e3Bfh4mFmVgo/WHV
	H5QOmgEzCFJFJAxOazwkbLGVia7Pz120G4B1nAyaXi5yRfibPWMWFbFFntNY920OBj/w4ZaNE7RYJ
	SygsznUr4vLwjiTMWxjF0Lp7y589QkyRZErU1pWJQ6qBL/BeIhHokC1C7jb3Hq5asau12xO+vEJhd
	m5jl6vbqhfNXy+DBJD7J2ElazNGYrpGO6UzMAGa0fsC2nZS+5SiGY679iL/LJl8b+Kb7sMD3fpiKv
	QKFsxqKRaRNBtLUhVqrvu+xvtymNsqOMo+tRFcu/Beus4kRx8uo/1Na9qNlcbnCKFu/MALP4vNKSL
	M5I9cw9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElqG-0000000599L-3YZ1;
	Wed, 05 Jun 2024 08:17:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElqD-0000000597V-2CCz
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:17:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E1DB67373; Wed,  5 Jun 2024 10:17:49 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:17:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240605081749.GB18688@lst.de>
References: <20240604043142.GB28886@lst.de> <93f6bb98-e9b4-481e-afae-c2b4d90e686b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f6bb98-e9b4-481e-afae-c2b4d90e686b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_011753_942300_A8401831 
X-CRM114-Status: GOOD (  16.62  )
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

On Tue, Jun 04, 2024 at 09:05:03AM +0200, Hannes Reinecke wrote:
> On 6/4/24 06:31, Christoph Hellwig wrote:
>> On Mon, Jun 03, 2024 at 06:43:56AM +0000, Nitesh Shetty wrote:
>>>> Also most block limits are in kb.  Not that I really know why we are
>>>> doing that, but is there a good reason to deviate from that scheme?
>>>>
>>> We followed discard as a reference, but we can move to kb, if that helps
>>> with overall readability.
>>
>> I'm not really sure what is better.  Does anyone remember why we did
>> the _kb version?  Either way some amount of consistency would be nice.
>>
> If memory serves correctly we introduced the _kb versions as a convenience 
> to the user; exposing values in 512 bytes increments tended
> to be confusing, especially when it comes to LBA values (is the size in 
> units of hardware sector size? 512 increments? kilobytes?)

Maybe.  In the meantime I did a bit more of research, and only
max_sectors and max_hw_sectors are reported in kb.  chunk_sectors is
reported in 512 byte sectors, and everything else is reported in bytes.

So sticking to bytes is probably right, and I was wrong about "most block
limits above".  Sorry.


