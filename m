Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FEBEB64DC
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 07:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JA5SXRPA542vGqllBWOTAbqsID3ErsYVcZI5Ced2v6c=; b=tO20txG8wfspCfkkt33joCIkNS
	lPXcdXCVOrPwIxRaVBz+iTAWiycWn27LRRAcyLteGlTuxSguNov9NUJ9fYYbznFj3B9yCsMX0qRg9
	+03FWuMSyvv7dx8fDkJqHwqjYa56mIsnj8RRp//S9dmI/IyQ+TA8ecJAglQieHg4/WA+peJZ07ABR
	0GHtQDag6+W1glTTK+TH0yS3dj28lfMOCgOe8DUvTBhsypN6KMszDcUChMjRjBvxn2B/3GxIYhpmy
	H2AYt4r7ZY+UiIE8JXpZM4asbCVG/CmoJw2f5ZYEAD7f2IfxZSfeP8vHDYoWhzkYnxeGCqy50F3QW
	RCImKLQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMNjw-00A3ET-2V;
	Thu, 20 Jul 2023 07:06:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMNjs-00A3Da-0w
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 07:06:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F0616732D; Thu, 20 Jul 2023 09:06:12 +0200 (CEST)
Date: Thu, 20 Jul 2023 09:06:12 +0200
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
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 1/9] block: Introduce queue limits for copy-offload
 support
Message-ID: <20230720070612.GA4722@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184000epcas5p1c7cb01eb1c70bc5a19f76ce21f2ec3f8@epcas5p1.samsung.com> <20230627183629.26571-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-2-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_000616_468203_53058A9B 
X-CRM114-Status: GOOD (  14.19  )
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

Just a little heads up:  I think we need to properly solve the
hw vs user limit as the various ad-hoc mechanisms tend to be
broken and don't scale.  I plan to start looking into that the
next days.

On Wed, Jun 28, 2023 at 12:06:15AM +0530, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
>         - copy_offload (RW)
>         - copy_max_bytes (RW)
>         - copy_max_bytes_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload: used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_bytes_hw: Reflects the device supported maximum limit.

Why do we need the separate copy_offload boolean vs just looking
at the max_bytes value?


