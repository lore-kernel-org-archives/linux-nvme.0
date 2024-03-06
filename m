Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7A2C54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RC4vZC02eJo4W0ZdjjuZDGKQO5AW85qq/pWj2c4GTk=; b=Ef7O0gL/uEIOxHLAnF29/WgqoH
	uCU5mp8D+jDEtQeRQJSjgozgQ94xxvGd9CKc3ACeL9A/T2n7NHXwIShFSVDUUEb7i6oieVXB4Sm2W
	JxG+GlhdBkVsUSdb61mh4l45T5jRicXmkQUfYxumqcINs5txZ+2gctI3Sy8lVunJXg2wpOqfN+UTd
	tTbwjtmlCwbAt5i00pouTOU4CLMOke2KYYHT4ZXLam7XNx6D/lQ9uSS2aD/uXgNdbqEszzMfTNMDd
	kCs5rFWRRFgVM0k2HYnA1WUTqGGgNzmRa0H2NYJZR6VgAmi/5D7HYcev4B1WiI7TMv3WIlsEbmTl8
	TFYV+JQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhs6f-00000000Xjb-045J;
	Wed, 06 Mar 2024 14:18:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhs6d-00000000Xiz-0e4M;
	Wed, 06 Mar 2024 14:18:51 +0000
Date: Wed, 6 Mar 2024 06:18:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Message-ID: <Zeh7S3WLjRvlutc-@infradead.org>
References: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
 <Zeh3E0qz2BE16yKP@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zeh3E0qz2BE16yKP@kbusch-mbp>
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

On Wed, Mar 06, 2024 at 07:00:51AM -0700, Keith Busch wrote:
> On Wed, Mar 06, 2024 at 03:03:03PM +0900, Shin'ichiro Kawasaki wrote:
> > When nvme_identify_ns() fails, it frees the pointer to the struct
> > nvme_id_ns before it returns. However, ns_update_nuse() calls kfree()
> > for the pointer even when nvme_identify_ns() fails. This results in
> > KASAN double-free, which was observed with blktests nvme/045 with
> > proposed patches [1] on the kernel v6.8-rc7. Fix the double-free by
> > skipping kfree() when nvme_identify_ns() fails.
> 
> Your patch is good and applied for nvme-6.9. I just want to mention we
> have a bit of an inconsistency in how the driver handles this pattern:
> nvme_identify_ns_nvm() only sets the caller's pointer on success, but
> nvme_identify_ns() and nvme_identify_ctrl() set it all the time. If we'd
> only set it on success, then this problem wouldn't happen, so a possible
> follow up suggestion to prevent the caller from having a pointer to
> freed memory:

This looks like a good idea to me.


