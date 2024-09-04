Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529FFCA0ED3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7HgPjp20k6CbXwP2NcFeZOjNtqqxxpO1qJf17eZQPOc=; b=dp+xbQ60d8cnhcdBVXm9kGWele
	G4/au8XKmoi6VISbSy4Am38aO8+aG3ZVIIINJ8HshqEwBF1Cl2XyvpEtSTylsKg5l1Jb/VeLpcls+
	SCYYUSom5sExWaqtcDVkmXwDQ3H6EAdUvSlqToy8EIQxvNrp5S//uRMv2nUdRA5BsbLI/rTaH1FQF
	8aZ6DS23N1oZ1KN/Na2vZnlikMLM8O9et4UbvcnkF8sF4xjmLqONMAi2aP2YRd86IulHcPLWWXpc+
	Q8+VTlFjyigVGTdtivtqLGLsT1wDeJEtFTID6InfvxSgOQwkyXPbQm7eHrTId8cpTTNUIcZjlkzp0
	gdLiZSbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhKz-00000002koG-3BHb;
	Wed, 04 Sep 2024 04:09:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhKw-00000002knV-2PUN
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 04:09:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C71268AA6; Wed,  4 Sep 2024 06:09:32 +0200 (CEST)
Date: Wed, 4 Sep 2024 06:09:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-multipath: fixup typo when clearing DISK_LIVE
Message-ID: <20240904040932.GA13295@lst.de>
References: <20240903180345.35253-1-hare@kernel.org> <20240903180345.35253-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903180345.35253-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_210942_778873_0E482E58 
X-CRM114-Status: GOOD (  12.99  )
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

On Tue, Sep 03, 2024 at 08:03:44PM +0200, Hannes Reinecke wrote:
> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
> 'struct nvme_ns'.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although a sentence on how this was found and if this causes
real issues wouldn't hurt.


