Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72210CEBF61
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+sPUm133fM87WIFKPda5ZoXzNeEcmeiwV1MrsNca2jo=; b=xER3QWzWfGvvd3lhiMQIbx3kA2
	CoT2h4pFfzVpzEAuVyIq2IEQkTxnDU+1XXK3AZZQgShBXZO/6+GxtRnNyXCZXzWpymkNLb69/nviE
	F1UG1z8mDbXvxPl85CF4QkRIYlWQLhFa+kGwcIzo9xZuA2Gxhf/40MzCDDUzhzLmbeYDU10bza2BN
	SvfUzzL0bj+48bNTNAgH9yJyu/nOeSUYh8XRR23dXiPIlQRBeVTTbYrEGn0lcq7cLdwN9pL5mE4ji
	njIrhOmG65ePcRbyFSDOLmz19wMzD0BZfWsv9swu5rb5vJl5+yOmkzzcxcmDnxDioqi0Co2Iq33TU
	d8yNBdpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKzSP-0000000GCVZ-29C8;
	Mon, 17 Nov 2025 13:39:49 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKzSM-0000000GCUt-41q7
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 13:39:48 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so6501806a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386785; x=1763991585; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+sPUm133fM87WIFKPda5ZoXzNeEcmeiwV1MrsNca2jo=;
        b=hfCf9DBD9l1IWUK/QHyWlDQXx7Pg8koNtiBwkGawbHbwQf+3qERsOxD31f6S/tkgSa
         0MXlEY+mHPAIXQPcCppdGa0DXZgq1QxyF2ARd/7n/fxGwPAIPRd7kjcjFr4QP5BXHjt4
         Jcb5rJw65UOTzEpNxaNFq63tqkHbOiS3vNPfVu/LLntghCD01lWcuGf+ldl6C4URIJ6V
         2NBsHqj/Npga6dxHx6jdUHALJplkxCCPoLpNXfJ/HZZkccHwVBG7JxaQzYmWMNEOV8ut
         IngN9M7uykoeu1r23pfHEaTnQdWE+FaQ8npqqjZfozXYMM27BMEJnjBj3dE11MWBI+eb
         iNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386785; x=1763991585;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sPUm133fM87WIFKPda5ZoXzNeEcmeiwV1MrsNca2jo=;
        b=vILImO1/ARDmTA2kcTN910azmdLgWrycM3zd9BTiMY8z77GtMJ7RT7fOexxo43/nR5
         xFDUrCi5LlzPEJqvTy1FDdsiR56LLySACZaC+LnXG6G4vdSlSzDtJRyeN/4M/zv+qZtw
         100OOerUOBtyH/UXKX/TxJxtyITrJtJV5rdgM2kUTjInAbNmyZmx9YGXX9eapxg8wQMt
         c4tliaE4eukujcUcEx/lNhMnvu+Z5YR2oy4jPtEBANofyFqp+nleDDaSNiqekhqrenmU
         qicZit3F5dQwadeAFlYK2YqjRtpY0Z5OTjl/SQIO2Zwhtol9YJvbBZsh9b4mHIKNtdSn
         0h5Q==
X-Gm-Message-State: AOJu0YzZp4QWfrYcybKKmeyB50dCVy7v2lJw/48uNdes9x1q6GrEQQ3M
	pGmPfUVD4Eb30GcuzvIzDT/CQFGt0Jisv5wwtdiFusu1U3/79ortDu9La+ShSAmjD8j/MiEsCcG
	o12XNyVniwOi9WuJoAXDIeMeLJOR+gME=
X-Gm-Gg: ASbGncuZ10vEigKTXGwixrSAT1XP3bnXpnpsO3pv2pNx/txMQBWUf0ebzHtcezssb9a
	ZCSRMeNpM+FY/KMx+fNb810R1rzMeJsq00y7plthZsK25VaN+ra/8rcKyhmqlAsRcg6eraURqIY
	aXqZs6bIVxeQ6rUKLFxOxsddf10LgLW+I3NUH9royf9Yk6ckixjsIgw6G2iXN7/o3CAxw3Z+IMK
	ucLEd6g2M2JzAxeJztfy6sj+KO/3CeD/+RvPC+jBercwTCf7z+aFnTmBr3nbofOa0B3eY9AaCfW
	VxI0emTSehHrxTC9NyM4o5oILQA7GH3bIHj2IazoXClEaK8JmYP1oi2dJlUqjGHdMS8AU680fcm
	PYs32QQQuk63S
X-Google-Smtp-Source: AGHT+IGaFPg+F7e2TIhlWzhxYkQ+WIawUg1FLkotHrBdOCGIj2sg7CIqMcMtLoOH1kAzUshU1JZ8logo+oQeWXMshms=
X-Received: by 2002:a05:6402:5188:b0:640:cc76:ae35 with SMTP id
 4fb4d7f45d1cf-64350e899a3mr10158552a12.21.1763386784678; Mon, 17 Nov 2025
 05:39:44 -0800 (PST)
MIME-Version: 1.0
From: Thomas ten Cate <ttencate@gmail.com>
Date: Mon, 17 Nov 2025 14:39:17 +0100
X-Gm-Features: AWmQ_bk2wMVd7eS0X3pjj1mnEL7ULvHA-3yeul1b2gWFTU269qkhFgaH6Lu-AVY
Message-ID: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
Subject: "controller is down; will reset" on SK Hynix NVMe drive in Lenovo
 IdeaPad Pro 5
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_053947_020204_68C560CA 
X-CRM114-Status: GOOD (  14.08  )
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

Dear kernel heroes,

I'm encountering errors with the NVMe drive in my laptop, which appear
to be related to power saving modes (search keywords: APST, ASPM). It
got more serious in some recent kernel version, but seems to have been
present before.

After just booting, starting `dmesg -w` and waiting a bit, the log says:

[   43.710561] could not locate request for tag 0x0
[   43.710585] nvme nvme0: invalid id 0 completed on queue 1
[   43.710593] could not locate request for tag 0x0
[   43.710598] nvme nvme0: invalid id 0 completed on queue 1
[   43.710603] could not locate request for tag 0x0
[   43.710607] nvme nvme0: invalid id 0 completed on queue 1
[   43.710611] could not locate request for tag 0x0
[   43.710615] nvme nvme0: invalid id 0 completed on queue 1
[   73.744791] nvme nvme0: I/O tag 129 (4081) opcode 0x1 (Write) QID 1
timeout, aborting req_op:WRITE(1) size:32768
[   73.744862] nvme nvme0: I/O tag 130 (a082) opcode 0x1 (Write) QID 1
timeout, aborting req_op:WRITE(1) size:36864
[   73.744875] nvme nvme0: I/O tag 131 (8083) opcode 0x1 (Write) QID 1
timeout, aborting req_op:WRITE(1) size:4096
[   73.744886] nvme nvme0: I/O tag 133 (5085) opcode 0x1 (Write) QID 1
timeout, aborting req_op:WRITE(1) size:12288
[   73.756694] nvme nvme0: Abort status: 0x0
[   73.757641] nvme nvme0: Abort status: 0x0
[   73.758533] nvme nvme0: Abort status: 0x0
[   73.759422] nvme nvme0: Abort status: 0x0
[  103.824976] nvme nvme0: I/O tag 129 (4081) opcode 0x1 (Write) QID 1
timeout, reset controller
[  103.966268] nvme nvme0: 16/0/0 default/read/poll queues

Notice the 30 second delays. This problem has been present at since
6.12.40 stable or maybe earlier, but has gone unnoticed until now
because things apparently recovered. Full log of a similar occasion:
https://gist.github.com/ttencate/9f2c4739d9e8a4c0142fd8246b56a7d6

More recently, since 6.12.56 or maybe earlier, I'm also sometimes getting these:

[  336.613637] nvme nvme0: request 0x0 genctr mismatch (got 0x0 expected 0x9)
[  336.613659] nvme nvme0: invalid id 0 completed on queue 8
[  366.657750] nvme nvme0: controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0x10
[  366.657768] nvme nvme0: Does your device have a faulty power saving
mode enabled?
[  366.657773] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0
pcie_aspm=off pcie_port_pm=off" and report a bug
[  366.761391] nvme 0000:03:00.0: enabling device (0000 -> 0002)
[  366.761842] nvme nvme0: Disabling device after reset failure: -19

In this case, the messages are followed by a slew of btrfs errors,
btrfs switches to read-only mode, and the drive becomes entirely
inaccessible until a reboot.

The log suggests to add the kernel arguments
"nvme_core.default_ps_max_latency_us=0 pcie_aspm=off
pcie_port_pm=off", which indeed makes all issues go away.

I haven't found a reliable way to trigger the latter error
specifically, though doing something I/O heavy like compiling a kernel
seems to make it more likely. This makes bisect difficult to do, but
it's clear that something was going on in previous versions as well,
so I wouldn't necessarily call this a regression. Either way, the
issue is still present in mainline 6.17.8.

Since it happens only after some idle time, and disabling PM fixes it,
this seems related to power states. But of course, I cannot completely
rule out faulty hardware either.

Machine: Lenovo IdeaPad Pro 5 16APH8
Architecture: x86_64
NVMe drive: SK Hynix HFS001TEJ4X112N
Full lshw output:
https://gist.github.com/ttencate/5540c81454bbe1fa679955effba65eba

Distribution: Arch Linux
Kernel version: 6.17.8 (vanilla from commit 8ac42a6)
Kernel configuration:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux-lts/-/blob/b0cac6a69041703bbe1aba4a2a269585d77b108b/config
(plus `make olddefconfig`)
GCC version: 15.2.1

This is my first kernel bug report, so I hope I didn't miss anything;
if I did, please let me know. I'd be happy to experiment or try out
patches.

Kind regards,

Thomas ten Cate

