Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A688C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 23:06:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6BD6143C
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 23:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6BD6143C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fZOLidfjA9DSeoYsyE8GZ9b5e+cHvht7b/vkP3frJ2w=; b=iCJsXAGr/BMq2H0WCb2yzw1i0
	PP98cSAgxqdPDF75EX4E6/fzEwJfvpJaZxOuMc4i9SOX+iK/Rrcgxp6Scgoqe3JIOQVwplkyR6S8D
	TKVm+3Wzj0/K/fnRQYhm3jyxVUXFg9dE3KcegKDpnI6oftzKSv5ym0eRrnzc99lxGo4K76dzy7U0p
	EKE9v5pek1iVxaLolCnDPs9iIW7lpe3sk9aZjaAMBJA6V8xpnTFSQKZcJCLYUWow/jsNDHokARK5C
	OLab/+oOPnryQkfNCxyPrm2qoP5RR7Q+1455sUYT09wA8YfyhoG39cEmljV7LWPIzEw8bIFzsJ6/0
	qNfxCSVaQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhgsX-009EQ6-Q8; Fri, 14 May 2021 23:05:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhgsU-009EPe-Vp
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 23:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=282LAdQjptuf8ptxgH4T/7JjopJcuZ0tHVsZK8FuHfc=; b=Cj0ZC9yiMoC8xW9xDh6xm45E6x
 h4RCtT1RRKvNUOEiw6wyaMlluD663u2H2ZgerQIHEGsF4vqRc274zRhe1n7K0Sonss+J8vz2Y5Rq8
 lGc0uRfQIfrMNMVkQsE4+zpIjXSVHcazjezZ5jDgH3SqKsGw6fLHLHmd5F1epW7UapbWKFTucl40L
 +rQkB+xzpriuuRpQufEMOM1IrHZ0TWla1/ygVpDHOMSySAJD1WiG4EkyM1/dtJU4/4rnPdc1FunZ7
 ypGe40jWumjmqGsqmGFwE8/l7S7+avvn3Nzlu1HcS7NSoMwKCmjMcaiNpgEU9sgDFjn/oInKxLVF7
 l5Eo/xhg==;
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhgsR-00CJMG-PT
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 23:05:53 +0000
Received: by mail-pf1-f177.google.com with SMTP id x188so796399pfd.7
 for <linux-nvme@lists.infradead.org>; Fri, 14 May 2021 16:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=282LAdQjptuf8ptxgH4T/7JjopJcuZ0tHVsZK8FuHfc=;
 b=MaBWUApsVPFwhA0RB2fuXATc4tIOxgyYD4bJ1QLDRKmcfyQkPY2X+PqX8PNlEPtffV
 xqvqBQFnnyKzs5N9F6Ns5p2+Mdht8EN5gmGRhvjS2LSyzeZkRo9ICPM7Q8QmonOmVNF7
 ys97qJa9BDsIyqtlLAEkiVbUcGBgMM6sHHQuawpFis6lZhYRwCiZiGf3WZlAbpfsvsY+
 IF97UuOvcMzrylcVXMjFv05vpXSxNwhd7EVUdHWzbctBR2l9BVfTUOFS1eTRVfP+0efN
 AdcS2MaVRscypBmSG1VdQuAyPtVA48Fqrtvu2n9FLnY+9M8e0Oy41Hy5fCvEOdG5+BAu
 wTog==
X-Gm-Message-State: AOAM5312eSQhgqk9o+B6OLsK4LJK32Ip/PO1mR3WQIMKOY7Xmndb0WCw
 2C9S7bHylQqiGfoN+9YH+5g=
X-Google-Smtp-Source: ABdhPJyM4mStFk/iBdfVy7uGFUH4ng5dtqFlHEUDj6jBZRQyfgCjZcIgbRdKSECeKhZYKCaOZ8NADg==
X-Received: by 2002:a63:4553:: with SMTP id u19mr20199136pgk.323.1621033549918; 
 Fri, 14 May 2021 16:05:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7268:613:2b37:5fbc?
 ([2601:647:4802:9070:7268:613:2b37:5fbc])
 by smtp.gmail.com with ESMTPSA id c7sm5165191pga.4.2021.05.14.16.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 16:05:49 -0700 (PDT)
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
To: Martin Wilck <mwilck@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.com>,
 kbusch@kernel.org
References: <20210506134823.2566853-1-hch@lst.de>
 <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
 <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6f6110c1-8a4d-7bd1-817c-07838816941a@grimberg.me>
Date: Fri, 14 May 2021 16:05:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <23286bbda8b62afcb8bc0ce0d4deb655197cf8a7.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_160551_849258_065317F2 
X-CRM114-Status: GOOD (  16.56  )
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> =

> Our partner reported a crash during NVMe controller initialization with
> the kernel I built with this patch applied. I'm still looking at the
> dump,=A0and it's not impossible that I made a mistake backporting your
> patch. But I thought I should inform you anyway.

Strange, the log indicates the discovery controller, which should not
even have any ANA related activity...

> =

> [ 1010.869437] nvme-fabrics ctl: Failed to read smart log (error -5)
> [ 1010.869444] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
> [ 1010.879383] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.disc=
overy", addr 192.168.1.14:4420
> [ 1010.929700] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress=
.discovery"
> [ 1011.041659] BUG: kernel NULL pointer dereference, address: 00000000000=
00010
> [ 1011.041665] #PF: supervisor write access in kernel mode
> [ 1011.041666] #PF: error_code(0x0002) - not-present page
> [ 1011.041668] PGD 0 P4D 0
> [ 1011.041672] Oops: 0002 [#1] SMP PTI
> [ 1011.041675] CPU: 13 PID: 0 Comm: swapper/13 Kdump: loaded Tainted: G  =
             X    5.3.18-6.g7ea043c-default #1 SLE15-SP2 (unreleased)
> [ 1011.041678] Hardware name: FUJITSU PRIMERGY RX2530 M2/D3279-B1, BIOS V=
5.0.0.11 R1.20.0 for D3279-B1x                    06/15/2018
> [ 1011.041689] RIP: 0010:bio_copy_kern_endio_read+0xc6/0x130
> [ 1011.041691] Code: c0 75 87 8b 4e 0c 44 89 df 89 ca 81 e1 ff 0f 00 00 c=
1 ea 0c 29 cf 48 c1 e2 06 89 f9 48 03 16 e9 6f ff ff ff 48 8b 3e 4c 89 c5 <=
49> 89 38 4a 8b 7c 0e f8 4b 89 7c 08 f8 49 8d 78 08 4d 01 c8 48 83
> [ 1011.041695] RSP: 0018:ffffab41804c8ee8 EFLAGS: 00010212
> [ 1011.041697] RAX: 0000000000000000 RBX: ffff9ff1b73e1500 RCX: 000000000=
0001000
> [ 1011.041699] RDX: fffff2b810ce1240 RSI: ffff9ff1b3849000 RDI: 000000000=
0000000
> [ 1011.041701] RBP: 0000000000000010 R08: 0000000000000010 R09: 000000000=
0001000
> [ 1011.041702] R10: 0000000000000001 R11: 0000000000001000 R12: ffff9ff16=
8ace140
> [ 1011.041703] R13: 0000000000004810 R14: 0000000000000000 R15: 000000000=
0000000
> [ 1011.041705] FS:  0000000000000000(0000) GS:ffff9ff1ff2c0000(0000) knlG=
S:0000000000000000
> [ 1011.041707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1011.041708] CR2: 0000000000000010 CR3: 00000001de60a006 CR4: 000000000=
03606e0
> [ 1011.041710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 1011.041711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 1011.041713] Call Trace:
> [ 1011.041716]  <IRQ>
> [ 1011.041722]  blk_update_request+0x8a/0x3a0
> [ 1011.041726]  blk_mq_end_request+0x1a/0x130
> [ 1011.041729]  blk_done_softirq+0x8f/0xc0
> [ 1011.041736]  __do_softirq+0xe3/0x2dc
> [ 1011.041744]  irq_exit+0xd5/0xe0
> [ 1011.041747]  call_function_single_interrupt+0xf/0x20
> [ 1011.041749]  </IRQ>
> =

> bio_copy_kern_endio_read() means that this was a command sent via
> __nvme_submit_sync_cmd(). I don't know yet which one.
> =

> Regards,
> Martin
> =

> =

> =

> =


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
