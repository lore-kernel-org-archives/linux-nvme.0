Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14511ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZY1N7hN1ZoxkNF5F9W6OLAUSDaQlgbo0fMLLqjUSprQ=; b=SVlD8UVslOKM9thknCmg6RKm8l
	b731rBKtrWCOFbZmXf1WyYK0xaJPJQhHtnHihmGFBSxJun7+M4O5keg9/jtIGeWq6i3vVr7beNwDL
	1xv8FzKsBuJiyiKoV9HZOvH9OB5ykgjSUBfJIlxMwo8PufwF85UqLgp+EZ8jF+SBvINO+ems7xdML
	m0R5AYhkpWDC8enIb1ZfQvbwpJkOZ/h+O7op13Sd9+aILHBIaL7C+AOCneNtX6XTLQU+0mb5bM81w
	Ssun7bN91apWbc20k62lLWU+w4l/0SHGAi5qudDLt3drvuBBBoVdnosVcauQAGdboBHzTfCtXF1iE
	fw/rU0tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTJcm-0058uI-3w; Wed, 31 Aug 2022 09:03:04 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTJcg-0058pZ-Ai
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 09:03:02 +0000
Received: by mail-wr1-f49.google.com with SMTP id m16so17316562wru.9
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 02:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZY1N7hN1ZoxkNF5F9W6OLAUSDaQlgbo0fMLLqjUSprQ=;
        b=CQtlJDgMVgIPQDmFE/f8nW6YuRV7fKaRChKstDFjO2SXcN/0j8mkuwGmFfxxIJWoJy
         ptQEhPbxuhgmNYhvwfLmbsCy9Qb1W24uzwhKMA7TKAzgdL/4A90hEpP2sp3iRZhiMSAk
         vdBNDEJEW21AfU14Vg818XpabtL27lC+k5tud5OyRkfccabnVbA2r3mrCfbEiOfIcZ05
         SkDgwN/9kMiG+MXf+1IKwFa9ATY2Y/++bJca3wYmRGC5BWSAdp30zDggfS4MEzI7t0dO
         ThIbwfqWVmhr/Yp3oMhVRnAAJE72O798Z4RMLCvqjHBeRXpG0Cer7xbEucVmPSpgdG/9
         WatA==
X-Gm-Message-State: ACgBeo2zbVO5Q/nlPmQu420tVRMpS62eFTZYJK0iEu44XfjEwbT69DK3
	UBLYTZlcDNKaXYz7w1qCeYEeUA0TIW8=
X-Google-Smtp-Source: AA6agR6ya5PHtyNu0O0seAhWNz11C7O4aPWqOO4PP0AxWJaw9DM/Fmzyq8Y+puwqyBeIk1pNSxid4w==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr11226266wrr.583.1661936574869;
        Wed, 31 Aug 2022 02:02:54 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id k25-20020adfd239000000b0021e43b4edf0sm11370607wrh.20.2022.08.31.02.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:02:53 -0700 (PDT)
Message-ID: <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
Date: Wed, 31 Aug 2022 12:02:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>,
 linux-nvme@lists.infradead.org
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_020258_445333_5830750B 
X-CRM114-Status: GOOD (  19.57  )
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


> Hello,

Hey Jonathan,

> We've seen sporadic I/O errors with nvme-tcp in our lab when testing
> with kernel versions 5.15 through 5.19. Using a combination of tracing
> events and network traces, we can see nvme_setup_cmd() trace events
> that do not result in transmitted commands PDUs.
> 
> Here's a snippet of the relevant portion of the nvme trace. The
> following events are the last of tens of thousands of successully
> executed reads...
> 
> tar-9004    [004] ..... 22457.614117: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=53272, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760448, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> tar-9004    [004] ..... 22457.614118: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=61463, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760384, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=16406, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760376, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=28693, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760312, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> tar-9004    [004] ..... 22457.614119: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=40980, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760248, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> 
> The following 5 commands are issued to nvme, but never make it to the
> wire. The wire state was verified manually using tcpdump on the host and
> trace events on the target. Perhaps the "need-resched" marker in the
> trace and the context switch to the kernel worker are relevant
> to the failure?
> 
> tar-9004    [004] .n... 22457.614171: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=61469, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760704, len=55, ctrl=0x8000, dsmgmt=7, reftag=0)
> kworker/4:1H-8668    [004] ..... 22457.614183: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=45084, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760640, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=28699, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760632, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=40986, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760568, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> kworker/4:1H-8668    [004] ..... 22457.614184: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=5, cmdid=16409, nsid=1, flags=0x0, meta=0x0,
>    cmd=(nvme_cmd_read slba=15760504, len=63, ctrl=0x8000, dsmgmt=7, reftag=0)
> 
> The reads above eventually timeout and recover after reset. Here are
> the related reset messages.
> 
> [22486.420606] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760568, 64 blocks, I/O
> Error (sct 0x3 / sc 0x71)
> [22486.429326] I/O error, dev nvme1c1n1, sector 15760568 op 0x0:(READ)
> flags 0x4084700 phys_seg 1 prio class 0
> [22486.439262] nvme nvme1: queue 5: timeout request 0x1b type 4
> [22486.461788] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760632, 8 blocks, I/O
> Error (sct 0x3 / sc 0x71)
> [22486.470440] I/O error, dev nvme1c1n1, sector 15760632 op 0x0:(READ)
> flags 0x4084700 phys_seg 1 prio class 0
> [22486.480386] nvme nvme1: queue 5: timeout request 0x1c type 4
> [22486.486256] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760640, 64 blocks, I/O
> Error (sct 0x3 / sc 0x71)
> [22486.494994] I/O error, dev nvme1c1n1, sector 15760640 op 0x0:(READ)
> flags 0x4084700 phys_seg 2 prio class 0
> [22486.504946] nvme nvme1: queue 5: timeout request 0x1d type 4
> [22486.510822] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760704, 56 blocks, I/O
> Error (sct 0x3 / sc 0x71)
> [22486.519563] I/O error, dev nvme1c1n1, sector 15760704 op 0x0:(READ)
> flags 0x4080700 phys_seg 2 prio class 0
> [22486.529723] nvme1c1n1: I/O Cmd(0x2) @ LBA 15760504, 64 blocks, I/O
> Error (sct 0x3 / sc 0x71)
> [22486.538610] I/O error, dev nvme1c1n1, sector 15760504 op 0x0:(READ)
> flags 0x4084700 phys_seg 2 prio class 0
> 
> To further aid in debugging, I resurrected Keith's nvme_tcp tracing event
> patch from a ways back. If my understanding is correct,
> nvme_tcp_cmd_pdu() is being called for the commands in question.
> 
> I've isolated the failure to a scenario we can reproduce at will
> in about a minute of runtime. Is there any additional debug that we can
> provide to help locate the bug?

Would be interesting to understand if for these requests,
nvme_tcp_queue_request scheduled io_work or not (can be marked on the
command and printed during the timeout expiration). If not, would be
interesting to understand why.

