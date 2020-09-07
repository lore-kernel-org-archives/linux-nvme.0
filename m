Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F84C43461
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 07:00:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2163206B8
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 07:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJwKb3g+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIqLl1xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2163206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vqsXY6XZKNTqvLKEHGsREdewD9E8ksz5PW8zl2/9pZU=; b=EJwKb3g+FIQ0Bhp/PHVcWWJUb
	e1s0FMCEfJ34INIj/GDtHzape1PsY1WtfClDho3mXwO9wrsNLaLU9+x1evaYMdnl6d9MAph/dKYUX
	0fDWRrpxLMGOtDoAT1mqWvREmXFST++h8vj4kTUBiPVNfsNjIS3gvr2czc0m2IDX20attwjTwmQrq
	L/wGh+Ab4mUXw+HgK1ZvvrXctcbhA/fzbjrwkRbiQByxU90/HBntCw0InMJPp3O5KEuod/R6n1JBC
	9vVDgEkr1BRu0d7WW18YnGzlult5S5gaU2bTL8ICPpCoOJENCS14oz/lbmotIEW1cdq7iUP8fIqUO
	j9vjuhofA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFB92-0008UD-3B; Mon, 07 Sep 2020 07:00:52 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFB8y-0008T8-Cy
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 07:00:49 +0000
Received: by mail-wr1-x442.google.com with SMTP id x14so14509579wrl.12
 for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2020 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WfzwDVfM8m0y+mb0RhkT5Io2eJbPcmHQd46uG9l5ymc=;
 b=jIqLl1xYfSJFF24MfCtCOPcw1Zktgt7on1X6gtmoly7bN7q0WH3vPIWbzo1gYlc3TG
 h49zsU1P9OvWDB0WORgAmLvjT+A8grODmY7fng5sidgI6oZjfMZjcovuvTp7ZgWSxlcY
 iGLAgsW88qSY7NkLeJjT/tTeMoJ/FWarHimJtJdHt8hS3PAflJUUEyt2Z7hROT6p32Dg
 Wgqztyqch8o9nbNahzGH1+bZVPvSR56Bg453CM/ieyvjefjuXKza41hfZvykphZtntYP
 VCdGiQi8Aw21uBWwvwp2B5vBd2BM2k7IbYp3wsc8Ao0ROfU2HvInsD8vYg+FEApOi2Pp
 7sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WfzwDVfM8m0y+mb0RhkT5Io2eJbPcmHQd46uG9l5ymc=;
 b=DWB75TRpcES5XF5IeVXM8rMG6sw1T7C9GLAe6VzFBoNXGOXp50oHI2Mi0G4vFTnQp5
 e2fOWzTEXH65Sc3F/fd1w8ckx2F/By+TvrDmE1mctKW5it7P0yDW5Lx8Xd4Z3/cQ49pP
 ZgBrcEdznTZVvH+Jso9J/dA415rAWYlIUGEj4LA8N83Na1OX5IJFjl/DuWxVQZVyI6ZQ
 jP1EuGScLDyNRyHM1wKCLINFCqGScA6eNB/IDXsd4PP8Um5e7EnCs+5Xrb/uc5Oxjwi1
 6k9LkpVVHWjoTWgxG10VwrAc8qsCPbIBY4lyKFS/lc7g4biOPvoIDUYQb6DidopaamiE
 o5xw==
X-Gm-Message-State: AOAM531OzHWwfSOJvmeCzwl9dJMMxvWkuTPTBcchB72usmXYji83vi3l
 muYm+gUhZikeauB6FKW2Rm/yzhpqnusCWC951zxAcfaMLZdDKrfC
X-Google-Smtp-Source: ABdhPJx1ZNF3nhnMlM4DIcwBkG1PgVcpMOjaywDCO4pSbDC9BfY5i+FrqUblHpVBsisrnfyAH4HAdCSwWzgWeUaX0iY=
X-Received: by 2002:a5d:574c:: with SMTP id q12mr19832219wrw.253.1599462044348; 
 Mon, 07 Sep 2020 00:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 7 Sep 2020 12:30:19 +0530
Message-ID: <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_030048_459115_E2EE00DE 
X-CRM114-Status: GOOD (  34.16  )
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

On Wed, Aug 19, 2020 at 4:47 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/08/19 19:32, Kanchan Joshi wrote:
> > On Wed, Aug 19, 2020 at 3:08 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >>
> >> On 2020/08/19 18:27, Kanchan Joshi wrote:
> >>> On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
> >>>>
> >>>> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> >>>>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
> >>>>
> >>>> No, it is not.
> >>>
> >>> Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
> >>> I see that null-block zoned and SCSI-ZBC both set this requirement. I
> >>> wonder how it became different for NVMe.
> >>
> >> It is not required for an NVMe ZNS drive that has zone append native support.
> >> zonefs and upcoming btrfs do not use regular writes, removing the requirement
> >> for zone write locking.
> >
> > I understand that if a particular user (zonefs, btrfs etc) is not
> > sending regular-write and sending append instead, write-lock is not
> > required.
> > But if that particular user or some other user (say F2FS) sends
> > regular write(s), write-lock is needed.
>
> And that can be trivially enabled by setting the drive elevator to mq-deadline.
>
> > Above block-layer, both the opcodes REQ_OP_WRITE and
> > REQ_OP_ZONE_APPEND are available to be used by users. And I thought
> > write-lock is taken or not is a per-opcode thing and not per-user (FS,
> > MD/DM, user-space etc.), is not that correct? And MQ-deadline can
> > cater to both the opcodes, while other schedulers cannot serve
> > REQ_OP_WRITE well for zoned-device.
>
> mq-deadline ignores zone append commands. No zone lock is taken for these. In
> scsi, the emulation takes the zone lock before transforming the zone append into
> a regular write. That locking is consistent with the mq-scheduler level locking
> since the same lock bitmap is used. So if the user only issues zone append
> writes, mq-deadline is not needed and there is no reasons to force its use by
> setting ELEVATOR_F_ZBD_SEQ_WRITE. E.g. the user may want to use kyber...

Right, got your point.

> >> In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be set only
> >> and only if the drive does not have native zone append support.
> >
> > Sure I can keep it that way, once I get it right. If it is really not
> > required for native-append drive, it should not be here at the place
> > where I added.
> >
> >> And even in that
> >> case, since for an emulated zone append the zone write lock is taken and
> >> released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is required
> >> only if the user will also be issuing regular writes at high QD. And that is
> >> trivially controllable by the user by simply setting the drive elevator to
> >> mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.
> >
> > Are we saying applications should switch schedulers based on the write
> > QD  (use any-scheduler for QD1 and mq-deadline for QD-N).
> > Even if it does that, it does not know what other applications would
> > be doing. That seems hard-to-get-right and possible only in a
> > tightly-controlled environment.
>
> Even for SMR, the user is free to set the elevator to none, which disables zone
> write locking. Issuing writes correctly then becomes the responsibility of the
> application. This can be useful for settings that for instance use NCQ I/O
> priorities, which give better results when "none" is used.

Was it not a problem that even if the application is sending writes
correctly, scheduler may not preserve the order.
And even when none is being used, re-queue can happen which may lead
to different ordering.

> As far as I know, zoned drives are always used in tightly controlled
> environments. Problems like "does not know what other applications would be
> doing" are non-existent. Setting up the drive correctly for the use case at hand
> is a sysadmin/server setup problem, based on *the* application (singular)
> requirements.

Fine.
But what about the null-block-zone which sets MQ-deadline but does not
actually use write-lock to avoid race among multiple appends on a
zone.
Does that deserve a fix?

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
