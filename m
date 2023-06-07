Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33F3C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 07:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CbgdtrMRU8SgCC/lj9k+w8TeWMG8R3cL1TBFp6UuqY=; b=l0Fn4T7haJixVdmOfsrmrn9kRQ
	cP+NMm25KF3MauLbUWDYElPCcbLyuG9/4vY2U24CubHZOLtVEHB+9bleu6evU7Oc7LRI5osUun3An
	QPO/t1JySCvhtk5BxbnHEZpY3QnO/RImLZ3IUfOVk/AdFHH2t8Er2hUpl5h+s2cINfQjv6E3Fb4G4
	+8zJh3KmJB6uwssKGWaD+RFttXBdeymUBrETCX20+aVWbwl/zNTpB5Tih14FjolEAg/+B7/FL3LrR
	YS/xJgE2b9BtXSjDVmwyD1ttBNGn72xz6TnhqUw2n4wPfHwJ33oTpKkpOSEo3xCpWd+jIY8I5ncnS
	UKC1SVvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6nMl-004gMT-1e;
	Wed, 07 Jun 2023 07:13:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q6nLa-004gCI-2l;
	Wed, 07 Jun 2023 07:12:46 +0000
Date: Wed, 7 Jun 2023 00:12:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
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
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <ZIAt7vL+/isPJEl5@infradead.org>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
 <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
 <20230605121732.28468-6-nj.shetty@samsung.com>
 <ZH3mjUb+yqI11XD8@infradead.org>
 <20230606113535.rjbhe6eqlyqk4pqq@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606113535.rjbhe6eqlyqk4pqq@green245>
X-Mailman-Approved-At: Wed, 07 Jun 2023 00:13:55 -0700
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

On Tue, Jun 06, 2023 at 05:05:35PM +0530, Nitesh Shetty wrote:
> Downside will be duplicating checks which are present for read, write in
> block layer, device-mapper and zoned devices.
> But we can do this, shouldn't be an issue.

Yes.  Please never overload operations, this is just causing problems
everywhere, and that why I split the operations from the flag a few
years ago.

> The idea behind subsys is to prevent copy across different subsystem.
> For example, copy across nvme subsystem and the scsi subsystem. [1]
> At present, we don't support inter-namespace(copy across NVMe namespace),
> but after community feedback for previous series we left scope for it.

Never leave scope for something that isn't actually added.  That just
creates a giant maintainance nightmare.  Cross-device copies are giant
nightmare in general, and in the case of NVMe completely unusable
as currently done in the working group.  Messing up something that
is entirely reasonable (local copy) for something like that is a sure
way to never get this series in.

