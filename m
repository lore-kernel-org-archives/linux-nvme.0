Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995F0C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ict3NyiJFNJ/V/hcEyhm1BAKV1kssqxT7ov9RyHzhO8=; b=IEJo+0XEsm7bdr9tvctWeZdfqR
	8pY82v80+alL4CCTGsa6F57GeDkHsnS4sYX03eV+ueGG5o6tsTnO8iRCxOaq8MpMp2xfU/ImZlXMR
	uPjjW6exashyP+0VdvdAmYULBmLGMbol/GE8VRRGuL8z/zboHbIDasz5JOP49Wk1QaPaMPuhLRVVO
	1mJSiltoWJCGXN/Uv2Re5oAywRLFJfh1XA5vnhkvlhso4FaVitebvolminCEiODw7jwKpMiTYJmdT
	Q1e8D0efbTNBnq4Mc/wPXlieeUvBYtGtS1LQU6XEvfqETreboW1wusQWW9+/4s3PlprdAiKBebRoF
	a1QXufzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPTy-00000008HEg-3yxB;
	Fri, 24 May 2024 07:36:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPTv-00000008HE0-0lJW
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 07:36:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A59FB68B05; Fri, 24 May 2024 09:36:40 +0200 (CEST)
Date: Fri, 24 May 2024 09:36:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien LeMoal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] nvme: fixup zns namespace initialisation
Message-ID: <20240524073640.GA16336@lst.de>
References: <20240524061808.129399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524061808.129399-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_003651_388029_62639731 
X-CRM114-Status: GOOD (  15.01  )
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

On Fri, May 24, 2024 at 08:18:08AM +0200, Hannes Reinecke wrote:
> nvme_set_chunk_sectors() needs to know whether it's a zoned namespace
> or not, but the information is only set in a later call.

It doesn't really "need to know it".  It's kinda handy to warn if
a zone namespace sets an IOB.

> So move the calls around and ensure that the namespace is marked as
> non-zoned initially to avoid calculation errors when trying to derive
> a non-existing zone geometry.
> 
> Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")

Even before that commit, nvme_update_zone_info is clearly called only
after nvme_set_chunk_sectors.  The order goes back to
73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7 as far as I can tell.

Note that until the atomic limits series we kinda had to do it that
way as nvme_update_zone_info needs the sector size and other earlier
information.

The changes themselves looks fine, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>

