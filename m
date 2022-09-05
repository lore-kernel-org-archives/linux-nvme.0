Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD433ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=JO3qJJ7qKAlBGPnq+fE0tdZ0tW
	wiWj16Uq0eqi7ReUuEXUSJK0oLNqnW9qK2uCxii40BmaP2Fi0ArEIFEVE3/PbXK9fnHKUTZFDpNSH
	vSBmXdKpt44Piw1ovgTCCZ9wFbDFZtWqNComAxlnIjRb+EkWol0OD0s/Sgerp8SWaK5z3ywL3cpuN
	yxtFQIUmRbJD0D2e9teVoTaaXh9UF6ndrn1c2SW645iOBVi7XvvTwaqLDKMOttXkf6OZVS8LNPAm8
	+2VMBtScQqzDcYxBsixWJiA9WOrefUZqQo1v5EKkKMduRNP36YKuoCISRj0jtkbLRG0Z2thd5FXm2
	aL3uZTfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCmO-004AyV-BD; Mon, 05 Sep 2022 14:08:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9sk-000ooQ-JV
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 11:03:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE77868AFE; Mon,  5 Sep 2022 13:03:05 +0200 (CEST)
Date: Mon, 5 Sep 2022 13:03:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: move from strlcpy with unused retval to strscpy
Message-ID: <20220905110305.GD21823@lst.de>
References: <20220818210052.7133-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818210052.7133-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_040311_558341_0ADC6FBD 
X-CRM114-Status: UNSURE (   9.14  )
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

Thanks,

applied to nvme-6.1.

