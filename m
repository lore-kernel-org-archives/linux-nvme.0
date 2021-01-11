Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D28C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 16:19:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74042247F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 16:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74042247F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nfp4UZ3+knK/WrpbjPHsM60Hn+r9jqmmgirEinbWjAk=; b=OkdEu/aw+5ko8bINPe8GUeVGR
	XM31HoMwqeMAuR/yuMKbGY0r3wnhM/PApo9HGdkn+7Sk0c81VbP2oBnieTECB2kFD37vhDZixyvG6
	zxsV4UeGxbdV06Wmyo9AIF/k6Ti48BQ5HuaNF5wC2FbzbqJgMXWbNC8Xklvv0ZvOOrvsxvYfiaRfo
	BXmuoMjfjC/4EXPa72AQl4M9KLcC0hV/U6ob1Si6Lk/cW4Fjva0dvQsElYQqd0NNroTMEr9ICzGFh
	k/W3Cpfn5UpOfmgpSHqLw+J8UTYvzRsA/9mvHwdOKqax2Bk6Ijc7SpS0YgvgjCBBc+rUGg56Ky3nR
	B4A2NOYlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyzuI-0006kJ-1O; Mon, 11 Jan 2021 16:19:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyzuF-0006ix-NV
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 16:19:00 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8F6A4AD57;
 Mon, 11 Jan 2021 16:18:57 +0000 (UTC)
Date: Mon, 11 Jan 2021 17:18:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210111161857.okecoo4h4b4prpic@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
 <20210104210610.hliiupywksawgei3@hyori>
 <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
 <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_111859_883708_8D4C8747 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Enzo Matsumiya <ematsumiya@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 11, 2021 at 05:00:18PM +0100, Hannes Reinecke wrote:
> Yeah, using the controller node for devm allocations is quite dodgy.
> Does this one help?
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 6fdd07fb3001..7260af028cf7 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -226,7 +226,7 @@ static const struct hwmon_chip_info
> 
>  int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  {
> -       struct device *dev = ctrl->dev;
> +       struct device *dev = ctrl->device;

This is what I tried. Yes, it fixes the obvious problem and moves the
hwmon entry under the nvme entry. When the nvme is destroyed, the hwmon
entry is not accessible. But as ctrl->device is not managed by devm the
resources are not freed.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
