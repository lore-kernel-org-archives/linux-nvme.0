Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B062C54EBD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OeyFWbxxgQZ0nroC/1HvPXEMIsCVUv2bdRB3gyM5Cvs=; b=GY387oEEigCgptwLuB/G3RMp01
	j4irtvpxACHL+lbDBFPx/58rZtDY4pEvxDLK5pOVNckI8T9sTQe2TbWPxI+GjtO2WlpXD6pvU87Y8
	3gUo5YYIuZxvagV/b5a6+Sn0SPxLobqfOrQ3PIgHvMCs+uoQtl4hfNT3Gid6A8aEUUyTosVm70ZLA
	aRj0irR8sZK75ZoizdnSjtF+4jcdlCHi9ZWB4v3oeATZFGTBjFoTvsy1S4jYPN4k8M0TUYkMo3Xdc
	lDHoXaZsSftkaOlyhYYr9KQSDhEXeagtnX65hZhiF1qEQrdLlC2MxXQth/Dy2ToXUmK9juKZ7/5u3
	hzn0HOsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDrsy-00EUbP-Vb; Fri, 06 Jan 2023 18:56:13 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDrst-00EUZq-MY
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 18:56:10 +0000
Received: by mail-lf1-x12f.google.com with SMTP id z26so3244913lfu.8
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jan 2023 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeyFWbxxgQZ0nroC/1HvPXEMIsCVUv2bdRB3gyM5Cvs=;
        b=eBW7Nq7Hjhh5EIFVtWwQH7UPgao0aaS0tBsX/feVO52hSyGzzjrqYp1raq1Dj56Ny4
         nfCh6WdJxWVO7xk67wYMtnEM6QPi4lEUOfLkTjpjtSP/FqiH+JP1PS0kH7P3cz4OAaqS
         ezsozKN8vYggdoKhWqWdhdyC6oUwpAu3+u+Q3btxPx/TVIB8UC0z4+z74HeGWAmZHBn7
         RgMjOBk3CYKj3EuztuVfi5BdXUFQAuUWYviKA2B9mexr2fZcE04CcKXBpObj0nORpDo6
         HOnpnql5QbL22/wwElqNs6J3xHLPQMr0IUga4ImyCa8fpRag4zwkvNbV9Q/Un1NPT/ZV
         9ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeyFWbxxgQZ0nroC/1HvPXEMIsCVUv2bdRB3gyM5Cvs=;
        b=KPaRvedjnL/eos6YpScxwtxiL15wBXhC8Gv4bU5NSagt5cCnFr3D00YjVi6+F2Wc+5
         qKQGL6NiFYAzar1ZaeFIffNOtKncGMEBI+QTxS5hXiCnX/LzSh6Ha1lwaM9onIFeEY4T
         RKgk6oZCdVD2PGFAgkQA99j9e0MNK/TzFOFHD7tq7qbsz4bxR71hqvg1IuAySleW5f2d
         0exaE5ZTwJnCt+siMm6vpB4ryXfA4K+reApY0Uqn0mI6L8CC6ZFlVoL64qDf58YpFxrW
         0Gn172yBoRmn82pFItqDAqEjzuJTR7MwCcDoIhFNFlOAYZCX0B5nG0fuAEbCfpBSSMdR
         gQgw==
X-Gm-Message-State: AFqh2krKvdD1B1HELPHWC6ny4FovXTa0F7MCZRl1l10yjFSOkgqVW+BI
	prFtTz7q1tkUO434KLOLd05NnUDG//WNMUB2MeWXzaKrsz1vsaFk
X-Google-Smtp-Source: AMrXdXt8zaJgDJ5cooaHCCZDny5uoIKZl17RJLuw8njKzzJmbv6+azF3L5XlXhOFycOGLl35Kg9oyjjICwlCtc8RF8s=
X-Received: by 2002:a05:6512:370c:b0:4b5:6dbc:b719 with SMTP id
 z12-20020a056512370c00b004b56dbcb719mr5285001lfr.270.1673031363642; Fri, 06
 Jan 2023 10:56:03 -0800 (PST)
MIME-Version: 1.0
References: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
 <CADqNVTqnwkFDmfWSN_ryMVzjF3GXdSv1mu_DcE81-E0a3=v_Kg@mail.gmail.com>
In-Reply-To: <CADqNVTqnwkFDmfWSN_ryMVzjF3GXdSv1mu_DcE81-E0a3=v_Kg@mail.gmail.com>
From: Nick Neumann <nick@pcpartpicker.com>
Date: Fri, 6 Jan 2023 12:55:51 -0600
Message-ID: <CADqNVTqOc8hw3jOrcKcn4Bs+e==BZs77pvGm-JOwH1LUJ+K4vg@mail.gmail.com>
Subject: Re: trying to gain understanding on BLKRRPART and "failed to re-read
 partition table" error
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_105607_783542_74F2CDA0 
X-CRM114-Status: GOOD (  36.08  )
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

I've got a sequence of steps that seems to reproduce the issue about
20% of the time. Adding a 10 second sleep after the suspend and before
the format appears to make the problem go away, but I need more
runtime to be 100% certain.

I captured the failure with strace to see that the ioctl(BLKRRPART)
call is returning -1 EBUSY, which means one of the following happens:
disk->open_partitions is true
(disk->part0->bd_holder && disk->part0->bd_holder != owner) is true

There are a couple other cases later in the code that also return -1
EBUSY, but I believe they do so only if one of the above is true.

My best guess is that upon returning from resume, the nvme driver ends
up in nvme_first_scan which calls disk_scan_partitions. If nvme format
runs as this is happening, then the BLKRRPART it issues at the end
fails because disk->open_partitions is nonzero from the resume scan.

If that is indeed what is happening, I imagine that it could still
happen in the latest nvme-cli, but because there are now a number of
cases where BLKRRPART is not run, it is much less likely to be
encountered.

On Mon, Jan 2, 2023 at 5:25 PM Nick Neumann <nick@pcpartpicker.com> wrote:
>
> I was struggling to find why ioctl might return ECOMM, then found the
> change where nvme-cli went stopped returning ECOMM for all negative
> statuses. I'll see if I can get the actual error code ioctl is
> returning.
>
> On Mon, Jan 2, 2023 at 4:52 PM Nick Neumann <nick@pcpartpicker.com> wrote:
> >
> > I've been using nvme-cli 1.9 (default on ubuntu 18.04 LTS) for several
> > months formatting nvme drives repeatedly without issue before running
> > device-level benchmarks with fio. I always format passing in the block
> > device, e.g., /dev/nvme0n1, and haven't had any issues.
> >
> > I recently started playing with creating file systems on the drives to
> > do file-based benchmarking. After doing this, I've noticed that
> > intermittently the format on a drive that has had partitions,
> > filesystem, and files created will fail with code ECOMM on the
> > re-reading of the partition table. However, I've struggled to make the
> > failure happen reliably. This is the error I'm talking about:
> >
> > https://github.com/linux-nvme/nvme-cli/blob/c3db2bfda5346f68344a9e6d795319a7bf35d19e/nvme.c#L5212
> >
> > The current nvme code has multiple guards on running the problematic
> > BLKRRPART, and one of them, "cfg.lbaf != prev_lbaf", is enough that
> > current nvme-cli would not run the BLKRRPART for my nvme formats.
> >
> > But I'm hoping to understand if these guards are actually fixing the
> > issue I'm hitting in 1.9, or would just mask my issue... that is,
> > upgrading to current nvme-cli would make the error go away, but it
> > seems possible that changes to how I format cause BLKRRPART to run
> > would bring it back). Are the added protections for the block device
> > format case to avoid issues like the one I am hitting? Or is it
> > unusual that I'm seeing such an error?
> >
> > In case it helps, the system does not have the drive or namespace
> > mounted in any way, and the format is being issued immediately after
> > the system is resuming from a suspend. Happy to provide any more
> > details that might help.
> >
> > Thanks,
> > Nick

