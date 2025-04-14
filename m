Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ADFC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sgEXNk9K6SL06MbMFIJoNsxVAl12hJwAoXO/oKV5RdI=; b=qPy7Q6HFZGo512hnwtJRfSHRZ7
	4l8Atrct/c/U8pondqhMFWgB1u99i0NPMM8ongwl173aioF1OK9Ds4Zxuhq6dXbVqPeTb3dM0gotX
	h0JCsV1zMM5AM02fKzdSQwHEfP/2rVDu92z24YHLRNCKvYeT4DwAe0fUnLWek4pEn/5fbztns/AWF
	41ouSs009zj0o2CNsWIFUvsjopwj3Mzxvs8OSFhMWo0iGUWjW/nJbHqPcJWcIvt3dp4MNdeZNKHaP
	LANnqb6VAwrco+RPsoNkN4JQgKkMeybWXkuJVcMR6nprfkWlL0QaL5HOrQHavPR8kRiJCftEUqI2o
	miMpUUzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4KtO-00000002PB6-01jn;
	Mon, 14 Apr 2025 14:34:34 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Kj9-00000002MTF-3RZt
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 14:24:01 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso2959702a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640638; x=1745245438; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgEXNk9K6SL06MbMFIJoNsxVAl12hJwAoXO/oKV5RdI=;
        b=Lb+A5uL5yP5UMcZQvyfV+eAg4oD1PUY1aH2YkFUuxln1FHwL3cfO+cDXZvSIh5AUHl
         akSLddZLIQI02glMGhiHCBHZwaoSayg02Z3CwjLY3lo0miMTpuyVBQpVihRg7TA0yG6F
         pJFuESfCnLdny3ZV2dutwTjG5oqdBvg6QoVqtYgUud9famsEFwGVuyCITb3i4o0umurZ
         gW7lnigKSJdIH8bhAUCPFEEP8kB01NEZ4+DMB3bP/5HPz+gWI9h7jCNVKJQ0nv7scf2z
         FQiFWQlWSP3USVZduOUtTGFNgJtIHncB2JgJNAKR2XrV7Dq5cDGyA3/MB2aUR2hlIT4s
         7TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640638; x=1745245438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgEXNk9K6SL06MbMFIJoNsxVAl12hJwAoXO/oKV5RdI=;
        b=OYDqDm0TVLwIfcTRKoAL/w1jG02ZFIhRYpHKn0ChA/ehKoAHcJd6hhu39yrNAXGe6H
         vdg//z9W/Al3b2uZSKETrzIPmwXBsfUx3qKWMAUPnENqDR+yPuGT6NEhomotYAVO6snq
         wftb/2R/d4OkjOS7tQt2b7PQJXzTRNOoqSJz8g/u43s1qgKftZTnAuDRfm1BDXjGgLZU
         32rEd/voAAMPoDaGq2bhHtolxFE7IYGuGIPX56fg+tE3q7+3eAhElXbhZ7JVzz1Mf4ES
         UbH9eOquKJwNfVtRp1nEnJalL/vp/VjwYSU3OH9+2E20QS2w1TtX+ktKOaAR9BU90M1c
         r5jg==
X-Forwarded-Encrypted: i=1; AJvYcCUQzYTP6DtaiPW0uKYf6iGgd09TsEBHyO/49JVpT3hoQECi7bvqn8GYp2RlDaGpjrueASvuRrratbiW@lists.infradead.org
X-Gm-Message-State: AOJu0YznxmcL+HXfnnWlPZuIwV1PeBXJxxyve2/TIrFlDdhsx/8ou1Pd
	3awgkffc4PE6Vua3kYZAHm6Vu5PONY76Y+SnUkarFUNb1gnvOH/4
X-Gm-Gg: ASbGnctgOeVsrORAslal1DQK6pSwh6zmu9EIFud0Dn9q0Lke2W49RzMGghT4duO0tIU
	aCLoosHil8A0+5gZxyELwJqDKzhB0yxdUSWn47TfvamO1K+P9L3fUPUUNLqv0g2TzRAv5zyCE/f
	yQCl47P+5/FOGBcaK5cADVGc72fWb6LZbVFUWn3Pe9KLiqln7z4ObDT3lCGIumaxy4LCS/E+hXY
	81I7e+mqrqPpSYvhkIzif7Hhn1fqpXY+Sj8nZiks+Y3BeCM2CDbe2FKLQ7KlFx5a5EkHvhYnLgk
	3Z4kyAgbt0qWb07W4eap7MvI7Ek4aFAxN7GQqVj6
X-Google-Smtp-Source: AGHT+IHSZ5n5rQRQc/3WrM7mhjkhYw594WAjHLJNZX13PRmG+um1mNImtTwHqEmx6IgKxsy9Tw0IYw==
X-Received: by 2002:a17:907:7f8b:b0:aca:c441:e861 with SMTP id a640c23a62f3a-acad3446956mr959730866b.7.1744640637384;
        Mon, 14 Apr 2025 07:23:57 -0700 (PDT)
Received: from m4.lan (tor-exit-15.zbau.f3netze.de. [2a0b:f4c0:16c:15::1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce70d9sm901269166b.163.2025.04.14.07.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:23:56 -0700 (PDT)
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1u4Kj4-0001j4-2T;
	Mon, 14 Apr 2025 16:23:54 +0200
Date: Mon, 14 Apr 2025 16:23:54 +0200
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Christoph Hellwig <hch@lst.de>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Srikanth Aithal <sraithal@amd.com>
Subject: Re: [PATCH] nvme: fixup boot failure on nvme-pci
Message-ID: <Z_0aen-vPXRLNA5z@localhost>
References: <20250414120509.49638-1-hare@kernel.org>
 <20250414122616.GA14884@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414122616.GA14884@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_072359_861392_59FD38AA 
X-CRM114-Status: GOOD (  18.52  )
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

On Mon, Apr 14, 2025 at 02:26:16PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 02:05:09PM +0200, hare@kernel.org wrote:
> > From: Hannes Reinecke <hare@kernel.org>
> > 
> > Commit 62baf70c3274 caused the ANA log page to be re-read, even on systems
> > where the ANA is not supported.
> 
> And unsupported log page should normally not cause a boot failure, but
> it seems the controller in question does not handle it well.  I've
> applied the patch with a better subjet and commit message explaining this.

These are the messages that hang my FriendlyELEC NanoPI M4 SBC at boot:

[    4.342362] nvme nvme0: 6/0/0 default/read/poll queues
[    4.359986]  nvme0n1: p2 p3 p8 p9
[   35.830402] nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x1010
[   35.879571] nvme0n1: I/O Cmd(0x2) @ LBA 1000215040, 8 blocks, I/O Error (sct 0x3 / sc 0x71)
[   35.880346] I/O error, dev nvme0n1, sector 1000215040 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[   35.881320] nvme nvme0: Failed to get ANA log: -4
[   35.926157] nvme nvme0: D3 entry latency set to 8 seconds
[   35.939041] nvme nvme0: 6/0/0 default/read/poll queues
[   66.550428] nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x1010
[   66.600020] nvme0n1: I/O Cmd(0x2) @ LBA 1000215152, 8 blocks, I/O Error (sct 0x3 / sc 0x71)
[   66.600806] I/O error, dev nvme0n1, sector 1000215152 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[   66.610493] nvme nvme0: Failed to get ANA log: -4
[   66.654065] nvme nvme0: D3 entry latency set to 8 seconds
[   66.667024] nvme nvme0: 6/0/0 default/read/poll queues
[   97.270420] nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x1010
[   97.320023] nvme0n1: I/O Cmd(0x2) @ LBA 1000214240, 8 blocks, I/O Error (sct 0x3 / sc 0x71)
[   97.320796] I/O error, dev nvme0n1, sector 1000214240 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[   97.330486] nvme nvme0: Failed to get ANA log: -4
[   97.378015] nvme nvme0: D3 entry latency set to 8 seconds
[   97.390837] nvme nvme0: 6/0/0 default/read/poll queues

> But if the controller handles unsupported log pages so badly it will
> probably cause trouble in the future as well, or even now when
> applications ask for unsupported log pages using the passthrough
> interfaces.
> 
> Srikanth: what controller is this?  I'd like to add that to the commit
> message as well.

00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983

With the patch above everything works again.

Thanks,
Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

