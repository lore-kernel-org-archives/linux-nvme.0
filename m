Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4FEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUrEJeAR51v0SiAU5D7Qt+Udlc5TjMSGkC/jwjN1UYA=; b=kuQMB08msc3pa2Nul7OG3TMmKC
	M12Y1Pqf6E7S9+rwjMpk5htO2acxGnBdgdjVuGPUMKC7ku9uowbQ4k5B46AO9CGUHLFiOTwVMGbqO
	j6J7LyPAmPCIOEbjAw8d/6/rxT+Pc/m3D7lwr/XDt7LKIzV88bDGTDUeUrB4tNzxz1ozczDRAiF7+
	/ilmTg0+mvTcME2Hboifka57E+8yeTqhj7JfBBnaUlR8ODGS4D47HNxuOehOPylzjYjrJDOe4GBq+
	QloLiif9CVweHG4Y/kC0P3R39BuzjZh377eB4DKF/fiZP/mAT58DRXuwYGJ224fRI8gPeKZS8FM29
	u7RfHYkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpd3i-003VjP-6q; Tue, 23 Nov 2021 21:10:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpd3g-003Vii-AP
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 21:10:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8684A60C49;
 Tue, 23 Nov 2021 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637701831;
 bh=lWQc63Wkkeed3YSVbjpDlgTf4FFwoqSGNkyQhDlRQQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XXb/RLvs66HKsUaiTke8/JThGmy8VI6IHKHnHGMJ7baL8U1lW5rroEFzRXEonYyVU
 3+XrlNvk8kNyvYqMMN2T0dsL1nq/TmK351RUKGjG2K7nvMWreJxm+4PERaEvJa+BNT
 +Z8xDp0ZALViG/vsdxnesXZaunlF+i23sHZCOP5dShX5t75U69WMOIExH2iG1+Z6jQ
 ytlRv1FKXhryTKDnERGrlIfA7BH5WVM3LHWKQs4AlJ2gdP7x+OBtbQ1NVH8VbxJ8Xt
 uciqrrota0iPgSkk5nDv/zVvR0YFvxgOadMjqpUp8PEWXG/y+5QIm9TVbet5q4N0nW
 d6kR8CPaUhjgw==
Date: Tue, 23 Nov 2021 13:10:29 -0800
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: disable namespaces with unsupported metadata
Message-ID: <20211123211029.GE3540867@dhcp-10-100-145-180.wdc.com>
References: <20211123174554.3574990-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123174554.3574990-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_131032_415700_0E4F8B04 
X-CRM114-Status: UNSURE (   9.27  )
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

On Tue, Nov 23, 2021 at 09:45:54AM -0800, Keith Busch wrote:
> The only fabrics target that supports metadata is RDMA and usable only

Sorry, the above should have said:

  "The only fabrics host driver that currently supports metadata is ..."

I believe the spec allows all transports to support any arbitrary
metadata format. The drivers just currently aren't able to, and we can
update this path as they become more capable.

> if it is 8B per block, and formatted for protection information. If an
> rdma target were to export a namespace with a different format (ex:
> 4k+64B), the driver will not be able to submit a valid command for that
> format.
> 
> Suppress exporting these namespaces as read/writeable to the block
> stack.

