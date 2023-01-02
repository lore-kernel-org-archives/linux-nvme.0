Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2AEC4708E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jan 2023 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7hEWvGvtFRjNOMJw44UInvxVnSgiDU4c4eqh/GvFFQ=; b=XLURyGwUbFO7S5iaWnQCg/f0g/
	4CUUfEfFbzoWErg9ksa2J+PTFpWCs7NVSJ8dyD9Bd5M8rEJ0H5/TUZitBa5kovQtPdRQztqQYFZWx
	eobW03dBuYnA5rXUT422r570LHjckxr08O0dBZzwfinUQJg1j/1uMvYFoe5wTYlc01LauDn6OKMAQ
	cnDE900XzezTUCWdo2V8gyIGgSvRZn7LIq/ZSvEiEvDscjuD57gIZri0LOtaXenO9gNzVWcfz5gjt
	lfiAptxmkQa5xcGyl5wA2MNzZn7hR+UvTBg3hU9r/1hu5Vv23aJx9CgVdlHugbB18Ntg43FVfk44n
	ghN5FC8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCUGW-00EsOE-PL; Mon, 02 Jan 2023 23:30:48 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCUBc-00Eqmp-0C
	for linux-nvme@lists.infradead.org; Mon, 02 Jan 2023 23:25:45 +0000
Received: by mail-lf1-x12e.google.com with SMTP id bq39so35671156lfb.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Jan 2023 15:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7hEWvGvtFRjNOMJw44UInvxVnSgiDU4c4eqh/GvFFQ=;
        b=cF/P7MMAS49JpEeiwbK93Qr4dpDKcQgIucN0pt3ySHHSLaIlxEBbWk5NNmzKKNp9eW
         v/d9RCD2T5gu3s/CAJ+22ciK9M+VbmG3A177oqes0PMwlprxjEhuHBduampP0fwnUdmT
         uM2nkLeUpvcrPnxIvrizfPZSKlB0jOczj57M8AkDxjDyYAoY+lmWSqe5k6SDykssQOgn
         /QiKwmAYUxwl3u0Mrfcl/mTEiagTvYKslkGihw/Pd1dbfpwAxLckx9RnZh/qQ/OjnJ6j
         TcIxzULREVKUw5HKgDWzs1LGy7fxfTTKTiRloLhsnKAREBgYBnSQ9ac9V52Z6/JFgV74
         rH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7hEWvGvtFRjNOMJw44UInvxVnSgiDU4c4eqh/GvFFQ=;
        b=R9t9z4uuT3Pavst2RgRpb7y+6XRv1h0qqGEshYBfcsTEZ+Ar3oyjQ9HNReGVMiuixD
         B3LnfQSByk0raPbgY267s7psL4tXFuYra6kr6ygoFi4EjdKxP03PvwtXZq34SLFhzKqz
         EjR1Lge9uv4Kprr82mPzVtsAcSHc+akErcC1tKJpJ1FONulwLZwHXcxIkPAiThXrKGG6
         4FigkHnIrb9d0axs0iUxDAt18Z00UaXyPyL339K4apwOTgUVFIzzrJNOp8VpgosUakwQ
         kxllsMEI/4PPzOtj5QPGDSXdIA+2UcihIN4hNeLInq4lEaWrPxeb6FdAlHhmHIkzqmPx
         a0rw==
X-Gm-Message-State: AFqh2kqv9IPrM2jBGN112fnCszISbsY6MGp8iGD37HtcustPOc81vk0L
	udOGC8DHwoEKSQ/oEXqDuO6orr46+5Pr0YNj1VxEW7zaO6gT1g==
X-Google-Smtp-Source: AMrXdXsPniZKIrQK3xcyn7JSBeQrqtCpZCG0A5UmmVyderYlozLGqWvDwMSbish54UAe4nbMb5CGopjemXdLoSp5xh0=
X-Received: by 2002:a05:6512:3b8b:b0:4b5:64e1:a4dc with SMTP id
 g11-20020a0565123b8b00b004b564e1a4dcmr1889076lfv.546.1672701932660; Mon, 02
 Jan 2023 15:25:32 -0800 (PST)
MIME-Version: 1.0
References: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
In-Reply-To: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
From: Nick Neumann <nick@pcpartpicker.com>
Date: Mon, 2 Jan 2023 17:25:20 -0600
Message-ID: <CADqNVTqnwkFDmfWSN_ryMVzjF3GXdSv1mu_DcE81-E0a3=v_Kg@mail.gmail.com>
Subject: Re: trying to gain understanding on BLKRRPART and "failed to re-read
 partition table" error
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230102_152544_100328_4DA8D71C 
X-CRM114-Status: GOOD (  25.35  )
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

I was struggling to find why ioctl might return ECOMM, then found the
change where nvme-cli went stopped returning ECOMM for all negative
statuses. I'll see if I can get the actual error code ioctl is
returning.

On Mon, Jan 2, 2023 at 4:52 PM Nick Neumann <nick@pcpartpicker.com> wrote:
>
> I've been using nvme-cli 1.9 (default on ubuntu 18.04 LTS) for several
> months formatting nvme drives repeatedly without issue before running
> device-level benchmarks with fio. I always format passing in the block
> device, e.g., /dev/nvme0n1, and haven't had any issues.
>
> I recently started playing with creating file systems on the drives to
> do file-based benchmarking. After doing this, I've noticed that
> intermittently the format on a drive that has had partitions,
> filesystem, and files created will fail with code ECOMM on the
> re-reading of the partition table. However, I've struggled to make the
> failure happen reliably. This is the error I'm talking about:
>
> https://github.com/linux-nvme/nvme-cli/blob/c3db2bfda5346f68344a9e6d795319a7bf35d19e/nvme.c#L5212
>
> The current nvme code has multiple guards on running the problematic
> BLKRRPART, and one of them, "cfg.lbaf != prev_lbaf", is enough that
> current nvme-cli would not run the BLKRRPART for my nvme formats.
>
> But I'm hoping to understand if these guards are actually fixing the
> issue I'm hitting in 1.9, or would just mask my issue... that is,
> upgrading to current nvme-cli would make the error go away, but it
> seems possible that changes to how I format cause BLKRRPART to run
> would bring it back). Are the added protections for the block device
> format case to avoid issues like the one I am hitting? Or is it
> unusual that I'm seeing such an error?
>
> In case it helps, the system does not have the drive or namespace
> mounted in any way, and the format is being issued immediately after
> the system is resuming from a suspend. Happy to provide any more
> details that might help.
>
> Thanks,
> Nick

