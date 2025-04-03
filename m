Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42610C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uT7wP3Ginz6Rujak7CmexXchwNLK0ZvCFs+B+I5ExC4=; b=IVivUARHztJ4KuJJp3o474Evda
	lu6z83Gn3BcdHziYXXS+y8xuYfSvqIxGSdaf8K1MYTP/Vj5RawkZxLnRgdn7lgLioonPNGFBXU7te
	ECWhTb2rYw8SwVYex5QHo/frTdrgJrFjIecVFaTEp64hXDA4HyguXrjT/YlPHVq+ojTNYUyhBGTDn
	b2M/xRyhnT4lsvKUVohGJAjEa0AjJduq4lkKE/j3mcnXajeJSMnc2hVe/DkCyXD62f9XkRyUgOv8z
	cM7QJyJ3UTB0ItYqyK1YeF5SuVto/cATE7F8UjyU89HErwNE1bwJbod/fxVoe102Hq2AKx5Ry650A
	JjJWT16A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CIi-00000007koM-0b6y;
	Thu, 03 Apr 2025 04:35:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CIe-00000007kny-0iVL
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:35:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3AFC68C7B; Thu,  3 Apr 2025 06:35:26 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:35:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH v2 2/3] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <20250403043526.GC22526@lst.de>
References: <20250322232848.225140-1-jmeneghi@redhat.com> <20250322232848.225140-3-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322232848.225140-3-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_213532_600799_B441EFC2 
X-CRM114-Status: GOOD (  18.46  )
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

On Sat, Mar 22, 2025 at 07:28:47PM -0400, John Meneghini wrote:
> The new CONFIG_NVME_MULTIPATH_PARAM option controls the core_nvme.multipath
> parameter. When CONFIG_NVME_MULTIPATH_PARAM=n the multipath parameter is
> removed from the kernel and nvme multipathing is permanently enabled.
> When NVME_MULTIPATH_PARAM=y the nvme multipath parameter is added to the
> kernel and nvme multipath support is controlled by the
> core_nvme.multipath parameter.

So as stated before I hate these options with passion.  On the other
hand both RH and SuSE stated they'd prefer to ship with the option
disabled, so I'd rather accomodate them rather than having to ship
patches for this which will then confuse folks why they are different
from upstream.

But:

> +config NVME_MULTIPATH_PARAM
> +	bool "NVMe multipath param"

This isn't really a good config options description.

> +	depends on NVME_CORE && NVME_MULTIPATH
> +	default y
> +	help
> +	  This option controls the inclusion of the NVMe core module
> +	  "multipath" parameter. If this option is disabled the
> +	  nvme_core.multipath parameter is excluded from the kernel.
> +	  If this option is enabled the nvme_core.multipath parameter
> +	  is included in the kernel.

So maybe invert the option to 

config NVME_MULTIPATH_DISABLE
	bool "Allow overriding the default nvme-multipath parameter"

	help
	  This option controls the inclusion of the NVMe core module
	  "multipath" parameter. If this option is enabled the
	  nvme_core.multipath parameter is excluded from the kernel.
	  If this option is enabled the nvme_core.multipath parameter

	  See the nvme_core.multipath documentation why disabling
	  multipathing is generally harmful but there might be
	  exception reasons to do so anyway.

(assuming we already have the documentation mentioned, if not we
need to add it)


