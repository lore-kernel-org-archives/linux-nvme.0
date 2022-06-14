Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D27C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 05:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gdpv0IQN8rDztJ37DpZmHyHSMHKTiRLPhoUNEIkjZ8o=; b=NrcZcrn2LL2AVl0ZEuAk35tNQ2
	ms69HGmk6ts4kctWDJ0HCaSRmJnYaOSpqb+WWWG500NSNIe8wGGthfbFkX+lu4c/LyrxnZ6MW8E0n
	sIuieUCx65k7bfezYUPs3OXnkxCZ8B8yvyiv2gf0J4GCfsLatTZLg00FwLXUrQBOsnzsggePQoO5q
	1w2HSoD6xfQt00G8RlblB6Z4nfJ+C4vkmuMrgeR/7IiwS+2B9CBTIenQFCk2EFtqyngsNhrPf3fwZ
	9i9dj5xC8YpUy3t6zlaDd8WCBdW2jgTifuZnawTRTa8qpdl4YOu2OFxWGp+Bxi1n7Q1k5m3c+3l5A
	upryYxCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0zDM-0076s0-Vd; Tue, 14 Jun 2022 05:35:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0zDK-0076rI-8S
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 05:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655184940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gdpv0IQN8rDztJ37DpZmHyHSMHKTiRLPhoUNEIkjZ8o=;
	b=UdnC40M6OryWnYIWDlkRDI+P5r2zeSfQ1A1QOb3xFInQIg8T7pWxfJ3xROZWauUDq7XKmE
	iqtoBG+/TeLDLNYQzY38jf2mEjIw1zSxLO8gKO+gXLPfHRMVO6gETg+jbAoMtzKT4/mNAI
	/zOyVoxUDeH75ZvfFZHyrqe1zqmVpM0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-PelkR3oyMpaFO3W5UilkGQ-1; Tue, 14 Jun 2022 01:35:39 -0400
X-MC-Unique: PelkR3oyMpaFO3W5UilkGQ-1
Received: by mail-pl1-f199.google.com with SMTP id k10-20020a170902ce0a00b0016774f4a707so4247080plg.22
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 22:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gdpv0IQN8rDztJ37DpZmHyHSMHKTiRLPhoUNEIkjZ8o=;
        b=RePb1XTA4yN3+k0g0BFHwtrL/16kWG+gNDrb4vVNQO3ZJjOomMKW0vhDHppOKyFXpN
         +nOONbeKSzTMyiVEjqXtGOz1lm8B0RBqPvWcoWXLl8J7Ml3Wub2c6FtAlAVjIj8vd6CT
         mO92gufv8kejKU7LfbtvKvFgtAllyr4vYuvqEAtd3G54Mw9yTpwpEVNAUaGpQDwMeOhj
         DrH0ZCiz3vt1o2QkcLFJqVeUGee9uW5DfHcj6X35xDaY4BsZIh+c0ogeVEcJ4613035i
         bWMtlWUu2MkmTh5dYUMNot63tDoMKLLkCrSIrCYDHRab6+0QgGPYyfG2MLoYl8nOiraE
         8sjg==
X-Gm-Message-State: AOAM530yMML0lSVejCGSBms14IvmXcmT/TSKDnQo5HL+Ovy4wEoYaRUU
	jUIKuzH8lcTn6RyAPWXT7s4b63SBOzQFJ0GCtyH+E8tNMB3vFPSIUsgjdsg3DCLeAUKfPj8Yh7D
	/sFA4G7nto20YvX3BVblc0hWkopTdyDQqTCkxwhHJ+Zg=
X-Received: by 2002:a63:341:0:b0:3fc:824e:86bf with SMTP id 62-20020a630341000000b003fc824e86bfmr3051964pgd.140.1655184937833;
        Mon, 13 Jun 2022 22:35:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGudJ5XREv8F44TihPnlz/ghBHhworo5J64YHspGEpCPwBdut0h7AHhpnKpaB4pmJcElCY4osFImu9ufrz69U=
X-Received: by 2002:a63:341:0:b0:3fc:824e:86bf with SMTP id
 62-20020a630341000000b003fc824e86bfmr3051947pgd.140.1655184937517; Mon, 13
 Jun 2022 22:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590> <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
 <YqdIWcgnEylFuSci@T590>
In-Reply-To: <YqdIWcgnEylFuSci@T590>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 14 Jun 2022 13:35:25 +0800
Message-ID: <CAHj4cs-66nWX_8HvN4_j8QmrTKA9tXNrdfejPagaDNOzNTGs_A@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed from blktests on latest linux-block/for-next
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_223542_413470_5970883C 
X-CRM114-Status: GOOD (  20.26  )
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

On Mon, Jun 13, 2022 at 10:23 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jun 13, 2022 at 09:08:11PM +0800, Yi Zhang wrote:
> > Hi Ming
> >
> > The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
> > nvme_core multipath and retest.
> >
> > # cat /sys/module/nvme_core/parameters/multipath
> > Y
> >
>
> OK, I can understand the reason now since rqos is only removed for blk-mq queue,
> then rqos allocated for bio queue is leaked, see disk_release_mq().
>
> The following patch should fix it:

Hi Ming
The kmemleak was fixed by this change, feel free to add

Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> diff --git a/block/genhd.c b/block/genhd.c
> index 556d6e4b38d9..6e7ca8c302aa 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1120,9 +1120,10 @@ static const struct attribute_group *disk_attr_groups[] = {
>         NULL
>  };
>
> -static void disk_release_mq(struct request_queue *q)
> +static void disk_release_queue(struct request_queue *q)
>  {
> -       blk_mq_cancel_work_sync(q);
> +       if (queue_is_mq(q))
> +               blk_mq_cancel_work_sync(q);
>
>         /*
>          * There can't be any non non-passthrough bios in flight here, but
> @@ -1166,8 +1167,7 @@ static void disk_release(struct device *dev)
>         might_sleep();
>         WARN_ON_ONCE(disk_live(disk));
>
> -       if (queue_is_mq(disk->queue))
> -               disk_release_mq(disk->queue);
> +       disk_release_queue(disk->queue);
>
>         blkcg_exit_queue(disk->queue);
>
>
> Thanks,
> Ming
>


-- 
Best Regards,
  Yi Zhang


