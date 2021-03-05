Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8DFC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 10:41:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1D464FDF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 10:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1D464FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wwp/ojyYHqaTPZYM+1efi1REIyYS+6lZjOw9214eBUI=; b=qFZ4A9NHtE4qv+M23Ho6ehqAf
	FwEJLfEuxX5DW2Q9OBmNnzsJWVJQ5loiryk1J0pn1XkWyCTVhaiKJvH4KGrUAoGaLXiEZeGJffO+u
	jw8rzXebOMxAv7VTL7ftbNGAuw9sgSjheVXLueVLS5knMYQb+HRGFAxj4OZEa2eNk6yfIn+qAPDsG
	wAEzEMhRg5XiF7ircx4NxYpuL5s93FjYQvA6lvrNJ3oMOiyZYqiuNk0hND0u17tFBwCybx8W0c2SV
	9zooHJUlQxRDvSY0atYpBobsNUYqmTNWfu706KMiqZtRaGeUkcZulO6BXE3QpoLKSGCBlaZQAL6h4
	qjEwTUF1A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI7tN-00EbqJ-Ra; Fri, 05 Mar 2021 10:41:13 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI7t2-00Ebo4-S0
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 10:40:55 +0000
Received: by mail-wr1-x431.google.com with SMTP id b18so1535560wrn.6
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H95xvo9vQWpBEjEoM4WW8sLMHdulWjpm44uHAKvsKSE=;
 b=QtBqNgGK1tiNxAChBsd1aMaBD1tQwbJY/Y01r4QpFdNzSwhEdTAFrNcdOSfnN+mpSd
 HACc/kmLxu3a/1obQ4GecNWSU1EhumLdaj2ZboTieVoSzTIhP0ect1Zgm92jxdKEfgFR
 EYqqy6mjj8fFr7XeaPzjBRZZ8ezGvaNEj3G9Jpzt/drD0zztzsjoHuUYsbGMGpeLMtH8
 nWstmcT4DgvF7tTutcvIS6P5fZfuft3R1W4fhXXWkasnuSCMUMs1ewiR824mFUYwANyL
 7a9YrGCzFSmOiRqG2ceI2MDSKRi5PcUYAFgfHJH9mYtkptflumP1DXFaiKMvDWX3Pxsy
 XkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H95xvo9vQWpBEjEoM4WW8sLMHdulWjpm44uHAKvsKSE=;
 b=av4fh3F+o1oNbyl9M+DLbWjEB8wk1M2b302zlC7EsSaXA+sqarUWhaWw35fwqosaM0
 /z73wi5J69hCJlmIFigZP2tP0w1+WnN+BThY8GV0ZgSDqnWNIjh+abhjY9xsrNQu6hyJ
 CgI3KdJBLOA19/cyDff3aP2GMrT5gxtwjq6X1bTJwo+hw2++YGMq0tiB2SPl36S49cWQ
 TgvEwXCfCo4yblPF/N5iMWrSqyxrAkkDyD5xB0uQEYZaQbquDSyLZlj1nOrPMzyWR0g7
 ZhmGnl3bG9U7zHdd6WGysyOzSyHXRGSnPnmBe/GSWbUtN5tbEHeMa2JO4EgmWnBymr1t
 69ug==
X-Gm-Message-State: AOAM5331/+xbsBK4cSbUpdP6vJ2ojiEvo5NmKLfZMEGlK9xzz469PCxZ
 /RM6IluDjNBq+6ZoNfUPjbfWtJCx0VEAUjzaf+I=
X-Google-Smtp-Source: ABdhPJzPG/VE3eG4qnhLsT5LJ0GWlh20Mud+oLZU78uOjs5eDa1trxFOV58DpuC8BivumJPHjM2SwFudyifiDA5Db4E=
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr8473834wrw.355.1614940848299; 
 Fri, 05 Mar 2021 02:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc@epcas5p2.samsung.com>
 <20210302160734.99610-3-joshi.k@samsung.com>
 <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+1E3rLCSWDmLa1rrZ986xnbx6fcsGgBE6NPP59eJj4swY+gQg@mail.gmail.com>
 <BYAPR04MB49658E6ACD06FAC7F6F26A6886969@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49658E6ACD06FAC7F6F26A6886969@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 5 Mar 2021 16:10:22 +0530
Message-ID: <CA+1E3rJ62DNN=9-w1g0E7=0y4CZYjjckQ-K4Efk+3HjigbdSQA@mail.gmail.com>
Subject: Re: [RFC 2/3] nvme: passthrough helper with callback
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_104053_908476_00B0E046 
X-CRM114-Status: GOOD (  13.92  )
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

On Fri, Mar 5, 2021 at 9:44 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 3/4/21 03:14, Kanchan Joshi wrote:
> > On Wed, Mar 3, 2021 at 8:52 PM Chaitanya Kulkarni
> > <Chaitanya.Kulkarni@wdc.com> wrote:
> >> On 3/2/21 23:22, Kanchan Joshi wrote:
> >>> -void nvme_execute_passthru_rq(struct request *rq)
> >>> +void nvme_execute_passthru_rq_common(struct request *rq,
> >>> +                     rq_end_io_fn *done)
> >>>  {
> >>>       struct nvme_command *cmd = nvme_req(rq)->cmd;
> >>>       struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> >>> @@ -1135,9 +1136,17 @@ void nvme_execute_passthru_rq(struct request *rq)
> >>>       u32 effects;
> >>>
> >>>       effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> >>> -     blk_execute_rq(disk, rq, 0);
> >>> +     if (!done)
> >>> +             blk_execute_rq(disk, rq, 0);
> >>> +     else
> >>> +             blk_execute_rq_nowait(disk, rq, 0, done);
> >>>       nvme_passthru_end(ctrl, effects);
> >> This needs a detailed explanation in order to prove the correctness.
> > Do you see something wrong here?
> > blk_execute_rq() employs the same helper (i.e. nowait one) and uses
> > additional completion-variable to make it sync.
> >
>
> There is no gurantee that command will finish between call to
> blk_execute_rq_nowait()
> and nvme_passthru_end() is there ?

Got your concern now, thanks for elaborating.
I will move the passthru_end to when completion actually occurs, and
get it processed via workqueue.

And perhaps I should send a micro-optimization patch which will call
passthru_end only for non-zero command-effects.
Currently we do three checks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
