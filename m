Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1DBC02196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lELPM0gFKqIpB6TQGOsF4JiNvRvpg+B2tbFqtHlFImM=; b=NasRp4qldcwVmnLzmS/FIoN8dL
	2muEOAZZOkRSjbwRn/eNhKetM0GPnQneZon1Z+XISMUDWBWi8twUcrpqEaiFkEZ9mmKXGfVueTa0w
	zJyormd53eVQFYT0xec2to70lEAxPlhFHjEaxN12Qqe1OOjuTtqGSKKeLIxsISzEGmWqfUgAQRJ/Z
	lfaZu6mUC8ksC7Jtas9vVaKmu/KAcvL99mu2rmOPB1jYeqAjAldMLtMBDdmd2DK6ZGtDtfiPuS96o
	0DJm4uLEnMDIqdaotYIXUQTrznNwNxVhxjNHhuhsXjmt2Il+QkrCyoQX8sL3dR9cJs2zqWVT4xug7
	6TDiNILA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgMLG-00000009Ju7-48Q5;
	Fri, 07 Feb 2025 11:16:14 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgMLE-00000009Jt0-2CTB
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 11:16:13 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-6f9c2d2dbc2so888327b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 07 Feb 2025 03:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738926971; x=1739531771; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lELPM0gFKqIpB6TQGOsF4JiNvRvpg+B2tbFqtHlFImM=;
        b=WnhaR/wJpG00styAmYuI74kbzW3XctSRceqGqlpuy20cJiwYWUD3+vYXOU6/JbeDFS
         kgCGTrDxjsXVpHfHnPPxD5o4quPbzp93/NH7iuy0en6Kyb3Wg6ZRnW0hn3gfleczn2Da
         kwB5XL5wj1mfuCU6bBdchq5ymNF1aIHlINU667SmQneSmCbolAUPJGMld5ZQ6IgJD+W/
         Oiuuky8l59yHI8KV0PSg7xRTN8Gh2ohpSwv+YHpoNbzAfpRzXqQxzTsv7mABrGHIQw07
         VfyTGnStCMZOIv0VTDEniWXg0mXWk60ZTIpkIpJkExhXSWxEJ80efQzSnr0HkSmp14XH
         srSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926971; x=1739531771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lELPM0gFKqIpB6TQGOsF4JiNvRvpg+B2tbFqtHlFImM=;
        b=LW3PJ8ODz5mUu8ioT7b63Ak1wuHzMLtWA+vgHOjJXjtJO6Zjdt2NN9sK8MBDAJsfXW
         pwtpmH44MB1dA1gG19l3T6jNbhfVgzqseB8vh7XLXu30/ymplochK+2Wllwxgf3UsIW1
         CAkzn1BcYt4m9hhf8kWqlUmw6NVFCxwTgMvhn640nRk3lsZwiHux7EfrEXKAcjQ9dwmY
         lm1Z1ysimED975A5B0gycNDsdYP6J+EVm5tNWuU3WL2frfRRzCXp7cPymOoq0jEC3rYV
         xPLYLwetiw1gwUSrVN8FE9RDnJcmWvY9q3HM5tDzYwP1n5oVLdI6K9ickVn812svFdJx
         5QuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuQnvYrfLyFbXZ3QD5k/ERb7/XUN0+9GtmPP2Ofp1oqxyNtouMznvHM/PDcLL1NPW87Mih7yxOmQwK@lists.infradead.org
X-Gm-Message-State: AOJu0YxUrsWgL5or792ZxRfMC4Owo/kTUCCNc+XcsRm2fswBnUIZcAp0
	WyjtIOevNeneWxpecJKfqzmbYloLaasvvjPv7S5vfBw2cwOOV7wqsjJfXPXz3g+mAiP9cnugjtt
	u/yk4g3Yv+ivtAtLquSCh1rSzRQhESIphKF9wuA==
X-Gm-Gg: ASbGncs56KAQDgFRVYYPaZYAmcC4V8wMlI0GfKZE2w4mU+XIOithDpidg3DrquR9kmj
	KuwHmBgXAeBLyBwKiY9rD1zeEZ2WOe/Q+T5A8UQYW008RZ3bZ8qYuSqPRip0xWui3CwLNlCNb0k
	A=
X-Google-Smtp-Source: AGHT+IFFVSHnPt+eL5wAiG6E+J60NEM+2l3Y5dSqvOtEam+TtljaI/VuuJrH8GhWVebw58UUdhZPJ1qQFPNm2Mx4w64=
X-Received: by 2002:a05:690c:6890:b0:6f0:23da:49a3 with SMTP id
 00721157ae682-6f9b2802330mr22270597b3.8.1738926970909; Fri, 07 Feb 2025
 03:16:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
 <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com> <Z6Vqlo3s3sK6d0ng@fedora>
In-Reply-To: <Z6Vqlo3s3sK6d0ng@fedora>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Fri, 7 Feb 2025 16:45:59 +0530
X-Gm-Features: AWEUYZkRQC9nK96x4IHETx4pwTTJEBBjwQxJocZ-yPlBoO60Z-qgsBSnuBIAuvQ
Message-ID: <CAJHDoJaaO8eG5pJLLZkL2iEywVkccUdgN1eRatuvJw6JHCqLug@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Ming Lei <ming.lei@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>, hch@infradead.org, yanjun.zhu@linux.dev, 
	linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_031612_567257_A21E5A49 
X-CRM114-Status: GOOD (  27.93  )
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

Thanks Ming for the insightful suggestion about struct_ops pairs for
bio handling. Moving these operations to eBPF aligns perfectly with
the goal of keeping non-essential business logic outside the kernel.

As mentioned previously, I've open-sourced our implementation (blxrep)
which demonstrates this approach. While simple in implementation, it's
proven effective for capturing incremental changes on data disks with
sync frequencies above 3 minutes:

BPF implementation:
https://github.com/xmigrate/blxrep/blob/main/bpf/trace-blocks.c
Documentation: https://blxrep.xmigrate.cloud/

Your suggestion about generic bio/bvec kfuncs is particularly
interesting. Would you be open to providing feedback on our current
BPF program structure, particularly regarding how we could better
leverage these proposed bio handling capabilities? I would also like
to hear what others think about this approach.

Thanks,
Vishnu KS

On Fri, 7 Feb 2025 at 07:36, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jan 13, 2025 at 11:01:30PM +0530, Vishnu ks wrote:
> > Thanks everyone for the detailed technical feedback and clarifications
> > - they've been extremely valuable in understanding the fundamental
> > challenges and existing solutions.
> >
> > I appreciate the points about md-cluster and DRBD's network RAID
> > capabilities. While these are robust solutions for network-based
> > replication, I'm particularly interested in the point-in-time recovery
> > capability for scenarios like ransomware recovery, where being able to
> > roll back to a specific point before encryption occurred would be
> > valuable.
> >
> > Regarding blk_filter - I've been exploring it since it was mentioned,
> > and it indeed seems to be the right approach for what we're trying to
> > achieve. However, I've found that many of our current requirements can
> > actually be implemented using eBPF without additional kernel modules.
> > I plan to create a detailed demonstration video to share my findings
> > with this thread. Additionally, I'll be cleaning up and open-sourcing
> > our replicator utility implementation for community feedback.
> >
> > I would very much like to attend the LSF/MM/BPF summit to discuss
> > these ideas in person and learn more about blk_filter and proper block
> > layer fundamentals. Would it be possible for someone to help me with
> > an invitation?
>
> If one pair of bpf struct_ops are added for attaching to submit_bio()
> and ->bi_end_io() in bio_endio(), lots of cases can be covered:
>
> - blk filter
>
> - bio interposer
>
> - blk-snap
>
> - easier IO trace
>
> ...
>
> Then both bio and request based devices can be covered.
>
> It shouldn't be hard to figure out generic bio/bvec kfuncs for helping block IO
> bpf prog to do more valuable things & fun.
>
> Thanks,
> Ming
>


--
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

