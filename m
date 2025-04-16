Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83600C369CF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPhAKgSzy8ZorosPbLbQYUfCXsX8YY93br9OttTmY1Y=; b=UxMBAutdTQLvUUhjHVz1bHGMpG
	rvnTeNVUFRmecMSuhUXWADePxmzZdhY/Blgsv8J7Jab48ySwtbj+Pm0QtMLPq8Xcmw6eubqYX66KI
	aH1ZVKdR8yip6leXuWGtxACPtPyM6ca5stw9/uR+7xfhSQc1Oy4iYj8IrxuphNBROue35GZ0hxKuf
	B1IRbJAvEzAtz5oYY1eVD7jdQ6QwfXKMlcnLwv59UkNGXB/f1lsyeKiJ67BJByCLE2f9rADR7387b
	9sR3AGMcsvR7S80Z4VYwi3s6IAxODr9yQJtS9aMPB1wmwq/QZd0ceW8czW9jcVGzYKQqhJ0j6SGwr
	3EN4rldg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5onT-0000000Gzqu-487u;
	Fri, 18 Apr 2025 16:42:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uhV-00000008Bjt-1esq
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 04:48:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD62068BFE; Wed, 16 Apr 2025 06:48:27 +0200 (CEST)
Date: Wed, 16 Apr 2025 06:48:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
Message-ID: <20250416044827.GA24153@lst.de>
References: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_214841_568337_3A102868 
X-CRM114-Status: GOOD (  10.45  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:34 -0700
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

Your series did the grve mistake of sending various patches only
to some recipients making it unreviewable.

But doing less and more explicitly inlining in general seems very
questionable.


