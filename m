Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE25C48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 05:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGAsuJ4JUrAAtk/Y4GdBXmsxhu1i6DQQWGtABcrWkbI=; b=q7uAMt4GOi/t+JtvIwZcegf4C2
	R25PP+km5FifwLjat5tmAyCeCc/WGKS5mmp3wnaMrYCMQOMuORKaFSwfzbK0NPlZx6XbhdUlHAc8W
	AFbLhBVtEOO65TsHaW1eKNfYrT+extV4mrId+IGQQHh7oqWwa0H0G7PZslKKjClhPvutT6CZNN9a2
	cu1Umb0XYBC8L0KPJfNl2YAyOg5vHBAFrC/o7B62saCjxXGVviHyyn9geseqejoIQwgqWM4vbvbpm
	ex1aAdVq3yM33zZZt/FD6IrNJIN0aypdIsSINWtmUahXemzz9+BKJw03Gl2Je9nsP0/LvExfv3Hsx
	/zUqofLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcJ4u-0000000DGHq-20xI;
	Tue, 20 Feb 2024 05:54:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcJ4o-0000000DGHI-3rsr
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 05:54:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A54E168AFE; Tue, 20 Feb 2024 06:53:53 +0100 (CET)
Date: Tue, 20 Feb 2024 06:53:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <20240220055353.GB7554@lst.de>
References: <20240219131531.15134-1-dwagner@suse.de> <20240219131531.15134-2-dwagner@suse.de> <ZdOheNNssYuhBT9w@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdOheNNssYuhBT9w@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_215359_123757_82E29C76 
X-CRM114-Status: GOOD (  12.81  )
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

On Mon, Feb 19, 2024 at 11:44:08AM -0700, Keith Busch wrote:
> The series looks good to me. My only feedback is this patch doesn't
> change anything without patch 6, so I think these two go together.

And it needs to clearly document why fc is different and why we believe
that's reasonable (if we do, I'll chime into that thread in a bit).

