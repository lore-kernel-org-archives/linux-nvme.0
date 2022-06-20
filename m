Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6F9C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/vDfXslr0zvxG2cuD/6uevm0CjqM3c5edKdk2ZAG00=; b=aLof86q0UZq0AYvfY+X8W03uAm
	THUT2tsJw50QtjbWOMowNp3YOgn62JHNUKUSummE9VD1fkh5XG8q8t8+gtWzY7cVT6UR8+a1p7Tmy
	gvbIPev3p76D7Iav0f9ZLL58Xai96GQv47niuIW9gmleWeUC9MJXY0jVbHCRcVcXJN4qM5qCvroVU
	nge2qXb1tL1pgMM1ZEY3vShx/IqtJk0T92IW7R3FJ+8JNEowzsfrRvHfxwbb7/Xlfti5iFYlOqTNZ
	VOFHoelIVQxJhS8PfVV4I62OxEB3YRL1fJ5VU3Du7hEnJR+8ktijiwjixaMEcP3rhSrsiEYUtY/97
	u0386cfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BX9-00GbJI-Lx; Mon, 20 Jun 2022 07:09:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BX7-00GbG6-Fn
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 07:09:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB12F68AA6; Mon, 20 Jun 2022 09:09:02 +0200 (CEST)
Date: Mon, 20 Jun 2022 09:09:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: onenowy <onenowy@gmail.com>
Cc: hch@lst.de, Jason@zx2c4.com, abhijeet.rao@intel.com,
	alan.adamson@oracle.com, axboe@fb.com, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	monish.kumar.r@intel.com, pankydev8@gmail.com, sagi@grimberg.me,
	yi.zhang@redhat.com
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was:
 Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests]
Message-ID: <20220620070902.GA11418@lst.de>
References: <20220615113106.GA10697@lst.de> <20220620033627.8728-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620033627.8728-1-onenowy@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_000913_708364_042C2B6E 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 20, 2022 at 12:36:27PM +0900, onenowy wrote:
> Some samsung SSD for OEM also have the identical PCI-ids and are affected by this quirk.
> But they have different subsystem-ids.

> Addtition of subsystem-ids of X5 to pci_device_id(as below) may solve this problem.

Monish, can you look into that?

