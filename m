Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAF6EDF022
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 02:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smzZ3x+/CxGIjF+viNzPyt2GtLxFj2phL7txTq/UcDM=; b=Dwq3X6TCJDpH4yCAibjsQEGTk9
	tFWumxp+ysSIXSgOaTYkfHNMJy+kai5K79K616/ELcwEze1TqYiJhLf5rtTdXBiBfgmEYjVjZji+3
	DDnhorOluYItsH7LSQuK+4su6k684vmmt+sGm4p22Pu++pI0MN53QXAdRqa2cW5P/pI6F9ujnYjsi
	96cK+3aqKJBDKlNMCD4LuktYmh3jaZqscxNWnWdMhUhW85ii3I8d0dvoYYXqnXVNmqNqWMBjxY+8a
	gqQsa3/2v87kurM1ChKvzEcsGPXVkEC0+LEDHVXEoR54lyFaoBOZcQHRWUykNtI2+giB9CvgK3lFb
	1Ys8in8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMWj-00000001JfS-1cnC;
	Thu, 12 Feb 2026 02:33:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMWd-00000001JfM-2j9P
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 02:33:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B4A1660010;
	Thu, 12 Feb 2026 02:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A6CC4CEF7;
	Thu, 12 Feb 2026 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770863630;
	bh=LCKDlHwNxzpvyQYOzrSr799I7q6hXsARLD78taO+pvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k71/xhryxbYZDyeQ/IxOGbvwlwPbSsUoJqvXT8gg+VDK0WJoZEdHstWtS3+SkFWDF
	 G/cVY38UDzkHvAshv6xjy8LzR/cC/3C8X8nCfUXGws2ZXBgl0fc9UnM+1r2ceAucyR
	 k0ag/59OuF4XZdGjPsp8tIskeDONXAtvhxb7V5z8wGAq4a1g8PKbjL+cW5aTLZYApN
	 Z/+ciX1gulKFXIdoDtMh7/Rrpqw/WULsHem7FqNBsQZqrZG8kpzSsPYj51IQ1YfKOK
	 EnOVBGaKgSwGEEWVkt8EG+hclrBd4v3aH2iCyW69l2gI8OV1Am2Jag1kyJEgZ3qkej
	 BE/71NVLn4Wsg==
Date: Wed, 11 Feb 2026 19:33:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: hch <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4] nvme/host: fixup some typos
Message-ID: <aY08DMHh8G0wqPit@kbusch-mbp>
References: <20260114063722.68846-3-wilfred.opensource@gmail.com>
 <18e09860f731dd83c206e286f570ac77a5186ce9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e09860f731dd83c206e286f570ac77a5186ce9.camel@wdc.com>
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

On Wed, Feb 11, 2026 at 04:28:53AM +0000, Wilfred Mallawa wrote:
> On Wed, 2026-01-14 at 16:37 +1000, Wilfred Mallawa wrote:
> 
> Gentle ping, in-case this got lost in the threads :)

The previous version was already applied:

  https://git.infradead.org/?p=nvme.git;a=commitdiff;h=f947d9e77b26238b821b5227afb4fee8c7ea0d5a

