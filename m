Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84238E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 01:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wmWc/77/LQw1qXjfBth30rSS1ne9bLH3axy43XapDEY=; b=LSIhMjzJFCRfrLMmQisuiTIXae
	LGF+gYuPXypX4WmbpwH9x0fgDsXnJqP5rA77DSehrcWEd4L3N0q8FGW3f5Cpap6nAKZgsoGq/c90G
	ODSaAKMtfe+rwDpf4pYI2NYSD7J69YI6PbSMkvNRYZPAyQ/eYhKaXcWslX20AYmECzKMnZUPewJXw
	1zCaKSaSJ2fCSzitbKAUxANonVzxP9qZPeujGQHkGhtFyurqrdBiosZ3vOXyKQAocV2QS7EQDU3iD
	smxoi2lF/1oN5WS9bJnlvnif7GgajRnjsWi9PHcWnWjGnCxjbQtcZa7pR7hIjcv89DW7DNd5RCYWE
	N5U/4yUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTshG-0000000EICS-2Dcm;
	Sat, 04 Jan 2025 01:11:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTshE-0000000EIBd-1eVt
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 01:11:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6F3085C5C98
	for <linux-nvme@lists.infradead.org>; Sat,  4 Jan 2025 01:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CCAC4AF09
	for <linux-nvme@lists.infradead.org>; Sat,  4 Jan 2025 01:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735953077;
	bh=wmWc/77/LQw1qXjfBth30rSS1ne9bLH3axy43XapDEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bqJLpKw07XoGSy1s/RnWX7CW13aqgAa363xnGnoBSlocZfIOAbPgPuqrJI+bWPjQW
	 r0zgnqpg7mr4upZIaDqhkA/jiifoDPu1WcjFVUqcRTppNXhGAuWDISahRigYuELu1Z
	 2gjTGCJLAsjIbff0lG3kIlEXFMj61KAcwZsu1Vj3qPYedJhN8bLyZzcWt9PcspSLvz
	 kpI/71dzbt+JfYR6Qk5WcjjMIjOlR36MUB8vDkQrPYBPthOcrXT4zrPtPPRxDcyQ01
	 ZTg1qGIeohV/aE8iuTiJrWzumtRCXpeoCA/L8fiE8xQXcIR1TJCaykRv5DSHe3qd8E
	 EfoXc5SM6k8Yg==
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so476651739f.2
        for <linux-nvme@lists.infradead.org>; Fri, 03 Jan 2025 17:11:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcC17X5yU1Da1jzXHHyxmLZagT7ocyktMbCnBxtWi5e9liXR1Ee79njlvxyUDMXpdyArnsM+JcuNtx@lists.infradead.org
X-Gm-Message-State: AOJu0YyV+mwL+NsRRZN8tgV1nutUukvxMmSaD+ZHRDjCQ6cZmniKKuf2
	pSW4Zf0vI+DDQSpijFokb/K7W/5ypJ2a54hfCYZQ+7KViR4cat4zfaldWakcT2Sez6+hxPe4WNI
	BnELxxPoZhBzlblkPx3CrXs9ctzg=
X-Google-Smtp-Source: AGHT+IGTA5mtmUi1e5ekRsHIG12mFpFa5wf8eXRP6b6qWFlz3OJQR4sTw+SV7jM2yAMOh4Ck6+8eVMdDAjf6weeDmGU=
X-Received: by 2002:a05:6e02:20ca:b0:3a7:86ab:bebe with SMTP id
 e9e14a558f8ab-3c2d514f966mr429152675ab.16.1735953076345; Fri, 03 Jan 2025
 17:11:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
In-Reply-To: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Jan 2025 17:11:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
X-Gm-Features: AbW1kvYvND5wrLCJdMk5CZBrLIhjlv6180Ove4rv7MC2kdmdU3zFjiIWHq56MBY
Message-ID: <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_171120_521893_E921160A 
X-CRM114-Status: GOOD (  15.75  )
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

Hi Vishnu,

On Tue, Dec 31, 2024 at 10:35=E2=80=AFPM Vishnu ks <ksvishnu56@gmail.com> w=
rote:
>
> Dear Community,
>
> I would like to propose a discussion topic regarding the enhancement
> of block layer tracepoints, which could fundamentally transform how
> backup and recovery systems operate on Linux.
>
> Current Scenario:
>
> - I'm developing a continuous data protection system using eBPF to
> monitor block request completions

This makes little sense. It is not clear how this works.

> - The system aims to achieve reliable live data replication for block dev=
ices
> Current tracepoints present challenges in capturing the complete
> lifecycle of write operations

What's the difference between this approach and existing data
replication solutions, such as md/raid?

>
> Potential Impact:
>
> - Transform Linux Backup Systems:
> - Enable true continuous data protection at block level
> - Eliminate backup windows by capturing changes in real-time
> - Reduce recovery point objectives (RPO) to near-zero
> - Allow point-in-time recovery at block granularity
>
> Current Technical Limitations:
>
> - Inconsistent visibility into write operation completion
> - Gaps between write operations and actual data flushes
> - Potential missing instrumentation points

If a tracepoint is missing or misplaced, we can fix it in a patch.

> - Challenges in ensuring data consistency across replicated volumes
>
> Proposed Improvements:
>
> - Additional tracepoints for better write operation visibility
> - Optimal placement of existing tracepoints
> - New instrumentation points for reliable block-level monitoring

Some details in these would help this topic proposal.

Thanks,
Song

