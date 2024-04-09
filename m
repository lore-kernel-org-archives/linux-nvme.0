Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B827FC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1Hx2qrqBUYl/KNO9ToCxD5wNKmEai5c/5smTxjY9Ek=; b=WH/hIOvKrVGoOH9ZsBFDOw4Fvw
	zj2k5veUZGMphSqBALye0WpAOgoUWFdx1V1WtySAbkQ9I/EetBz4pqOSVstVurERbkC/csFlBcXGh
	mqEcbwcriDuQwI8xU5PBgyTkc7kXBLvNn4gDocYgos9F2YYlP5hqX0XnOCKqQdCHkfU9vfbBMzud+
	booaNos2DusLkaA/0HrLWd62S81VkvFrqx7qxQQXW4fp8q41ZkP3mYvjW1iALBuxRIF0ELqQsF9+j
	hlcujJSbYdQ6wyqDesG9/KX3KybEXvlrYhNwa4oOt7LPZWSMkh77kCfraQuQgl8z/gywqtSYyrGAj
	DdY/q3ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHrl-00000003feR-3iHN;
	Tue, 09 Apr 2024 20:14:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruHri-00000003fdq-48M5
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:14:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EB663612AE;
	Tue,  9 Apr 2024 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E73C433C7;
	Tue,  9 Apr 2024 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712693685;
	bh=ibAqeCoQkmuMa06beBnZLbNBG1bw+Wt8jm5FJ7Cf0JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lor+Vqi7BhXthadgCQTo8fDbY3H7ttnAo1JOTzdQV7Yzo2VxCiaEnDcTsS3jEhUeX
	 iWdO6Vz3YsY2pBfrwG4nfhDOZe8BTK+LBmo0ZkAD0QPewbDjxMm5F8F+Gw6RV+DPx9
	 aJJ5F9cMHr2T1y/91kjUyG4d3ABOOyRd1FAe4dL/5WJxb6xBlx7UXiyGe0yh78kaaJ
	 EUPb800+VeBeKMfS+nhM/dYTHfGIaawUMQHwvfaSMAotSD7FW6RyTUsYUVtgnxqLbV
	 MMZL8XplMbLAEV69NkBWJr0zQ5IcMtp2+3nVfIjQ8I3TubHHiPDDQEvcXOMstri7bM
	 gMyo41lA395CQ==
Date: Tue, 9 Apr 2024 14:14:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Holger Huo <holgerhuo@outlook.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Holger Huo <i@holger.one>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Message-ID: <ZhWhshq7hpPd9XrI@kbusch-mbp.dhcp.thefacebook.com>
References: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_131447_163474_4DD6C2B0 
X-CRM114-Status: GOOD (  11.05  )
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

On Wed, Apr 10, 2024 at 03:28:50AM +0800, Holger Huo wrote:
> This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
> Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
> 4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
> notebooks. This SSD produces all-zero nguid.
> 
> Other SSDs manufatured by Shenzhen Unionmemory Information System
> Ltd are likely to face similar issues, but I currently have no
> device to test.

Are you using the most recent stable kernel and still need this patch?
These quirks shouldn't be necessary anymore unless it's advertising
multipath capabilities, and it doesn't sound like this one should be
doing that.

