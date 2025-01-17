Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429BEC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVo7L/phiOwok7BqC1abUFsogRLeFl2Re0mMohXr1z4=; b=J1jakkDoqte5UN8l4aeRxVlT+E
	wK8ZHRiNvIfXFgWVNA7wQZ4kZUGvaIDD3XUtF40mOOZcU0L4QeDdU7zwZo6aRu284G3DlyhrQFWoq
	3cVp7kTtu6+LA1gJ2J5F+Kz2qDGaGLM/BcDkzgS7udUxMmoDjTUX7m1Rk3zG+sn2GnhOqgorl1N4p
	dM9ALm9uzlUnkYFbbfchPaNAScYEpK+LMgdkXRV+CKpsJudi4sMAwRQyUBgZTVSLv42+kALVopHO8
	c9k9C7BzFsZnFqo9gV5cK0b38zaYo2OoDgGRAMpIEdQg4jOJgpuD+zNWy7JhVwHoLs1w20LixJfqH
	UCvm/dIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYmWj-00000000Mpz-2E2G;
	Fri, 17 Jan 2025 13:36:45 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYmWg-00000000MpI-2k2w
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 13:36:43 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2f441791e40so2950863a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737121001; x=1737725801; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVo7L/phiOwok7BqC1abUFsogRLeFl2Re0mMohXr1z4=;
        b=EAM8dIW3XjF8tKrpNVlHCsaz7d5MAM4BRbRqqlzFG8LiG1EJawTVAW1H0w8FevJnKw
         3WjKIH0nzz2dXnhDPBC+e8DyrbPjTyItq8yjizpCGT0mnrPHyNGPraLe0nAizc/pXVAp
         1PiVU2xj89f9eHo6QTkjwBylwsP0Z2ETBhuyqMBYdj0URFUGx4hPS2+fosDJA3X+Bl/Y
         3tsHLjaN0E9WbBFIOtr8e5kGL8cxlWihb5UyUgBAcWkF5vWJB7P0w1GiRnvLTrfE5Akd
         /QRlkHus6FsgV+mwX+5xHn9Ucx+3APWBo6c+d9ZTUwof7qdeSmNHmOboZ4HGCcCGrEDK
         xglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121001; x=1737725801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVo7L/phiOwok7BqC1abUFsogRLeFl2Re0mMohXr1z4=;
        b=XP6KYoz96fhhX+YI/50GFevgh134UzdsCd3hR8Yemb8jjsbFnNAdZBvAUDpjK4GgAX
         KT/IsjysoXbMa2VpbVCK5EZMaVzsAzLcpXWcW8/9nt3GRx3zb1u7XN4/hvZyOCovU4YD
         FfTj01AgJOWhEnHbu/c8ddNKN0ksDCnjUy6BYHweOS8U7NCXyYJ6DJfuRdC8TggPyN5d
         TRU7maOa0x+tR5rW/+Ief6qI1D9b4ufCKqspKk8mDqF7sdfDT/ljfR1TQ0ocDzMARH+R
         FCoTuWj+ut1olWYMlJhbW7T6G/tM+yERCxf2gkej3DLzoZS/oR+NPSVRDeYg2vsDyUea
         OhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS+FR4Re6a2rIo5fCbN/nBSgIJygd0jjzWuNWXnHbVg0MHoh75MWmqGR3c87wUJ7t+Fi42PvfBD5Rc@lists.infradead.org
X-Gm-Message-State: AOJu0YymRbkHeVkm4oSxPIyPMtCTsXcIQc+AcQ/nf97JWtHv1KQrqdBk
	kwsDvpj+90hLDk6i3oMCLUcDbS3jHKlqK1KB+9pIweoNy4E8tK8jCAOqFKqHHiet7P2ATdGQDUN
	AungH4LCemwk61jIaJ02jL0EledY=
X-Gm-Gg: ASbGnct1PiZ0K9FoaU17UwX1plY72oQnfTrLnQslaJm3myfayPI+M53p2RNDn1/E5xI
	JKq5m9fRcMqKmryFtkwZBQ6pZsa7hePvogcG2XmfF1mX0AfPNXskMni33LGqbYIyJaQFT
X-Google-Smtp-Source: AGHT+IEHTPv5hTMRK4zXvRVqJQFfmEi87cZRYjPzN5FnPgoIlZsbqiWaV272Z4i2e3oeYxmEo6z79pG4EFV4U7uQ5JI=
X-Received: by 2002:a17:90a:d44c:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2f782d98026mr3192289a91.32.1737121000939; Fri, 17 Jan 2025
 05:36:40 -0800 (PST)
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
In-Reply-To: <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
From: Bruno Gravato <bgravato@gmail.com>
Date: Fri, 17 Jan 2025 13:36:24 +0000
X-Gm-Features: AbW1kvbkbBkK34A4Ax02ZPC_Ze-dz19Wri7acxvdXEP8qeEWMyEJBFXk8nhdLsQ
Message-ID: <CAOBLbT-MFfEw_JYdGOJYxN7S_gjPmG27fMotCwZ==s0i4pdRYw@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christoph Hellwig <hch@lst.de>, Stefan <linux-kernel@simg.de>, Keith Busch <kbusch@kernel.org>, 
	bugzilla-daemon@kernel.org, Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_053642_711853_A6161A87 
X-CRM114-Status: GOOD (  14.49  )
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

On Fri, 17 Jan 2025 at 09:51, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> * Not totally sure, but it seems most or everyone affected is using a
> Ryzen 8000 CPU -- and now one user showed up that mentioned a DeskMini
> x600 with a Ryzen 7000 CPU is not affected (see ticket for details). But
> that might be due to other aspects. A former colleague of mine who can
> reproduce the problem will later test if a different CPU line really is
> making a difference.

One other different aspect for that user besides the 7000 series CPU
is that he's using a wifi card as well (that sits in a M.2 wifi slot
just below the main M.2 disk slot), so I wonder if that may play a
role? I think most of us have no wifi card installed. I think I have a
M.2 wifi card on my former NUC, I'll see if it's compatible with the
deskmini and try it out.

The other reason could be some disk models aren't affected... I think
Stefan reported no issues on a Firecuda 520.

I ordered a Crucial T500 1TB yesterday. It's for another machine, but
I will try it on the deskmini x600 before deploying on the other
machine. I should receive it in a week or so.

Bruno

