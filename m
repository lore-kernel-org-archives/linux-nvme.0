Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE13CF64B1
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 06:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YW35sxUxIlGDrd2+h8IaRlcKG4sa3HfSuqLbLrmJaJI=; b=o9pK4UIGCzpqQAQEd8Vg+jf1dC
	fn5Z9Tk9pKIq3Z69/fdEJIWSNChwicLwFJHtTbLhnllJIOxXv7NwyYeqdoCEnoluza/PNx0ILAbUI
	+R2IGUE08osjYsZUmDQdvDPFYTG3rkyGsbLUj1DKkUecyXezfNGfhJ9zroUkemDVpIF9+LgUV2kA/
	lZNr0758OIdVP/KcJnoKYZ2js1wNyNvggo3K6THUBwQopvHcFkBH7cmhhUUMJfL/wWY5vZYpJWoXg
	OC9sVl55pPFr4OQhce23Glrh2Odo76UjPMl6arWUg/UvHlKZmDyaDY17paBkJYDtDQ0Se7ogXElrQ
	GhY5SdbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhHX-00000009JVW-2OoR;
	Sat, 22 Nov 2025 06:39:39 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMhHV-00000009JV8-1m9b
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 06:39:38 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so23140441cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 22:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793576; x=1764398376; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW35sxUxIlGDrd2+h8IaRlcKG4sa3HfSuqLbLrmJaJI=;
        b=ZEqQI4itK+3vzTQm9cB0iBbNCefp5Lr/NL45SJFVkHQMkIRuGt0VOj7qo3wXuNLH0m
         QSk3gYx2IhbH7tBli6dildrP4gdsnhwigxMA5il/HEilca/1iUqMrpJ5SMKuxTjFve3A
         XnIg9C5+AKUJwbuR7kp0BPaNjdH3L70si4ewxQrVCQ2UpV4HbX2g+ixcbTT17oQ/YUFb
         YIhnE7X2Zahx+NV1YgfZM6YOqQueta+bwvEEf0sxcoYEAEYbZ65SsMhoccK/cuYxL9NB
         tNWyGIJbVCqwIblTOI38GRH13j2bQoVs6wqr9NHpAtAGaq6OmQqem/1cAbgAhk2mWKIj
         C/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793576; x=1764398376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YW35sxUxIlGDrd2+h8IaRlcKG4sa3HfSuqLbLrmJaJI=;
        b=RA5dva8yse7lZHLxs9GHQ644fs0SrWzuhu7ZPmmoL0gYaoteRiR4sFfR4qjht4z1FG
         yo7WxVm+XPAZdclUes5tgbYpG1cY8yiD2jUqMc5AmpyClzMQDK9rx5O4H9Pxzkkrk+oX
         Fj22akPsULUUhWvidH7Y0rXhC/KpvydY6GfPvGlg9pMOyVD9TgSLR9bOBxWqJJtsm+IK
         JgkJIrJ+aLYchOxF+iJiCfoEEDX1UFSmfaHilVeU3PN1hZV0mtLyYJVgu3YlBCLF8sCI
         V6oS/ryZsNstRwu6r1LqNFTWN9tAtNkdVvwejBCQ+9pHDWzD32ZOWGiWoaFgMhbdGW6T
         IRhg==
X-Forwarded-Encrypted: i=1; AJvYcCXCQ9lBEcWwrhKYRahsxpmmM2aVGqpMrM11b+3rz31U1NKEucA71jJYd1PGaNY5JFR5sV+aVH55T5LQ@lists.infradead.org
X-Gm-Message-State: AOJu0YzD3lfmLuamjZ5a4DAQpq2yliMm0twsZ2zqOvG8yaGYoNWUbcpX
	HfdSVSYZBA+VZmM3rBdHQfwF5pGIDhvSWxPY95Y0YwNocGN1sgHfRt3e8KvCjXKDZNJf11A0yx/
	k5U34cf/ijVCS0IDTmMb8cy2RRbdeGKs=
X-Gm-Gg: ASbGncuz/yQGop88BHqIkAKKMdDmROoC3GS+K14KxMXYwnOKIfUvLJVlG1L61HZk4Di
	paIfdJ8Rer52czmOXzls881T9I7tDUZ1vmN90p6nFE78Q/q2PcX6vvFYQS4cBFo1q2yfvqjzoes
	olIFRWFoGKby3Lg9PyDfNtpxnqmMcLaJfeVlSYwly2NuoQEj+w2S30PBbDh4NDRC5kaj4O3L7ZH
	liQ+T7xHY9JnSnobikvIg5eit8P4KdLN/jv2No/hjI372xgT7mJ1YpDVPr26tMOFkzrPO4=
X-Google-Smtp-Source: AGHT+IF0DYx/ezSpM3sNXuPI7QGPPd1MKz4pLJ0a0/6OoiZEU9FOe4XHHmix0YrH/Vv9iTIapqMIoP7P9dG70k4KHUQ=
X-Received: by 2002:a05:622a:409:b0:4ee:84c:20c9 with SMTP id
 d75a77b69052e-4ee588cb648mr53122111cf.65.1763793575672; Fri, 21 Nov 2025
 22:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <aSBA4xc9WgxkVIUh@infradead.org>
In-Reply-To: <aSBA4xc9WgxkVIUh@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 14:38:59 +0800
X-Gm-Features: AWmQ_bmXTJbUJAhOvzCNFWsbGJVgzknSUgPoO-O5XzpCN3-HI1wRpjG5vYjbcM0
Message-ID: <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_223937_504087_2B61A31A 
X-CRM114-Status: GOOD (  37.74  )
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

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=BA=94 18:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > We have captured four instances of this corruption in our production
> > environment.
> > In each case, we observed a distinct pattern:
> >     The corruption starts at an offset that aligns with the beginning o=
f
> >     an XFS extent.
> >     The corruption ends at an offset that is aligned to the system's
> >     `PAGE_SIZE` (64KB in our case).
> >
> > Corruption Instances:
> > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
>
> Do you have a somwhat isolate reproducer for this?
>
=3D=3D=3D=3D=3DThe background=3D=3D=3D=3D=3D
Sorry, We do not have a consistent way to reproduce this issue, as the
data was collected from a production environment run by database
providers. However, the I/O model is straightforward:

t0:A -> B
About 100 minutes later...
t1:A -> C

A, B, and C are three separate physical machines.

A is the primary writer. It runs a MySQL instance where a single thread
appends data to a log file.
B is a reader. At time t0, this server concurrently reads the log file from
A to perform a CRC check for backup purposes. The CRC check confirms
that the data on both A and B is identical and correct.
C is another reader. At time t1 (about 100 minutes after the A -> B backup
completed), this server also reads the log file from A for a CRC check.
However, this check on C indicates that the data is corrupt.

The most unusual part is that upon investigation, the data on the primary
server A was also found to be corrupt at this later time, differing from th=
e
correct state it was in at t0.

Another factor to consider is that memory reclamation is active, as the
environment uses cgroups to restrict resources, including memory.

After inspecting the corrupted data, we believe it did not originate from
any existing file. Instead, it appears to be raw data that was on the disk
before the intended I/O write was successfully completed.

This raises the question: how could a write I/O fail to make it to the disk=
?

A hardware problem seems unlikely, as different RAID cards and disks
are in use across the systems.
Most importantly, the corruption exhibits a distinct pattern:

It starts at an offset that aligns with the beginning of an XFS extent.
It ends at an offset that aligns with the system's PAGE_SIZE.

The starting address of an extent is an internal concept within the
filesystem, transparent to both user-space applications and lower-level
kernel modules. This makes it highly suspicious that the corruption
always begins at this specific boundary. This suggests a potential bug in
the XFS logic for handling append-writes to a file.

All we can do now is to do some desperate code analysis to see if we
can catch the bug.

=3D=3D=3D=3D=3D=3Dcode analysis=3D=3D=3D=3D=3D=3D
In kernel version 4.19, XFS handles extent I/O using the ioend structure,
which appears to represent a block of I/O to a continuous disk space.
This is broken down into multiple bio structures, as a single bio cannot
handle a very large I/O range:
| page 1| page 2 | ...| page N |
|<-------------ioend-------------->|
| bio 1      |  bio 2        | bio 3  |

To manage a large write, a chain of bio structures is used:
bio 1 -> bio 2 -> bio 3
All bios in this chain share a single end_io callback, which should only
be triggered after all I/O operations in the chain have completed.

The kernel uses the bi_remaining atomic counter on the first bio in the
chain to track completion, like:
1 -> 2 -> 2
if bio 1 completes, it will become:
1 -> 1 -> 2
if bio 2 completes:
1 -> 1 -> 1
if bio 3 completes:
1 -> 1 -> 0
So it is time to trigger the end io callback since all io is done.

But how does it handle a series of out-of-order completions?
if bio 3 completes first, it will become:
1 -> 2 -> 1
if bio 2 completes, since it seems forget to CHECK IF THE
FIRST BIO REACH 0 and go to next bio directly,
---c code----
static struct bio *__bio_chain_endio(struct bio *bio)
{
        struct bio *parent =3D bio->bi_private;

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;
        bio_put(bio);
        return parent;
}

static void bio_chain_endio(struct bio *bio)
{
        bio_endio(__bio_chain_endio(bio));
}
----c code----

it will become:
1 -> 2 -> 0
So it is time to trigger the end io callback since all io is done, which is
not actually the case. but bio 1 is still in an unknown state.



> > After analysis, we believe the root cause is in the handling of chained
> > bios, specifically related to out-of-order io completion.
> >
> > Consider a bio chain where `bi_remaining` is decremented as each bio in
> > the chain completes.
> > For example,
> > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > bi_remaining count:
> > 1->2->2
> > if the bio completes in the reverse order, there will be a problem.
> > if bio 3 completes first, it will become:
> > 1->2->1
> > then bio 2 completes:
> > 1->1->0
> >
> > Because `bi_remaining` has reached zero, the final `end_io` callback
> > for the entire chain is triggered, even though not all bios in the
> > chain have actually finished processing. This premature completion can
> > lead to stale data being exposed, as seen in our case.
>
> It sounds like there is a problem because bi_remaining is only
> incremented after already submittin a bio.  Which code path do you
> see this with?  iomap doesn't chain bios, so is this the buffer cache
> or log code?  Or is there a remapping driver involved?
>

Yep. The commit below:

commit ae5535efd8c445ad6033ac0d5da0197897b148ea
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Dec 7 08:27:05 2023 +0100

    iomap: don't chain bios

changes the logic. Since there are still many code paths that use
bio_chain, I am including these cleanups with the fix. This provides a reas=
on
to CC all related communities. That way, developers who are monitoring
this can help identify similar problems if someone asks for help in the fut=
ure,
if that is the right analysis and fix.


Thanks,
Shida

