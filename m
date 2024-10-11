Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E11CCFC61B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mExv6Hf+hxG/YT58BZzNX7MtY/1p6NGVlWVNJxyNIQY=; b=Z/rJs2BOp8biDGEPpcKsOA84J7
	lRFGo1zAgdfVDZ9nFSZKEmiOSEvAxKJjAUJ3oFi/GQtPqccbgT9CdulQG5UUwtL+oRozUYBgHiNBO
	IjDjQ3uLsX40WXT3MRScnrqgw9qu7TS4jeaCTTIT51aBQncZhKXmIf5c7RaJIq+KLScYDbQTOGjJK
	2vg3H1YSGmdyPNLotoSLIbXIloVBRrEQP3TXXJgpgoxHuso83kMs6wu79CmJqIFU00vVsXpIGljx9
	orZp549RLBlyUC4Bsjza9BahP197FDaiM2u7fmwFIl9sz5Ulcbqyit+SF8acIPL2OpXlBNqYcqxCc
	ue2UVXmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAur-0000000FfyH-1jj3;
	Fri, 11 Oct 2024 08:22:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAuf-0000000Ffx7-07sn
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:22:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D06D4227AB3; Fri, 11 Oct 2024 10:22:12 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:22:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de
Subject: Re: [PATCH 3/3 v2] nvmet: add rotational support
Message-ID: <20241011082212.GC3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-4-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010123951.1226105-4-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_012217_234573_5A036128 
X-CRM114-Status: GOOD (  13.27  )
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

On Thu, Oct 10, 2024 at 02:39:51PM +0200, Matias Bjørling wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Rotational block devices can be detected in NVMe through the rotational
> attribute in the independent namespace identify data structure.
> 
> Extend nvmet with support for the independent namespace identify data
> structure and expose the rotational support of the backend device.

Most of this patches looks fine, but what it really is, is just an
implementation of the I/O Command Set Independent Identify
Namespace data structure.

NVMe actually requires more for rotational media support (quoting
from section 8.1.23 in the NVMe 2.1 Base Specification):

A controller that supports namespaces that store user data on rotational media
shall:

 a) set the Rotational Media bit to ‘1’ in the NSFEAT field of the I/O
    Command Set Independent Identify Namespace data structure (refer to
    the NVM Command Set Specification) for any namespace that stores data
    on rotational media;
 b) support the Rotational Media Information log page (refer to section
    5.1.12.1.22);
 c) support the Spinup Control feature (refer to section 5.1.25.1.18);
 d) support Endurance Groups (refer to section 3.2.3); and
 e) set the EG Rotational Media bit to ‘1’ in the EGFEAT field in the
    Endurance Group Information log page for each Endurance Group that
    stores data on rotational media.

So we'll need to implement a bit more here.  Most of this should be
pretty trivial stubby code, though.

> Signed-off-by: Keith Busch <kbusch@kernel.org>

This also needs your signoff if you pass it on.


