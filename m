Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB95EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jul 2023 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WbeqUwXg63Mjue9IkzBHg2sl77/SvPI+XDchBxbZf4=; b=V13bpUXoM+qvrgy/ire7YwAl1B
	YOpuJjXabUKxd90XqshRNSrjkBVjuQWXNle1kRm51AQEql3+SSZl+fmghFOquGbnI6AfxR+10GRnL
	nUaqXmdmtJJC2QbRor2bfBwqW6iWzSeiwMlS9X3bTsjIXbSA8anYYr0prglZR5DM6526Mu3L46OpI
	QjpudK1GZAZuSwQ1KyaIKcLBE3QEXjzVE0EoYAFmxtOf4xmydVc89ss/JjOulHvgvrP/m+S6fE775
	cFiXKR/AwHBdqrZSztsT65a17X8XxmThcU4ZAp35mHRZyd/kvcR2f+viYv7Y8oG5iYgGm19j/xHJ8
	ou9DWhdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLJDK-003Oen-0v;
	Mon, 17 Jul 2023 08:04:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLJCl-003OZq-2U
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jul 2023 08:04:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDAB60FA0;
	Mon, 17 Jul 2023 08:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF2CC433C7;
	Mon, 17 Jul 2023 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689581017;
	bh=fxCzi9cqQ/6Te9Id+fLIHCQJFVg7LEXG2cA0E+qADbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FISKc+7gCFhCRRl0wkH4LKhJ2TtLo1Zcbd5H+B09PDWFKUUyJcBeJg8VL+QClvgea
	 y4E77RexFfMjBLyDjcaeMg4lWfeICFn4Oveq5XGMC+aUifC1cYMA3yCcRwnIisZhxr
	 Jmpm2nph7AAyTLi77S1ghli1vuBZpaVXqYg9dV3rWYMOUiVBlrmTDD1YOw7pTILx02
	 YQloLQwMXxGqmcyRSvTbK3zNyJJMG3uNkc4gP8mT5NWVi7UDBhl1QN06YpwygQOI9l
	 o8qBEmIhDKjm3J9+L4ZVo00gG+Egb/vpHbwsCXAsatTAhdqhfCrUtZvhHwUBPryh7h
	 4UURKLSAGBsLQ==
Date: Mon, 17 Jul 2023 10:03:32 +0200
From: Keith Busch <kbusch@kernel.org>
To: Sean Wang <wangxiao@hotmail.it>
Cc: "highenthalpyh@gmail.com" <highenthalpyh@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"xuwd1@hotmail.com" <xuwd1@hotmail.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO
 MAP1602
Message-ID: <ZLT11NpGd4hR4yp7@kbusch-mbp.dhcp.thefacebook.com>
References: <MEAP282MB039120C4DEF97CED9B4CE841B33BA@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEAP282MB039120C4DEF97CED9B4CE841B33BA@MEAP282MB0391.AUSP282.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_010340_652662_13207A61 
X-CRM114-Status: GOOD (  11.81  )
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

On Mon, Jul 17, 2023 at 07:41:26AM +0000, Sean Wang wrote:
> My two SSDs are from different companies, but they all use MaxIO 1602 nvme controllers.
> 
> After applying this patch, they could work.
> 
> Otherwise, here is a workaround to make live cd to recognize these SSDs:
> 
> 
> echo “1” > /sys/bus/pci/devices/0000:02:00.0/remove
> sleep 1
> echo “1” > /sys/bus/pci/rescan
> 
> Where device id (02:00.0) could be found via
> 
> lspci -nn -d ::0108

We have a generic solution for such devices as of 6.5-rc2 so it should
work now; however, it's still recommended to get devices with this
behavior in the quirk list in order to ensure that the we get udev to
generate deterministic symlinks. Since this controller is used by
multiple vendors, though, it's unclear if this quirk applies to all
variations.

