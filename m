Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90354C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHIHnaUmLfkh8rKpGuolgb1w+x1anbd90wYZ28yT1J0=; b=L8jyX/8DRbkD3M+6o+XM6h6Ggh
	CH9zBNv+FMda4d6+StEX9n5LDajbVvuzz72En08GOJqKvJ5yOKPLKEv83nYUcMuAFJjpipMDl+6gY
	r4ZaWtu3cQMy2M8duj2SxrsOurh7vspWbBhxmvytzCDIDfJoSS1/FsFDPSh8rqajWApkkOKSF4z1r
	HAUM+8MeqG27aYpiNQnXQ/2I2RCtr4PrS7gKvAafZVBfYqIJ2PelRgGf+FqMBMGyKkV6Vk7i2/LkS
	Q+S+KcRtouaTEmhcewQ3yTVfkgeoPEs2G2wFSd4tqIcpRa8nyp4b6icamakLCfTvNj0QT/J4MXXCF
	gJYxpnKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzj1-00F9ij-MX; Thu, 14 Jul 2022 14:21:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBziy-00F9cZ-Fx
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 14:21:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EABF68AA6; Thu, 14 Jul 2022 16:21:39 +0200 (CEST)
Date: Thu, 14 Jul 2022 16:21:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvme: Fix block device naming collision
Message-ID: <20220714142139.GA22724@lst.de>
References: <1657802530-364205-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657802530-364205-1-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_072152_721021_0EAB5A33 
X-CRM114-Status: UNSURE (   8.07  )
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

applied to nvme-5.19.

Incidentally my refactoring of the probing also fixes this (and
will have a small merge conflict).

