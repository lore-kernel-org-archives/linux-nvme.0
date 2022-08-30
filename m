Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB0ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 23:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IR7B/d0eJCK2vNY7OigjOUl7RJKQlLAex9+T57Rn88g=; b=26DkCdpm8d22Ma32wz3iwBNpWe
	Rjn9CrdGj055/JifCM093c1aQJyuUEjMAFYkRWxKAcCCTk+pJ9gKvSn7dQGsAFGRIWeVOVwmp+9IT
	Re8RxNzMntSfKdWvLfnMG3vmAGYIJz5yjegECUPiyivKOsdUayWUmtlSYzFuvWCpwBjSJlDY1IMDm
	fQu60IBOcZIgaNNqFkcg19OU6u+FNTqpNgoH9toba4eGnKRUFuo6wYmUwdv/SaNhIrip4y5EBrltH
	UR5sdXuNEqTezex3aM9cYrj4kqXM9mTe51XzFf5F2xOBdl31ZWIRvjmTt9cCu+wqVcgkDoZryw9Dr
	cyUFYv1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTAOO-002OIr-Gk; Tue, 30 Aug 2022 23:11:36 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTAOM-002OHl-32
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 23:11:35 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33dce2d4bc8so292638717b3.4
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=IR7B/d0eJCK2vNY7OigjOUl7RJKQlLAex9+T57Rn88g=;
        b=Lkea76LRMhv0wEoFVyjmTrtkqeET4FiggblvjEsR43uBlM9klQH3GiDyxq98nXMm1u
         BdVJ3SBgndM6XYDWi8mH/PLCsFUeL/o2MHy/3bXVI9xrn5gWP9VR8JuVaeUUSC1/fVGn
         09Itt3M7BEbhXYxJRFnGFGumHNbTBwUQp0naLzdxjuONwM2dx62mjzlePCexmANnZATI
         8WhCZNscMeMSujAdEbeA1HtTALFzc7Z+6/HfQuXWv5XgIy8THhKNx6W+0y7Y9oFvAi5f
         lNv1kf2PkHkvSTEThUqbKIuuu438jxmtHVhs2JpNilGqkVSWK8Z5y3SF4uv08ICdYKmS
         rwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=IR7B/d0eJCK2vNY7OigjOUl7RJKQlLAex9+T57Rn88g=;
        b=rKkzLv3CzPpk9cM9YuefjZWYii+G5WaqTEG7EJEjutrUOTykBxAx5jbSsOLN1kq12j
         ogFWX0F8v+ng/TgbXTptALLv8QHrfhGml3UpG4QU5khxp7iwJFCaTnMZJWR9nP4rIEV2
         PIrlFGMhO4TdGzcosSJfpu/eumek6JNBWtH5WZRhPiMkr8MjtI19aLboktflEZsx0O5d
         yIEZ3Aokj9KaZDrkYMQ9hdyTA3h+00ICT2SMeEIHuJlbdXmYv5snTXYLICr4Goil8DLB
         sS7Bzld9mMG1ySJTeiJ/g6747PbT7pnpo1u57DuTFS0sprQnHpf2CdMWMjlwcrg6xlhA
         LS/Q==
X-Gm-Message-State: ACgBeo1qvbv7dE5Y5t/I9uy1RL19lbPhmMlhFeRV/btUvFDE7EaPLHZe
	B3rs8C3+LAubosUQAWna10/4+R48oWhBOX/UYTvw9lk0SQglKUqn
X-Google-Smtp-Source: AA6agR7K5pQ3+zllfq2A+nCqIVjZLo0y722zrph90IbgrEkozWDogitIl8XQjJwXODmvdNiUeR+p/KBPwBOy+5hn0Rg=
X-Received: by 2002:a81:a93:0:b0:340:ad44:589c with SMTP id
 141-20020a810a93000000b00340ad44589cmr16568382ywk.163.1661901088112; Tue, 30
 Aug 2022 16:11:28 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 30 Aug 2022 19:10:52 -0400
Message-ID: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
Subject: nvme-tcp: i/o errors and stalled host from failure to send command pdus
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_161134_168343_8BB0CD71 
X-CRM114-Status: GOOD (  10.65  )
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

Hello,

We've seen sporadic I/O errors with nvme-tcp in our lab when testing
with kernel versions 5.15 through 5.19. Using a combination of tracing
events and network traces, we can see nvme_setup_cmd() trace events
that do not result in transmitted commands PDUs.

Here's a snippet of the relevant portion of the nvme trace. The
following events are the last of tens of thousands of successully
executed reads...

tar-9004    [004] ..... 22457.614117: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=53272, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760448, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
tar-9004    [004] ..... 22457.614118: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=61463, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760384, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=16406, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760376, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=28693, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760312, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=40980, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760248, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)

The following 5 commands are issued to nvme, but never make it to the
wire. The wire state was verified manually using tcpdump on the host and
trace events on the target. Perhaps the "need-resched" marker in the
trace and the context switch to the kernel worker are relevant
to the failure?

tar-9004    [004] .n... 22457.614171: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=61469, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760704, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
kworker/4:1H-8668    [004] ..... 22457.614183: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=45084, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760640, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=28699, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760632, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=40986, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760568, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=5, cmdid=16409, nsid=1, flags=0x0, meta=0x0,
  cmd=(nvme_cmd_read slba=15760504, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)

The reads above eventually timeout and recover after reset. Here are
the related reset messages.

[22486.420606] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760568, 64 blocks, I/O
Error (sct 0x3 / sc 0x71)
[22486.429326] I/O error, dev nvme1c1n1, sector 15760568 op 0x0:(READ)
flags 0x4084700 phys_seg 1 prio class 0
[22486.439262] nvme nvme1: queue 5: timeout request 0x1b type 4
[22486.461788] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760632, 8 blocks, I/O
Error (sct 0x3 / sc 0x71)
[22486.470440] I/O error, dev nvme1c1n1, sector 15760632 op 0x0:(READ)
flags 0x4084700 phys_seg 1 prio class 0
[22486.480386] nvme nvme1: queue 5: timeout request 0x1c type 4
[22486.486256] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760640, 64 blocks, I/O
Error (sct 0x3 / sc 0x71)
[22486.494994] I/O error, dev nvme1c1n1, sector 15760640 op 0x0:(READ)
flags 0x4084700 phys_seg 2 prio class 0
[22486.504946] nvme nvme1: queue 5: timeout request 0x1d type 4
[22486.510822] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760704, 56 blocks, I/O
Error (sct 0x3 / sc 0x71)
[22486.519563] I/O error, dev nvme1c1n1, sector 15760704 op 0x0:(READ)
flags 0x4080700 phys_seg 2 prio class 0
[22486.529723] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760504, 64 blocks, I/O
Error (sct 0x3 / sc 0x71)
[22486.538610] I/O error, dev nvme1c1n1, sector 15760504 op 0x0:(READ)
flags 0x4084700 phys_seg 2 prio class 0

To further aid in debugging, I resurrected Keith's nvme_tcp tracing event
patch from a ways back. If my understanding is correct,
nvme_tcp_cmd_pdu() is being called for the commands in question.

I've isolated the failure to a scenario we can reproduce at will
in about a minute of runtime. Is there any additional debug that we can
provide to help locate the bug?

Thanks,
-Jonathan

