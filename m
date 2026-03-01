Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA6DFD0057
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hO3DODQxk+CR7mXTiAfTGerkCPdjbu/UHjaWR/mPewE=; b=l/f1c5cqvNeiivFBbpObGu0xc+
	tJiMGZRH0n9P9+4jz0oNd19crr13W2byHcAvPAH0dSgbATR87N340GQTFxHHr6Sa538pkkP0GrIfP
	VZ9EJ7RuZvZZ+HynRvYdPW/VbsodXVmyOx8E6NVjj/uuPQimBsiaIB/wAtoI8oUikdBJ2jyCF1L0f
	RMsf/WYmFO9ZSjWiYyucs+yodlu6MK/YxTKk5bbH1vzPxH1/sgzZo7HQVWqtyEknF3snvEfQoUvHa
	UUUAVwmEAE7QcmFAGzFFBZclvkV9DGikk0hKJpbYo8afdiCB7uhWBwlkxuA8/E01FlLP4IWYH8B+9
	wk7c3vKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwhjS-0000000BZlF-3moY;
	Sun, 01 Mar 2026 14:25:18 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwhjP-0000000BZkt-3jM0
	for linux-nvme@lists.infradead.org;
	Sun, 01 Mar 2026 14:25:17 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-7d4c3896e32so1939921a34.0
        for <linux-nvme@lists.infradead.org>; Sun, 01 Mar 2026 06:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772375114; cv=none;
        d=google.com; s=arc-20240605;
        b=YMNwXea025pq1j5QIEPmYUB8VFBRNSX6vd2/UAhcaOdDVQTxVtt76VEGEPjzqRuopI
         ujkntm72dG/iU8Dh8J2rKT0lKRDBxAdZjo740A/zli4dcIzUz++3Xwbp8G3eC5pXm4wE
         j0Q4fpj5vhm2zfs4JYj0/ZC74gnIxc91QKwZB8uc6LqeVooF9e1hW3uUPNbb0a6sn06f
         olLcFdaCIab72xbGcifEaik24rjUlWpzYQRjavC/PzgwhfVAZ0ok1Zs9plk8UcGqdc8J
         MSrfd7kv0OuyuOnyCQl6YWPFGPI1x50KZ+5NE3KdcWYrQ+nqy0Wyu9kUQ/RgZMhn69Og
         Ejlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hO3DODQxk+CR7mXTiAfTGerkCPdjbu/UHjaWR/mPewE=;
        fh=Bpw7Zj1lWxh02I805VVMYsQM8pymL2SPLlC8p3f1Nu8=;
        b=Ps5dklTbfzXgq/m66DT4v0ccz4YRhiLU2N9E8UFqKZmqYxug3x1IU+aLqsPAiidwYw
         8H5z+JSQwLshzl88ywVRd1Ruj6QILhszrbJfDAFEJ4kDNy0wZx39hzGOYPgdIkYMRXfy
         g7xM7wHoo/4UU1gYTucFnM/vVviogiycHAUE89YkpAynAg1u4urNyGVqgpjMEVnt0ZLi
         gtlJrYPh0tAH57RRtTQDnuEl883tBzHBAlcUR/sRGgXNNzu9UJog1Ks4Up2po0Uk+tla
         8H3HCuxal9+IR3I2HoZvYPXasZAoIeo7w+Gv317+kFkg/ObpzYx6T9pdMxbmjqUXHMmE
         Ub+A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772375114; x=1772979914; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO3DODQxk+CR7mXTiAfTGerkCPdjbu/UHjaWR/mPewE=;
        b=kMTUWchLRkoxaD/47t/VuXBAuhk61pjaBNc5vPG/+FSCNg9njOujNAZMjS+WH5dk+T
         iAqY1jELmVR4AxTD28CyWdMhbQntmXXDenI3cgMpb84GG5lr2rZ0lM5QSnYOqpmby4Qh
         4meP/szPhdbE6wl9wISCOfly18GfBvTafq2jyzcsiT7tiWW1NEF595RZVUIVHJqwTJtm
         QWKqqKDFHXg0fY5NAcuH+Xr+BdVtAM+G9nJd8i5T6xMgU9h3/uJy9QXamqaWzCEn+6wx
         6L7m8IK0GhGkAMzMS2lvdqap5faB1lrGh2QjJ2rU1HUkilyijbeAekkVv/fcEd4jgZsb
         WYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772375114; x=1772979914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hO3DODQxk+CR7mXTiAfTGerkCPdjbu/UHjaWR/mPewE=;
        b=HcHs260o6//1wCNjDm0vMbW0iRBPYfrUKMjdWEBlvdEtMAuxU+y9MVrnASFgJHhUeY
         U3cP1lUESsZ1NwEHC09Fjl0WXznEUdazjydfz5u7BPujUBgcenxyJi9BretVrD+ivohj
         sNmxiLZ4pobWB8/HjU+556QA10hcW2Bw5WWwrSUiQ37fePOUkd0SrGt54dPYMFuBWOk2
         OSXiCcJAC+2MUEE/dMTApakEkgmc5C8XJgp7brv2RN3I5mbl02D7KNlskyWxrk1BTfLR
         RHyzBlm3AURuMzdgipvBqAjut8pbagmJyiAyjTew3/sZG/26T36ihsEE2xiD/YD4Cx/S
         koTw==
X-Gm-Message-State: AOJu0YwYAGIqrexmx5rIEPBnnItSgGpc5PGfVPHg3+Y+02L7398wY0zQ
	NAy3wyejiHtDs1br7VZPDuvgDvsialudY4NMAhVcuFm0TaUKvUVXhFgOmfvzz4CR/BQ9coFzcvp
	FtTZBdDM/O+M0N/caKJ6W5TSScDZU4s3zaA==
X-Gm-Gg: ATEYQzxCy1BwzmtV8xw+maDhdOfvVb4p0ipQhg9FBLs/16uJyvjna48k8gzE66l2tYd
	wsjrPBbr7aPwRTK4c6z8/BKIB/SnZmMUB/Udvt5rBx/ZnVkf4Y09yCdfimkpXshy3Wb+eq9A1ow
	THBY1RAdJEF3uT620UF+kK8wXd03vH5yC3LjnHMTVm6mkyAW7JtQgAkMIMPZJK2gAd7Vs7xxqdu
	CXOUFMVJ5gNiYue6iV4e0sDMLis+RwmFun6gv3VKHUDIM7xhzuO1/mky4TcofH4GbLIXesPD5pF
	p6G9O914
X-Received: by 2002:a05:6830:81ce:b0:7cf:ddb7:8823 with SMTP id
 46e09a7af769-7d591b34e79mr8555075a34.11.1772375114177; Sun, 01 Mar 2026
 06:25:14 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SCFgVzj+Jr8kc1ySLH9KAPjGFN8XTEKQjvefEVyRT9K5w@mail.gmail.com>
 <DGRHI7H6BTSG.12V7ZG8WJGOVB@bsdbackstore.eu>
In-Reply-To: <DGRHI7H6BTSG.12V7ZG8WJGOVB@bsdbackstore.eu>
From: Sune Brian <briansune@gmail.com>
Date: Sun, 1 Mar 2026 22:25:02 +0800
X-Gm-Features: AaiRm52SWIUH9Hfn1RD3lc192-6VNSvJzhBGv93UnoslB4ZWvO7F1frK9LOmrDA
Message-ID: <CAN7C2SD7mLjrKARiwuu3ygfYNgaM2tX9Tco9gqUk-hNP_efC0g@mail.gmail.com>
Subject: Re: [BUG] NVMe: Discard timeout/hang on a801 during mkfs
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_062515_935245_D82F5979 
X-CRM114-Status: GOOD (  19.53  )
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

On Sun, Mar 1, 2026 at 9:36=E2=80=AFPM Maurizio Lombardi
<mlombard@bsdbackstore.eu> wrote:
>
> On Sat Feb 28, 2026 at 1:22 PM CET, Sune Brian wrote:
> > Issue: A fresh NVMe is format below instructions
> > always result in series of "opcode # (Write) QID 1 timeout"
> > While normal mount and read write shows no stall
> > or hang.
> >
> > dmesg log is placed at the end.
> >
> > During testing it shows that DRAM-less NVMe will result in
> > timeout but DRAM NVMe does not.
> >
> > Please maintainers help to see if there are any possible
> > causes that could remove these possible PCIe reset.
> >
> > Test Kernel: 6.12.33-g3234b1ed8956-dirty
> > CPU: ARM7l
>
> I am not sure from where this kernel comes from but a search on google
> hints to the Altera FPGA github tree
> Is this the Altera's kernel?

Hi Maurizio,

Absolutely correct kernels are clones from the Altera trunk.
I am hoping there are patches missing and let me give it a try.

>
> I looked at their 6.12 LTS branch
> https://github.com/altera-fpga/linux-socfpga/blob/socfpga-6.12.43-lts/dri=
vers/nvme/host/pci.c
>
> And they miss a patch that fixes some problems with I/O timeouts in
> the nvme-pci driver.

>
> https://lore.kernel.org/linux-nvme/CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaSJu=
CxQRO7cjPtgWg@mail.gmail.com/
>
> https://lore.kernel.org/linux-nvme/20250331162859.1407725-1-mlombard@redh=
at.com/

Thanks,
Brian

>
> Maurizio
>
> >
> > 1) sudo wipefs -a /dev/nvme0n1
> >
> > /dev/nvme0n1: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49
> > 20 50 41 52 54
> > /dev/nvme0n1: 8 bytes were erased at offset 0x1dcf855e00 (gpt): 45 46
> > 49 20 50 41 52 54
> > /dev/nvme0n1: 2 bytes were erased at offset 0x000001fe (PMBR): 55 a
> >
> > 2) sudo fdisk /dev/nvme0n1
> > g
> > n
> >
> > w
> >
> > 3) sudo mkfs.ext4 /dev/nvme0n1p1
> >
> > mke2fs 1.47.2 (1-Jan-2025)
> > Discarding device blocks: done
> > Creating filesystem with 31258368 4k blocks and 7815168 inodes
> > Filesystem UUID: 8f469cc5-d6e1-4606-bfda-869806245d9f
> > Superblock backups stored on blocks:
> >         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, =
2654208,
> >         4096000, 7962624, 11239424, 20480000, 23887872
> >
> > Allocating group tables: done
> > Writing inode tables: done
> > Creating journal (131072 blocks):
> > done
> > Writing superblocks and filesystem accounting information: done
> >
> > Thanks,
> > Brian

