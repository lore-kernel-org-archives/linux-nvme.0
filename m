Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A84BC43461
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 11:54:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CB1207C3
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 11:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TCa4RgdQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Ae1sQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CB1207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M42+ahNlTt9E012IE3uhZY5mLATfHnEfXvnc03TPqhM=; b=TCa4RgdQUJD24AAsBO8BEJnxp
	zTocBb0r9h/MRvtREmBwxJvhZv7zthTXGbVxR0Li1s35wCPHciX10HrHTZ5IzlWMmRpGqkj8Iz7I0
	Fx+SOij+n+vVRRlWfvgJ1n/RZokBBWf7g3D0U3b8Ki0La0dxnX/P9heu8iAgzAyn2Oqu0kaWHc2Z7
	ynDPkHX5/SuBzVsSiwvwDKAixhdexoeZ6hCgE3idJsfKGliKsUPyDK38D4PV8w55Zd9BOToBHd+mC
	C2KAg6lqwSDSgCsrpRu0yQckcBJS6sHwwsh3OpFCodcT+TkCobuYPXGy0vqE9n8k8cQTVnQ4b+Efz
	DcQGxSI0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFFjU-0003Z1-Qb; Mon, 07 Sep 2020 11:54:48 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFFjR-0003YV-R7
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 11:54:46 +0000
Received: by mail-wm1-x341.google.com with SMTP id v4so13930977wmj.5
 for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2020 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OR+grx7rkHafCDDiGBz5vMeFbMGhU5jA0sq+dJevcqs=;
 b=H3Ae1sQMU3QDMtnyX3+xZtz6s1GPf3SQJ48vMHTrvOqN0P90Bi8at73uXh4Hg13jk3
 /o9/3Z1EuejT24OKfqp7aLZnu9lsD9zjP029koxPH7CiWyO11KFnw5CrRCav9GL3VJ8y
 35ReUrwanHemCx5mhqF0M22pBQYwq1IYvogw2EZfEp9YyvM95JkR+z9QQ7fJlRJ8+QfN
 yFDqcFdOCeQfigpb9NgvSaySzkZhGa7WVY4oItULB45o+jmw140QknPxxx8N+9EnUH08
 lEAsQ3kP8j6YqWDaf4ETVXWNh8czD0XwxQluGOytQe9Sdp2s0bD8G32b38Eh9ojVa8Bf
 OPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OR+grx7rkHafCDDiGBz5vMeFbMGhU5jA0sq+dJevcqs=;
 b=E3d5KzXt9NYUqTYVAWcHM7zDEXgVMko9Ion2iw5y5kKo1KIhW0TeXvenwIlcOPbV1x
 IHFUC98GKf3509fVc564V/UiuFvsU4XtPB6w29S/VEqVvjLLePSSxAfBfqgebiS/+8km
 rOXXp6SQ2yvyYx0hKjUFHue1xmKzHtMHqpx7mU20+gFJKhsxxKuiQAKNuJ/eTt6TpmA6
 cjSj+H1rvjQN2pVWwAl+2qh/Xz9KDAfoQwh4gzuMjJ6M3Jo3GAD5qfwsvg7YBm6M3tj1
 4U/b0lr/qvcizd/W4bD7qOXutFjoki1/5Nd6xV+maqEty4FXaL236nuHXBvdOm72/bvU
 l/eQ==
X-Gm-Message-State: AOAM532eAthT8jybY8CzAbxsHve9bHqgbrON7WC7sS/zqirToepD4/4N
 VMw7vXsW9zH669OaM4f0wMS2vymTXtzBkDxu6zE=
X-Google-Smtp-Source: ABdhPJwQrcj7pOMtW+ubR5dY9vTjAdfHlJlCVTWfZxIAQNeUmmUxO7ArntdPLUqJ7jvqE9jaZxgl9E7Hl5fxw2RmDkA=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr19558190wmj.138.1599479684792; 
 Mon, 07 Sep 2020 04:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
 <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+sN8n6-ibJ1v_S5HEdfhbJ8yAYTm5ja=0M8ng2ujLZ4g@mail.gmail.com>
 <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 7 Sep 2020 17:24:18 +0530
Message-ID: <CA+1E3rJtGTt6gss-5uAjzQ+BAXWTOTcjUzyFToz-QWbEfkLkaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_075445_926539_8C633A72 
X-CRM114-Status: GOOD (  25.88  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Selvakumar S <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 7, 2020 at 5:07 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/09/07 20:24, Kanchan Joshi wrote:
> > On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >>
> >> On 2020/09/07 16:01, Kanchan Joshi wrote:
> >>>> Even for SMR, the user is free to set the elevator to none, which disables zone
> >>>> write locking. Issuing writes correctly then becomes the responsibility of the
> >>>> application. This can be useful for settings that for instance use NCQ I/O
> >>>> priorities, which give better results when "none" is used.
> >>>
> >>> Was it not a problem that even if the application is sending writes
> >>> correctly, scheduler may not preserve the order.
> >>> And even when none is being used, re-queue can happen which may lead
> >>> to different ordering.
> >>
> >> "Issuing writes correctly" means doing small writes, one per zone at most. In
> >> that case, it does not matter if the block layer reorders writes. Per zone, they
> >> will still be sequential.
> >>
> >>>> As far as I know, zoned drives are always used in tightly controlled
> >>>> environments. Problems like "does not know what other applications would be
> >>>> doing" are non-existent. Setting up the drive correctly for the use case at hand
> >>>> is a sysadmin/server setup problem, based on *the* application (singular)
> >>>> requirements.
> >>>
> >>> Fine.
> >>> But what about the null-block-zone which sets MQ-deadline but does not
> >>> actually use write-lock to avoid race among multiple appends on a
> >>> zone.
> >>> Does that deserve a fix?
> >>
> >> In nullblk, commands are executed under a spinlock. So there is no concurrency
> >> problem. The spinlock serializes the execution of all commands. null_blk zone
> >> append emulation thus does not need to take the scheduler level zone write lock
> >> like scsi does.
> >
> > I do not see spinlock for that. There is one "nullb->lock", but its
> > scope is limited to memory-backed handling.
> > For concurrent zone-appends on a zone, multiple threads may set the
> > "same" write-pointer into incoming request(s).
> > Are you referring to any other spinlock that can avoid "same wp being
> > returned to multiple threads".
>
> Checking again, it looks like you are correct. nullb->lock is indeed only used
> for processing read/write with memory backing turned on.
> We either need to extend that spinlock use, or add one to protect the zone array
> when doing zoned commands and checks of read/write against a zone wp.
> Care to send a patch ? I can send one too.

Sure, I can send.
Do you think it is not OK to use zone write-lock (same like SCSI
emulation) instead of introducing a new spinlock?


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
