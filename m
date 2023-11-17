Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2575C197A0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkscOyuRtZotHOfNZgicH91WsZkPiuHwlhg7MOKwlw4=; b=QK5FX3ZQgrQZnzPCpMh2JdwSiC
	BCbiCYtRE1pwJMoSUPpJUrDgtulGTvKSRck/ea5iAtvOZU4Q96ZJBVhyf7P8CJ1Z8Umf74XiSrJ9p
	2n+OOrJ8bjFNhiezniYf9rPc8zheKdzRC1fK3j6ClO66PAMU7czZ/bCd3vj2/bDmsXgkTnFCGCfqP
	5x59wQ3+VnR7ojbyCh2mgSPQSS6gBkJ4lyeeweLx3+GlIIvuR9/2k+Ds5nb3IdKHwNnK/+yxBemKz
	1s53mjnRR9aUeH666Ftd8GlUupkTbfXim6Pp99TWC5hdED13ntXU1P42w3E1hbC2uvTuPJC+rhgBo
	1C4oMwjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3yjs-006dRc-2S;
	Fri, 17 Nov 2023 13:18:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3yjp-006dNa-1Y
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 13:18:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BE836732D; Fri, 17 Nov 2023 14:18:15 +0100 (CET)
Date: Fri, 17 Nov 2023 14:18:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCHv2] nvme: blank out authentication fabrics options if
 not configured
Message-ID: <20231117131815.GB6832@lst.de>
References: <20231116121435.17340-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116121435.17340-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_051825_679674_171AC09C 
X-CRM114-Status: GOOD (  12.42  )
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

On Thu, Nov 16, 2023 at 01:14:35PM +0100, Hannes Reinecke wrote:
> If the config option NVME_HOST_AUTH is not selected we should not
> accept the corresponding fabrics options. This allows userspace
> to detect if NVMe authentication has been enabled for the kernel.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

