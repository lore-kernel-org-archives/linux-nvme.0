Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAFEC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VrBtgM7L/EMiyujqSzOf/4EdwnNKHGPhzY1olMdrw40=; b=Ux8U917KjJM9D/M63xL0oI5PRN
	MyCAC6wMfhtMWuGizqktL/RdqmqyYU5rfFdkrg5sqviynKeSSltKIXDw9qKSdkoh1be9OBPWTfLfm
	0cBu4iGOGho2FGGEoHEyaVYcC25tOzo5YLGym3PG0j54evA5ncEdBXxP0jSZSF6IiUjQ+a5PjdZ0t
	M/BAhxThq39WZvLPSLFWZqWzBDrQEcH2+WMhEZq9BDsoBbZ5AbkwsFw2KpRYZWKyczX1xm/YKN76p
	wCZqVb7OT0uqnRa3EZzTI8kFGxh+tKm2ejD7kCltLOUgnPOs+QqkFQR1HXpjuG/E194LQSFpQhGML
	vysykn7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osSK7-0070gt-Hn; Tue, 08 Nov 2022 17:23:43 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osSK2-0070fi-HK
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 17:23:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6461FB81BAC;
	Tue,  8 Nov 2022 17:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B956C433D6;
	Tue,  8 Nov 2022 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667928215;
	bh=hQg7NoKja9TGe1uumJQDYjviyfCTnfLxmswlsfS/doA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSd+n7EE0MNX8tHp3LUL4qUnk/MPwMLUQgiWCVIl7kax2vTSV/3xCxAlRW5WHEC0x
	 drPFNSZrYwOh7acWU1RUVu/qXRWXj4K9KBW5Gpl2ZOfmuZd4YCl9In1ysJNm99LCkc
	 oeacoG/asj5IgNc8yKo5f5Bsa6JQ1oXUzq/3qyXApUv26+lD0D3qDGKgFaJA52Ub/J
	 mHYT1nLia7/P3lq7RXvHJJVbPA66HFsULrud/EBTMd1GYrJhcfbLwHNfqCxnQOm5oO
	 th7Hrptz99tmaYorsTtnWTlKcZq2xgZ0b8XhP46c+WMveHDJirW5AqfDfkqDMcl4/J
	 kKcPWw5HxOhNA==
Date: Tue, 8 Nov 2022 10:23:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <Y2qQk/LuiNNdmdRD@kbusch-mbp>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <20221108074846.GA22674@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108074846.GA22674@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_092338_733121_EB06FE5F 
X-CRM114-Status: GOOD (  15.93  )
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

On Tue, Nov 08, 2022 at 08:48:47AM +0100, Christoph Hellwig wrote:
> Below is the minimal fix.  I'll see if I sort out the mess that is
> probe/reset failure vs ->remove a bit better, though.

This looks good to go. I vote apply for 6.1, and we should consider
merging your larger refactor for 6.2 after more test/review.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f94b05c585cbc..577bacdcfee08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>  
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
> +	if (!ctrl->tagset)
> +		return;
>  	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>  		blk_mq_quiesce_tagset(ctrl->tagset);
>  	else
> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>  
>  void nvme_start_queues(struct nvme_ctrl *ctrl)
>  {
> +	if (!ctrl->tagset)
> +		return;
>  	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>  		blk_mq_unquiesce_tagset(ctrl->tagset);
>  }
> 

