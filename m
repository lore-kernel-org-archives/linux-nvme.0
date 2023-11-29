Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA81CC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bcr7YI1zKPWjLEfoDfiTAQ33I/N4mEzfuEXEbPDzSTM=; b=wr8QnkjDD7L28ikDXJNkAe22UA
	s4ZoDfgUFroSPT7TBqXVJdLA7FuKIp38ADeNtusY4OkcbMX6ASo+5jqvMoluPBOoo/KrgYivTSg3B
	oNi4ILN9ZxDt2jqFRAvVRCtGdAj7fmtXOJutqpE+V5bRM0oVOYvJ4s+EOmBDU7+FZVqNHe51Pmvex
	5qkbDKKTR3OhPAQyXeo94+HNqEvlI/U0Unp7tBioV+KrJaC+PWhhjVllBe8dNACV8ydGDKwErm6jM
	ugcYbYvUnHlZh9mTf9kkqtVxUABUGZCKG8gmE39nUJz7s+w8ALJpB87870AzBM9hffqdmnjsWpihw
	/EPmSDcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r889S-006e4j-2J;
	Wed, 29 Nov 2023 00:10:02 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r889P-006e3z-1K
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 00:10:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 69781CE1D0A;
	Wed, 29 Nov 2023 00:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48EFC433C7;
	Wed, 29 Nov 2023 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701216595;
	bh=m73Trz87dPQgImAcfxCzaxmbSK2YY2Ek+G0J2e+T4XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1AHvE14L3YQOefTK8+GgjBEgn0lUAjnW9vDqnzKHN2p72Be4Axcvp44XbEt5fLHv
	 sTmBVE9Ov+n+zAuTF0kLf2KL85lJr8O8erbCDusuuhB/8EoFs0x3bwzIs6sFJlK5XK
	 wAWQw+OMrjqAHWxK6B83Opmy5Bx+l14ZfpUyvvNqN/79BbOIM9MtlzWdz6NygmUhsr
	 R2xbrLTyEa78hOFoe/UM4oMI4ZX+7uzL3qQNGChBYTQbbNnBS0xiFnVVeyhfCe58mm
	 jzfgwwGTCb6I/7MMt+gpBCGjeEj9bBxCUWwFAqxo57SAqmTsIWpdBgvI8ECJ/OxbmV
	 VnzWrtzlZHfVg==
Date: Tue, 28 Nov 2023 17:09:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: "hardaway.tseng@sk.com" <hardaway.tseng@sk.com>
Cc: Jim Lin =?utf-8?B?5p6X5b+X6J6N?= <jim.lin@siliconmotion.com>,
	"Jim.Lin" <jim.chihjung.lin@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	CJ Chen =?utf-8?B?6Zmz576k5YKR?= <cj.chen@siliconmotion.com>,
	David Yeh =?utf-8?B?6JGJ5a+w6J6N?= <david.yeh@siliconmotion.com>,
	"sangan.han@sk.com" <sangan.han@sk.com>,
	"ives.lu@sk.com" <ives.lu@sk.com>
Subject: Re: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Message-ID: <ZWaBULOgInxbp6JQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
 <SEYPR01MB4341EFAA7D4B563BFF903B45FDBCA@SEYPR01MB4341.apcprd01.prod.exchangelabs.com>
 <71aae1b4cb0441d0940a5e536f4ffce0@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71aae1b4cb0441d0940a5e536f4ffce0@sk.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_160959_661455_562E9DCE 
X-CRM114-Status: UNSURE (   9.28  )
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

On Tue, Nov 28, 2023 at 11:51:42PM +0000, hardaway.tseng@sk.com wrote:
> Hi Keith, Jim and team,
> 
> Thanks for efforts!
> 
> This is Hardaway from SK hynix, this software change has been tested and verified by ODM Compal, the testing result is pass, therefore, we would like to apply this update.

Great, thanks for confirming. I've got this queued up internally, but
want to check if Christoph's question could lead to a better outcome for
everyone. For reference, asked here:

  https://lists.infradead.org/pipermail/linux-nvme/2023-November/043298.html

If you were already testing close to upstream, 6.2 or newer, then this
patch is already the best option.

