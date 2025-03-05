Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E96C282E5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5BZ6tWR5hlyCvov/NRwRTliNB0jXbmL6hiQqkO+yxI=; b=ByKJdutn4QFpskCS3uE2b8ndPU
	uuFRjLgLC12GQNkfglplwOWoVAfRhqsqJ/BpnLej5//tPcN+4f4wFKjNHACEX1Hcy8khA3Z0TT1u9
	bF9SfUPqDyzhMVkWJnGVl31zTRIz7Mn+535Rd8lr9doEIo44ti1RrPL28Vw7omTB3VVFSDiZYtxsf
	clJdWE5iNC520ZmLuSo9HO0wb3IDUFN3WanJQ3WW7UsxJH1PtcJz+vXiT6x+xdAWz5TYl0OXMo+AZ
	b/T8GKoVlkuQbyAua2N+lRc+KSDyc+heOScHyER4AQpowOlJbyHcZ7o1XzwkpmLnu6RbO9v/YU8KZ
	dL1dwaZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tppqw-00000008NDN-0LdI;
	Wed, 05 Mar 2025 14:36:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppor-00000008Mft-1b5O
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:33:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 149BC68C7B; Wed,  5 Mar 2025 15:33:54 +0100 (CET)
Date: Wed, 5 Mar 2025 15:33:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <20250305143353.GB18526@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-3-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228032541.369804-3-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_063357_557999_2412A587 
X-CRM114-Status: GOOD (  12.41  )
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

On Thu, Feb 27, 2025 at 10:25:39PM -0500, John Meneghini wrote:
> The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
> parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
> and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
> the multipath parameter is added and multipath support becomes
> configurable with the core.nvme_multipath parameter.

What's the point of adding yet another confusing option?


