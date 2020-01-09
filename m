Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008CC32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 10:19:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ABF206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 10:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dErI6jcE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="uYzxlv0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ABF206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hNCa5wG1EsXhnA6T/sp9Gh5MOCA/hHM3PM6+gKr02HA=; b=dErI6jcEpfXFlQ
	eHPSrxFBiLjn4dVjeMXBKIH8YM8qpPgDreNXgBqDWksntIc/EsNXuWkU90gG5jsELnejabgQMjjnC
	l3k/hqPIvqfMc2BOxDU3jSgFD0JeEGPmQIqpbcM4/Qzek0xAmmUPU8SkTcjrg8kLR19cr1Nw0YdDO
	Qiv5sAuBVEk5Qmk5y7DEteqeqIG51yncN/sUkY7drf9fqVfwnEiGHuoTWzOqR3SPJleqIeN3xlKJa
	9ggKwIrdxLJWZL/NEx7ghkAvUtX6gwttMLpdkIC4fWgY9vUFkEf0CIOc++YWxLJmjiYmnYBDArwIe
	COwDS6sJT1sFmjhjWwng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipUun-0002C7-FM; Thu, 09 Jan 2020 10:19:45 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipUuk-0002AE-LB
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 10:19:44 +0000
Received: by mail-lf1-x142.google.com with SMTP id n25so4807839lfl.0
 for <linux-nvme@lists.infradead.org>; Thu, 09 Jan 2020 02:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=owltronix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yc4QpQbWMkHB15aVjvX5Uf8UyPL+iSSMmYHHhc2yIwo=;
 b=uYzxlv0MH3lWrOqNXTAMC4nSdMn9kXVD7TITYZVX48fhAILr+2N98aficvb6pw7P8p
 0gxJxLCckWdMKiUatQOJ0Nh5o8Xp7tu7YWcluC8wIQj7ZAa7FvXvMolQGh0gMSGueuh6
 oAbECXOL8iUN6kDN+PdXcAstydIMeZCq+cmGmT6MLgXss5c8N0Rgz689E6tMxquB/HoK
 m/NGGSky1xcDkq+0suKtbTwkebL2+gjO51iEwBBnMoV5ZHhAKdD/pkK+M8IBEwJM5UGe
 P11aPxWK1Di+Y9gCax0lRgRyMwlj52m8QVGfQM9Eh59vwTjDUaR1/LCLBqMJoDlIO3p+
 nNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yc4QpQbWMkHB15aVjvX5Uf8UyPL+iSSMmYHHhc2yIwo=;
 b=ZnAuc4Js6mbXOxT56tUfTqszRYLM+UGnIH0fCDMEeznGl6pw59XeYAWBHgp1Qaq0w2
 V0kiVYUkCS2VoaJ14uRu8rkAFYUn2mV+GacWgQnAsu/BBiml1oHfyahWtLDHzervQOgp
 6Dk7TRr8n4Mp/AzmHCJ3BcBOynO1eb+I6hqf9Dij0JiuL1JRZ06MuW7AawszFOtj9+2O
 65rW1ZiZ+bH6B+WqjI1VJBVX6BEvnmCm59Hbt17wAJqF10XxjogJ7wSGjxpWNvKZB/9B
 HfKa4o8NZbIyuAf09Ful0q4cRwNW+QUgx7RbxLWex2NIxrUS9KwRgphFAeS0kmw1l6Y7
 +rIg==
X-Gm-Message-State: APjAAAW9wEae4Hmq69dQDkusxUoBSOqgeoz17wvuJWR/M3CNuAeFOZ8s
 AHsc34tKQGuWL+uk9H94elQG5h0f4a6M8lKxZElCIQ==
X-Google-Smtp-Source: APXvYqxmGTVUfoDgWWWDW+R4ESIx2uJCdDcI1Lqi+Tz0MO4cyGhe0CQU0VdfHQ5e1HYKYj1OvVtzWjMUcdBgFrHWbCU=
X-Received: by 2002:a19:850a:: with SMTP id h10mr5795499lfd.89.1578565176867; 
 Thu, 09 Jan 2020 02:19:36 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Thu, 9 Jan 2020 11:19:25 +0100
Message-ID: <CANr-nt0=C+1v=1MU6eNhX0-X4CEvc7D2UEF02oRMNHraQ1FRow@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200109_021942_704130_A9B36AEC 
X-CRM114-Status: GOOD (  18.11  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Omar Sandoval <osandov@fb.com>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 19, 2019 at 6:50 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Adding Damien to this thread.
> On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:
> > Hi,
> >
> > * Background:-
> > -----------------------------------------------------------------------
> >
> > Linux Kernel Block layer now supports new Zone Management operations
> > (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).
> >
> > These operations are added mainly to support NVMe Zoned Namespces
> > (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,
> > user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,
> > Device-mapper in order to support these devices in the field.
> >
> > Over the years Linux kernel block layer tracing infrastructure
> > has proven to be not only extremely useful but essential for:-
> >
> > 1. Debugging the problems in the development of kernel block drivers.
> > 2. Solving the issues at the customer sites.
> > 3. Speeding up the development for the file system developers.
> > 4. Finding the device-related issues on the fly without modifying
> >      the kernel.
> > 5. Building white box test-cases around the complex areas in the
> >      linux-block layer.
> >
> > * Problem with block layer tracing infrastructure:-
> > -----------------------------------------------------------------------
> >
> > If blktrace is such a great tool why we need this session for ?
> >
> > Existing blktrace infrastructure lacks the number of free bits that are
> > available to track the new trace category. With the addition of new
> > REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can
> > track more number of requests.

In addition to tracing the zone operations, it would be greatly
beneficial to add tracing(and blktrace support) for the reported zone
states.
I did something similar[5] for pblk and open channel chunk states, and
that proved invaluable when figuring out whether the disk or pblk was
broken.

In pblk the reported chunk state transitions are traced along with the
expected zone transitions (based on io and management commands
submitted).

[5] https://www.lkml.org/lkml/2018/8/29/457

Thanks!
Hans

> >
> > * Current state of the work:-
> > -----------------------------------------------------------------------
> >
> > RFC implementations [3] has been posted with the addition of new IOCTLs
> > which is far from the production so that it can provide a basis to get
> > the discussion started.
> >
> > This RFC implementation provides:-
> > 1. Extended bits to track new trace categories.
> > 2. Support for tracing per trace priorities.
> > 3. Support for priority mask.
> > 4. New IOCTLs so that user-space tools can setup the extensions.
> > 5. Ability to track the integrity fields.
> > 6. blktrace and blkparse implementation which supports the above
> >      mentioned features.
> >
> > Bart and Martin has suggested changes which I've incorporated in the RFC
> > revisions.
> >
> > * What we will discuss in the proposed session ?
> > -----------------------------------------------------------------------
> >
> > I'd like to propose a session for Storage track to go over the following
> > discussion points:-
> >
> > 1. What is the right approach to move this work forward?
> > 2. What are the other information bits we need to add which will help
> >      kernel community to speed up the development and improve tracing?
> > 3. What are the other tracepoints we need to add in the block layer
> >      to improve the tracing?
> > 4. What are device driver callbacks tracing we can add in the block
> >      layer?
> > 5. Since polling is becoming popular what are the new tracepoints
> >      we need to improve debugging ?
> >
> >
> > * Required Participants:-
> > -----------------------------------------------------------------------
> >
> > I'd like to invite block layer, device drivers and file system
> > developers to:-
> >
> > 1. Share their opinion on the topic.
> > 2. Share their experience and any other issues with blktrace
> >      infrastructure.
> > 3. Uncover additional details that are missing from this proposal.
> >
> > Regards,
> > Chaitanya
> >
> > References :-
> >
> > [1] https://www.spinics.net/lists/linux-block/msg46043.html
> > [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> > namespaces-zns-as-go-to-industry-technology/
> > [3] https://www.spinics.net/lists/linux-btrace/msg01106.html
> >       https://www.spinics.net/lists/linux-btrace/msg01002.html
> >       https://www.spinics.net/lists/linux-btrace/msg01042.html
> >       https://www.spinics.net/lists/linux-btrace/msg00880.html
> >
>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
