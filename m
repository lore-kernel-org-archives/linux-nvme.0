Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB9AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X168mkep0rr7Opke+i+7LpkJJ/Nq78vDr3J4FdKIGhU=; b=PF6CyP7iiq+XIJKxOHQH/HEe0b
	ys3MglS8jSFzDcj9gGcGxHKCQyLMLLa577ykFB6t2kQewQk0bbKsoaTKio/+VT92BJJxNF89RD0XE
	4eCjHWQvwbxP1Xwbe4MGM0xjfDsacQ39PVbzrNVEzjxolRNiqTxNaZJ7rglrTgj1X/9GlWT6ibS3+
	Mp2MGuoW4FeJHbblO6yWBxtdgsRa/VrSZdP8ZWFC83hk1ZzLqzSb+DHsonrTSgrz0FnvVpCWSwNWY
	vpOs9+9Ud5KchCLEbJjXlp9MMNjShNXdXUEEG2a4cL/TvSafV6Q7L7w5qnh8BXC38IllfxOeJcsXQ
	2BwK1geQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrhxz-007tDD-7Q; Thu, 19 May 2022 15:21:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrhcv-007fLX-00
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 14:59:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7623D68AFE; Thu, 19 May 2022 16:59:31 +0200 (CEST)
Date: Thu, 19 May 2022 16:59:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Muneendra <muneendra.kumar@broadcom.com>,
 James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Message-ID: <20220519145931.GA25382@lst.de>
References: <20220519144555.22197-1-hare@suse.de>
 <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
 <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
 <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_075945_374956_75C242A7 
X-CRM114-Status: GOOD (  13.62  )
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

On Thu, May 19, 2022 at 08:57:53AM -0600, Jens Axboe wrote:
> I'm assuming that commit is from the scsi tree? It's certainly not in
> mine. So your commit message may be correct, but since it was sent to me,
> I was assuming it's breakage from my tree. Which doesn't appear to be the
> case, and I don't see any of the SCSI maintainers on the to/cc.

Yes, all this went in through the scsi tree.

