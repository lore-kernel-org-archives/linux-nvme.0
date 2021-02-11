Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5210C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 10:28:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163B164E95
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 10:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163B164E95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kC1+3ZJ1qgS4afTBGq/r2n25iHzz8vS+eHC4cWS5Qo0=; b=t3fcrkIAq8eooL
	2lKfhF5qgTKneCC7Vl6LMxFsaamAIkLnZ/NmfRTg3bxb+hkUq3T59v2eEjUJKUbQyMm1PP2Ty6bUF
	jyZVQMYmJ3o8CewfC7LdpFYyxIAbvBqAJeam4CojqGrSwGMWPPHQn6wuRh5o7HevmtsIj5Mcq+clt
	nxW/DrzNhkn9CcgY1KPxneoeyS65sV084gJ+nsCYohwlPU/s7x/ubxcFIC2tTul7WuH0iqywG9yIh
	Pishb4LDPokdFGCCMOjAUt64MPe3gR8F/0Sj8nC5nG8X0dFYfGGcgAlyr48gkb1g4648MdqVLIL7M
	gr5RRSzocrCdq31uA7Iw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lA9DO-0003ah-Av; Thu, 11 Feb 2021 10:28:50 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lA9DC-0003aE-1n
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 10:28:39 +0000
Received: by mail-pg1-f172.google.com with SMTP id o38so3547740pgm.9
 for <linux-nvme@lists.infradead.org>; Thu, 11 Feb 2021 02:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=BzUyvxImXHzdpYgS9lqSW9xmFJVN1Rgj2pjxoCpHMVc=;
 b=b4U3qn7rhS6q2o97giQ9aoow1tnA1NgaPK23ZCtp/aqzaH+GljsMKO1uk+ft8DeIsc
 dJKrXnQ0+b2RUU+hIaLFPC+CYuDfMC/EhsrMHeLh+X1ogEs90PR6SatGqdy7KzuKNBwV
 cjE92hakmXdli4e8uVHfvr5kE/QASlDj2pOwSZm+H0Ln73NF2TKNWncVUWwbUTIPYkao
 wXIjL1UwkUxB+neOz8j+KgHidLe8VcD5YwwmAc9z//YrEW3DC9chx23sylLyHXH9VG/Y
 z7goRG/Edslzo/Gm3IHyDJrE4GOy8cuvw6CNZ53imjDPRP+dY7uVzFUaRNzjLWM8QgFO
 HNtQ==
X-Gm-Message-State: AOAM532ZH+qstsf/YPpNIdQ35nK8uhox9ZqkBfaczxIL/L17PvJUpUIM
 Aw6oQeGo2iOFaeRWMxBbQmY=
X-Google-Smtp-Source: ABdhPJzEuTSAyoPUkl7fRQXytB250MdGattqf9zmrZruiWa2KrBElNL63CLElhBZ0jSxab+M8MJ//A==
X-Received: by 2002:a62:25c7:0:b029:156:72a3:b0c0 with SMTP id
 l190-20020a6225c70000b029015672a3b0c0mr7373018pfl.59.1613039314840; 
 Thu, 11 Feb 2021 02:28:34 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:1c07:7210:2422:7e89?
 ([2601:647:4802:9070:1c07:7210:2422:7e89])
 by smtp.gmail.com with ESMTPSA id o14sm5685001pgr.44.2021.02.11.02.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 02:28:34 -0800 (PST)
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: nvme-5.12 is crashing with fabrics discover
Message-ID: <f4f56a23-c458-5a4c-457d-d9478aea854a@grimberg.me>
Date: Thu, 11 Feb 2021 02:28:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_052838_140432_F8C89F6E 
X-CRM114-Status: GOOD (  11.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey,

Started seeing nvme discovery crashing since commit:
a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")

Not yet sure what's going on, but reverting this commit
makes the issue go away.

Trace:
--
[   86.901818] nvme nvme0: new ctrl: NQN 
"nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
[   86.902223] BUG: kernel NULL pointer dereference, address: 
0000000000000368
[   86.903345] #PF: supervisor read access in kernel mode
[   86.904949] #PF: error_code(0x0000) - not-present page
[   86.906202] PGD 0 P4D 0
[   86.907020] Oops: 0000 [#1] SMP PTI
[   86.908025] CPU: 3 PID: 1470 Comm: nvme Tainted: G           OE 
5.11.0-rc5+ #35
[   86.909333] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.14.0-1 04/01/2014
[   86.910924] RIP: 0010:bio_associate_blkg_from_css+0x45/0x140
[   86.912854] Code: 38 f6 c2 03 0f 85 de 00 00 00 65 48 ff 0a e8 12 52 
cb ff 4d 85 e4 74 4d 49 83 bc 24 c0 00 00 00 00 74 42 48 8b 45 08 4c 89 
e7 <48> 8b 80 68 03 00 00 48 8b 70 50 e8 0b fe ff ff 48 89 c3 48 85 c0
[   86.915683] RSP: 0018:ffffbe6c409d3da0 EFLAGS: 00010282
[   86.917316] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000010
[   86.919128] RDX: ffff9e82f3b60000 RSI: ffff9e82f0fdea00 RDI: 
ffff9e82f0fdea00
[   86.919135] RBP: ffff9e82c2769000 R08: 0000000000000001 R09: 
00000000409d3d00
[   86.919137] R10: ffff9e82c2769000 R11: ffff9e82c2769078 R12: 
ffff9e82f0fdea00
[   86.919139] R13: 0000000000000000 R14: ffff9e82c2769000 R15: 
0000000000000000
[   86.919143] FS:  00007fbecaea0780(0000) GS:ffff9e833dd80000(0000) 
knlGS:0000000000000000
[   86.919146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.919149] CR2: 0000000000000368 CR3: 00000000034f6004 CR4: 
0000000000370ee0
[   86.919162] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   86.919164] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   86.919169] Call Trace:
[   86.919243]  bio_associate_blkg+0x20/0x70
[   86.923268]  nvme_submit_user_cmd+0xd9/0x260 [nvme_core]
[   86.923391]  nvme_user_cmd+0x11f/0x190 [nvme_core]
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
