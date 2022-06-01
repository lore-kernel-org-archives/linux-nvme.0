Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA36CC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=71dVbCRSnFcr0VmnK3BuRcwO5itLUGAh3GJL7iSIw4c=; b=e4fYDA7D379YHAtX21piBuGLBo
	tH4kBKTZY8d7lY3rjuLwPoc8Xy6zDWD04q+SYIYIjFb1oeGWCpwHtdmiOMJD+EaG20U12Pzp/Iuy5
	VpIwShO6gcD5y81EinbzAgUWJxavODOzkgPWu+Yev8tShtcolVs+zI0czxw71YikB8X0a7pKSd95K
	bwmnTNC8m81xqSORP7XH0fcowaJ9qmclToYx9TlVvi3PvM8AwQi7xW6rTygpAJXZlyHQkk5KAM1hj
	GU1+e8qKiNEIBS7XB1ei4255YrnE7kYECDpFbgGlnG9ckQNmJqQCUH+F/yBXK/bMjERipxOpF6jjq
	pQP0kNAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwRq7-00HEkT-4i; Wed, 01 Jun 2022 17:08:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwRq3-00HEiR-7e
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 17:08:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46DDE68AA6; Wed,  1 Jun 2022 19:08:48 +0200 (CEST)
Date: Wed, 1 Jun 2022 19:08:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
	Richard Wurdack <riwurd@microsoft.com>,
	Nathan Obr <Nathan.Obr@microsoft.com>
Subject: Re: [PATCH 2/2] nvme-pci: handle persistent internal error AER
 from NVMe controller
Message-ID: <20220601170847.GA27165@lst.de>
References: <1654056747-40143-1-git-send-email-mikelley@microsoft.com> <1654056747-40143-2-git-send-email-mikelley@microsoft.com> <20220601073505.GA24875@lst.de> <PH0PR21MB302599C693F0A48F3777008ED7DF9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302599C693F0A48F3777008ED7DF9@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_100855_463554_70AF72F7 
X-CRM114-Status: GOOD (  16.69  )
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

On Wed, Jun 01, 2022 at 03:56:59PM +0000, Michael Kelley (LINUX) wrote:
> If there is a persistent error that does a controller reset, it looks
> like we should *not* queue async_event_work at the end of
> nvme_complete_async_event().  The controller reset will
> submit an AER on the admin queue, and so presumably
> we don't want nvme_async_event_work() to also try to submit
> another AER, which may or may not succeed depending on the
> timing of when the controller state shows LIVE again.
> Agreed?

Yes, that makes sense.  I guess we can just check the return value
from nvme_reset_ctrl and propagate this to nvme_async_event_work
and skip the rearming for that case.

