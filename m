Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B27E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CytCX/yJgP/fleYJlC53F2ZOkdsOT0ASSFcccopMVwc=; b=Lzl9peajxKCmHdtYNDaGFf8ZsW
	JXyY65DxsMAuMDEymmSWTEx58ZGHFHWsRJXWxtwuula54V4fYdolh8WnPSxtFti4UCwVi3xNMggSY
	EGT8v2exTWHZS6+B7vGd/KKCul7FvP64Z5mRimkwHax1Tb7+iBXgKABRICkeR4rzixP3/kXIHTERR
	roqa8NLvW0AT5mmfCQvTnH1Eyy7MAAxeXC+0dWaDCjUUPoOJ81pvFVbMysKjBYVlQ07A1xZhR9tWP
	nlF/mZW+84FSI39La5i13rOfPTAHdHjP3p/NLzWwkvyxsGKqtlNdOU7eFWFAjFT5u6aooVPrtof1K
	UhPKNMpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUuVx-00000002irU-0Tnc;
	Mon, 06 Jan 2025 21:19:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUuVt-00000002iqJ-3cdg
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 21:19:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DAA6FA41E9A
	for <linux-nvme@lists.infradead.org>; Mon,  6 Jan 2025 21:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FF5C4AF0B
	for <linux-nvme@lists.infradead.org>; Mon,  6 Jan 2025 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736198392;
	bh=1IvVO8wjdXmDKwRzBaEFXBnAwV0/f29Vw48pMxlqPlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lk3Q/bzUpa6izmDyOCrjhJCDsh6IKKGbHfB7OWrP/PW9o42skAr7RzUwzupMBRJER
	 cbbr/u9mW+gjF+d3LZMwfzlmT2sEAkiHHKYgsTRCfuGpdXOhWBQqDtMyhn6/VkWVXf
	 Uy+BNwQIJt//AqxI+x3SIWSKqCOi6RTNa79KVXlsl0zUVeiu8qpiCfEVP/YZe3UYlB
	 kiZbl9+crmV778I3QrA2/FgqZQdGTSRtEskp9e72jHH5P9RvaJPRBzbEmH5Hb8Ws25
	 bF1ZBmAdWt0NJZfhaKNf9vYHuYrDenn77RnXp1ropqx0SgcVUIOM4L+uHRpI+lR3Vb
	 ya4HIpOvfFRCg==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a816cc9483so114874805ab.3
        for <linux-nvme@lists.infradead.org>; Mon, 06 Jan 2025 13:19:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiQrLqbbu3mrtrof8gnsBCP+qCWdC2s9f9RLr9Ww/9WuJn5mAiF87cRDfWzicCNWURhBwNxtE0/OVh@lists.infradead.org
X-Gm-Message-State: AOJu0Yx90ziFW6jlgfKwxpB/MzFVmnLEYZmQOwwGn7WXl+B9AVZcAVhy
	BRKXlEVMfWWz3BdaPDAgZCmAxciCze9QHOTJ3r9WDiPazZxwQGgHx0XkLt3KWp0oCUwHf3QGqmL
	T5uNyzEl0j1iqtx5DTzs+Ofjh9HY=
X-Google-Smtp-Source: AGHT+IG+IZ862kK6kDnKJWKdE2t5hnf3zzYHYsozv0R7eibPPM7/ODHoZWX3L5ZjVn6xVB8eQQ/ogUsuhhubpVxH1Kw=
X-Received: by 2002:a05:6e02:1fcb:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3c2d5b3786dmr365300975ab.22.1736198391826; Mon, 06 Jan 2025
 13:19:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com> <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
In-Reply-To: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 6 Jan 2025 13:19:40 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
X-Gm-Features: AbW1kva00aG7ViLBjQbXd8zclJSkWUzD_mt2_zAtClxvxCVGi76ef79Gc0_jSxs
Message-ID: <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: hch@infradead.org, yanjun.zhu@linux.dev, lsf-pc@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_131953_972820_EB9FE145 
X-CRM114-Status: GOOD (  11.60  )
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

On Sat, Jan 4, 2025 at 9:52=E2=80=AFAM Vishnu ks <ksvishnu56@gmail.com> wro=
te:
>
[...]
>
> @Song: Our approach fundamentally differs from md/raid in several ways:
>
> 1. Network-based vs Local:
>    - Our system operates over network, allowing replication across
> geographically distributed systems
>    - md/raid works only with locally attached storage devices

md-cluster (https://docs.kernel.org/driver-api/md/md-cluster.html)
does support RAID in a cluster.

>
> 2. Replication Model:
>    - We use asynchronous replication with configurable RPO windows
>    - md/raid requires synchronous, immediate mirroring of data

immediate mirroring is probably more efficient, as the system doesn't
need to read the data from the device.

> 3. Recovery Capabilities:
>    - We provide point-in-time recovery through incremental sector trackin=
g
>    - md/raid focuses on immediate redundancy without historical state

IIUC, the idea is to build a block level remote full journal. By "full" jou=
rnal,
I mean the journal contains all the actual data in addition to metadata.
I think the consistency can be really tricky with write cache etc.

Thanks,
Song

