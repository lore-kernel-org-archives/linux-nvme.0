Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C1DC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4gbyoe8fDl1Z4i8eb+V130cKPriCqV8pTA8MHoU4vGM=; b=bJttvDW2HKpKckLgCLknqdE7bk
	XABERQAUo8VyctSiPwDsuu4qKSOwbJWejLLEEyCa74RXno5oyvZYJpfq0XRwlNXvtO+1Hb92DaJaJ
	5lKo6WcAiByQKyk8EqT0rcMENtCrYAJnHyseEAV0ZzN9xHl3s5gaz79F+rVwkjVPdiMLr0Hr4jEHG
	EgJAaM5vK8XmGaZR3gyC27LkSi7tAohDPQDsgkSxEe1i5B522Dlqn9xiscmjuGijhtKpHYC3zLrT1
	QHkvwHsJ5YRM4ZGnD0an0OKCD2EJcmRBEQjL65ItQ8PwOlSpmKyHGZr1ters3Nn0fpkiio5yZLMDU
	TULa6UJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsvZ-00000003AgR-0v0R;
	Thu, 09 Jul 2026 17:52:49 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsvV-00000003Ael-2Zvv
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 17:52:48 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so125139a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 10:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783619563; cv=none;
        d=google.com; s=arc-20260327;
        b=T0iXj+RIVl2j4AlvaRf3ckAZ90GWXRD5WOLmEOECaFsR+3zkAGYaA5JxOi8nYNHzf7
         e6KozguJmsyvbN/Y1aPHQMowg9G8KtPRC5PdYw/Z+Kp1BHBIE+5aD89LjV80xiBsIayu
         AAmtC1KY3K7r9wI96Vn00oTSjTJiK8cMI4RuQRLeqvxYUmh6bejJ+umALmbcxJ11C7mZ
         GmqJzVpRCiFwFCFVTZ3000s5XkxuOm9dPMbk9615KggPFRM/1ZNzlfddXdEyYh4L3UUf
         7K17Gau5DS3QnR/9oZD00rVGW1iWbYBYZ/jMHu7ij7vacP+RFXavzrCyaaCo4vu1FvJ9
         nL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4gbyoe8fDl1Z4i8eb+V130cKPriCqV8pTA8MHoU4vGM=;
        fh=0q+kCqa1/MfqF6Xr9jMeoecFJUgiWh5BVIYPgf+quP0=;
        b=UXoCK9nxj1UZq54ZRDCQTvimtQZ5UX6/LROjXOUDZicnEHNp3CRJOBv3qJugMMhRJ0
         JZBB8JFCG2LSQ9SQddIAnftY7D8H+zB0Qt3CGPkyaCFZxMU8zmDxo/Tx1btwtxFF7FCS
         lFYQYCH0k87sDgp1OIIzro8XOtcUw2VOeXq8nE5dUF6wjkfEnRiJ6I+H0h0PDU4FXlMK
         efMhRt/k6sehPMNNeEDicb7JaX9EvhezZAGte5aGPUDbu5S0YNtMfrm7naQP3CYvZFIr
         +Ghk36HdNQBnTmn5UsQiieV0+WUMHlRAI/2GLKKeZgE/VjhskQnw+TJnH2jKRm7Ua0lF
         ARhg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783619563; x=1784224363; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4gbyoe8fDl1Z4i8eb+V130cKPriCqV8pTA8MHoU4vGM=;
        b=ZB9efRVrnn7H4C15OKXKpKaRVcsPf4XNZf5tDCuOB4GV4/5XexIQWoxnEWtqVVjDCL
         mFpmRlUkSgYxcR8+YeQxU4kUS+lqUMJEPeKNP81HVZfL4FF86q/q1svpxkAW4kl8VDAC
         cl2NCgTx4tXGYXvzCe/V/8wS549VJjIOzMpltO46yJarJDvmAesInrCpmzPHKtTKo8mY
         8OI3LbrDPg5zK0iXI4yt0kf4mXd4HgPzZ2ziU8M4Rn4s0bWKa2XRWFUc8opsV5bEEtYE
         ghcF3beQ+AOmcRC4s8d604eTKbIYmVPb7nOsURukmFRF1HN5iYWM7irijYvzct87uYDm
         ymIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783619563; x=1784224363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4gbyoe8fDl1Z4i8eb+V130cKPriCqV8pTA8MHoU4vGM=;
        b=KFDt0i4c5zXAAUooEuxF+NDV2jKOhuvqlMGnhnIMIW4eoObXR2aexrxQafSNwSr+jy
         AprlMVdM6ILMfgXVYqoeI2oCbuNx0EM5RRrNnqzw4akPVWUUc1b7jTW7Lu4zkm1G6SWV
         QxyF2trh08iyOIADyngwmwSdUyp5H3Kqb8Vjnqyg9DtFUTN8MSIdLeIx7mNhdfVn0odz
         TJsdD3Y3z+YYMuOnQ7bAhubUTTNLtmlVs7/nyNzuFz2mQ9sKdUYxOTdc3IwIOwQ8c/e+
         O8MNW+lmBpSCyss4OH8Kb2brsLUMgUktb6+XoDWbJno7i5MgtpuJhsG4XgqC3sFeaBK7
         9ofA==
X-Forwarded-Encrypted: i=1; AHgh+RqyShlQgIyq2LlVkOF11d/eEn45LHNM5uPKUyFdWVjbhGbmGWMK0CFj0i0i8vK/lZUynnI4CFNj6Z5D@lists.infradead.org
X-Gm-Message-State: AOJu0YzOuusOThe+N1J8zv2VWXUemutNUa8IPfqtZdsyFOnERgdgnGog
	3f0RLzBKmm/FbvY9ZxFYQDDRw+2xLunCZix/eJIFVL+xbUvpRqccy9+mYLjURP71DXjqXpjdxlI
	ygHdLIxnyOkLquHBBNhg6DPgDQtlxuKQ=
X-Gm-Gg: AfdE7clepMi4JY5jtQEAXyxVSW9KEPnJJBDo8i5s00Q5ui0Jb1LuNQShiLaLlg4CdpE
	vPuYK1p0z45r8YlLbwYohgSQp/TM2mmNpsXohWGA8NyoeZuyxs1TB9UBO0qf5T4IBoX23dZqkt7
	x1HCrighuYXwD+4yvE4ctZPft0FQAtHsINy2Jqvu4AMBDK73Bu8kuY7oUp2AsyDrzOg1LUTj9V8
	ExO5xpUYyvcuk7RbKGz1KgBU/guehELa1OkOT3JkJ/pW2bGHOwG4qlWGmcrY4rIDVDhKHYH
X-Received: by 2002:a05:6402:4488:b0:698:b25b:8df with SMTP id
 4fb4d7f45d1cf-69ab44a1cf9mr3235616a12.21.1783619562874; Thu, 09 Jul 2026
 10:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260527055923.456769-1-coshi036@gmail.com> <ahcR2vy8k2FZAp9D@kbusch-mbp>
 <CACd_6n2vT8RiWGL6g2aasEgzpdnOFz5NnwF42vwzO0gEd=cu1g@mail.gmail.com>
In-Reply-To: <CACd_6n2vT8RiWGL6g2aasEgzpdnOFz5NnwF42vwzO0gEd=cu1g@mail.gmail.com>
From: Chao S <coshi036@gmail.com>
Date: Thu, 9 Jul 2026 13:52:31 -0400
X-Gm-Features: AUfX_mysPotYPY27FvikP_AQqYPDYQktQIRiHWzUDGnMieO6GSgbxaPugaNifrM
Message-ID: <CACd_6n1Ws_rg8bwqbOTV0VcKOGYnfA6TLQnCyM-JxhE4V5zGHw@mail.gmail.com>
Subject: Re: [PATCH] nvme: bound the freeze drain in passthrough commands
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_105245_677713_F20110DA 
X-CRM114-Status: GOOD (  36.18  )
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

Gentle ping.

On Tue, Jun 23, 2026 at 6:28=E2=80=AFPM Chao S <coshi036@gmail.com> wrote:
>
> Hi Keith, Christoph,
>
> Both questions land on the same point, so one answer below.
>
> Keith wrote:
> > The IO timeout callbacks that nvme drivers provide are supposed to
> > forcefully reclaim any IO no matter what state the device is in. Is
> > that not happening for some reason?
>
> Christoph wrote:
> > Note that the blocked message itself is not a problem, but around
> > this time we should have done a controller reset and fixed up the
> > issue.  Does that not happen for your test case?
>
> It did happen.  nvme_io_timeout was the default 30, and the relevant
> dmesg from the campaign that produced the hung-task report:
>
>   [ 44.220408] nvme nvme0: I/O tag 451 opcode 0x2 (Read) QID 1 timeout, a=
borting
>   [ 44.220798] nvme nvme0: I/O tag 819 opcode 0x1 (Write) QID 1
> timeout, aborting
>   [ 44.220820] nvme nvme0: Abort status: 0x0
>   [ 44.221286] nvme nvme0: Abort status: 0x0
>   [ 45.591197] nvme nvme0: resetting controller
>   [ 46.307151] nvme nvme0: IO queues lost
>   [...100s of silence...]
>   [144.561596] INFO: task systemd-udevd:134 blocked for more than 123 sec=
onds.
>
> Timeout fires, abort is accepted, reset starts, reset reaches the
> "IO queues lost" branch (drivers/nvme/host/pci.c).  Then nvme_reset_work
> itself blocks at
>
>   nvme_mark_namespaces_dead -> blk_mark_disk_dead -> blk_report_disk_dead
>     -> bdev_mark_dead(bdev, true) -> sync_blockdev -> folio_wait_writebac=
k
>
> i.e. the unconditional sync_blockdev in bdev_mark_dead's bare-bdev
> else-branch (block/bdev.c) is itself waiting on the writeback that the
> reset was supposed to drain.  The reset_work kworker doesn't show in
> this dmesg because it crosses the 123s threshold ~25s after the
> snapshot console was cut.
>
> So in this report, the IO timeout did its job, but the reset that the
> timeout kicks off cannot complete, and nvme_passthru_start (which is
> already in nvme_wait_freeze at this point) has no way to back out.
>
> Two reasons I still think the bound in passthru_start is worth applying
> on its own merit:
>
> 1. The reset path has several ways to fail to drain in
>    nvme_io_timeout: abort can be rejected, the admin tag for abort
>    can be unavailable, the controller can be wedged before abort
>    lands, an in-progress reset can outlast nvme_io_timeout, or (as
>    here) reset itself can block.  Each leaves nvme_passthru_start
>    waiting forever, holding ctrl->scan_lock + subsys->lock + every
>    namespace's freeze ref, which then fans out on bd_disk->open_mutex
>    via any concurrent bdev_open/release or BLKRRPART.
>
> 2. The same pattern is already established in the tree.  pci shutdown
>    (drivers/nvme/host/pci.c), nvme-tcp reset, nvme-rdma reset,
>    nvme-apple, and Daniel Wagner's 2021 nvme-fc series
>    (20210818120530.130501-1-dwagner@suse.de) all use
>    nvme_wait_freeze_timeout(NVME_IO_TIMEOUT) for exactly this reason.
>    nvme_passthru_start is the only userspace-reachable caller still
>    on the unbounded variant.
>
> Christoph also wrote:
> > So not blocking forever sounds useful, but this might break existing
> > uses.  I guess we could do it based on the O_NONBLOCK flag if people
> > really cared.
>
> NVME_IO_TIMEOUT is already the bound any submitted I/O can be
> synchronously waited on; a freeze drain that legitimately exceeds it
> implies the controller isn't doing useful I/O anyway, and
> nvme_core.io_timeout=3DN scales both knobs coherently.  Drain on a
> healthy system is sub-second.
>
> Gating on O_NONBLOCK is a reasonable fallback if you'd rather keep
> the old default, but the nvme ioctl path doesn't currently consult
> fd flags, so it would be a new userspace contract.  My concern with
> the current default is that any of the scenarios above lets a
> userspace ioctl wedge a kthread with two ctrl-wide mutexes held; the
> +9-line bound prevents that without changing the success path.
>
> If the maintainer preference is the O_NONBLOCK gate instead, I'll
> respin.
>
> Thanks,
> Chao
>
> On Wed, May 27, 2026 at 11:46=E2=80=AFAM Keith Busch <kbusch@kernel.org> =
wrote:
> >
> > On Wed, May 27, 2026 at 01:59:23AM -0400, Chao Shi wrote:
> > > If a completion is silently dropped or the device hangs, the calling
> > > task wedges with ctrl->scan_lock and ctrl->subsys->lock held, fanning
> > > out into hung-task reports on any concurrent open/close/passthru on
> > > the same controller:
> >
> > The IO timeout callbacks that nvme drivers provide are supposed to
> > forcefully reclaim any IO no matter what state the device is in. Is tha=
t
> > not happening for some reason?

