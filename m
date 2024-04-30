Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7B3C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tkKnyVhNvrBQagq6/KTRiauumw2/czr0ivE7Xi1IcsE=; b=kNHC+UsKg9U3lxndKAN00d1POP
	eCzRKMVWkFQC5wbyTW75SpBXQlxNNAmNHqRItukiZ/57qTDyM9SLeLY6uELb0ez+oghw6drmG4QUW
	9/K5Di673CPx3Wz6wCA2BKJE8vTOegDhkthxM9SgZUvNotIdhjBAbteK0Wf2Od6b985cuVEmHfHAa
	bK/SJgSnVAo6S5k6x2CQm2/2OIBZbNYN83T39bTrPVWMjzTmwgMNfkty6suMUfqsGH6KtLGFWXEcG
	QMTlWxho9PtqUIehtwwbp5+qg3hx9s9qWVCNxJBpzpXp61uvG5HtBHAzTWd+d2vKQMIR/65CAWtIE
	Buno25gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1oIV-00000006kzP-19op;
	Tue, 30 Apr 2024 14:17:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1oIR-00000006kyD-2zu5
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 14:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkKnyVhNvrBQagq6/KTRiauumw2/czr0ivE7Xi1IcsE=;
	b=SyzfFrwpt2XqmaOyGW6iSYdTUP33q1LMDwZLw1mhJeHCyBl3VcpBzqme9/6GJfUHSDjggF
	RgeUUhRwrMwoT6DKbjgRyqxx2RFGUSWdY+9HxIMsKDvJZX3CZI1Igv/fprxEUp15nxx6eO
	TIXi5bJpLN9CIiZbS6t2vYcqDE0lgH8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-a5aCusGJNQGRZE1WFv3HKg-1; Tue, 30 Apr 2024 10:17:22 -0400
X-MC-Unique: a5aCusGJNQGRZE1WFv3HKg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b0ad84f81eso3478914a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Apr 2024 07:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486641; x=1715091441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkKnyVhNvrBQagq6/KTRiauumw2/czr0ivE7Xi1IcsE=;
        b=S7VLW2hcCgdz3fVEYnD0EaLYUNmfbAqnlNnKdrK7+JEnJyWi0SuY9zkC3TvcJ00Mix
         7YtSYE2ECtRxmJcsMi/s82ycv9izsncFEZ4xTAFvi1j4DMOPJxxbxZQrtGnGwbtNpyRH
         Sb16UauuzY/posu8WkCwQ5BfLGWt4JuFopCiybnrxpwsHXh2r24scZw5kUlWDRA6WoLP
         +ESB93EZaPIubiMKfIuRZmf4U4xf5zACbOSDshLFWCvEiRPXdY27+1n0bNiDO7xgd/ir
         FbQjbSlUcK+vgbWpU9wGcz3raXyI+vENhslEQNaq1xZx5DZ36UwoeMOMIaJgJ0h3tX1E
         Y3WA==
X-Forwarded-Encrypted: i=1; AJvYcCWO3BSzV5G87XUKfMJ+m6UE1dUd9XXY7qq46IJXr12kxFtcMEHZAJeSqNu5ecX3nH4mGe6W1Ltr4N6iQbsTO+7aWFUy0TESJFQcNBNAg20=
X-Gm-Message-State: AOJu0YwnrplAmwEoLq31dqvpRhgpLq+ngJ0h313RDFWZSn94dm0BzRxI
	nNhkvkwrNpJorYgTp2f8d/oMoPAMpJA4fSbtCkThU/ITsO+IrK6fLUyRokjhBMwNwvS4OvXa2Vd
	meUrY+Kw98PTLCNn2PysyDQY5AQxlawpTiEuSyMPsVYtn9asoobIoAK2sNuRZ5cAZsv6NViEihv
	ACQh1UXusITVD+tRSM0GzNcfqmR6gZnEasTB1cb5Q=
X-Received: by 2002:a17:90b:4a8f:b0:2a5:f19:978d with SMTP id lp15-20020a17090b4a8f00b002a50f19978dmr3044541pjb.37.1714486641257;
        Tue, 30 Apr 2024 07:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFreilTEzi4jgoqCEUd0HqgILrV3AJHsBQAzL8L7ttDETqE55m26zZsV9Yha1p5qKharZxB4ed3HxzY3t7T4gU=
X-Received: by 2002:a17:90b:4a8f:b0:2a5:f19:978d with SMTP id
 lp15-20020a17090b4a8f00b002a50f19978dmr3044508pjb.37.1714486640799; Tue, 30
 Apr 2024 07:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com> <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
In-Reply-To: <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 30 Apr 2024 22:17:06 +0800
Message-ID: <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_071727_979504_3E142607 
X-CRM114-Status: GOOD (  18.44  )
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

On Tue, Apr 30, 2024 at 2:17=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 30.04.24 00:18, Chaitanya Kulkarni wrote:
> > On 4/29/24 07:35, Johannes Thumshirn wrote:
> >> On 23.04.24 15:18, Yi Zhang wrote:
> >>> Hi
> >>> I found this issue on the latest linux-block/for-next by blktests
> >>> nvme/tcp nvme/012, please help check it and let me know if you need
> >>> any info/testing for it, thanks.
> >>>
> >>> [ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
> >>> [ 1873.761900] loop0: detected capacity change from 0 to 2097152
> >>> [ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> >>> [ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> >>> [ 1874.208883] nvmet: creating nvm controller 1 for subsystem
> >>> blktests-subsystem-1 for NQN
> >>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> >>> [ 1874.243423] nvme nvme0: creating 48 I/O queues.
> >>> [ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
> >>> [ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> >>> 127.0.0.1:4420, hostnqn:
> >>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> >
> > [...]
> >
> >>>
> >>> [  326.827260] run blktests nvme/012 at 2024-04-29 16:28:31
> >>> [  327.475957] loop0: detected capacity change from 0 to 2097152
> >>> [  327.538987] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> >>>
> >>> [  327.603405] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> >>>
> >>>
> >>> [  327.872343] nvmet: creating nvm controller 1 for subsystem
> >>> blktests-subsystem-1 for NQN
> >>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> >>>
> >>> [  327.877120] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for fu=
ll
> >>> support of multi-port devices.
> >
> > seems like you don't have multipath enabled that is one difference
> > I can see in above log posted by Yi, and your log.
>
>
> Yup, but even with multipath enabled I can't get the bug to trigger :(

It's not one 100% reproduced issue, I tried on my another server and
it cannot be reproduced.

>
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns)
>
> [  279.642826] run blktests nvme/012 at 2024-04-29 18:52:26
>
> [  280.296493] loop0: detected capacity change from 0 to 2097152
> [  280.360139] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>
>
> [  280.426171] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  280.712262] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>
> [  280.718259] nvme nvme0: creating 4 I/O queues.
>
>
> [  280.722258] nvme nvme0: mapped 4/0/0 default/read/poll queues.
>
>
> [  280.726088] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  281.343044] XFS (nvme0n1): Mounting V5 Filesystem
> 513881ee-db18-48c7-a2b0-3e4e3e41f38c
>
> [  281.381925] XFS (nvme0n1): Ending clean mount
>
>
> [  281.390154] xfs filesystem being mounted at /mnt/blktests supports
> timestamps until 2038-01-19 (0x7fffffff)
> [  309.958309] perf: interrupt took too long (2593 > 2500), lowering
> kernel.perf_event_max_sample_rate to 77000
>
> [  377.847337] perf: interrupt took too long (3278 > 3241), lowering
> kernel.perf_event_max_sample_rate to 61000
>
> [  471.964099] XFS (nvme0n1): Unmounting Filesystem
> 513881ee-db18-48c7-a2b0-3e4e3e41f38c
>
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>
>      runtime    ...  192.747s
>
>
>
> Can you see if you can reproduce it on your side?
>
> Thanks,
>         Johannes



--=20
Best Regards,
  Yi Zhang


