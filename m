Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F003CC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:55:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD20E20706
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 22:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9MLs23k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xPboe4JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD20E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sy/JcqEpDfwlR4ZdmwqFT1J2n6S/XBqhlBYU5Opycf0=; b=b9MLs23ksxXKd79KqtLComRU/
	gkjGPXV4eDKMV3DloD17KO3ax0JKJHjfraY3l+gMDIbFQtg89lDWnquhA2fvqbuVn4PploiZ1UkLw
	ILB/fWeQpb6vbVyUExfm+KgOSfSaYa4FC4tQJzFucqvVYd413TOP2IDYPFL1fo1hvJ0R2g250uP5n
	+0w6IiXr+/+pH8ZPnntEudKTExrFP0Xnbo5keVhBUkU9vPZ9v+dIinFOKv0uZfQBJdUEmYLV8TP9a
	Af0WYZHAy+OL5ILkGXrAtFlOsdk0ocYaYK/8OwzSK6HoJo6poQw9HepcFGmrHDbiAHWbUIj5tHBpm
	i12nGNDhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kALNP-0007V9-TQ; Mon, 24 Aug 2020 22:55:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kALNN-0007Ug-IU
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 22:55:42 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D64920706;
 Mon, 24 Aug 2020 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598309740;
 bh=9hFqOaa6t/klT97y5YeLUK29jdjlOWa/x3kLroxOQMo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xPboe4JT9TvgzUJzkJOIX6cTJyxBsxJIRsZH4791iufq+7gRWjCiVcu6Km9zHsjmQ
 mHcD+b+RKEaUh+JQh/ZVmUP8TsxrsTwM5Mzwok2jICHuunwB1hGN0Rua/c9Y94FU1X
 ASCbhXuRv+E3ZhJSn621t06epr13se9RlyY23IN8=
Date: Mon, 24 Aug 2020 15:55:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Null pointer dereference in nvme_ctrl_reconnect_delay_show
Message-ID: <20200824225538.GA1688475@dhcp-10-100-145-180.wdl.wdc.com>
References: <59c468d3-b688-260e-b491-581c3ba96a21@markus-regensburg.de>
 <49c95bdd-d55c-582a-a238-74b7c564c228@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49c95bdd-d55c-582a-a238-74b7c564c228@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_185541_747985_895CBECD 
X-CRM114-Status: GOOD (  24.74  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Tobias Markus <tobias@markus-regensburg.de>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 24, 2020 at 03:50:30PM -0700, Sagi Grimberg wrote:
> 
> > Hi all,
> > 
> > I hope this is the right channel for bug reports regarding the NVMe subsystem.
> > 
> > Trying to read sysfs attributes of an NVMe drive resulted in a null pointer dereference on 5.9.0-rc2.
> > 
> > The precise command was:
> >      udevadm info --attribute-walk --path=/sys/block/nvme0n1
> > 
> > Using strace, I found out that the bug occurs reproducibly when reading
> >      /sys/block/nvme0n1/device/ctrl_loss_tmo
> > 
> > I could further determine that ctrl->opts is not set in the struct nvme_ctrl in nvme_ctrl_reconnect_delay_show.
> > 
> > I could reproduce this bug with the latest NVMe fixes (commit c41c3ec4) as well.
> 
> Yep, thanks for reporting, this should fix the issue:
> 
> nvme: Fix NULL dereference for pci nvme controllers
> 
> PCIe controllers do not have fabric opts, verify they exist before
> showing ctrl_loss_tmo or reconnect_delay attributes.
> 
> Fixes: 764075fdcb2f ("nvme: expose reconnect_delay and ctrl_loss_tmo via
> sysfs")
> Reported-by: Tobias Markus <tobias@markus-regensburg.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 537dcd900cb5..2039f5dac4f4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3676,6 +3676,12 @@ static umode_t nvme_dev_attrs_are_visible(struct
> kobject *kobj,
>                 return 0;
>         if (a == &dev_attr_hostid.attr && !ctrl->opts)
>                 return 0;
> +       if (a == &dev_attr_hostid.attr && !ctrl->opts)
> +               return 0;
> +       if (a == &dev_attr_ctrl_loss_tmo.attr && !ctrl->opts)
> +               return 0;
> +       if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
> +               return 0;
> 
>         return a->mode;
>  }

Ah, you beat me to it! :)

Looks good except for the duplicated dev_attr_hostid lines.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
