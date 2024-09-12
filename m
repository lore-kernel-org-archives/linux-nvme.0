Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7CDEED617
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6q4+5B1dzDElrwSCoqQMrwi9Y4XTNRw+aY9OmVLZZc=; b=o3kWVPJ5CnzkUyX0W0qK+9ohwT
	MBjumA125+A4ijLBuqpPmjzn1ZELKzhZo5zn9zgbPHPZZnCPrPNOiH4SLq4enKEbbwxDFeUqJCLfc
	Pf7eZs6vZ8V60UvvVYdGpYh7NZg8yFsLw2D8FCKoVAcW6h+U21g1kunKxiBpR/dyhhFTnbppnOW0Y
	Odswaid9irNuPmwoDNVKKRB/BeGueLlz2zZN4VNKJjLC+JFwVg//upzrGFyMtrnvCVeVGLQI6VZ9C
	z/32okzTZHRg6yM/KJyZE9lZq/zjkh9yLtCf87az7o+fk46/2hOX4XyaXR0sABGgttHNtsq/NkWWb
	X2gGP1qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somoT-0000000Dio8-3hOd;
	Thu, 12 Sep 2024 16:36:57 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somoQ-0000000DimQ-0WaL
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 16:36:55 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2054fea6f26so827335ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2024 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726159012; x=1726763812; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6q4+5B1dzDElrwSCoqQMrwi9Y4XTNRw+aY9OmVLZZc=;
        b=QeLq8Dhnpu+QuaZtFx3VU9hTuAXTAVtsSJjeDxkfPxZS5xR+bBiNF8bp+kv+wQsIud
         zySNov9WAo8/cs4VTpAkdwLyOrWsz6kn8wAY6kKG9ZVZkTv8i9DTB0PfOpHJXv7yeEvU
         eQjUglF0TW7P6korvnfDSJGHy+9RGqqGfpFAdGugHtGGzIcmdJKavx7yXDrV2hqcgSDU
         qnBLFGQS7fNpOT8T1iDR5BzcavWfJp7dRB8vp611nZIPqBF/CMEm+zcZH3BsQj1n0ARz
         zbrdicN4m+Lk7kRwYr9nbNoh9qVyWBrxmctKsBNipRv5ICQTmH+lH64vqGt2mt1QasaN
         /sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726159012; x=1726763812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6q4+5B1dzDElrwSCoqQMrwi9Y4XTNRw+aY9OmVLZZc=;
        b=mHHcZyYg0orp/aAiCKNHyJQcoiu2dq61vR1p6ZL1sN6Ac+eebOh4noVNcUIMjTfFGj
         WQWoKhZMho5mRMm6HkT/d0uc2q+DfSkT1bVYVMSSKTU0tXhiF1O1nMlwMBCaWhY61N95
         eCZgL82EFO4FCiC9GPJCUh3uj2LKTRQkOmhKO6XaYHvDlMx/gtYL6UtEZt9IlrDttplA
         eZRAdjYhPGHXQeBo5eP94XbvCDSxVPW3tzf0/8lDCmynngVF7MjSHcT/spkjdgwxeTm6
         RFGCsAGUEtrOOppEkKlDyMKUcwkfk4zF61owXN7h0lJDCsf3S6lIijLxKEUN74/Cs9PW
         82CQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tWfATIPB4k31iDAcbbAenisMy6faPht2IQUo7ez/lVvVAXGOr48Nr4G6DvAO+MammDSHRoFC/N7Y@lists.infradead.org
X-Gm-Message-State: AOJu0YzFeVf0erOvbkdiMB7Qs/7G6cZtim+HosXwL1y13nqEUxH3JxXc
	yCSrz3fntLOAfjjX70s6FmH7WelfaAunDP+OvSXpALte0Eh+uRskxqFlqNAs5RmRecIqfta5EOi
	YfKYOjATif93oZKmO4/6csJsA017+OK2Cl+BKJw==
X-Google-Smtp-Source: AGHT+IEvuK2/C9SKR9LDljnhJ6Xha1j/3+G4D1jNUklth3QzOk+XtBkpfo/0udmvLjLT/3UQjcmXO62DLyEN6F9Ohks=
X-Received: by 2002:a17:903:190:b0:207:14d2:ddeb with SMTP id
 d9443c01a7336-2076e4249a8mr20956535ad.13.1726159012392; Thu, 12 Sep 2024
 09:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240912064259.5228-1-d.bogdanov@yadro.com> <20240912064259.5228-8-d.bogdanov@yadro.com>
In-Reply-To: <20240912064259.5228-8-d.bogdanov@yadro.com>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 12 Sep 2024 09:36:41 -0700
Message-ID: <CADUfDZpUJEhowQRis0u==4cKkQPbm7mJJvg6TsaZ-myfFSATJg@mail.gmail.com>
Subject: Re: [PATCH 7/7] nvme: allow send fused commands
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_093654_320831_7B1A2A30 
X-CRM114-Status: GOOD (  24.33  )
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

There is prior discussion about exactly this change at
https://github.com/linux-nvme/nvme-cli/issues/318. The concerns raised
there still appear valid 6 years later. The main issue is that this
interface requires 2 separate ioctls/io_uring operations to submit a
Fused Compare and Write. That means the 2 commands could be submitted
to different I/O queues, which wouldn't work. Not to mention that 2
threads are required in order to submit the commands concurrently if
the blocking ioctls are used. Additionally, another application using
the NVMe controller concurrently could submit a command in between the
fused commands, which would also break the Fused Compare and Write.

FYI there was a set of patches sent to the mailing list
https://lore.kernel.org/linux-nvme/20210105224939.1336-1-clay.mayers@kioxia=
.com/T/#u
that attempted to implement a new passthru ioctl for submitting fused
commands. But it adds memory overhead to each NVMe request and there
are a lot of corner cases to consider around error handling.

As an implementer of Fused Compare and Write on the target side, I can
say the concept of "fused commands" is pretty horrible to work with.
It breaks the model where each NVMe command is an independent
operation and requires a ton of additional error propagation logic.
Not to mention that the NSID, SLBA, and NLB parameters are now
duplicated between the 2 commands... As far as I can tell, the only
reason to make the operation 2 commands is to allow a separate PRP/SGL
for each command. I guess this avoids the memcpy that would be
required if a single concatenated data buffer was used? But at what
cost???

On Wed, Sep 11, 2024 at 11:45=E2=80=AFPM Dmitry Bogdanov <d.bogdanov@yadro.=
com> wrote:
>
> Allow a user to pass fused flags for the commands.
>
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>  drivers/nvme/host/ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 1d769c842fbf..affedac90f04 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -220,7 +220,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct =
nvme_user_io __user *uio)
>
>         if (copy_from_user(&io, uio, sizeof(io)))
>                 return -EFAULT;
> -       if (io.flags)
> +       if (io.flags & 0xFC)
>                 return -EINVAL;
>
>         switch (io.opcode) {
> @@ -299,7 +299,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
>
>         if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
>                 return -EFAULT;
> -       if (cmd.flags)
> +       if (cmd.flags & 0xFC)
>                 return -EINVAL;
>         if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
>                 return -EINVAL;
> @@ -346,7 +346,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
>
>         if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
>                 return -EFAULT;
> -       if (cmd.flags)
> +       if (cmd.flags & 0xFC)
>                 return -EINVAL;
>         if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
>                 return -EINVAL;
> --
> 2.25.1
>
>

