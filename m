Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BD6C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uPOnAz+kVeBEpH0vXR2iEyueShM0hCxOPL5dZCgxBUk=; b=rC5KnuY3aXzIrxB7MDP2iQ3mBT
	WZEhEmGXeY4o+JH5Z8QZFQZEV099XZziB9Fth0zOG0PBHYh0tHfjTcrYfuXABdIXJAfAdWET3P11L
	imezjF8wO3Kyh1F7/7O8H33oHoYsy+ugUvzfRv8qHqcrFtqbuzoUix8wiCryNAYAFc9wR7dc9bqeJ
	J0jZR2AAKhFklVeTezuz1wJay1n3IQj1WtHLoR1aUsVyML9/MeCD4ey7C0uNh43qiH0ZmY+xr0guH
	uYwZ2+3GbWj7A8yqd4KHOgIQEREvd9IfrTNsEvaEbYproSF2pdN2b6PWiLFgoWVGtHdeY3mqrVyQp
	YcAehDUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEsVQ-00000006bcX-1RjE;
	Wed, 05 Jun 2024 15:24:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELpq-00000001BOj-1CxV
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:31:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2831268D12; Tue,  4 Jun 2024 06:31:43 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:31:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240604043142.GB28886@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_213146_498549_98D41FD7 
X-CRM114-Status: GOOD (  12.46  )
X-Mailman-Approved-At: Wed, 05 Jun 2024 08:24:50 -0700
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

On Mon, Jun 03, 2024 at 06:43:56AM +0000, Nitesh Shetty wrote:
>> Also most block limits are in kb.  Not that I really know why we are
>> doing that, but is there a good reason to deviate from that scheme?
>>
> We followed discard as a reference, but we can move to kb, if that helps
> with overall readability.

I'm not really sure what is better.  Does anyone remember why we did
the _kb version?  Either way some amount of consistency would be nice.


