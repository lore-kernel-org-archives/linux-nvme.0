Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1883C3DA5D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rcqh0gAHnqmjrR/O8zwWEHOuTC/X+tqiFREuS7SY4z8=; b=aflVR5JQQnRXU/Y0IBjmHs0Wpb
	RUpLfR3BHe0oVr5yZ6mUPqyCe8jbMbHm23LhlELAls+k8rJY6HFYj+Zg4pj0VZtPL1ZltGyxRPkq8
	vQxJ6AZDkdFcaXQ4JjXH1Lixv4/aIbfU4dVDGxsKByQKWxolR54p01iZjEPAvi8WLUyGbvqQFmM8D
	Xh0KPMwFWJi63S770G6ardqgEXb0T6zKNVtbOiq1CVSvPAe7MhgLA+Mg3Gq9iN3k9P6OBmPVHz7vU
	Hg17IbINY6A4Nhh4CvHZC1rDf8LNM46eXOPYZ7voyYGA8x08lFZrRzCgic8ViC4qteW6YPCPVV6EJ
	vT0kJ9og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzA1-00000001CMl-1I0l;
	Thu, 25 Jul 2024 14:09:37 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWz9u-00000001CLX-0MEe;
	Thu, 25 Jul 2024 14:09:30 +0000
Date: Thu, 25 Jul 2024 07:09:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC v2] nvme: basic RMEDIA support for host
Message-ID: <ZqJcmkVCqKne2R8B@infradead.org>
References: <20240723232419.19753-1-wangyugui@e16-tech.com>
 <20240724123052.49185-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724123052.49185-1-wangyugui@e16-tech.com>
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

On Wed, Jul 24, 2024 at 08:30:52PM +0800, Wang Yugui wrote:
> Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
> We firstly add Rotational media(RMEDIA) support to nvme host, then we can add
> the support to nvme target later if the backstore is a Rotational media(RMEDIA)
> block device.

I'd reword this a bit:

Subject: nvme: add support for the rotational media flag

Add support for the rotational media (RMEDIA) flag in the NVMe 2.0
specification by propagating it to the block layer BLK_FEAT_ROTATIONAL
flag.

> +	bool is_rmedia;

I'd stick to the Linux 'rotational' terminology here, i.e.
is_rotational.

> +	if(head->rmedia)

missing whitespace after the if here.

But as blk_stack_limits inherits BLK_FEAT_ROTATIONAL I think this
shouldn't even be needed at all.


