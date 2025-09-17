Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56949CAC59A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Sep 2025 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wDvGVZzm00wFWkUg5i2UTIrSHaqK/lo6stUlZetY6+Q=; b=mpbSm9q2J/4s5Al2hHF7zbNLcF
	GSkPOkvMrQM9pefZqkwy4tZgNEuZgp/IY+HyWRWo6B6kUNjcp2JUxYcHTo6pZK/hMnCtVJWQa/gaW
	029vX6aQ1UbVgtrBz8R/WtlM9r9g0X2LYxqyD6EX/7R8gdFeSqgJ7gPP9omami0boleOfeLAf+O9Q
	Qw6ueBl9/W6XAaqaMv2vV07YyWHXQBlGUA8ko2BayxisAqVWg/6VZAIH2SYJjxMCa7qGwgDG71LOq
	4V/oiQy7FkNsi0T2pZU33wQ0gK6D+Z4HROfwgX8hWBUeEBp5wpLn0v3g2qClEVC9TwH1sAT/zcQ6g
	asin+D1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzw6-0000000Ezdr-2CsR;
	Wed, 17 Sep 2025 21:43:34 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzw3-0000000EzcE-1WEP
	for linux-nvme@lists.infradead.org;
	Wed, 17 Sep 2025 21:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758145411; x=1789681411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4JOcVTSCeEfgOssAtyQSaAtfoWGzYMGWH/ZaLvB0CpA=;
  b=fKG3+nMoWq8tAIcGXbU1KaojAEbWhimgL0a46baE6CbQhF4VVtavAZbM
   N6GcM7jb7iG96Vi53luzeAIxbEreAxS9U7BNGQolJg8y4mHkSuoJuvnpq
   Kq0l80RiYfRi8x7Qx5u6Jx7Kzpl6H5HvBdtlfFr1F6nPzgqkyoKRgSZOs
   xTdo2PD6rvOV2CH3k43o7/JNxK2vabJZMmL1NSJCYYGPwLKypzmWDSb0j
   ggD/oK0ZjY294MlPbPFJyZ7FCxc/WYJFpNNXA+oOKbNHgaqhrXAaO7QGm
   Q6OaZj9/k37v6h1FiJS8ocxVghJGMzT7Ur9DJFr/ElhoJwdKS8Vq1iUmm
   Q==;
X-CSE-ConnectionGUID: YyyiomojR4+e/wH2DGnJwg==
X-CSE-MsgGUID: SVroYaDNTmiwQDf+mlOoNg==
X-IronPort-AV: E=Sophos;i="6.18,273,1751212800"; 
   d="scan'208";a="123094267"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 05:43:30 +0800
IronPort-SDR: 68cb2b82_pKLglazghMeXXyHWz3loYVRTCo+yCZNU7JwL36f6sdngJ1I
 Aq6Yt46a0LG0Ipklu9pXUKl7qV75WUbh+boSw3g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:43:31 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:43:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cRshf3lh9z1SHvj
	for <linux-nvme@lists.infradead.org>; Wed, 17 Sep 2025 14:43:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=in-reply-to:content-disposition
	:content-type:mime-version:references:message-id:subject:to:from
	:date; s=dkim; t=1758145409; x=1760737410; bh=4JOcVTSCeEfgOssAty
	QSaAtfoWGzYMGWH/ZaLvB0CpA=; b=mWAXJQHhbOUuvwoxwa2MSzY1dOq/Okrc7c
	Uz2S8uS0mIYMqZminsOypUjQ4mVZkD8Zds85sRnc/SgrSM8DWsF+gAa5fwi9Oeah
	N3RZGbojbZI/qVayVOr7lkvU+LOSS/tasNh+BSp9Pq1GGpW2piGE4meaT44Mxh/9
	hDnZ79tTxs0DbJUtbFcL9BPWQYlCcZMpUTJAOWKGVnbyfKC4yJVqGxtx7IrLtD6z
	rfx9nA7ZnNYiQPjB7p3OpMKpmnBEX90xCZouUOXUBkxYnsRTXG+gNXD375arDSlZ
	UIftvNzOpNY83mLaiq9VW/0aizaWYLH8IcdCqu3S88MmZuAHTWHg==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0mRIO-rLmj2R for <linux-nvme@lists.infradead.org>;
 Wed, 17 Sep 2025 14:43:29 -0700 (PDT)
Received: from opensource.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cRshd3FDSz1SHkR;
	Wed, 17 Sep 2025 14:43:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:43:28 -0700
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v2 2/2] nvme-core: do ioccsz/iorcsz validation only for
 I/O controllers
Message-ID: <aMsrgNycCQOCO9Sd@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
 <1077309c-2e91-4f0d-b8a6-69d3f9d60cac@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077309c-2e91-4f0d-b8a6-69d3f9d60cac@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_144331_405425_C46E248C 
X-CRM114-Status: GOOD (  16.34  )
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

On Mon, Sep 08, 2025 at 02:57:00PM +0200, Hannes Reinecke wrote:
> On 9/6/25 01:25, Kamaljit Singh wrote:
> > An administrative controller does not support I/O queues, hence it
> > should ignore existing checks for IOCCSZ/IORCSZ. Currently, these checks
> > only exclude a discovery controller but need to also exclude an
> > administrative controller.
> > 
> > Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> > ---
> >   drivers/nvme/host/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
Please review and provide any feedback for both of these patches.

Thanks,
Kamaljit

