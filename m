Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F7E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 11:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XBGILMKbPORy8DLEp8X2Qh3B2A7Bk9CG+PKoCeUe1Jc=; b=y0cEjLiws5geEJvmGFsJfxW/i2
	lkd7xGZU5ZCohHPHfM0XyrlYiI3CLC4qpjcr6p6yHCh45DrcHtWlSLxrSrq47maB1XcRh499SeUCy
	KyXO+WlmEFZDQJ05zZUitn2cMp2y79G4rrlFKHRHnUj8RHN04+IzkJID37fCH4FJ+wg3bBqmEcpA+
	NtBnEYFk55ac1b2u4xmpqtntd+OTM1Q2IONBvwue4eMnLh4kLTLUP194eHQEMp0Fvv5y0BYQc+hbT
	wFBxDlf71ztWe6VQlrLW1d0aUizhjf3a4AQe3gNrYzqKWJqTldH7kHdm0ZDeW6W7gD2gHk3xBdo1i
	IV7qYMJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWD2M-0000000F5CB-294U;
	Fri, 10 Jan 2025 11:18:46 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWD1Z-0000000F559-40bu
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 11:17:59 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso2595753a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736507877; x=1737112677; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBGILMKbPORy8DLEp8X2Qh3B2A7Bk9CG+PKoCeUe1Jc=;
        b=TywuRV9evqiSh5UumK8Rhs4ZNBSEUJNyJ7cCnSsNNd9QzTGN26eKyn2U0xggQ0mtgK
         hnUfkCEnpIY1x2KJxpGkQrHXi6leiTZwQjN0G8/lOlOnsDFHe6wprq+xzWj/UmpcbJF3
         V3TyuyW5KTR4R1LLaRV46u7uYNsLwGZLhGcSRCg8ymvU5Zh5ZVnMDAb54xz7O2enpAcw
         FGQdZWMkBko5L/BeXsH2y/336m+kNbuShrVzF3VzIqwTBXl2PksWenryQ/FELt5EG1Fd
         0pukdiY7KNsnAizBy2MlML8WL0Au4Ki/+lBG+zK0JjJCeT1psTuFw3gZi2YFsFfseknb
         BJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507877; x=1737112677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBGILMKbPORy8DLEp8X2Qh3B2A7Bk9CG+PKoCeUe1Jc=;
        b=a30Ysb0xO9ghDDsoSZm1rjF3vAbgA8YzMfk079yiw3VheMJ0oI6kSzjbHNlxL8spSO
         NlpfIx9XYP4w2NvOF3+/cV83FBY12CgYVJo7jRj61e2Cs5ADeGXvyUMtKcHd6UM4G8p9
         7Ww6B190lxZcQpViMvcYtBV6/+TwvWKhLyZEvTOOmguAiSeWMkGA2BQPEqA2hucReJJZ
         JISEL02tkBRwgr8ZQ4WTTa0qxKdUA7ZEhCvBcVE+8ZGQCm7P02x2ZDlwr7uA3maao4MI
         tnhpWUjAjNNcgmAJcJafo7J9dtqJocUHWanyxYoKAK+DfbS3EMmdtTksFfK22pl3JAlQ
         Iskg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Q3qncdhfGV1aM2anG65ozcpbUUti9Cd6tdVkj4N8AxWpU2LPUQZhmztBo2qRMsTKnwYLRP+HkgXn@lists.infradead.org
X-Gm-Message-State: AOJu0YwxJTSGRkeGnL8IiqJ5axoFodpTcVLmuFzreOuls2mD9JRlerbm
	06OkQ/P0ohG2K4qvwv1L91NCj/MQt464pvPl/9r/HlnWWh1RQYhCSyie7ATpPmAHJFg3vwnlZYS
	6iqp7D3bnbVZrvT/1eOaYGwLJrHc=
X-Gm-Gg: ASbGnctBsU8ni6q13OHfC0HKTh1O9JjUtlqLUkOunFKl2fQsaFEujTVUyXnjWeapDTg
	aFYkG4bNi7/KbzzvvGyaoEK2V/570fR6LGuzAYdXGxauowcBSKihChmQ+cq4YQYgm/NqB
X-Google-Smtp-Source: AGHT+IFYbBam4o4hPnqv5ECFznzUa81yzrzUmG6GTq7IvWKxjPCuMu/wl+xlLxnUadOXAssaCN8aC2NTJbFj4BQYFvU=
X-Received: by 2002:a17:90b:2b83:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2f548f103e9mr15815078a91.8.1736507875452; Fri, 10 Jan 2025
 03:17:55 -0800 (PST)
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
In-Reply-To: <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Fri, 10 Jan 2025 11:17:39 +0000
X-Gm-Features: AbW1kvakzUWN3Ty8_Iw5S5n0dcdWHYdfxgarw1RZaaaHPbcJ6gOq-a2NLJaQBdk
Message-ID: <CAOBLbT-hrN3hOHbhwkzokR_NXRLH9AgF4GNMi-=LP7Fuqwba_A@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_031758_000308_B296452F 
X-CRM114-Status: GOOD (  29.21  )
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

Hi,

(resending in text-only mode, because mailing lists don't like HMTL
emails... sorry to those getting this twice)

I can reply via email, that's not a problem.

I'll try to run some more tests when I get the chance (it's been a
very busy week, sorry).
Besides the volatile write cache test, any other test I should try?

Regarding the M.2 slots. I believe this motherboard has no chipset. So
both slots should be connected directly to the CPU (mine is Ryzen
8600G), although they might be connecting to different parts of the
CPU, right? I guess that can make a difference.

My disks are gen4 as well.

Bruno


On Thu, 9 Jan 2025 at 15:44, Stefan <linux-kernel@simg.de> wrote:
>
> Hi,
>
> due to Thorstens hints, I'm trying to reply to both, the bug tracker and
> the mailing list.
>
> > --- Comment #13 from Keith Busch (kbusch@kernel.org) ---
> > If I'm summarizing correctly, we're seeing corruption on Lexar, Kingston,
> > and now Samsung NVMe's?
>
> The Kingston read errors may be something different. They are described
> in detail in messages #108 and #113 of the Debian Bug Tracker
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1076372
>
> With the Kington, I never saw the write errors that occur with Lexar and
> Samsung on newer Kernels (and which are easy to reproduce).
>
> (ATM I cannot provide test results from the Kingston SSD because the
> Lexar is installed, the PC is installed remotely and in use. Thus I
> can't swap the SSDS that often.)
>
> > # cat /sys/block/nvme0n1/queue/fua
>
> Returns "1"
>
> > --- Comment #15 from Keith Busch (kbusch@kernel.org) --- as a test,
> > could you turn off the volatile write cache?
> >
> > # sudo nvme set-feature /dev/nvme0n1 -f 6 -v 0
> Had to modify that a little bit:
>
>    $ nvme get-feature /dev/nvme0n1 -f 6
>    get-feature:0x06 (Volatile Write Cache), Current value:0x00000001
>    $ nvme set-feature /dev/nvme0 -f 6 /dev/nvme0n1 -v 0
>    set-feature:0x06 (Volatile Write Cache), value:00000000,
> cdw12:00000000, save:0
>    $ nvme get-feature /dev/nvme0n1 -f 6
>    get-feature:0x06 (Volatile Write Cache), Current value:00000000
>
> Corruptions disappear (under 6.13.0-rc6) if volatile write cache is
> disabled (and appear again if I turn it on with "-v 1").
>
> But, lspci says I have a
>
>    Shenzhen Longsys Electronics Co., Ltd. Lexar NM790 NVME SSD
> (DRAM-less) (rev 01) (prog-if 02 [NVM Express])
>
> Note the "DRAM-less". This is confirmed by
> https://www.techpowerup.com/ssd-specs/lexar-nm790-4-tb.d1591. Instead of
> this, the SSD has a (*non-*volatile) SLC write cache and it uses 40 MB
> Host-Memory-Buffer (HMB).
>
> May there be an issue with the HMB allocation/usage ?
>
> Is the mainboard firmware involved into HMB allocation/usage ? That
> would explain, why volatile write caching via HMB works in the 2nd M.2
> socket.
>
> BTW, controller is MaxioTech MAP1602A, which is different from the
> Samsung controllers.
>
> > --- Comment #14 from Bruno Gravato (bgravato@gmail.com) --- The only
> >  difference in the specs between the two M.2 slots is that one is
> > gen5x4 (the main one, which is the one with problems) and the other
> > is gen4x4 (this works fine, no errors).
>
> AFAIK this primary M.2 socket is connected to dedicated PCIe lanes of
> the CPU. On my PC, it runs in Gen4 mode (limited by SSD).
>
> The secondary M.2 socket on the rear side is probably connected to PCIe
> lanes which are usually used by a chipset -- but that socket works.
>
> Regards Stefan

