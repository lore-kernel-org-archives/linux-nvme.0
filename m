Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7592C4167D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSWVnBF2dLcqQxv/l5drzVHSE9YKSk6saMu5opCior0=; b=Bip46bGl8uYA9AcbjX3dZ2Bf5E
	KJIDhx5RJ8oNmDZlr4A/0As4HBswFlnzWIz4LxdcCxZk8LKlsMaLqO/3s6JnY8EMIMkjdUERp3yxf
	JE88SNgtwHX5D6fF3l8LiP8VeCb6lvNsTY/8wmNr22IkExdIZlbUSVtvIMAPe4+xxwDUA0sNFqXUx
	i3HrAOnsSesilPM+mZylKaykC6zh5+h6SMNfxIPCjq4PcGGBmCVmx51ODdNJJe8UCVgDAOQLC7ZXU
	1nbm3ANCPGA3Xs2ybgwnCWz4DihxbGibhcJcZLVMIwPnwX2p/bqPkeMJrUAcwQV3oV+U1FIFMUwgn
	nvBNyF7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTn5-003WuQ-09;
	Mon, 30 Oct 2023 15:02:55 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTn0-003WsG-2E
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 15:02:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 180ACB80781;
	Mon, 30 Oct 2023 15:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC11C433C7;
	Mon, 30 Oct 2023 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698678168;
	bh=HZ3Ha4rMhluR/cnIvD4+pZKPzbOWuqqbVllRMsRZcNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b90S/syrmiFfKANW1rMs6SDRfIVVQqjZZxL7UiiJksBYlm9MTD8zenrtE70wqr0BD
	 LhZoBkxLKim2fybQa9nrVdd5MdYlV2aLs7RkJJ5dpNuwayc7Cl7taCAnM7jNRMqG65
	 FGYfgLunpPsD9xmP8jsRumpV5xXBP3Dw5SwwgHSdVzMqntVNXtvGjrq5ZaxqNiDDaf
	 hAVeFtM+dTqqdhSSHHSkab/Aqzn5PIsqFxwZluHqGFLRsdboDRAiQTXmUmYK8oDzna
	 O8rTWHvU521mPhLxfZwtqqrHiyIYw9+vsEtpHPB6v3OxJ3IHq8AgmRt0issMqOaNQS
	 aUBksnbFS2nMw==
Date: Mon, 30 Oct 2023 09:02:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-tcp: Fix a memory leak
Message-ID: <ZT_Flc9XuDdB9clo@kbusch-mbp.dhcp.thefacebook.com>
References: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_080250_856632_788DDF16 
X-CRM114-Status: GOOD (  10.39  )
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

On Mon, Oct 30, 2023 at 03:49:28PM +0100, Christophe JAILLET wrote:
> All error handling path end to the error handling path, except this one.
> Go to the error handling branch as well here, otherwise 'icreq' and
> 'icresp' will leak.
> 
> Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, applied to nvme-6.7.

