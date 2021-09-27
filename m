Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C357C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0535160F39
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0535160F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=edlQzrUJjizJGWmjBy8zHo0TCvZ4700aI5ro1CqIefE=; b=DFdEgdC8vC58nB
	WilFXYZwiCJmEALZEz7S+DevgvwZKfYJ+7Q353CEkbJ6449ap3G2YvgUvtWxC0zfsnBniCWp8AKsc
	9nW6ZD74DD7Rb1u3FLrtCdNaiq6Id+9zm+JRw4I7iUAh7s3+ldBTGDoGySqXodlthFMa9rhvVmwtG
	K8YkZW6uhOdKvwc9HxYYh7Xuv6FoHgPKs83afF3dX3cUHKHhw5Ko6nFqI/8NCorsJFpRArHPYqzZM
	fwAzIKLeX8nb2R/5P/gvzVwDSDMmlFOe3sfEyGsD/8ZhTt3y9EyKdyL1a0P/yncN/tSV1WxJOuCeO
	vKJBbupaW61IUg+3ipoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUs9h-0030Vo-3T; Mon, 27 Sep 2021 15:02:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUs9d-0030UD-Rj
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 15:02:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC38F60FED;
 Mon, 27 Sep 2021 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632754972;
 bh=NOnXKz3j8SF7vlCFUvHvs5X4xIJFwfY2ZbVXhTcTrwI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XMaBKXiDeZdKN9ENJh8WDYkhbQxEE/tE7UWhY7FlgduHrpeWWtgxJ6NC+C/b2deJ5
 6FnIjyM52Guvmwd9NiUmUV6uZcI/zATz7lQcGAe2AQPSv50DqxvrwOiqEjPEc1q8t3
 aTA1a4B33/Wh3qG7C2R2O2btYC7J4ntjyAp8YXJB5KxR/3za9pajrvTHUlbCFVzGuc
 FG3jOXuIgGEiJL/Opz6hu0wcbHn4TpByvOsSgwChqZyzZFg/fWIjRIMR2TqQaAWrmv
 +Ws+9Zan3zWGmHhphwILYYveKZyHO81kp7O46gLKXaUY3sXYFtEnG9LDEyI3JTtrRD
 mWmmTFNWwpyLA==
Date: Mon, 27 Sep 2021 08:02:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Aditya Garg <gargaditya08@live.com>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "hare@suse.de" <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>,
 "hch@lst.de" <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Message-ID: <20210927150249.GA148020@dhcp-10-100-145-180.wdc.com>
References: <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
 <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
 <1b5d6bef-db6f-073f-8d24-4963f0df82ab@protonmail.com>
 <PNZPR01MB4415801C6084E8CFD068A84AB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <d65ecc69-35c9-4400-8fb0-95aa04360b03@grimberg.me>
 <31c4dc69-5d10-cc6a-4295-e42bbc0993d0@protonmail.com>
 <PNZPR01MB4415F35759F136E812A8F91DB8A79@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <d4fb602c-43ab-4b5d-93ad-fa9116462dec@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4fb602c-43ab-4b5d-93ad-fa9116462dec@www.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_080253_959865_48445470 
X-CRM114-Status: GOOD (  26.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 27, 2021 at 08:05:00AM +0200, Sven Peter wrote:
> Hi,
> 
> 
> On Mon, Sep 27, 2021, at 06:51, Aditya Garg wrote:
> > I am getting the same error.
> >
> > ________________________________________
> > From: Orlando Chamberlain <redecorating@protonmail.com>
> > Sent: Monday, September 27, 2021 4:22 AM
> > To: Sagi Grimberg; Aditya Garg; kbusch@kernel.org
> > Cc: linux-nvme@lists.infradead.org; regressions@lists.linux.dev; 
> > hare@suse.de; dwagner@suse.de; hch@lst.de
> > Subject: Re: [REGRESSION] nvme: code command_id with a genctr for 
> > use-after-free validation crashes apple T2 SSD
> >
> > On 26/9/21 18:44, Sagi Grimberg wrote:
> >>
> >>> I checked out the proposal sent by Orlando Chamberlain to replace NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html. The , still causes panics to the T2 as described before. In the case of |, the kernel boots correctly without panicking the T2, but in case we are having Linux on an External Drive, which is my case, then the internal SSD doesn't seem to be recognised at all. I've tested the patch on 5.14.7.
> >>
> >> That sounds like a separate issue, because with this patch applied,
> >> all tags should be within the queue entry range (with generation
> >> set to 0 always).
> >>
> >> Is it possible that the io_queue_depth is being set to something
> >> that exceeds NVME_PCI_MAX_QUEUE_SIZE (4095) ? the default is 1024
> >>
> > I've been able to reproduce it by using the same kernel Aditya is using:
> > https://github.com/AdityaGarg8/T2-Big-Sur-Ubuntu-Kernel/actions/runs/1275383460
> >
> > From the initramfs:
> >
> > # dmesg | grep nvme
> > nvme nvme0: pci function 0000:04:00.0
> > nvme nvme0: 1/0/0 default/read/poll queues
> > nvme nvme0: Identify NS List failed (status=0xb)
> > nvme nvme0: LightNVM init failure
> 
> Maybe I should've just submitted the quirks required for the M1 already...
> The ANS2 firmware on there doesn't support the vanilla nvme_scan_ns_list
> call. That should not break anything though because core.c falls back to
> nvme_scan_ns_sequential in that case which does work. It just results
> in that "Identify NS List failed (status=0xb)" error message.
> 
> Not sure where that LightNVM failure comes from though. Afaict lightnvm has been 
> removed from 5.15 and shouldn't be used for the Apple controller anyway.

Yes, lightnvm was removed in 5.15, so the quirk bit identifying these
devices was removed. The patch was made for upstream 5.15. If you want
to backport it to stable, the bit will need to be changed, otherwise it
make the driver think its an openchannel SSD instead and fail.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
