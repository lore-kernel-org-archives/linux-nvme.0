Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D35C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Bta6uh+/S8ur+ikl4X0ejv9pRv/76aMXaS+owY3HiU=; b=zlXDBUIbWYczTWCXg5Y/DtYkDM
	fFzSz8/CgngBGbVqtGSeiNFeUCkqcuKlKqWQ5bRZeAsPZ75v43yByff59RgApytTg3R6dIvwjL8b2
	f0mLSjiB5X2138x8J2Dk3wtsCLnToAppbcpEaE6Ys6HoTf/S4K6LNuqKoGwkKLtzRAlkCRDAUEyKx
	bV/NNBNetnRYWZHy0bvY2AQJty1wdrbePSt0ayJe1P3BrG7tTgUujI+QGbwEfqY2aWgi53H1JiHvk
	okYYlYHnQWk1tkFdapdo7bbCQop6eNHdsOkL+jOmh/DfKrzuQqGlwx506l5xGkQ7eBG7sDibl6xxN
	8y4cA3pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe3f5-006Hm3-BV; Fri, 30 Sep 2022 00:13:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe3Lg-0068Nh-Le
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 23:53:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D9DDA621EF;
	Thu, 29 Sep 2022 23:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F59C433C1;
	Thu, 29 Sep 2022 23:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664495627;
	bh=zGoeBEsQFYR1XddbT/4DDXBJnqm/WcRswhc2BoBKNsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei7KWbmfxEJw0h3HBiNrGSOWNuOiEfbtjZ6aLz3C+GQXZYR5ZkazD9oPv0kBuK1n7
	 W2jsgUdNNk/ewDV565eh/s05q8gpUQRiWl2sFn+jNlH6ZpebjUsbMNwzXaw/gVQJ2x
	 fJ8b96KylIqy1qU1FK18niUAimozIpikL3DDS9cvmlUx0V5FYCtt3bSKEO2We0eTUI
	 5PKr/gKxyey9anLVcOyVoSUNBRiZGBnSctC6mG5ABKMJ6Ld6GZQ9UhoZVrjGm7JRh7
	 4h6JdMMfrEvifxwtr0+lwDbXMynTptHBnu4QF0xGsHAYBfcwyjFkpbQ1OcMhwQfg/E
	 qXYS07xGLV4Gg==
Date: Thu, 29 Sep 2022 17:53:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_165348_780174_235466F2 
X-CRM114-Status: GOOD (  17.11  )
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

On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> Inability to allocate a buffer is a critical error which shouldn't be
> tolerated since most likely the rest of the driver won't work correctly.
> Thus instead of returning the zero status let's return the -ENOMEM error
> if the nvme_hwmon_data structure instance couldn't be created.

Nak for this one. The hwmon is not necessary for the rest of the driver to
function, so having the driver detach from the device seems a bit harsh. The
driver can participate in memory reclaim, so failing on a low memory condition
can make matters worse.

The rest looks good, though.

> @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return 0;
> +		return -ENOMEM;
>  
>  	data->ctrl = ctrl;
>  	mutex_init(&data->read_lock);
> -- 

