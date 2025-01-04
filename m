Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A0E77197
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUjkPGj47hm11KTQsm2hKqLSxMMo/hgYDvHHmf6hkiE=; b=Wh46hry4eYQUpmMurajbcZUNnU
	3rvMsPek5gV0rKh5L9WY6UpES0nbiK73MT8TdD3gPMVbg3LKZOdAUbiId5DJm+11kZP4hiw/ioOAC
	ojalJB+t/27jtuIHho2+lHdmh0nijZbXZve08hjtuPHPNQz9MYKIqbfvdRN7Jmpuc2eib0DjLEBK7
	MTTcT5I2H33U/XF8TjBlrKKNWr0go1yMaMjRUhWrFZ63XN8CPhsY+BhlgBikepfL50AgzACDH639u
	g5pBRkdxMKuVTlkqdJ9sbgu4c3iJ9EQKwHCphhHNjFW6s6WVNWZQVGMe6FYlAJfIHMelE3rQIUz8C
	JAB3osQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU8KY-0000000FMaW-0UWQ;
	Sat, 04 Jan 2025 17:52:58 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU8KV-0000000FMYr-1KEb
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 17:52:56 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-e479e529ebcso16808153276.3
        for <linux-nvme@lists.infradead.org>; Sat, 04 Jan 2025 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736013174; x=1736617974; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUjkPGj47hm11KTQsm2hKqLSxMMo/hgYDvHHmf6hkiE=;
        b=f1G/y41vzlMx9Q5Gopqi5WyH/o6LfpXsbhR3UB+rrRJeQkM6a5gfPtc9MU9QlEHp7q
         V1twhWfjfeNhczBKmgoJirPMJncSdXt9gWY/TRwQD7IOEPZ4Vtg6dwaElWoUohjX+rka
         px9JFeoKhmRu8Fzc7WdbwGUcz1OVxPc1f4zu1XCArGreTFlY2z4xdP1MwctbKoC5eEEE
         auSMQlUwHGOBgmqISihntz0loBWWCqXILxqc/3aB9hd1u2qficZLpJ++ckh/5gc6+Ooq
         D6VY8bC0b42CTPde1hGkjaFUs5ssCIP5ULkJXLVq7QtZQkm/J6Z7LO+E8uFnqV2gVE+S
         VuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736013174; x=1736617974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUjkPGj47hm11KTQsm2hKqLSxMMo/hgYDvHHmf6hkiE=;
        b=uL9LeES2Y7agtNjspADI3x637kfnQJmpGSB0oCLFELj0rp7o8nGh12eZniyafuFhAj
         5HYpdRH1Vstdcphy1d+336sBrRm2QT0MQ8tspXd8M3aGpaSA5pPCqjNQ4oBGwLXUNCLI
         2Lrt8Y1CWwpuUMEqqX9agRYV65iLS+LTStur9Uv5LNBg2O9oxQDw/Mzh2MuyVaJFamm8
         Z1Q74zNXca1o93FJYutJ375d4EosETtFtSXmCb0AjuhXOFJz0sZErPfB8+uVKqh2t0Uo
         LxCiVsWCd9whim3S8UZeob1NGzv5OKV3G1WdQf+26/WBMKF3RbGPjCy+IgEy/QgUevTM
         RZTw==
X-Forwarded-Encrypted: i=1; AJvYcCXqk80YsCtMt3C85rBHjTw0ciRtq9I/+EzXQkuFpmrjLMz3X2VxBjhzJP+qmhye1fAMFQnMkGgD2mFv@lists.infradead.org
X-Gm-Message-State: AOJu0YzrZ36e2h/5Wr29dwcEuWOZoRXCHRS6htsC4tFwgAC5K2r2N+DJ
	9JQE2E/n5cgBvWtZinYUja/MGh4brZSWQBUWOQlUb9ylMQH77dST7j3hGyVrIFvpeQLlaTGppKl
	/ymwfA6Hg6wNu7GyqVCr+/TYhWu6/i4a4LV0=
X-Gm-Gg: ASbGncs+K2S3xMZ+8+vRypGhydouyywCnhrntmJ3cFY6b1cOx+WGkl3LCIuM0uIilrN
	xLPLb0erOaAMGZeV6GYpZrHiZJhB2nBxXpJ+kY2Ib
X-Google-Smtp-Source: AGHT+IG7KRbfgRYvJrxcZgctdUiqfo+/iWiuWGtHyeYRqcBAPLNuiD8tFKWpsZsOjnyhO1nbDBXrZ5pr9sZU7MnA6P8=
X-Received: by 2002:a05:690c:7109:b0:6ef:6178:404a with SMTP id
 00721157ae682-6f3f820d3a0mr354863937b3.33.1736013173669; Sat, 04 Jan 2025
 09:52:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
In-Reply-To: <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Sat, 4 Jan 2025 23:22:40 +0530
Message-ID: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Song Liu <song@kernel.org>, hch@infradead.org, yanjun.zhu@linux.dev
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_095255_353990_41A53B75 
X-CRM114-Status: GOOD (  25.13  )
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

Thank you all for your valuable feedback. I'd like to provide more
technical context about our implementation and the specific challenges
we're facing.

System Architecture:
We've built a block-level continuous data protection system that:
1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sect=
ors
2. Captures sector numbers (not data) of changed blocks in real-time
3. Periodically syncs the actual data from these sectors based on
configurable RPO
4. Layers these incremental changes on top of base snapshots

Current Implementation:
- eBPF program attached to block_rq_complete tracks sector ranges from
bio requests
- Changed sector numbers are transmitted to a central dispatcher via websoc=
ket
- Dispatcher initiates periodic data sync (1-2 min intervals)
requesting data from tracked sectors
- Base snapshot + incremental changes provide point-in-time recovery capabi=
lity

@Christoph: Regarding stability concerns - we're not using tracepoints
for data integrity, but rather for change detection. The actual data
synchronization happens through standard block device reads.

Technical Challenge:
The core issue we've identified is the gap between write completion
notification and data availability:
- block_rq_complete tracepoint triggers before data is actually
persisted to disk
- Reading sectors immediately after block_rq_complete often returns stale d=
ata
- Observed delay between completion and actual disk persistence ranges
from 3-7 minutes
- Data becomes immediately available only after unmount/sync/reboot

@Song: Our approach fundamentally differs from md/raid in several ways:

1. Network-based vs Local:
   - Our system operates over network, allowing replication across
geographically distributed systems
   - md/raid works only with locally attached storage devices

2. Replication Model:
   - We use asynchronous replication with configurable RPO windows
   - md/raid requires synchronous, immediate mirroring of data

3. Recovery Capabilities:
   - We provide point-in-time recovery through incremental sector tracking
   - md/raid focuses on immediate redundancy without historical state

@Zhu: The eBPF performance impact is minimal as we're only tracking
sector numbers, not actual data. The main overhead comes from the
periodic data sync operations.

Proposed Enhancement:
We're looking for ways to:
1. Detect when data is actually flushed to disk
2. Track the relationship between bio requests and cache flushes
3. Potentially add tracepoints around such operations

Questions for the community:
1. Are there existing tracepoints that could help track actual disk persist=
ence?
2. Would adding tracepoints in the page cache writeback path be feasible?
3. Are there alternative approaches to detecting when data is actually
persisted?

Would love to hear the community's thoughts on this specific challenge
and potential approaches to addressing it.

Best regards,
Vishnu KS


On Sat, 4 Jan 2025 at 06:41, Song Liu <song@kernel.org> wrote:
>
> Hi Vishnu,
>
> On Tue, Dec 31, 2024 at 10:35=E2=80=AFPM Vishnu ks <ksvishnu56@gmail.com>=
 wrote:
> >
> > Dear Community,
> >
> > I would like to propose a discussion topic regarding the enhancement
> > of block layer tracepoints, which could fundamentally transform how
> > backup and recovery systems operate on Linux.
> >
> > Current Scenario:
> >
> > - I'm developing a continuous data protection system using eBPF to
> > monitor block request completions
>
> This makes little sense. It is not clear how this works.
>
> > - The system aims to achieve reliable live data replication for block d=
evices
> > Current tracepoints present challenges in capturing the complete
> > lifecycle of write operations
>
> What's the difference between this approach and existing data
> replication solutions, such as md/raid?
>
> >
> > Potential Impact:
> >
> > - Transform Linux Backup Systems:
> > - Enable true continuous data protection at block level
> > - Eliminate backup windows by capturing changes in real-time
> > - Reduce recovery point objectives (RPO) to near-zero
> > - Allow point-in-time recovery at block granularity
> >
> > Current Technical Limitations:
> >
> > - Inconsistent visibility into write operation completion
> > - Gaps between write operations and actual data flushes
> > - Potential missing instrumentation points
>
> If a tracepoint is missing or misplaced, we can fix it in a patch.
>
> > - Challenges in ensuring data consistency across replicated volumes
> >
> > Proposed Improvements:
> >
> > - Additional tracepoints for better write operation visibility
> > - Optimal placement of existing tracepoints
> > - New instrumentation points for reliable block-level monitoring
>
> Some details in these would help this topic proposal.
>
> Thanks,
> Song

--=20
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

