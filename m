Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CFC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:14:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DB364E24
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DB364E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9lteasIDKIR72NjHRtyDhyE1IBFglp0Bs+RZ7VR5tfA=; b=fTsnETlQ06uG8eO4oynyDmWyB
	haNrQ4Cu0T+vyBDX0n96v46Dzua394eZorAgNsLmeiak+f8dAIqKsXtnBaM9qKNkiadR32er951LT
	btwUE1+0nuy8AI74AvBLxPVdcbgkKkFxYcr4APXCVp0sgvfKbHKdp6n4CH+L2nBhX4s3NXVQiO/aC
	zt1Pj2wKAbxnX63W86PezR2UP4hE/l6NT6MKdXWAQxx/rAJKFEX26YaKsCL/h1TZv5ibCvmyLDRKr
	4zzz/ohbEG5kHMXaQGYrD3WP03Q/bHw+iS/USOf4ABGGNaZ+LnttmUzB7zbkkbOpf4G6/Tzd2cExf
	x9gG+HIqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Arn-00023Z-Ln; Thu, 28 Jan 2021 17:13:59 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Arj-000220-PK
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 17:13:57 +0000
Received: by mail-wm1-x32f.google.com with SMTP id y187so5184987wmd.3
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 09:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7SlUdwnPEQ27NCqhpgbYeyZWdUr/hbFxWqlJ+t74Kk8=;
 b=ZC610tgYYf3cXDd+K9835SRwKWS9h9WUHGCpEUZ6linSddg1wSPgVUjUNMN6mpS1Xm
 c4RrThuc6ArJUvlpnCsDOLiTLXxwP4gT29yqtbht4QP3gi5mE1lN6atmRBYG5NOiIKd1
 UhbGMFx8WThSp9iqxgoxo/aLM4qGLH8FwsrhUGC7qHZZCD6xm1tQMuyj2HAydcxCz3uI
 zskopGXRLz1XCgVbA2eQnIP2B5tmj8BCKRe8kXTgUz3M5QuORrsxvnYibguygGOosJF4
 8a6/v6PxOY926xVk3IVjtF+tjo+vcHysccUiuGX/6NIZCEvi7yotZrDMKGZbLUbe4IFg
 I9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7SlUdwnPEQ27NCqhpgbYeyZWdUr/hbFxWqlJ+t74Kk8=;
 b=IAE+q0d3fXdHrXIJDd3fgtQ3aXSRfmzzTvX6lwaIxirFLDQjf4q/W/xvnpZS8EBL7W
 EhvVIrdPsy60cBOLdU9HvT6QPHnefgeQkHN1YVRMu6AhLlqrNOB4lljhw3x1IJWW7dBD
 f0W97PsmA6P4PNUVwiuUJklqXa7G8jPydQ30XlyrG0STldc5xOZ3ZDG9IPLZdP2cSeb9
 5YABBF5ktkQCJ37dO2H680UGW5FLihNMdpQ2BRu7kNWLjiVgzDFs647mhwyf5i0VUHGT
 D/jgBbRUSeIjaWuXdK2+Xqz9jvGTNAXpV5Y792z0YSsfrUWAZD2GTsciU+6BA5hSuLN8
 OXXQ==
X-Gm-Message-State: AOAM530G8DtRVTvRh2DPjjr0WuORNHepfVcCoYVU9bRZPg8QAGFnQRy8
 np92YFmsHvGgmiOcWwb4If7wuQUUa2eLwWeE8o4=
X-Google-Smtp-Source: ABdhPJxXfXzFAr81U6woMH6ZlFCnx3rqdBDQvkZZfBp9Z6iPwsJ146GcYd//CXg+XfSzjLO8DPOg85PKnI4yVDcLSOo=
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr233174wmb.25.1611854034115;
 Thu, 28 Jan 2021 09:13:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
 <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
 <2d37d0ca-5853-4bb6-1582-551b9044040c@kernel.dk>
In-Reply-To: <2d37d0ca-5853-4bb6-1582-551b9044040c@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 28 Jan 2021 22:43:26 +0530
Message-ID: <CA+1E3rKeqaLXBuvpMcjZ37XH9RqJHjPnTFObJj0T-u8K9Otw-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Jens Axboe <axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_121355_859220_280B0698 
X-CRM114-Status: GOOD (  30.32  )
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
Cc: Selvakumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 8:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/28/21 5:04 AM, Kanchan Joshi wrote:
> > On Wed, Jan 27, 2021 at 9:32 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>
> >> On 27/01/2021 15:42, Pavel Begunkov wrote:
> >>> On 27/01/2021 15:00, Kanchan Joshi wrote:
> >>>> This RFC patchset adds asynchronous ioctl capability for NVMe devices.
> >>>> Purpose of RFC is to get the feedback and optimize the path.
> >>>>
> >>>> At the uppermost io-uring layer, a new opcode IORING_OP_IOCTL_PT is
> >>>> presented to user-space applications. Like regular-ioctl, it takes
> >>>> ioctl opcode and an optional argument (ioctl-specific input/output
> >>>> parameter). Unlike regular-ioctl, it is made to skip the block-layer
> >>>> and reach directly to the underlying driver (nvme in the case of this
> >>>> patchset). This path between io-uring and nvme is via a newly
> >>>> introduced block-device operation "async_ioctl". This operation
> >>>> expects io-uring to supply a callback function which can be used to
> >>>> report completion at later stage.
> >>>>
> >>>> For a regular ioctl, NVMe driver submits the command to the device and
> >>>> the submitter (task) is made to wait until completion arrives. For
> >>>> async-ioctl, completion is decoupled from submission. Submitter goes
> >>>> back to its business without waiting for nvme-completion. When
> >>>> nvme-completion arrives, it informs io-uring via the registered
> >>>> completion-handler. But some ioctls may require updating certain
> >>>> ioctl-specific fields which can be accessed only in context of the
> >>>> submitter task. For that reason, NVMe driver uses task-work infra for
> >>>> that ioctl-specific update. Since task-work is not exported, it cannot
> >>>> be referenced when nvme is compiled as a module. Therefore, one of the
> >>>> patch exports task-work API.
> >>>>
> >>>> Here goes example of usage (pseudo-code).
> >>>> Actual nvme-cli source, modified to issue all ioctls via this opcode
> >>>> is present at-
> >>>> https://github.com/joshkan/nvme-cli/commit/a008a733f24ab5593e7874cfbc69ee04e88068c5
> >>>
> >>> see https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops
> >>>
> >>> Looks like good time to bring that branch/discussion back
> >>
> >> a bit more context:
> >> https://github.com/axboe/liburing/issues/270
> >
> > Thanks, it looked good. It seems key differences (compared to
> > uring-patch that I posted) are -
> > 1. using file-operation instead of block-dev operation.
>
> Right, it's meant to span wider than just block devices.
>
> > 2. repurpose the sqe memory for ioctl-cmd. If an application does
> > ioctl with <=40 bytes of cmd, it does not have to allocate ioctl-cmd.
> > That's nifty. We still need to support passing larger-cmd (e.g.
> > nvme-passthru ioctl takes 72 bytes) but that shouldn't get too
> > difficult I suppose.
>
> It's actually 48 bytes in the as-posted version, and I've bumped it to
> 56 bytes in the latest branch. So not quite enough for everything,
> nothing ever will be, but should work for a lot of cases without
> requiring per-command allocations just for the actual command.

Agreed. But if I got it right, you are open to support both in-the-sqe
command (<= 56 bytes) and out-of-sqe command (> 56 bytes) with this
interface.
Driver processing the ioctl can fetch the cmd from user-space in one
case (as it does now), and skips in another.

> > And for some ioctls, driver may still need to use task-work to update
> > the user-space pointers (embedded in uring/ioctl cmd) during
> > completion.
> >
> > @Jens - will it be fine if I start looking at plumbing nvme-part of
> > this series on top of your work?
>
> Sure, go ahead. Just beware that things are still changing, so you might
> have to adapt it a few times. It's still early days, but I do think
> that's the way forward in providing controlled access to what is
> basically async ioctls.

Sounds good, I will start with the latest branch that you posted. Thanks.

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
