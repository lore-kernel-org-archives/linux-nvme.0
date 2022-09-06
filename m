Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A56C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3s1JTqlCrwzxj8uOmY78wWFJ3Xr8wr2i2lTv4ZqeUU=; b=ir9l4ALYPuwlWwVDyQPjmsQ0Go
	MN1USiUu/Tz9XDuNA5S0Hj5gWQCuhi3DGJQ68iggmSkvRUsJvwfx0Rq35GtPMDn7tqWU72T1VgRp4
	BVigxGRB2U9Xxd9F8Qx3vjTX2FbfFTqS5C01ThuqxFjBIazJMyn9PzXMiaw67gQvcmuV4kqLtjlKQ
	fvTrQZcbH3jF6baZ0ZFvon4SinbePhhnNpVAZa8HNNLNuDmGkXnUgE3mff/11Cur/RcHGbcq/hMA4
	zMXSzu7rSSeKMmfh60o5hjdz/7IudqWWl5N8Mv9alTzzu6d54Kg+4vJiDm/IZp8rZRYlUQAROzAMF
	yRI4S1IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSQl-00AYkW-Jg; Tue, 06 Sep 2022 06:51:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSQh-00AYim-GS
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:51:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E85168AA6; Tue,  6 Sep 2022 08:51:23 +0200 (CEST)
Date: Tue, 6 Sep 2022 08:51:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v4 3/4] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220906065122.GA2190@lst.de>
References: <20220905134833.6387-1-joshi.k@samsung.com> <CGME20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1@epcas5p3.samsung.com> <20220905134833.6387-4-joshi.k@samsung.com> <20220906062522.GA1566@lst.de> <20220906063329.GA27127@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906063329.GA27127@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_235129_057397_A5B8BF1B 
X-CRM114-Status: GOOD (  12.47  )
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

On Tue, Sep 06, 2022 at 12:03:29PM +0530, Kanchan Joshi wrote:
>> This context looks weird?  That bio_alloc_bioset should not be there,
>> as biosets are only used for file system I/O, which this is not.
>
> if you think it's a deal-breaker, maybe I can add a new bioset in nvme and
> pass that as argument to this helper. Would you prefer that over the
> current approach.

The whole point is that biosets exist to allow for forward progress
guarantees required for file system I/O.  For passthrough I/O
bio_kmalloc is perfectly fine and much simpler.  Adding yet another
bio_set just makes things even worse.

