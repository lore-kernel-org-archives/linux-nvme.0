Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE1C27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2PRbPq0v5iNyBG2l9Ad/rt64rAs/3M+tj7FpuQssKg=; b=bSYQnllciGnk+fso18hpKsFEMN
	urZRTxpBcsFt/sq+agXIfKkXIqAZDYs1DXVPlsG5Rl5bpBz7M8Vhoev3u5NAIZu+Pw9gtLoQN98p5
	u84EgWAuOMvGZhBX/HwGZ1aLkIct6iWU9P1AXiG4d/LRSixt0tMFpcJB+hX+pcT2WxVb7n/e+v1B3
	y6qhv1ETy0Wx/gvZAxqEVOEnfNo70f57K1VqBUF93pqGnoycBootaEXPdBxEB7zOLkBREcjTAAVVT
	4h28Qc0VeXxpf9As1oAjbRZPAeMGipNXou0r4Swg+vZFUX634L+q9DEZr/EZ8dJkENvhxR7bTDOsG
	zsozRPsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbm5-00000004XEa-2TWR;
	Mon, 10 Jun 2024 09:57:13 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbm1-00000004XCy-1PwY
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 09:57:10 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217e89b470so1605075e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 02:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013425; x=1718618225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2PRbPq0v5iNyBG2l9Ad/rt64rAs/3M+tj7FpuQssKg=;
        b=fEpTQmxvW6PR7gAgkeJ0M583sgLLIg68nZ+fpG3+gSP1shtJ0y5zFNcUanCyE5GrhO
         H5qxcrcN5Inrn/X93DqKzoEfHqJwcftUqbe8gvhgFc8emk/ruWm6+w4M7kCDJf96aTXl
         pNU9n+bwrf7o+fm7ItlSW1Gp3q7BtgNO9SEqBJkO23aFOhcolkN2SCe6QW1MjJVijXjp
         A5WEixownn6tt5cRGbJYWkEqf6/pxX/XnxdENsMuPm99ZzbWAk312sY2BvfpIHii+n1H
         Oso1zburTWFlfUSY7jN0R/xK7q8Q1Il88uiy6MebraKNKBzmMglkhz7jH8QT1HZZmPJB
         J1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW41w436SM2KLvHzrHj9G4F8ld61XKaHMkPQ64oyRoIzYsx1/6Xj/GcW5qmO1pyxLGKoW/hQhKJrotSYpJMrYDQSjqVGrmSaDgxsSmNagk=
X-Gm-Message-State: AOJu0YxDVuDVkyudDCT/PElbQgUOX2nZ/cCwWK3BKDHr+4yIVruJTjX6
	eFqNV95PzpD4BVOY+iFNIjN3xn1V/wTIvZLsm6NnAa2KRFRki/A8FnqFd7tR
X-Google-Smtp-Source: AGHT+IHFvslAofQ4YjFdR2WQdHXGC9CdeW9RPC5k4AW9d5SiotWWb4CqW4HYjqrXstB4syw8pJyhzw==
X-Received: by 2002:a05:600c:3514:b0:421:2df7:beb4 with SMTP id 5b1f17b1804b1-42164a2e9acmr69065335e9.2.1718013424675;
        Mon, 10 Jun 2024 02:57:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f19db5decsm5404090f8f.55.2024.06.10.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 02:57:04 -0700 (PDT)
Message-ID: <2285ff6e-533f-41dc-90d0-e8ca538da152@grimberg.me>
Date: Mon, 10 Jun 2024 12:57:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel OOPS while creating a NVMe Namespace
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_025709_404855_9D8C6771 
X-CRM114-Status: GOOD (  10.55  )
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



On 10/06/2024 10:51, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
> Observing Kernel OOPS, while creating namespace on a NVMe device.
>
> [  140.209777] BUG: Unable to handle kernel data access at 
> 0x18d7003065646fee
> [  140.209792] Faulting instruction address: 0xc00000000023b45c
> [  140.209798] Oops: Kernel access of bad area, sig: 11 [#1]
> [  140.209802] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
> [  140.209809] Modules linked in: rpadlpar_io rpaphp xsk_diag 
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
> bonding nf_conntrack tls nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set 
> nf_tables nfnetlink vmx_crypto pseries_rng binfmt_misc fuse xfs 
> libcrc32c sd_mod sg ibmvscsi scsi_transport_srp ibmveth nvme nvme_core 
> t10_pi crc64_rocksoft_generic crc64_rocksoft crc64
> [  140.209864] CPU: 2 PID: 129 Comm: kworker/u65:3 Kdump: loaded Not 
> tainted 6.10.0-rc3 #2
> [  140.209870] Hardware name: IBM,9009-42A POWER9 (raw) 0x4e0202 
> 0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
> [  140.209876] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [  140.209889] NIP:  c00000000023b45c LR: c008000006a96b20 CTR: 
> c00000000023b42c
> [  140.209894] REGS: c0000000506078a0 TRAP: 0380   Not tainted 
> (6.10.0-rc3)
> [  140.209899] MSR:  800000000280b033 
> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000244  XER: 00000000
> [  140.209915] CFAR: c008000006aa80ac IRQMASK: 0
> [  140.209915] GPR00: c008000006a96b20 c000000050607b40 
> c000000001573700 c000000004291ee0
> [  140.209915] GPR04: 0000000000000000 c000000006150080 
> 00000000c0080005 fffffffffffe0000
> [  140.209915] GPR08: 0000000000000000 18d7003065646f6e 
> 0000000000000000 c008000006aa8098
> [  140.209915] GPR12: c00000000023b42c c00000000f7cdf00 
> c0000000001a151c c000000004f2be80
> [  140.209915] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [  140.209915] GPR20: c000000004dbcc00 0000000000000006 
> 0000000000000002 c000000004911270
> [  140.209915] GPR24: 0000000000000000 0000000000000000 
> c0000000ee254ffc c0000000049111f0
> [  140.209915] GPR28: 0000000000000000 c000000004911260 
> c000000004291ee0 c000000004911260
> [  140.209975] NIP [c00000000023b45c] synchronize_srcu+0x30/0x1c0
> [  140.209984] LR [c008000006a96b20] nvme_ns_remove+0x80/0x2d8 
> [nvme_core]
> [  140.209994] Call Trace:
> [  140.209997] [c000000050607b90] [c008000006a96b20] 
> nvme_ns_remove+0x80/0x2d8 [nvme_core]
> [  140.210008] [c000000050607bd0] [c008000006a972b4] 
> nvme_remove_invalid_namespaces+0x144/0x1ac [nvme_core]
> [  140.210020] [c000000050607c60] [c008000006a9dbd4] 
> nvme_scan_ns_list+0x19c/0x370 [nvme_core]
> [  140.210032] [c000000050607d70] [c008000006a9dfc8] 
> nvme_scan_work+0xc8/0x278 [nvme_core]
> [  140.210043] [c000000050607e40] [c00000000019414c] 
> process_one_work+0x20c/0x4f4
> [  140.210051] [c000000050607ef0] [c0000000001950cc] 
> worker_thread+0x378/0x544
> [  140.210058] [c000000050607f90] [c0000000001a164c] kthread+0x138/0x140
> [  140.210065] [c000000050607fe0] [c00000000000df98] 
> start_kernel_thread+0x14/0x18
> [  140.210072] Code: 3c4c0134 384282d4 7c0802a6 60000000 7c0802a6 
> fbc1fff0 fba1ffe8 fbe1fff8 7c7e1b78 f8010010 f821ffb1 e9230010 
> <e9290080> 7c2004ac 71290003 41820008
> [  140.210093] ---[ end trace 0000000000000000 ]---
>
>
> Issue is introduced by the patch: 
> be647e2c76b27f409cdd520f66c95be888b553a3.

Exactly this was the concern when introducing a behavior change in a 
sensitive area of the code
to silence lockdep...

I'm assuming that the bad dereference is:
         synchronize_srcu(&ns->ctrl->srcu);

btw, looking at the code again, I'm assuming that synchronizing srcu in 
every ns remove
slows down batch removal of many namespaces greatly...

>
>
> Reverting it, issue is not seen.
>
>
> Regards,
>
> Venkat.
>
>


