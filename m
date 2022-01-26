Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BDEC2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=JwiuXHyTu9CNpW1620gKyj0/G5
	y+VPTPueTi3oOl0iZ324IhZ28cdNJpQ6gLq7P6rIHgOmYpGbyE1aO6/N5Rz34bpe2nm6PBYrJY92M
	ZCAxv1SbfPsa1c05efXMIZ72Wr1P9frtPJeRq+s6u0wEQayhKhpC4bNlggxAsHAgI2E1cScDCL3Ii
	tXAafHUyJKncuM4iVe390kiZ0jJIlGVkR4dCBb8ljh11563RUCj64chMt5wgOCj/0Xgms/HG7sDlP
	MXA56UVgp+sfs0HFasCKTlAK5AwesPPkhwGoPw5IDc0nNi7EV21opifeTVmj1r0ujByX3LAJQMx7g
	25R+3Bnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nClsd-00CvO0-Tm; Wed, 26 Jan 2022 17:14:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCkz3-00CZvR-UW
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 16:17:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C22EF68AFE; Wed, 26 Jan 2022 17:17:17 +0100 (CET)
Date: Wed, 26 Jan 2022 17:17:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme-core: remove unnecessary semicolon
Message-ID: <20220126161717.GA31376@lst.de>
References: <20220119074954.13531-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119074954.13531-1-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_081722_182333_A0490889 
X-CRM114-Status: UNSURE (   7.69  )
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

applied to nvme-5.17.

