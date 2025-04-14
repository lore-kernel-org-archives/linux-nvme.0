Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947BFC369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30fljFDyjk9jIrreZ8/GOnxDhnFStsR/c9FJ7/1q/ic=; b=J/jTBMEc8pja05vI9rOh1oPh6p
	Jz0jeF+Q3PZhcHF4mJwoXzUJyjX9VWPY8IjI1zTFAaFmOkhhg6CpANzHs08sWY0Ta48AU5TUMwdDX
	gSSdEXfv2g5lWsqSBGVDdzb1s5NvKK6DJeFVtM34FQENbCnBPtazyhVR66OICz0Keqev1KZLnc02i
	MiHRLUbpFbKC0wUrbP/l4Q++wCjtFUvqj+BR+vQpjVVX52o3ex5BtO8nB8hNFj18RZ8UVfLtQDoO7
	amWh0UB1tcT9Q+FgskSZvlyTzYXelRybLEQvyKVjzha9h/579sp6hwhDcwxGqP/Gpvo6ZQCkwHpqn
	5WKMaW2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QHD-00000003Rcs-1LNM;
	Mon, 14 Apr 2025 20:19:31 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QH5-00000003Rbl-05KW
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 20:19:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A9F69A49BAE;
	Mon, 14 Apr 2025 20:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F50C4CEE2;
	Mon, 14 Apr 2025 20:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744661961;
	bh=VcBYwknK3PevCEJXb5AsZ/jDttNi559Kvn6jseNlQ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcwVcf44YgdPqm7cowyz/Zc0TU78VqhwbxpIAVDQ7+NvzAy2yVtxHiG32rjOoxZ86
	 DM/X/hmwzQ225h69K0WjMev9FB+GFpSQTOLAukns5PeSEOdG+9SlvSy/lFeRd6S1eM
	 PBhwdpM2+NlctUj59VuES3gc7/4AgHThVvWwGUKFYXbPwQcklxCz7OPAPlggliRyCC
	 Z4D7izAQfdoAJ6hZraRushoux2J1U0qvDxTNp1nL8z4DzyhwceKjt90w/76P7xsL4l
	 86P0vCyAaG3dthMEySUu8Xp1MVQwe6CUASHAZ6cuRAfXWYKb1kgDLRPMyAzE45/5hW
	 s3GKss95vV08g==
Date: Mon, 14 Apr 2025 14:19:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH v2 2/3] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <Z_1twUvRSifuQPCQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20250322232848.225140-1-jmeneghi@redhat.com>
 <20250322232848.225140-3-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322232848.225140-3-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_131923_260371_9C873EFA 
X-CRM114-Status: GOOD (  15.06  )
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
> +config NVME_MULTIPATH_PARAM
> +	bool "NVMe multipath param"
> +	depends on NVME_CORE && NVME_MULTIPATH
> +	default y
> +	help
> +	  This option controls the inclusion of the NVMe core module
> +	  "multipath" parameter. If this option is disabled the
> +	  nvme_core.multipath parameter is excluded from the kernel.
> +	  If this option is enabled the nvme_core.multipath parameter
> +	  is included in the kernel.
> +
> +	  If unsure, say Y.
> +
>  config NVME_VERBOSE_ERRORS
>  	bool "NVMe verbose error reporting"
>  	depends on NVME_CORE
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 6b12ca80aa27..cad76de2830a 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -10,10 +10,11 @@
>  #include "nvme.h"
>  
>  bool multipath = true;
> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
>  module_param(multipath, bool, 0444);
>  MODULE_PARM_DESC(multipath,
>  	"turn on native support for multiple controllers per subsystem");
> -
> +#endif

John,

Is this the logic and wording you want this option to be? You, or at
least somebody, suggested to rename it DISABLE_MULTIPATH", default "n".
The end result is just a matter of setting it accordingly; I just don't
want to stall getting your feature in over a miscommunication. Thanks!

