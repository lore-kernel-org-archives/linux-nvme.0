Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E15CCFA18
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GtpUxdxH6tHpXNqd2iO08w1vKvEg3zXiBARa+Otl0m0=; b=L2rmsQZQxI3bTSgG3/4N3mHoVS
	O3mo/+8YvEnxAF5IgtuSl3ILdiOoqYq7CIUPUrJbFBYfgoyr5rzIokoql39ZvaTUwW+VowNpl9VHZ
	0XxGHnGgFV31we3okp643ADdDleoq62drrrHFRI3rEbYqm70sAXg9CQsPgbboowQG+IZvBLM3m2RL
	OgZJCrkNbzvcxZ64+fzIdwcgBEuRFpJJYRrOP6cidlnzgo6GQFGHNk8u3jB0ABG8FLPiOPL3SEOzN
	BxGDj115HPpqUADLYpTKnLXSx+02I+bFJmdJ326fMyT9UqbyKyYMXDFWSqZLxY/SaYJ4hfbujvTOE
	lP1Y8L+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIt3M-00000007bWa-3yWq;
	Tue, 11 Nov 2025 18:25:16 +0000
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIt3K-00000007bW5-1t2T
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 18:25:15 +0000
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-6567a0d456bso1977948eaf.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1762885513; x=1763490313; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtpUxdxH6tHpXNqd2iO08w1vKvEg3zXiBARa+Otl0m0=;
        b=ZaLxzOZ6wDpF3D61859KDoPK2aZmjoYWG5HP5zfLUPWIDnrgHF0yrWHLOk6zbAc4//
         6Tbvg4ct9e9NRSUeaf/e8M4tnmds3p6mw8BIvfBWeVcY0gErK8CIJ45qlgejBsuKwVO/
         4SQ5PFZb0lDqsP+7v9SZii7a5mm+eeghdSKUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885513; x=1763490313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtpUxdxH6tHpXNqd2iO08w1vKvEg3zXiBARa+Otl0m0=;
        b=JtJ0z+Qs3H8EogIIzYgu4j3YNZNxrHXn0AcsrfIX4Tyztetx2UXptnHIFX+sPF6s+/
         GglSdsrtF58BauM3r6cF/ZgH7uvlCnd2OCkJ8E8RaY2AKfN8fo1x/4wy5Qvy7SC6154S
         neuOwKJG8Ofn5akRuH7aMCuy10i3ykr1C/CypAC1eTvTvy5dMt79DfPvmv//Gb4V7Rpm
         jq172HBjLDGuuFgXqMek/hHGhQ/ggfbugmoiDYm6cjGZONR+vWIeSF83IZYcobBOm+XF
         cCSxQfm1npB9CjErJ+9PJHdo6ICngaULqDIkvBm174v8/jRsniq3buPBnvdtbPbH2UNy
         XkBA==
X-Forwarded-Encrypted: i=1; AJvYcCUdHysd2d8+u9ZIrh9LpiuVLyubwZQaS2H7THmXauh9T3nnhJWA4aE4nZXBBIdDiB4vBbpNpwrS8Em+@lists.infradead.org
X-Gm-Message-State: AOJu0YxPdTuUuE6kY6iUiK6M6Fc3WSD9Fk53PwWWJqWc0okBi0WxpmOb
	ujMoSukWwo1xH72Y+QqZwEg9ZXGmkqUHnEUyAusvZMOGOCEtmIevPgL/hgHknNVjoSXgxBLHtvJ
	ydgdlYBQl9oJfvPSzSBekIJNRu+j+EDzmNIsHt2gslg==
X-Gm-Gg: ASbGncsgcEhcdJoAMUVeAaN7kcyxxxCz/NrqpfhxsV+IGQMCRxtzSVFDUM13p+yZS9P
	QYVuVu35GLXdWBH3lFHF6zTgHfsTphiFK2MN5zz1CQphyUF1Xp97OFxLG/Hwc+jBez4e3STeCrx
	M+ITbro6oTF58ezXFDkhkidW25odMLTOaQtp06AI9MszHjzw3qTuthS+jdfaIn7NnoP9tom4PJ1
	w5DK1eS4UgKjiv6s9AamguDM20LhVcCs88rwYlIS+76E1mWz/8FiCDCCc6RA7icRHcSgg19q9tN
	W0k5nHXFwTNHNZZTGxW8/45oQTsIp1B2CkjdgT+RTaw8Y5h6R/erPB/pqlFNKMg=
X-Google-Smtp-Source: AGHT+IGVdcg1pExsgdw3sNUbMbWj2lV1fImaTNjRSyrzu1tSZotBcHq8osVRXnFb5AVR//+Vw+FtIRvg2dx8p6XhnhM=
X-Received: by 2002:a05:6870:390b:b0:3e0:788f:2600 with SMTP id
 586e51a60fabf-3e7c2530997mr5946058fac.12.1762885513036; Tue, 11 Nov 2025
 10:25:13 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
 <e5a2b8b2-d4e5-42ce-9324-5748c5e078d4@app.fastmail.com> <1e4dd261-0836-4eea-b7fd-8dec9a7453d9@nvidia.com>
In-Reply-To: <1e4dd261-0836-4eea-b7fd-8dec9a7453d9@nvidia.com>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 11 Nov 2025 13:25:02 -0500
X-Gm-Features: AWmQ_blcsc3mycJcTUxkKy46KcX9boZcZZKVUf7YKxs0lHKkJ_pwLPE_zw9uDCk
Message-ID: <CAO9zADydZ=WrHbeREhWfetAupvzewM_A9Sz0RV8tY0h9CctoFA@mail.gmail.com>
Subject: Re: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 37868055...
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chris Murphy <lists@colorremedies.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_102514_516516_1334E4B0 
X-CRM114-Status: GOOD (  20.18  )
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

On Tue, Nov 11, 2025 at 1:08=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 11/11/25 08:56, Chris Murphy wrote:
> >
> > On Mon, Nov 10, 2025, at 10:05 AM, Justin Piszcz wrote:
> >> Hello,
> >>
> >> I am using an ASUS Pro WS W680-ACE motherboard with 2 x Samsung SSD
> >> 990 PRO with Heatsink 4TB NVME SSDs with BTRFS R1.  When a BTRFS scrub
> >> was kicked off this morning, suddenly BTRFS was noting errors for one
> >> of the drives.  The system became unusable and I had to power cycle
> >> and re-run the scrub and everything is now OK.  My question is what
> >> would cause this?
> > We'd have to see a complete dmesg at the time the problem occurred. If =
the same device holds system log files, seems like a pretty good chance non=
e of it made it to persistent storage.


> >none of it made it to persistent storage.
Absolutely correct!!  Luckily, I do have remote syslog enabled and
captured the errors that were not logged to persistent storage, do the
errors below point to an NVME firmware issue?

"2025-11-10 01:42:51","notice","user","","machine1","[4043499.402974]
BTRFS info (device nvme1n1p2): scrub: started on devid 2"
"2025-11-10 01:42:51","notice","user","","machine1","[4043499.403000]
BTRFS info (device nvme1n1p2): scrub: started on devid 1"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.683686]
nvme nvme0: I/O tag 2 (a002) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.684742]
nvme nvme0: I/O tag 3 (c003) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.685778]
nvme nvme0: I/O tag 4 (1004) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.686802]
nvme nvme0: I/O tag 5 (c005) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712274]
nvme nvme0: I/O tag 6 (0006) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712483]
nvme nvme0: I/O tag 7 (4007) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712698]
nvme nvme0: I/O tag 8 (3008) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712906]
nvme nvme0: I/O tag 9 (5009) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:53","notice","user","","machine1","[4043621.419061]
nvme nvme0: I/O tag 2 (a002) opcode 0x2 (I/O Cmd) QID 2 timeout, reset
controller"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.821452]
nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850059]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850351]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850630]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850903]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851173]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851440]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851705]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851971]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:34","notice","user","","machine1","[4043722.877036]
nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.941289]
pcieport 0000:00:1b.4: AER: Multiple Uncorrectable (Non-Fatal) error
message received from 0000:06:00.0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.942254]
nvme nvme0: Disabling device after reset failure: -19"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969046]
I/O error, dev nvme0n1, sector 86788096 op 0x1:(WRITE) flags 0x100000
phys_seg 1 prio class 2"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969083]
I/O error, dev nvme0n1, sector 464581888 op 0x0:(READ) flags 0x4000
phys_seg 3 prio class 3"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969128]
I/O error, dev nvme0n1, sector 45027984 op 0x1:(WRITE) flags 0x4000800
phys_seg 1 prio class 2"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969127]
I/O error, dev nvme0n1, sector 117882144 op 0x1:(WRITE) flags 0x1800
phys_seg 8 prio class 2"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969146]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969146]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969163]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 4, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969160]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 3, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969167]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 5, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969167]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 6, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969179]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 7, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969179]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 8, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969184]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 9, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969187]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 10, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972280]
BTRFS warning (device nvme1n1p2): lost super block write due to IO
error on /dev/nvme0n1p2 (-5)"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972938]
BTRFS error (device nvme1n1p2): fixed up error at logical 782844493824
on dev /dev/nvme0n1p2 physical 237354287104"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972957]
BTRFS error (device nvme1n1p2): fixed up error at logical 782844821504
on dev /dev/nvme0n1p2 physical 237354614784"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972960]
BTRFS error (device nvme1n1p2): fixed up error at logical 782844821504
on dev /dev/nvme0n1p2 physical 237354614784"
[ ..]


> > Chris Murphy
> >
> Isolate the problem between kernel and SSD FW by:-
>
> 1. run the same workload on different vendor SSDs.
> 2. run the same workload on qemu nvme emulation.
>
> This will allow you to remove the SSD FW out of this question.

Got it, I was running 4B2QJXD7 firmware on both drives when this issue
occurred.  Recently, Samsung released a new NVME F/W update 7B2QJXD7,
which they note "address(es) an intermittent non-recognition and blue
screen issue."  I've flashed the drives to 7B2QJXD7 and will see if
this issue recurs.

>
> -ck
>
>

