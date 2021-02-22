Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA3BC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 13:43:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6327D64E74
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6327D64E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=txQJ7VNL+kv+G9fe5ZxuMKkDyEcup8jZ9kiexY/VvBI=; b=PCo2jSBoqu8vBrzuqhoeAsZmo
	jIScBCuIlicWA1+sHsJmLhlG95IVJKBzvh0VhLtfMZW6qFMF8yFJdmW0/HAjRK0PCslVUHma2iOPT
	jYFyji+Y5XakO2Im0f54WvWaoeEsifMpXH+fCvt5BwaUCUxNS1cGfwbbscc1r4WU5mTJslaZsIJxr
	L8KOPkF2AbtfxKKSRq4QcgzR9xHGrabC3Kq6Yp4L6TC368y9jw1C3I3uYlV4096kAmS6ND6hyvdYE
	bT37Y4MIqpP84o0kqSeZLTg+JjlSwhF0CcNPO9qfELx8fdxy+k8Ss5zJtvlDqO4b3lIIab6v56O+i
	6HPamkr+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEBU8-0001p9-54; Mon, 22 Feb 2021 13:42:48 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEBU6-0001oU-2i
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 13:42:47 +0000
Received: by mail-wm1-x332.google.com with SMTP id i9so3647807wml.5
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EokPmjsgtfLr/Ht3Tl2sy1hHZqSDcon8nbXZDyMDp44=;
 b=J5tKeePzyvCR1SlPSDb1w6I+IgKDdVtV0hiWmwZPNYDwwLhBwTrasjQW3m40fTQ1Lt
 d0AK3lNiNFi3at56v727sk2bhUwWNgp2vsWAdeqUSgHDqlfNKkj+g4hyhITWPT7VSezu
 bOQBKvIY9E+XnTKcWq4mJ3MwAhv5HGD5Yf2B47WUdsvem5cmyOKmurX6bpNLwF1PmUb5
 Jsxu9cU5d3blgFXdCiJZrl3RkJmn1ZUe7eanxYI3fZw0DJB7zPFkVjh+gNAeYQL1Mm4r
 wvIzNPXueFqJl42T61yvFMipBHgVsS9hZFqOgi/BG0U/1jdiLAgFBV4fxptyvZCf58VZ
 WFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EokPmjsgtfLr/Ht3Tl2sy1hHZqSDcon8nbXZDyMDp44=;
 b=J623D2yc/jM8Hg8nuB2I92qhMLQor3tfgwcNwDOZqcFt1qD6GHNF6BCsCeSvN+wazk
 v2YxoIlp2hScFYU2oRLnlyzafA7yJfFwM71/18LM6iQsxrhqEVuTOQJlwTDwsVOqK31W
 HYc8OlIrvJ2NXD95mTD5nR4IxakFGgwievP/Kf+2OdvKIbzB2b3CsyIKEa0G2XVRXasB
 w8olVr47i5Nm6Qr4acy8TefrnsSRnR6tRHL/h/4/ffuJmFypjrjclXfWB9FwG4+l1Ego
 UKDxXKGjukcgInoEToK1Pe+rXN5K0jtOM9FCmGpL0+g7PGDs432MpGpIze98I15PckmC
 22Jg==
X-Gm-Message-State: AOAM530gNdgXHC73j3O5Hgiv1KDIT6jWcV7zYd+Wp8h7Wt9JyJSj/zSU
 fMjWTGF5bd1qlIS44T/beqapQ+A/G+mgseC3tJ0=
X-Google-Smtp-Source: ABdhPJyKoim3/GDB0UpkwqwBKU/AY5ujt7EE/+q9PZBcBIJnUofaxL5JR2azM46w7FqtA5BNFld6Q5Wi0+SjT66z0Rg=
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr15312085wms.4.1614001362757; 
 Mon, 22 Feb 2021 05:42:42 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
 <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
 <2d37d0ca-5853-4bb6-1582-551b9044040c@kernel.dk>
 <CA+1E3rKeqaLXBuvpMcjZ37XH9RqJHjPnTFObJj0T-u8K9Otw-w@mail.gmail.com>
 <dd0392a1-acfa-ef4d-5531-5f1dddc9efe7@kernel.dk>
In-Reply-To: <dd0392a1-acfa-ef4d-5531-5f1dddc9efe7@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 22 Feb 2021 19:12:18 +0530
Message-ID: <CA+1E3rJqtpfDbKVGBjSYhX=WfzZ2bE8b0U3drUNz_=bp0u9Vuw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Jens Axboe <axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_084246_177730_8A1BF6CA 
X-CRM114-Status: GOOD (  37.04  )
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

On Thu, Jan 28, 2021 at 10:54 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/28/21 10:13 AM, Kanchan Joshi wrote:
> > On Thu, Jan 28, 2021 at 8:08 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 1/28/21 5:04 AM, Kanchan Joshi wrote:
> >>> On Wed, Jan 27, 2021 at 9:32 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>>>
> >>>> On 27/01/2021 15:42, Pavel Begunkov wrote:
> >>>>> On 27/01/2021 15:00, Kanchan Joshi wrote:
> >>>>>> This RFC patchset adds asynchronous ioctl capability for NVMe devices.
> >>>>>> Purpose of RFC is to get the feedback and optimize the path.
> >>>>>>
> >>>>>> At the uppermost io-uring layer, a new opcode IORING_OP_IOCTL_PT is
> >>>>>> presented to user-space applications. Like regular-ioctl, it takes
> >>>>>> ioctl opcode and an optional argument (ioctl-specific input/output
> >>>>>> parameter). Unlike regular-ioctl, it is made to skip the block-layer
> >>>>>> and reach directly to the underlying driver (nvme in the case of this
> >>>>>> patchset). This path between io-uring and nvme is via a newly
> >>>>>> introduced block-device operation "async_ioctl". This operation
> >>>>>> expects io-uring to supply a callback function which can be used to
> >>>>>> report completion at later stage.
> >>>>>>
> >>>>>> For a regular ioctl, NVMe driver submits the command to the device and
> >>>>>> the submitter (task) is made to wait until completion arrives. For
> >>>>>> async-ioctl, completion is decoupled from submission. Submitter goes
> >>>>>> back to its business without waiting for nvme-completion. When
> >>>>>> nvme-completion arrives, it informs io-uring via the registered
> >>>>>> completion-handler. But some ioctls may require updating certain
> >>>>>> ioctl-specific fields which can be accessed only in context of the
> >>>>>> submitter task. For that reason, NVMe driver uses task-work infra for
> >>>>>> that ioctl-specific update. Since task-work is not exported, it cannot
> >>>>>> be referenced when nvme is compiled as a module. Therefore, one of the
> >>>>>> patch exports task-work API.
> >>>>>>
> >>>>>> Here goes example of usage (pseudo-code).
> >>>>>> Actual nvme-cli source, modified to issue all ioctls via this opcode
> >>>>>> is present at-
> >>>>>> https://github.com/joshkan/nvme-cli/commit/a008a733f24ab5593e7874cfbc69ee04e88068c5
> >>>>>
> >>>>> see https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops
> >>>>>
> >>>>> Looks like good time to bring that branch/discussion back
> >>>>
> >>>> a bit more context:
> >>>> https://github.com/axboe/liburing/issues/270
> >>>
> >>> Thanks, it looked good. It seems key differences (compared to
> >>> uring-patch that I posted) are -
> >>> 1. using file-operation instead of block-dev operation.
> >>
> >> Right, it's meant to span wider than just block devices.
> >>
> >>> 2. repurpose the sqe memory for ioctl-cmd. If an application does
> >>> ioctl with <=40 bytes of cmd, it does not have to allocate ioctl-cmd.
> >>> That's nifty. We still need to support passing larger-cmd (e.g.
> >>> nvme-passthru ioctl takes 72 bytes) but that shouldn't get too
> >>> difficult I suppose.
> >>
> >> It's actually 48 bytes in the as-posted version, and I've bumped it to
> >> 56 bytes in the latest branch. So not quite enough for everything,
> >> nothing ever will be, but should work for a lot of cases without
> >> requiring per-command allocations just for the actual command.
> >
> > Agreed. But if I got it right, you are open to support both in-the-sqe
> > command (<= 56 bytes) and out-of-sqe command (> 56 bytes) with this
> > interface.
> > Driver processing the ioctl can fetch the cmd from user-space in one
> > case (as it does now), and skips in another.
>
> Your out-of-seq command would be none of io_urings business, outside of
> the fact that we'd need to ensure it's stable if we need to postpone
> it. So yes, that would be fine, it just means your actual command is
> passed in as a pointer, and you would be responsible for copying it
> in for execution
>
> We're going to need something to handle postponing, and something
> for ensuring that eg cancelations free the allocated memory.

I have few doubts about allocation/postponing. Are you referring to
uring allocating memory for this case, similar to the way
"req->async_data" is managed for few other opcodes?
Or can it (i.e. larger cmd) remain a user-space pointer, and the
underlying driver fetches the command in.
If submission context changes (for sqo/io-wq case), uring seemed to
apply context-grabbing techniques to make that work.

> >>> And for some ioctls, driver may still need to use task-work to update
> >>> the user-space pointers (embedded in uring/ioctl cmd) during
> >>> completion.
> >>>
> >>> @Jens - will it be fine if I start looking at plumbing nvme-part of
> >>> this series on top of your work?
> >>
> >> Sure, go ahead. Just beware that things are still changing, so you might
> >> have to adapt it a few times. It's still early days, but I do think
> >> that's the way forward in providing controlled access to what is
> >> basically async ioctls.
> >
> > Sounds good, I will start with the latest branch that you posted. Thanks.
>
> It's io_uring-fops.v2 for now, use that one.

Moved to v3 now.
nvme_user_io is 48 bytes, while nvme passthrough requires 72 or 80
bytes (passthru with 64 bit result).
The block_uring_cmd has 32 bytes of available space. If NVMe defines
its own "nvme_uring_cmd" (which can be used for nvme char interface)
that will buy some more space, but still won't be enough for passthru
command.

So I am looking at adding support for large-cmd in uring. And felt the
need to clear those doubts I mentioned above.


Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
