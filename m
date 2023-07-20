Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1AAEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gk3Ip9dCbQyHmuypkjiG3tOvL5BFP6Tkj1TMbP+cGKc=; b=r8OBROPaJ9xf0xFV8bWzmd69n8
	rP87bUZKfYaywkPO7qYKQ6M3Y0BaXFaOkJF4tuq041ftbiNxcbDnl8I9huVMKIcf1CcpN4fDK8MZu
	jBFUj35jkXssOJiwtKV2Ok+VHCv3hRSjOjQaxt4loa3mvFFLDPBjr29VahrOrm7lNilCxzVHqzF77
	2lxiYlHoiZ/gT1tDtYfErd6foFU7c1Y6xfy58b+jgGi5gMywV4uGKVfEFAD7MP6bzPh5PqCtpaTp9
	m7sEKlx6JOmrHmgMBDNjHZ1moN63btp3xXMBQuFYH4SP3EB01PzpwFe9bV2M7VXVoiVaqTeTOvzA4
	z0lHloFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMObb-00ADrn-36;
	Thu, 20 Jul 2023 08:01:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOaL-00ADa0-1T
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 08:00:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98BAB6732D; Thu, 20 Jul 2023 10:00:26 +0200 (CEST)
Date: Thu, 20 Jul 2023 10:00:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
	dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 5/9] nvme: add copy offload support
Message-ID: <20230720080026.GB6246@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184039epcas5p2decb92731d3e7dfdf9f2c05309a90bd7@epcas5p2.samsung.com> <20230627183629.26571-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-6-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_010029_631371_6CBF8540 
X-CRM114-Status: GOOD (  14.43  )
X-Mailman-Approved-At: Thu, 20 Jul 2023 01:01:44 -0700
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

> +	if (blk_rq_nr_phys_segments(req) != 2)
> +		return BLK_STS_IOERR;

The magic number of segments adding up source and dest really need
constants and helpers to make the code understandable.

> +	/* +1 shift as dst+src length is added in request merging, we send copy
> +	 * for half the length.
> +	 */
> +	n_lba = blk_rq_bytes(req) >> (ns->lba_shift + 1);

I do not understand the logic and comment here.

> +	if (WARN_ON(!n_lba))

WARN_ON_ONCE

> +		return BLK_STS_NOTSUPP;

and BLK_STS_NOTSUPP seems like the wrong error here, this is an
invalid argument.

