Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B726C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghKioJxXG5QX5fRrFqbNNSaKPpjm8tB+9WEBwPnp2jQ=; b=rGIeFLzGMW2zn7QFvuakFqzBkg
	DpmPvp3DHjCbc2qw8tZizOGaYdvJR97fW2vyeT3eIn08o+9T/L92loJB42Wm1lkFLQHCsaGvPTZ8y
	Bq+qLm4/MXavICjrQ5fHJs0IwyqHMZO3KUspwVkwJWGgraX45ND0sC1oH8213i5tSkQpxK+y2kgtW
	RtesU3LjnV+s9PhDNs7ix0J5Y2R9QH/VxDJBNMCxrxCtodnwEPox0uuGZCWdneg1Gti7d9xi8Xrfo
	xJkZaQw1fYA6SCB/9dFtydgozKPCmoxbLpAk+TFFHkrLJHjHjcSz7Yg4k3991qf0DzFpT+pr8ogBf
	9aUQxKfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKFPo-0062hZ-5p; Wed, 16 Feb 2022 08:11:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKFPl-0062fx-0a
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 08:11:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 08A5068B05; Wed, 16 Feb 2022 09:11:49 +0100 (CET)
Date: Wed, 16 Feb 2022 09:11:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, dwagner@suse.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 a.manzanares@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH] nvme-multipath: fix multipath path scan
Message-ID: <20220216081148.GA10851@lst.de>
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
 <20220216061305.45360-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216061305.45360-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_001153_227256_4E93F6C7 
X-CRM114-Status: GOOD (  10.30  )
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

On Wed, Feb 16, 2022 at 11:43:05AM +0530, Kanchan Joshi wrote:
> commit e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> introduced NVME_NS_READY flag. nvme_path_is_disabled() declares path/ns
> to be disabled if this flag is not found to be set.
> This causes side-effect on namespace for which block-interface is not
> fully up.

Hmm. This means for non-bdev namespaces we error out somewhere in
nvme_update_ns_info.  Where do we fail here, nvme_configure_metadata?

