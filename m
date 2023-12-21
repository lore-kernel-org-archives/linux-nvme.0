Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50335C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQpInXFFIQfcL83JuwNIpnn1b0O5SA+S7KATlZFf+/E=; b=mjeo3WHeDiarUBY9m/YIqJvw05
	K3Edt6TYoRtG6oV48oZkFeghuIW+rOyqj0x+v2d9VJ52w9dqEblyfJpDviFwqM5hSkNE/UbpL4RY6
	AbYUio0QDRsECej2Yu5uRXgMDIITJb/lvB0TcaBriR8bpoAcnH8jyjHYHMd1TZMF/H11mDGd9VcNs
	/y+bXJRDOz7eNkRdVqYJkq07LhlI3SoQm3w+2jum2R76zIrkBgiabIhu/jGUbowoozwx6nCs5ufnN
	OOhbZnPZJIC/hySY2rbIdv0mrGGcL1NzrBG8UrPLWadfDNusROtr/mXzc/5eI33UwdJKOTU4o6tKu
	ZG2gbXdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMkH-003dGR-2W;
	Thu, 21 Dec 2023 17:22:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMkD-003dEd-1b
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:22:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AD43361A0F;
	Thu, 21 Dec 2023 17:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25EC43395;
	Thu, 21 Dec 2023 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179320;
	bh=+OShkygO8b4TtyCowaquUJybB98QixWea8yQOCFnN+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBdxspNV9AGy+GpRpgr8Lj5PhOiZTGmZSAL2pSf4fjES2t8dmf+zUkc49KOeUV14u
	 GJuS+NRsoaR5sTIGsqiqGnHLzhKNWZq/hFS4lrB0IwMSvbL4Z1E3GITxhaaiTRKFNM
	 2jWUgox7LIdgDo6aW8QS5HAdtRFi+ZGJTInxssaVwMbxH9iFhGPKOiCU0j+bLcqx17
	 nPjSRUNJwo8/gI+5Y76Eec8j8mvci5m5k0F1PFn7IV/r70/dBdT0zdbuZ6yczv8oIF
	 LFG4NfA+hLZEtc9lZJVQ8ZCZLmNoyD1eGby0fdOIhkjNCnoXtQk/TSINDyLUWLNEaF
	 SC+WGXuPQUwhg==
Date: Thu, 21 Dec 2023 10:21:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	james.smart@broadcom.com, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme-fc: set numa_node after nvme_init_ctrl
Message-ID: <ZYR0Nk5SwI0Qqb9Z@kbusch-mbp>
References: <20231219174934.20400-1-kbusch@meta.com>
 <26567ee7-cef8-4484-ad8e-d8b6fbb1d1cb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26567ee7-cef8-4484-ad8e-d8b6fbb1d1cb@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092201_576268_631FE9F4 
X-CRM114-Status: UNSURE (   9.08  )
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

On Wed, Dec 20, 2023 at 03:43:03PM +0200, Max Gurtovoy wrote:
> On 19/12/2023 19:49, Keith Busch wrote:
> > +	if (lport->dev)
> > +		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
> > +	else
> > +		ctrl->ctrl.numa_node = NUMA_NO_NODE;
> 
> We don't need the "else" clause, it is initialized to NUMA_NO_NODE.

This was just moving the existing hunk, but your suggestion is a nice
bonus cleanup. I've folded it in and applied for nvme-6.8. Thanks!

