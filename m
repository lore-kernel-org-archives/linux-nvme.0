Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D929C0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+AHMI1n0um1Uc2f0ky1zL1PO/sMw1al2b0gfWEzKF20=; b=yS9/5+K/Y9Uw6QnW6Ipt+uHvBI
	8LFbkplBfOZ6NRDhaUcVkArsSvlpPXUfU7GNiLJfVkgLzAnigeD9SOBf3+Ekiin0cbq1cFJfT0+i4
	Q8/HpPicv5lkzdFPOkwJYlnqukrs5tr67WzDAl3Btdw0GmFCOOk8xtba9VdExjLQBTdDjO/sKWEIm
	n9Fto1OLa2ouGInLqFRtmNciNX/KiVBlfEfVa3VrRQmnk0CeW43yDdiDd2ZirsWzQuN2kaYsu5iul
	28AHrVIYJzHXDYoSIuyFa9tAEy3wvJBctdukUMmDQ4LkOiXxvRFxd5xhBRnZA+L01X4qTx1MkZMGG
	3RHYLGHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfEze-000000000TD-2ZYD;
	Tue, 04 Feb 2025 09:13:18 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfEzY-000000000Sr-1rgg
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 09:13:14 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so8910172a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 01:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738660391; x=1739265191; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+AHMI1n0um1Uc2f0ky1zL1PO/sMw1al2b0gfWEzKF20=;
        b=SSgWXm4zFeNCc/EIK4yYkxa5nY4y94Ppc3obqYzDyrV8xltPt4lL4Mu1s50c5zkXSy
         nTEfMib/6ycmd7Qwy+VVXzzRcFaf8PVAtvRKkeiubhN1VabQWyVdKrBUbxfvp1eAz/ay
         fDk7ssp1f8YBZT5AuCjQeV7RYNqT/8gvA4uZafptrUFqkvkOoH+Vx8MU3EtWRvotrfnZ
         vE3PKKBOWHEVgKyCi7Mib7OF4N6WxdjpS8dmnwdFsggCLL5TMGf0eNrbByoVQLBfT/BN
         TSRG+SlRRE2SuBWjxu7lROHQ1DXj+cI5rQqysuGqPAVnl+ypnhGhnGGUfeZdratDtlBr
         joaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738660391; x=1739265191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AHMI1n0um1Uc2f0ky1zL1PO/sMw1al2b0gfWEzKF20=;
        b=GdQmBU2UK3GLJ4pE5OFxaNsNGZUs2Ir+cU3wTcfGAXo3VEEbf/WHWF7DwPyBrM9z1t
         cSLU3gfL56QnNmoN2WGwZum4X10CBD0sE8LEawSgM+3C47suhiKGsatfh7BxGepfNpZV
         +RBAYEb9Xa0ci3uCXw8n7Ma8/A8febXe6l1xlsAPQa1hwE32dcm06jLhHliio8LGGL/m
         QbtlLKMIOiWStPtHu5cZMjyrQk2IoJyD2m2avSwcpZCw/t/K0WJhetvyQFzqNg9mtnli
         Qw6OYAYf5ItRjYWrDaybrzmJUmAl2OFvjU2rFL+2WIJRgYm9Hp02XUnL7Pdfv9Y5nCWK
         f8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4K6lV1n7sXJMsWvTLFgRbME8q4ajddMUFCOVTdqNZV0G6B6ZWSAJTM1Y5TzEOS/PPCztUs5EVNT+z@lists.infradead.org
X-Gm-Message-State: AOJu0Yxbudp8q4yTw3wJSaaeC1i4ziwQQ1Aot8t4XQOnPnB8ezIV5XsX
	Jz5nKipFhFZ/Xvv15LNv7kNzYaQ9SJDDHO2umKs/P9qz1Bhw5OESsGaaF1y3a8x2raA5m7Dw72z
	JXd5APQuO3y0zFSymBTHiFBE3Uok=
X-Gm-Gg: ASbGnctKqL3lchV56+ilV1NYNTpzN0EodsW6Fwprlc2kmY/Rrn2gf+E90JMlJ6KrhRC
	42cQwWUlqKrAt1fxdwMC0zdEnM3n3Gsmt9j1AuhRrG5Kg+Qt3TXG5RCtpRTUTHhUEIn6/32K6R9
	47QaGuFngKktIQ2bm9+NJy9g6mcSQ=
X-Google-Smtp-Source: AGHT+IEjr+5p9ULMzoc/xpn7zcsHmFh9pQft0Sd8GQkkXIpsHHX4xJoLdzK+6o4pH/qlQ/u3VVH/AFYlbacH5FUEJZE=
X-Received: by 2002:a17:90b:51cc:b0:2ea:498d:809f with SMTP id
 98e67ed59e1d1-2f83ac5e467mr32092446a91.26.1738660391086; Tue, 04 Feb 2025
 01:13:11 -0800 (PST)
MIME-Version: 1.0
References: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de> <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
 <Z5jTKTfKUeLm4uJT@gallifrey> <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
 <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com> <20250204061208.GA29300@lst.de>
In-Reply-To: <20250204061208.GA29300@lst.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Tue, 4 Feb 2025 09:12:54 +0000
X-Gm-Features: AWEUYZklsTO1DdX17XI0s3UrJDzPBR2NguTIOGWaQniEHqaiG2AWZWpwapwJWK0
Message-ID: <CAOBLbT_kn+5H-+RYM1UOAkxhfJnpqKMNv9_d_Ys9CgY_=TcdsA@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan <linux-kernel@simg.de>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Mario Limonciello <mario.limonciello@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_011312_491358_04F7C77A 
X-CRM114-Status: GOOD (  33.09  )
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

On Tue, 4 Feb 2025 at 06:12, Christoph Hellwig wrote:
>
> On Sun, Feb 02, 2025 at 08:32:31AM +0000, Bruno Gravato wrote:
> > In my tests I was using real data: a backup of my files.
> >
> > On one such test I copied over 300K files, variables sizes and types
> > totalling about 60GB. A bit over 20 files got corrupted.
> > I tried copying the files over the network (ethernet) using rsync/ssh.
> > I also tried restoring the files using restic (over ssh as well). And
> > I also tried copying the files locally from a SATA disk. In all cases
> > I got similar results with some files being corrupted.
> > The destination nvme disk was using btrfs and running btrfs scrub
> > after the copy detects quite a few checksum errors.
>
> So you used various different data sources, and the desintation was
> always the nvme device in the suspect slot.
>

Yes, regardless of the data source, the destination was always a
single nvme disk on the main M.2 nvme slot, with the secondary M.2
nvme slot empty.
I tried 3 different disks (WD, Crucial and Solidigm) with similar results.
If I put any of those disks on the secondary M.2 slot (with the main
slot empty) the problem doesn't occur.
The one that intrigues me most is if I put 2 nvme disks in, occupying
both M.2 slots, the problem doesn't occur either.
The secondary slot must be empty for the issue to happen.

I didn't try using the main M.2 slot as source instead of target, to
see if the problem also occurs on reading as well.
I could try that if you think it's worth testing.


> > I analyzed some of those corrupted files and one of them happened to
> > be a text file (linux kernel source code).
> > A big portion of the text was replaced with text from another file in
> > the same directory (being text made it easy to find where it came
> > from).
> > So this was a contiguous block of text that was overwritten with a
> > contiguous block of text from another file.
> > If I remember correctly the other file was not corrupted (so the
> > blocks weren't swapped). It looked like a certain block of text was
> > written twice: on the correct file and on another file in the same
> > directory.
>
> That's a very interesting pattern.
>
> > I also got some jpeg images corrupted. I was able to open and view
> > (partially) those images and it looked like a portion of the image was
> > repeated in a different part of it), so blocks of the same file were
> > probably duplicated and overwritten within itself.
> >
> > The blocks being overwritten seemed to be different sizes on different files.
>
> This does sound like a fairly common pattern due to SSD FTL issues,
> but I still don't want to rule out swiotlb, which due to the bucketing
> could maybe also lead to these, but I can't really see how.  But the
> fact that the affected systems seem to be using swiotlb despite no
> good reason for them to do so still leaves me puzzled.
>

