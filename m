Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED23C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 01:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WAYJaqn/4jsrC63FS7JpHVRiU6idieihWGSlrSqaS3I=; b=z4BbWtpTv6rHoXTd16rOS0Tp4+
	IIRi4uAdxz1U5QgtsinvXPAPAOGANyi/YnjuJEpR3wgZeoDc4+xQ+puG1mmPpV3qE3oNe8HykaCKn
	j//P498GbeYuKqcCVACr+2ZEHkm5h5v4S+EJ9OJA1WQ42c632QOJXRCllh4au2QlLxfYU5S575mew
	nz48Oz/byLLRAwi2d+3K3AibDarZOe3xptz0TPpPldyfLFVwnnyCZRCz/L+vIw5Ha9gxypU+QS2rQ
	CR0yzd7ITHxQWAyhAsQR73HAkbMQz6lrP6OKXAGmrEqLsl4ErWGAL1qoKO5H7pFSTWOmN8e1WjEKw
	nMwPakAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmQlA-00DYRF-71; Thu, 05 May 2022 01:58:28 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmQl6-00DYPe-TI
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 01:58:26 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id a5so2111767qvx.1
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=WAYJaqn/4jsrC63FS7JpHVRiU6idieihWGSlrSqaS3I=;
 b=DNYx53tiR8bWN5Rudy6owO9Ixme774X8e+nmpe1SjW6ecwZuJrX0anJmb04TuTcfmQ
 nsSVY0A+55xQD2tpm/vsN+9TbUAOP2wtMTLgtpttkndvotrfdYp4fRHxXyg+A+zQrr2m
 z/6YEWlANwPGY4sbtEiPShesHnduEBl8BhbLe0N63la8Gn6OlU/rMtN3houdKlafTPvi
 Ii42F0y8Q24OTXymaz+YBOZnVLEw3SlEJ5N+siB3aYdhJ0U9KcqSLYznoJhsdTaEZ+40
 ASqpVaj5WPJSw0uGJiprOojIH+M/vyvayNlmbMmIXqu3/LCAsGcrR2eAxsLlG+JcWiBG
 2PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WAYJaqn/4jsrC63FS7JpHVRiU6idieihWGSlrSqaS3I=;
 b=TTcsQseAEGY8vEAh9sF+GpoTaqKkCFL1uLOxN1Uj/F0ijZbwLLr2a7zG+LNEqEHrzc
 2FUkQE4nVdFHHzivi1kveaL9pD2Gvk2rfqMuozwj0/cG6Qmcga2M+YJY76GNeUneJBPp
 1JLrg3tn71yNqdm4kBhgkcprw5WcfNNTw2Mb4oqG7l4f2bhoHTVcp1DKwXcUjruo6YiI
 EzgZi6cjAp1TFu47qojLMHPxXvfqmfWBWBkmrVB+03wAZ3GfR1S5DaawY5zkGCZ6HIls
 AgwS1TC0U6MCOElPFCWcFzXcmodzTeM/t0SQgyJNsCiIIlQsWCSp1RIvXqYOPAm4qFVb
 khmQ==
X-Gm-Message-State: AOAM5328vmcdcRuu2aJkpKZitaN8mWtKRWvlc4q2PH2lBEkAVvmc2ODn
 1kT4LDXVx/cm2AYtmwjSGcYpS1zUfAdpMXnPJqc=
X-Google-Smtp-Source: ABdhPJygEgQUQsQir+UNYmEBJVBMaLnGmxatpdvIu/omvFTQoSJH6L8AJi7LsW4mQK/r3ukr9BrT2i/tUdGLebxQfuY=
X-Received: by 2002:a0c:f092:0:b0:458:1192:7781 with SMTP id
 g18-20020a0cf092000000b0045811927781mr20662982qvk.29.1651715902682; Wed, 04
 May 2022 18:58:22 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 5 May 2022 06:58:11 +0500
Message-ID: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
Subject: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
To: linux@leemhuis.info, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_185825_031477_D2D9963C 
X-CRM114-Status: UNSURE (   8.30  )
X-CRM114-Notice: Please train this message.
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
Today, for the first time, I encountered the fact that my new nvme disk is down.
In the kernel logs, I found the following sequence of messages:

[ 3005.869069] [drm] free PSP TMR buffer
[ 4626.562712] nvme nvme0: controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0x10
[ 4626.584716] nvme 0000:06:00.0: enabling device (0000 -> 0002)
[ 4626.585006] nvme nvme0: Removing after probe failure status: -19
[ 4626.590776] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590784] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590797] nvme0n1: detected capacity change from 7814037168 to 0
[ 4626.590814] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590816] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590816] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590832] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590835] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590838] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590847] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590847] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 11, rd 0, flush 0, corrupt 0, gen 0
[ 4626.593059] BTRFS: error (device nvme0n1p3) in
btrfs_commit_transaction:2418: errno=-5 IO failure (Error while
writing out transaction)
[ 4626.593075] BTRFS info (device nvme0n1p3: state E): forced readonly
[ 4626.593099] BTRFS warning (device nvme0n1p3: state E): Skipping
commit of aborted transaction.
[ 4626.593107] BTRFS: error (device nvme0n1p3: state EA) in
cleanup_transaction:1982: errno=-5 IO failure
[ 4626.593137] BTRFS: error (device nvme0n1p3: state EA) in
btrfs_sync_log:3331: errno=-5 IO failure

Googling turned up a lot of links to various old reports (4.xx kernel)
and APST issue reports.
In a bug report on kernel.org [6], the unfortunate users talking with
each other with no hope of a solution being found.
The most clarifying article turned out to be [1].

After analyzing the answer of the commands "nvme id-ctrl /dev/nvme0"
and "cat /sys/module/nvme_core/parameters/default_ps_max_latency_us".

# nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x1bb1
ssvid     : 0x1bb1
sn        : 7VS00CLE
mn        : Seagate FireCuda 530 ZP4000GM30013
fr        : SU6SM001
[...]
ps    0 : mp:8.80W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:7.10W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:5.20W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0620W non-operational enlat:2500 exlat:7500 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0440W non-operational enlat:10500 exlat:65000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

# cat /sys/module/nvme_core/parameters/default_ps_max_latency_us
100000

I concluded that my problem is not related to APST because 2500 + 7500
+ 10500 + 65000 = 85500 < 100000
100000 is greater than the total latency of any state (enlat + xlat).

Or am I misinterpreting the results?

Therefore, I would like to ask if there are any other ideas why nvme
can stop working with the message "controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0x10", which generally does not say
anything about the reason why this happened.

My kernel is 5.18rc5.

Thanks in advance for any answer that will clear things up. And where
to dig in search of a solution to the problem.

[1] https://wiki.archlinux.org/title/Solid_state_drive/NVMe
[2] [# smartctl -a /dev/nvme0] - https://pastebin.com/JwSXwu6c
[3] [# nvme get-feature /dev/nvme0 -f 0x0c -H] - https://pastebin.com/KZ6FjhGt
[4] [# nvme id-ctrl /dev/nvme0] - https://pastebin.com/seEkPfF7
[5] [full dmesg] - https://pastebin.com/aNEaqtCV
[6] [bug report about Samsung PM951 NVMe] -
https://bugzilla.kernel.org/show_bug.cgi?id=195039

-- 
Best Regards,
Mike Gavrilov.

