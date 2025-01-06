Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B22E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=As/URpSAXT2ejTMt8LEuxKVlrJ2og5Cxcx8BJolaDe8=; b=zrZHQVPONmxldDFFTiBjPOrIGm
	ln0rDYJs4Z693nBQQXfZ5Ox7shpZpo4hVTom+y6I8JaNav6o07FMIu0NCfoei5Xlb+8O19XtuYBGi
	VLLEZ2uSRxm7p2sI7eV7lTvW3lg3RKuGEGTRth863BLlH6dT5L82dxKjtbdeQIF7yOsb1pYJEgmoa
	ekSGDVWoKbRDsZx3CR/r4B7XfgnGAJhr16ZCgOSJhRbLwQ2mzdgp1Woabnh6oQ4TCOVejshqf2N+Q
	hJojNEP4hlDpOKj/9jGX7jE2HHuzjM1FhI8YZdE8FhNBc/2BCiP2qCCPazmO6F2xexrd51rxrI20m
	2BJusdQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrpr-00000002I49-3KvQ;
	Mon, 06 Jan 2025 18:28:19 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrpp-00000002I36-0crm
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 18:28:18 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso164002276.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Jan 2025 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736188095; x=1736792895; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=As/URpSAXT2ejTMt8LEuxKVlrJ2og5Cxcx8BJolaDe8=;
        b=cN8BcnlqIAK4nLbfV2AieLpfm3xymxRhTp4lKchZapyQ323u5ds9waQl9MTgcklLfH
         +/HvdkNg+oKjUCSyw2OzJtCLL8G5kuKq6b7yKDV9l9ZVXjiLdJ8FOkPWrdMdRTfKVWKq
         qc9ujDT9QEmqjUOgkDcW/8pqWCSkrqXo3fdyBZRL9IXtXf3epYgqWjNw8jzg7Jv2yOA2
         KJ4rw35YZfN/JQa8BGA46tbXr7OhZUn5KmSpAYXg0i7xFL/nwqc84Bh1Dd9Euw9GAfMb
         AtHXGP/155NcqQwom8AAaBL5AAt7mKSkyEvzXcy/ESPx8XU7xP44HLweZ9Ce/nE8c/9w
         /nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736188095; x=1736792895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As/URpSAXT2ejTMt8LEuxKVlrJ2og5Cxcx8BJolaDe8=;
        b=WjQbhqJLPn3WavpfqFN0pKifGfLHS7dWCAcfwgCkOY9sIGj/3L0maIfgMYK7bBieey
         w3huy9eQOv+3RYuTTV/IspGRyPhjkjZKSemkbObiOnBe+QvJx3QCNZ+yCX/qSP2lQ7OR
         96V+7OzRFUUjlQJlXX6NPqyWTYb1vuZrON7BPmxwbX1t8EJeaEShOLoFHnk8OBThX7+v
         PPUYcNZFY2taq/9ILAjxiWhllpCreGmtXdMaDi9bPqzNA4Cnjtthmu1bTtllOm8elPNn
         ExSmNaLY0xf7BthykrA80n57jCPBNolnJsEF8nMrl30Z/RyJbvJWRpxW4Mgyhw+8J0X8
         Ym7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZGMhCvlNDY9tVYz7Qi57Sbiu3rPJfKNt1Ln9vGKS+v4VUgbCiqm2oQgP3ZUDVjCJoC9FlTStST8jo@lists.infradead.org
X-Gm-Message-State: AOJu0Yy55VAQzRt1cyWuRY5IcGu9CQ2Tfv5IsTfjD7mxO9QtlaOKTjdu
	yeILmPXgy2Mijkv4r78GgpYyEWHPB7Jgk7bccRLYfCCHd0vmc8YvzzSYIOEXfF5k7u1tJZJQdge
	rm/Ar4wVz0U5MZxh/ZADr3dubAY8=
X-Gm-Gg: ASbGnct9PoajhEbYhTlzwcjoBvvbhZ3/21Ab6c0wVbXr1LYyJPjr4ED883exlE+fZum
	9P1JTae3BnvVCF0sRLf267uJUjRD1Nc0mdqor4V+m
X-Google-Smtp-Source: AGHT+IHVzTtKwzkbKFSzXa7l07tGcQew3Dxqacu5wnrYGdfYfCLuolpWPcrhn7wb5mCcrbaglujhU+O1jf5NrLHWmFw=
X-Received: by 2002:a25:aad1:0:b0:e54:ab05:4505 with SMTP id
 3f1490d57ef6-e54ab054d62mr4665827276.44.1736188095031; Mon, 06 Jan 2025
 10:28:15 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com> <ee32c284-aeda-4efa-adb1-bb4af724d097@kernel.org>
In-Reply-To: <ee32c284-aeda-4efa-adb1-bb4af724d097@kernel.org>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Mon, 6 Jan 2025 23:58:02 +0530
Message-ID: <CAJHDoJax9dw3TjG9bNifOUP29_neTaNX-NNHkbxDfbytRocBzQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Song Liu <song@kernel.org>, hch@infradead.org, yanjun.zhu@linux.dev, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_102817_202854_935A9A98 
X-CRM114-Status: GOOD (  30.67  )
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

Thank you for the detailed explanation about write cache behavior and
data persistence.
I understand now that:

1. Without explicit flush commands, there's no reliable way to know
when data is actually persisted
2. The behavior we observed (3-7 minutes delay) is due to the device's
write cache policy
3. For guaranteed persistence, we need to either:
   - Use explicit flush commands (though this impacts performance)
   - Disable write cache (with significant performance impact)
   - Rely on filesystem-level journaling

We'll explore using filesystem sync operations for critical
consistency points while maintaining the write cache for general
operations.


On Mon, 6 Jan 2025 at 07:24, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 1/5/25 2:52 AM, Vishnu ks wrote:
> > Thank you all for your valuable feedback. I'd like to provide more
> > technical context about our implementation and the specific challenges
> > we're facing.
> >
> > System Architecture:
> > We've built a block-level continuous data protection system that:
> > 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> > 2. Captures sector numbers (not data) of changed blocks in real-time
> > 3. Periodically syncs the actual data from these sectors based on
> > configurable RPO
> > 4. Layers these incremental changes on top of base snapshots
> >
> > Current Implementation:
> > - eBPF program attached to block_rq_complete tracks sector ranges from
> > bio requests
> > - Changed sector numbers are transmitted to a central dispatcher via websocket
> > - Dispatcher initiates periodic data sync (1-2 min intervals)
> > requesting data from tracked sectors
> > - Base snapshot + incremental changes provide point-in-time recovery capability
> >
> > @Christoph: Regarding stability concerns - we're not using tracepoints
> > for data integrity, but rather for change detection. The actual data
> > synchronization happens through standard block device reads.
> >
> > Technical Challenge:
> > The core issue we've identified is the gap between write completion
> > notification and data availability:
> > - block_rq_complete tracepoint triggers before data is actually
> > persisted to disk
>
> Then do a flush, or disable the write cache on the device (which can totally
> kill write performance depending on the device). Nothing new here. File systems
> have journaling for this reason (among others).
>
> > - Reading sectors immediately after block_rq_complete often returns stale data
>
> That is what POSIX mandates and also what most storage protocols specify (SCSI,
> ATA, NVMe): reading sectors that were just written give you back what you just
> wrote, regardless of the actual location of the data on the device (persisted
> to non volatile media or not).
>
> > - Observed delay between completion and actual disk persistence ranges
> > from 3-7 minutes
>
> That depends on how often/when/how the drive flushes its write cache, which you
> cannot know from the host. If you want to reduce this, explicitly flush the
> device write cache more often (execute blkdev_issue_flush() or similar).
>
> > - Data becomes immediately available only after unmount/sync/reboot
>
> ??
>
> You can read data that was written even without a sync/flush.
>
> > Proposed Enhancement:
> > We're looking for ways to:
> > 1. Detect when data is actually flushed to disk
>
> If you have the write cache enabled on the device, there is no device interface
> that notifies this. This simply does not exist. If you want to guarantee data
> persistence to non-volatile media on the device, issue a synchronize cache
> command (which blkdev_issue_flush() does), or sync your file system if you are
> using one. Or as mentioned already, disable the device write cache.
>
> > 2. Track the relationship between bio requests and cache flushes
>
> That is up to you to do that. File systems do so for sync()/fsync(). Note that
> data persistence guarantees are always for write requests that have already
> completed.
>
> > 3. Potentially add tracepoints around such operations
>
> As Christoph said, tracepoints are not a stable ABI. So relying on tracepoints
> for tracking data persistence is really not a good idea.
>
>
> --
> Damien Le Moal
> Western Digital Research

-- 
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

