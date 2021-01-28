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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E0BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 12:05:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E6861492
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 12:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6861492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=89HRJKC7gHGBcGvfgVbcm9rIed7xAxvCAorWHJNTK+s=; b=FzfHt9xvUhvIvVpDWTwBVK09Z
	AvGB6ETmUvMehkWcf/kbKWIzeNxD8Uz721QnQW9ihRrzuL45PGBZ9OqVhFUsuJpghTR4h5wyKAs25
	LHHu7AzseTlPKPYYJjCBF10rJ8T3qNd5ordlaHz3zq6GaMohKT47xtcwFsi6YXG4upJz7Capra7FH
	OCxI3QAk9UrIlYcIU3pdDdKTQgPIvBuHoG2mstOxnGSomXMwNoAeV8IuhYM01adDRSlrK1dxVUbFO
	tgfROKi3rgs1bGHhAqn+Hqxa4J76LtVfQffEX+t6fG0VzlsIf33pItu0EB9k7xZctTF8R64nkV+Ih
	Fr7eNagIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5638-0007JU-52; Thu, 28 Jan 2021 12:05:22 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5632-0007Gz-U2
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 12:05:19 +0000
Received: by mail-wr1-x42b.google.com with SMTP id l12so5146780wry.2
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 04:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FvPd5ifPVoBtRVnaGQOlqp/tByyxR4FiQHLJy7BycmA=;
 b=FxGiNKqvyueMB/lnAWyUND5sS13WlwGLefVHBucluxwpfTiLTiB/tqj2CEBOCAXLa6
 5z15i3J/sJAdQD0DyjNpqcBY+mfNIzkeryFwpejOq3p21irD1hy5eLoncofJX3N7VZyM
 qup1Glfv1Bohk6ivde403LQE10t2+FZy/qti/s/H+fqCeOO5XJj0eP0hiEzaets9d3oQ
 skh/3y7ZAX1y4BzRWT13oucubWLb6TgW0/dOt0m6MdEhok52ok0sbVAwq/ZX3eOL8jPw
 jKF+Ge1YdnFYtM9zRMxwUYAAyBeZow6YfMyrOAc8YGH5rVSvUe9r/AB/Eva+M0JGjGXN
 ZuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FvPd5ifPVoBtRVnaGQOlqp/tByyxR4FiQHLJy7BycmA=;
 b=sS1Yzx0Y20ISTQ0+AjkXwRZLDvvmznx38CmfwSEKLn+4E9U+h4yuw6KUjqYzyTmwXe
 QvYQT8s/KKe9SF93ISBn1swHicY3ZfyoPw/2L4bwPB/YA+70vot3+EeP9LQ6sJu+pS57
 0ls3mrWmUGW1B/V9S5IKcXERBnrxb0jZzM2tKu/o7joVYbi2r4DuhLeKBbfwZ/1zCT6o
 36YLWpjwsAiejgi1f+KKRsDY5GhsIzRx8ip+Qpn/1KEEK5inLrkkTsvQocaGdwW9xqhn
 /s01r1mJPYhA+VLSpvTKfLF31LhwjJUuSSCCpOt28nzHT5REtrOOhmyblLGBVF8GMe/X
 I5Mw==
X-Gm-Message-State: AOAM5300W9nIlL/kyCFXwOBVOGcT+p1KyXVwtHHZqT0Jfj1k5hOc9k+L
 taogqOjNAX1yqa0uM018kYEju/SmdYB+Mn690PE=
X-Google-Smtp-Source: ABdhPJwNKo9SgZ9Tw1csbr5dfyG4j+Gv4mh1lZYbpPwxkNVOWelF2qV1h2YZAKH8JyH5w+J7D7mZ0eXfhFXPOnnld+I=
X-Received: by 2002:adf:f182:: with SMTP id h2mr15937080wro.355.1611835513892; 
 Thu, 28 Jan 2021 04:05:13 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
In-Reply-To: <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 28 Jan 2021 17:34:47 +0530
Message-ID: <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_070517_071774_38F81877 
X-CRM114-Status: GOOD (  24.71  )
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
 io-uring@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 9:32 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 27/01/2021 15:42, Pavel Begunkov wrote:
> > On 27/01/2021 15:00, Kanchan Joshi wrote:
> >> This RFC patchset adds asynchronous ioctl capability for NVMe devices.
> >> Purpose of RFC is to get the feedback and optimize the path.
> >>
> >> At the uppermost io-uring layer, a new opcode IORING_OP_IOCTL_PT is
> >> presented to user-space applications. Like regular-ioctl, it takes
> >> ioctl opcode and an optional argument (ioctl-specific input/output
> >> parameter). Unlike regular-ioctl, it is made to skip the block-layer
> >> and reach directly to the underlying driver (nvme in the case of this
> >> patchset). This path between io-uring and nvme is via a newly
> >> introduced block-device operation "async_ioctl". This operation
> >> expects io-uring to supply a callback function which can be used to
> >> report completion at later stage.
> >>
> >> For a regular ioctl, NVMe driver submits the command to the device and
> >> the submitter (task) is made to wait until completion arrives. For
> >> async-ioctl, completion is decoupled from submission. Submitter goes
> >> back to its business without waiting for nvme-completion. When
> >> nvme-completion arrives, it informs io-uring via the registered
> >> completion-handler. But some ioctls may require updating certain
> >> ioctl-specific fields which can be accessed only in context of the
> >> submitter task. For that reason, NVMe driver uses task-work infra for
> >> that ioctl-specific update. Since task-work is not exported, it cannot
> >> be referenced when nvme is compiled as a module. Therefore, one of the
> >> patch exports task-work API.
> >>
> >> Here goes example of usage (pseudo-code).
> >> Actual nvme-cli source, modified to issue all ioctls via this opcode
> >> is present at-
> >> https://github.com/joshkan/nvme-cli/commit/a008a733f24ab5593e7874cfbc69ee04e88068c5
> >
> > see https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops
> >
> > Looks like good time to bring that branch/discussion back
>
> a bit more context:
> https://github.com/axboe/liburing/issues/270

Thanks, it looked good. It seems key differences (compared to
uring-patch that I posted) are -
1. using file-operation instead of block-dev operation.
2. repurpose the sqe memory for ioctl-cmd. If an application does
ioctl with <=40 bytes of cmd, it does not have to allocate ioctl-cmd.
That's nifty. We still need to support passing larger-cmd (e.g.
nvme-passthru ioctl takes 72 bytes) but that shouldn't get too
difficult I suppose.

And for some ioctls, driver may still need to use task-work to update
the user-space pointers (embedded in uring/ioctl cmd) during
completion.

@Jens - will it be fine if I start looking at plumbing nvme-part of
this series on top of your work?


Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
