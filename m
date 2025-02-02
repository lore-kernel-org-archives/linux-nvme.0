Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9283BC0218F
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Feb 2025 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h5gZJXr1gG8fo7EF0ILDnAS2K7ODCxc8o+NZCCDv9tQ=; b=ZwX1aXx0Qkt/ZNSpSO8wnHHb8F
	aDAJHX/+slzPuc2HdOfy7wbtbTKeyWxewznJH8yZAnxsWvGDpnXEQE7Hyrn9Q3fIrnGu55QqOVx/k
	/srXOEOcVr3ZgjAv5JQJkVhN2/58mlhQJamY+1LNpazrbF8U6oKKBr1H8t73gmMFWhKJWxmPYnsAY
	77XeDe/liw7UrKcGGsr6r3lpTBmUVYcXlgoHfSazShDEGVM8Ek6KMZK4Yg7VIva5soupqRM1SMk7B
	D7xtTmL2uRMv88RzA8Kb9Xqmxv/x1MibyIg2Xb4+17pNW856B0Hlflok0D2DEdj2248QFHq1UprF0
	95Qz/skw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teVPS-0000000DWs8-2bzB;
	Sun, 02 Feb 2025 08:32:54 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teVPN-0000000DWrj-0Wa5
	for linux-nvme@lists.infradead.org;
	Sun, 02 Feb 2025 08:32:50 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2f441791e40so4397281a91.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Feb 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738485168; x=1739089968; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h5gZJXr1gG8fo7EF0ILDnAS2K7ODCxc8o+NZCCDv9tQ=;
        b=O1+ohnhv0o7o8fVwIfw0PnkJIM28qgvJliAtZjoQlEBw8WkEIRywNxqzdVmZA55bbQ
         ax42tjWmPW1oxtDmy71SwGbxI4zWQjLOCufXxU01+oerMu96IrYZTGzzF5rGHD+HdPo2
         3vSvcSIeF99oItC5lD6Hy5VQ/QK0GQKb3eADwTYP6V2Qa5TXAzh+thrCpF6fnPQyCJj2
         stRMAvf/LwWshmschUS8unk7ad38exFqCe0zIuZ/FLLl1LNrxRwFSQoYC2iBaWDF0+PM
         ec07Cn5U6g1FmdAoVSgB4RvawGuWleUB2Fu5+pKDBYfXIFlRm3rqMJZiw6Fr+18zFPi2
         /+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738485168; x=1739089968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5gZJXr1gG8fo7EF0ILDnAS2K7ODCxc8o+NZCCDv9tQ=;
        b=OWtFW5iy6/2Jj8zK+MZO8dG/chryQLMebcLFHiG61rXwhNlUXSqqv0t/4Lx4Qo5smP
         tHRdgKNk2SVLEJdnzqEVmQR1755mXJyMP7UIbJEdtcdySkxtRyw4YpDqhn0wKKV1D4KP
         Mu7+UY6ejEzYcvOAiuUklPqC+/LQwhADH9fGoew7QhKhn3JQjf+nlKbUsqNNf3bYULSa
         WHEh0LAgQI5e3RDoIiu04hUvjEWo4SJFC4FEN/NLS2Bd5I+SnP6bE16zGuY4nmRkk/NM
         O0qvOTAt0Kpwwb5PxxWYCglkRmFOiRp+Z1GWSVGtOzKheDFHRKMC38MR93KI1kqYxjbz
         yeZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIXUU+lo27LJ/cEXgRaTPxciju+UFMsxdInScw8QvhNWV3dnS/Z+YeXDnhrYiIKvmPd6Jq6by4l/lv@lists.infradead.org
X-Gm-Message-State: AOJu0YwwoUZr9s6HpAFYK6+sixoEkUuUJ8Hy3VofEQif6ZTDil3nvBjO
	Rp9uj+6C9xXbwX3nBkRskY5nRf+dxsB+3PvhynPnt4LwrTNPu8ugWOLsstd96Pyyi9mqh3upJTf
	i8Vq0bvCYrh15fTOYZuYn56hUknyDVKxG
X-Gm-Gg: ASbGncsm6wp93NMzYKeevHHTLMBgUdowRsT4RIQb5dvOQoRai1y7lnmXNVkMDasCBcC
	ns9V6mHAxTSUhTNceagIEfH7ezi/x1qyOtFxF/eJf0mkfbC9h5UFANMc0Ft/u5o7i6oH9JLgvh9
	aTenWJpdo7zFJVZgA8Z6hHRcq8fr8=
X-Google-Smtp-Source: AGHT+IF4Xed2UK/m1b70t2nhQ8MCa/ZGxcKczWbWLCesTg1dtRBkKclSXAXCoFAdI2mFiGLkTfshl1Z+s2zbAA4wYng=
X-Received: by 2002:a17:90b:2742:b0:2f2:a796:26b with SMTP id
 98e67ed59e1d1-2f83abb3480mr24835867a91.1.1738485167545; Sun, 02 Feb 2025
 00:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de> <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
 <Z5jTKTfKUeLm4uJT@gallifrey> <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
In-Reply-To: <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Sun, 2 Feb 2025 08:32:31 +0000
X-Gm-Features: AWEUYZkyNSsitq97aeori6flZ7edGQ2TehN5fCXAeaoGoRvqgLYMRyksBa46SfI
Message-ID: <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Christoph Hellwig <hch@lst.de>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Mario Limonciello <mario.limonciello@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_003249_174786_6E02C654 
X-CRM114-Status: GOOD (  20.54  )
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

I just realized I replied only to the bugzilla list. Sorry about that.

So I'm forwarding my reply to everyone else who was in CC and may not
be getting the bugzilla emails.

> > Is there any characterisation of the corrupted data; last time I
> > looked at the bz there wasn't.
>
> Yes, there is. (And I already reported it at least on the Debian bug
> tracker, see links in the initial message.)
>
> f3 reports overwritten sectors, i.e. it looks like the pseudo-random
> test pattern is written to wrong position. These corruptions occur in
> clusters whose size is an integer multiple of 2^17 bytes in most cases
> (about 80%) and 2^15 in all cases.
>
> The frequency of these corruptions is roughly 1 cluster per 50 GB written.
>
> Can others confirm this or do they observe a different characteristic?

In my tests I was using real data: a backup of my files.

On one such test I copied over 300K files, variables sizes and types
totalling about 60GB. A bit over 20 files got corrupted.
I tried copying the files over the network (ethernet) using rsync/ssh.
I also tried restoring the files using restic (over ssh as well). And
I also tried copying the files locally from a SATA disk. In all cases
I got similar results with some files being corrupted.
The destination nvme disk was using btrfs and running btrfs scrub
after the copy detects quite a few checksum errors.

I analyzed some of those corrupted files and one of them happened to
be a text file (linux kernel source code).
A big portion of the text was replaced with text from another file in
the same directory (being text made it easy to find where it came
from).
So this was a contiguous block of text that was overwritten with a
contiguous block of text from another file.
If I remember correctly the other file was not corrupted (so the
blocks weren't swapped). It looked like a certain block of text was
written twice: on the correct file and on another file in the same
directory.

I also got some jpeg images corrupted. I was able to open and view
(partially) those images and it looked like a portion of the image was
repeated in a different part of it), so blocks of the same file were
probably duplicated and overwritten within itself.

The blocks being overwritten seemed to be different sizes on different files.

Bruno

